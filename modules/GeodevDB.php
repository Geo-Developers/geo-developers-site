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
    public function getUser($options = null){

        $meetup_id = $this->getParam($options);
        $this->db->where("u.meetup_id", $meetup_id);

        switch ($options["type"]){
            case "userprofile":
                $this->db->join("users u", "u.meetup_id=p.meetup_id", "LEFT");
                $result = $this->db->getOne("profiles p");

                $result["joined"] = date('d/m/Y', strtotime($result["joined"]));
                if(isset($result["twitter_url"])){
                    $result["twitter_name"] = $result["twitter_url"];
                    $result["twitter_url"] = "http://www.twitter.com/".substr($result["twitter_url"], 1);
                }
                break;

            //default:

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
