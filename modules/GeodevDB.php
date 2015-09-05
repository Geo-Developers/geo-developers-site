<?php

require_once 'modules/Skill.php';
require_once 'modules/prettyprint.php';

class GeodevDB
{
    private $meetup_id;
    private $db;

    public function __construct($args = null){
        global $dbhost, $dbuser, $dbpass, $dbname;

        $this->db = new MysqliDb (Array (
                'host' => $dbhost,
                'username' => $dbuser,
                'password' => $dbpass,
                'db'=> $dbname,
                'charset' => 'utf8')
        );

        if(isset($args["meetup_id"])){
            $this->meetup_id = $args["meetup_id"];
        }
    }



    public function getVideo($options = null)
    {

        if(!isset($options["youtubeId"])) die("You must specify a youtubeId param");

        $this->db->where('youtubeId', $options["youtubeId"]);
        $video = $this->db->getOne('videos');

        if(strpos($video["slides"],"http")===false){
            $video["slides"] = "https://docs.google.com/presentation/d/{$video['slides']}/embed?start=false&loop=false&delayms=3000";
        }
        $ids = explode(",",$video["related"]);
        $video["related"] = array();
        foreach($ids as $id){
            $this->db->where('id', $id);
            $v = $this->db->getOne('videos');
            array_push($video["related"],$v);
        }

        $video["tags"] = explode(",", $video["tags"]);
        $entries = explode("\n",$video["videoIndex"]);
        $video["videoIndex"] = array();

        foreach($entries as $e){
            $index = strpos($e, " ");
            $entry = array(
                "time"=>substr($e,0,$index),
                "text"=>substr($e,$index+1)
            );

            // Parse time to seconds
            $entry["seconds"] = timeToSeconds($entry["time"]);

            array_push($video["videoIndex"],$entry);
        }

        // Parse PT40M2S to 40:02
        $time = covtime($video["duration"]);
        $video["length"] = timeToSeconds($time);

        //TODO: get current progress for the user meetup_id
        $this->db->where("youtubeId", $options["youtubeId"]);
        $v = $this->db->getOne("videos");

        $this->db->where("video_id",$v["id"]);

        if(isset($options['meetupId'])){
            $this->db->where("meetup_id", $options['meetupId']);
            $elem = $this->db->getOne("progress");

            $video["progress"] = array();

            if(!$elem){
                foreach ($video["videoIndex"] as $entry) {
                    array_push($video["progress"], array(
                        $entry["seconds"], 0));
                }
            }else{
                $indexes = explode("|",$elem["indexes"]);
                for($i=0; $i<sizeof($indexes); $i++){
                    $t = explode(",", $indexes[$i]);
                    array_push($video["progress"], array(
                        $video["videoIndex"][$i]["seconds"], $t[1]));
                }
            }

            //Skip this step when video length==0 -> webinar
            if($video["length"]){
                $videoNumEl = sizeof($video["progress"]);
                for($i=0; $i<$videoNumEl;$i++){
                    $t0 = $video["progress"][$i][0];
                    if($i+1 < $videoNumEl){
                        $t1 = $video["progress"][$i+1][0];
                    }else{
                        $t1 = $video["length"];
                    }
                    $num = ($t1-$t0) / $video["length"];
                    array_push($video["progress"][$i],$num

                    );
                }
            }
        }

        return $video;

    }

    public function getUser($options = null){

        $meetup_id = $this->getParam($options);
        $this->db->where("u.meetup_id", $meetup_id);

        switch ($options["type"]){
            case "userprofile":

                $this->db->join("users u", "u.meetup_id=p.meetup_id", "LEFT");
                $result = $this->db->getOne("profiles p");
                if(!isset($result["joined"])){
                    $result = false;
                    continue;
                }
                $result["joined"] = date('d/m/Y', strtotime($result["joined"]));
                if(isset($result["twitter_url"]) && strpos($result["twitter_url"],"@") !== false){
                    //die(strpos($result["twitter_url"],"@"));
                    $result["twitter_name"] = $result["twitter_url"];
                    $result["twitter_url"] = "http://www.twitter.com/".substr($result["twitter_url"], 1);
                }
                break;

            case "user":
                $result = $this->db->getOne("users u");
                break;
            default:
                $result = $this->db->getOne("users u");

        }
        return $result;
    }

    public function getUserSkills($options = null)
    {
        $meetup_id = $this->getParam($options);
        $this->db->where("meetup_id", $meetup_id);

        switch ($options["type"]){
            case "gis":
                $this->db->where("is_gis", 1);
                break;
            case "other":
                $this->db->where("is_gis IS NULL")->where("is_important",1);
                break;
            default:
                $this->db->where("is_important",1);
        }

        $this->db->join("user_skills u", "u.skill_id=s.id", "LEFT");
        $this->db->orderBy("u.level","desc");
        return $this->db->get("skills s");
    }

    public function getExperts($options = null){
        if(!isset($options["tech"])){
            die("You must specify a technology with (tech)");
        }

        $query= "SELECT distinct users.meetup_id, users.name, users.last_name, user_skills.level, profiles.photo_url, profiles.location".
            " FROM users".
            "    INNER JOIN profiles".
            "        ON users.meetup_id = profiles.meetup_id".
            "    INNER JOIN user_skills".
            "        ON profiles.meetup_id = user_skills.meetup_id".
            "    INNER JOIN skills".
            "        ON user_skills.skill_id = skills.id".
            " WHERE skills.name = '".$options['tech']."' ORDER BY user_skills.level DESC";

        return $this->db->rawQuery($query);
    }

    public function getMembers($options = null){
        $this->db->join("users u", "u.meetup_id=p.meetup_id", "LEFT");
        $this->db->orderBy("p.progress","desc");
        return $this->db->get("profiles p",null, "u.meetup_id, u.name, u.last_name,  p.progress, p.photo_url, p.location");
    }

    public function getReferrers($options = null)
    {
        $meetup_id = $this->getParam($options);
        $this->db->where("refered", $meetup_id);
        $this->db->join("votes v", "v.referrer=p.meetup_id", "LEFT");
        return $this->db->get("profiles p");
    }

    public function getIsReferred($options = null)
    {
        $refered = $this->getParam($options, "refered");
        $referrer = $this->getParam($options, "referrer");

        $this->db ->where("refered", $refered)
            ->where("v.referrer", $referrer);

        $this->db->join("votes v", "v.referrer=p.meetup_id", "LEFT");

        return $this->db->getOne("profiles p");
    }

    public function getSkills($options = null){
        switch($options["type"]){
            case "geo":
                $this->db->where("is_gis","1");
                $this->db->orderBy("name","asc");
                $skills = $this->db->get("skills");
                break;
            case "other":
                $this->db->where("is_gis IS NULL")->where("is_important",1);
                $this->db->join("user_skills u", "u.skill_id=s.id", "LEFT");
                $this->db->orderBy("s.name","asc");
                $skills = $this->db->get("skills s", null , "DISTINCT s.name");
                break;
            default:
                $this->db->where("is_important","1");
                $this->db->orderBy("name","asc");
                $skills = $this->db->get("skills");
        }
        return $skills;
    }

    /*
     * This  gets the specifed param in options
     * if it doesn't exists it tries to return
     * the meetup_id, and if not... it die
     */
    private function getParam($options = null, $value = null){

        $field = ($value) ? $value : "meetup_id";

        if(isset($options[$field])){
            $meetup_id = $options[$field];
        }else if($this->meetup_id){
            $meetup_id = $this->meetup_id;
        }else{
            die("Error, you must set a meetup_id for this query");
        }
        return $meetup_id;
    }
}
?>
