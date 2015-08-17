<?php
require_once 'config.php';
require_once 'modules/Skill.php';
require_once 'modules/prettyprint.php';

class Member
{
    // Class properties and methods go here
    public $meetup_id;
    public $name;
    public $email;
    public $cookies;
    public $mailchimp_euid;
    public $last_name;
    public $id;
    public $location;
    public $joined;
    public $twitter_url;
    public $linkedin_url;
    public $github_url;
    public $meetup_url;
    public $facebook_url;
    public $flickr_url;
    public $occupation;
    public $position;
    public $studies;
    public $progress;
    public $photo_url;
    public $lat;
    public $lon;
    public $last_visit;
    public $bio;
    public $skills = array();

    private $db;

    public function __construct($args)
    {
        global $dbhost, $dbuser, $dbpass, $dbname;

        $this->db = new MysqliDb (Array (
                'host' => $dbhost,
                'username' => $dbuser,
                'password' => $dbpass,
                'db'=> $dbname,
                'charset' => 'utf8')
        );

        if(isset($args["meetup_id"])){
            // We will request it from the DB or USING THE MEETUP API
            $this->meetup_id = $args["meetup_id"];

            $this->db->where("meetup_id", $this->meetup_id);
            $user = $this->db->getOne("users");

            if(!$user || !$user["email"]){
                $this->loadFromMeetup();
            }else{
                $this->db->join("users u", "u.meetup_id=p.meetup_id", "LEFT");
                $this->db->where("u.meetup_id", $this->meetup_id);
                $userProfile = $this->db->getOne("profiles p");

                $this->id = $userProfile["id"];
                $this->name = $userProfile["name"];
                $this->email = $userProfile["email"];
                $this->cookies = $userProfile["cookies"];
                $this->mailchimp_euid = $userProfile["mailchimp_euid"];
                $this->last_name = $userProfile["last_name"];
                $this->location = $userProfile["location"];
                $this->joined = $userProfile["joined"];
                $this->twitter_url = $userProfile["twitter_url"];
                $this->linkedin_url = $userProfile["linkedin_url"];
                $this->github_url = $userProfile["github_url"];
                $this->meetup_url = $userProfile["meetup_url"];
                $this->facebook_url = $userProfile["facebook_url"];
                $this->flickr_url = $userProfile["flickr_url"];
                $this->occupation = $userProfile["occupation"];
                $this->position = $userProfile["position"];
                $this->studies = $userProfile["studies"];
                $this->progress = $userProfile["progress"];
                $this->photo_url = $userProfile["photo_url"];
                $this->lat = $userProfile["lat"];
                $this->lon = $userProfile["lon"];

                $this->db->join("user_skills u", "u.skill_id=s.id", "LEFT");
                $this->db->where("u.meetup_id", $this->meetup_id);
                $skills = $this->db->get("skills s");
                foreach($skills as $s){
                    $this->skills[$s["id"]] = $s;
                }
            }
        }elseif(isset($args["meetup_response"])){
            $this->loadFromMeetup($args["meetup_response"]);
        }else{
            echo "Args = ";
            prettyprint($args);
            die("You mush set ona param: meetup_id or meetup_response");
        }
    }

    public function update($values){
        $this->name = $values["name"];
        $this->last_name = $values["last_name"];
        $this->email = $values["email"];
        $this->location = $values["location"];
        $this->bio = $values["bio"];
        $this->studies = $values["studies"];

        $position = array();
        if( isset($values["worker"]) ){ array_push($position, $values["worker"]);}
        if( isset($values["student"]) ){ array_push($position, $values["student"]);}
        if( isset($values["unemployed"]) ){ array_push($position, $values["unemployed"]);}
        if( isset($values["freelance"]) ){ array_push($position, $values["freelance"]);}
        $this->position = implode(",", $position);

        $this->occupation = $values["occupation"];

        $this->twitter_url = $values["twitter_url"];
        $this->linkedin_url = $values["linkedin_url"];
        $this->github_url = $values["github_url"];
        $this->facebook_url = $values["facebook_url"];
        $this->flickr_url = $values["flickr_url"];

        if(isset($values["skills"])){

            //TODO, nuevas que no tenga el user
            foreach($values["skills"] as $key => $val){
                $this->skills[$key]["level"] = $val;
                //echo "$key, $val <br>";
            }
            /*prettyprint($this->skills);
            die("Yeah");*/

        }
    }

    public function suscribeToMailchimp(){
        global $mailchimp_apikey, $mailchimp_listid;
        if($this->email){
            $MailChimp = new \Drewm\MailChimp($mailchimp_apikey);
            $result = $MailChimp->call('lists/subscribe', array(
                'id'                => $mailchimp_listid,
                'email'             => array('email'=> $this->email),
                'merge_vars'        => array('FNAME'=> $this->name),
                'double_optin'      => false,
                'update_existing'   => true,
                'replace_interests' => false,
                'send_welcome'      => false
            ));
            $this->mailchimp_euid = $result["euid"];
            return $result["euid"];
        }
        return -1;
    }

    public function getUser(){
        return Array (
            "meetup_id"         => $this->meetup_id,
            "mailchimp_euid"    => $this->mailchimp_euid,
            "name"              => $this->name,
            "email"             => $this->email,
            "cookies"           => ($this->cookies)? ($this->cookies) : 0,
            "last_name"         => $this->last_name
        );
    }

    public function getProfile(){
        return Array (
            "meetup_id"     => $this->meetup_id, //TODO: check if it fails when updating
            "location"      => $this->location,
            "joined"        => $this->joined,
            "twitter_url"   => $this->twitter_url ,
            "linkedin_url"  => $this->linkedin_url,
            "github_url"    => $this->github_url ,
            "meetup_url"    => $this->meetup_url ,
            "facebook_url"  => $this->facebook_url ,
            "flickr_url"    => $this->flickr_url ,
            "occupation"    => $this->occupation ,
            "position"      => $this->position,
            "studies"       => $this->studies,
            "progress"      => ($this->progress)? $this->progress : 0,
            "photo_url"     => $this->photo_url,
            "lat"           => $this->lat,
            "lon"           => $this->lon,
            "last_visit"    => $this->last_visit,
            "bio"           => $this->bio
        );
    }

    public function getUserProfile(){
        $userprofile = array_merge(
            $this->getUser(),
            $this->getProfile()
        );

        $userprofile["joined"] = date('d/m/Y', strtotime($userprofile["joined"]));
        if(isset($userprofile["twitter_url"]) && strpos($userprofile["twitter_url"],"@") !== false){
            $userprofile["twitter_name"] = $userprofile["twitter_url"];
            $userprofile["twitter_url"] = "http://www.twitter.com/".substr($userprofile["twitter_url"], 1);
        }

        return $userprofile;

    }

    public function getSkills(){
        $data = array();
        foreach($this->skills as $s){
            $aux = array(
                "meetup_skill_id"   => $s["meetup_skill_id"],
                "is_gis"            => $s["is_gis"],
                "name"              => $s["name"],
                "slug"              => $s["slug"],
                "synonyms"          =>$s["synonyms"]
            );

            if( isset($s["id"]) ){
                $aux["id"] = $s["id"];
            }
            array_push($data, $aux);
        }
        return $data;
    }

    public function getUserSkills(){
        $data = array();
        foreach($this->skills as $s){
            $tmp = array(
                "skill_id"   => $s["id"],
                "meetup_id"  => $this->meetup_id
            );

            if(!isset($s["level"])){
                $tmp["level"] = 0;
            }else{
                $tmp["level"] = $s["level"];
            }
            array_push($data, $tmp);
        }
        return $data;
    }

    public function save(){

        // First, suscribe to mailchimp
        $this->suscribeToMailchimp();

        // Add user to the database
        $data = $this->getUser();

        $this->db->where("meetup_id", $this->meetup_id);
        $user = $this->db->getOne("users");
        //echo "User:";
        //prettyprint($data);
        //die("<hr>");
        if($user){
            $this->db->where("meetup_id", $this->meetup_id);
            if ($this->db->update('users', $data)){
                //echo  $db->count . ' records were updated';
            }else {
                prettyprint($data);
                die('User ('.$this->id.') update failed: ' . $this->db->getLastError());
            }
        }else{
            $result = $this->db->insert ('users', $data);
            if(!$result){
                prettyprint($data);
                die("The user ('.$this->meetup_id.') could not be added, please contact to the webmaster at root@geodevelopers.org: ".$this->db->getLastError());
            }
        }

        // Add profile to the database
        $data = $this->getProfile();
        //prettyprint($this);
        //cho "Profile:";
        //prettyprint($data);
        //die("<hr>");
        $this->db->where("meetup_id", $this->meetup_id);
        $profile = $this->db->getOne("profiles");

        if($profile){
            $this->db->where("meetup_id", $this->meetup_id);
            if ($this->db->update('profiles', $data)){
                //echo $db->count . ' records were updated';
            }else {
                prettyprint($data);
                die('User profile ('.$this->id.') update failed: ' . $this->db->getLastError());
            }
        }else{
            $result = $this->db->insert ('profiles', $data);
            if(!$result){
                prettyprint($data);
                die("User profile ('.$this->meetup_id.') could not be added, please contact to the webmaster at root@geodevelopers.org:". $this->db->getLastError());
            }
        }

        $skills = $this->getSkills();
        //echo "Skills:";
        //prettyprint($skills);
        //die("<hr>");
        foreach($skills as $key => $s){
            if(!isset($s["id"])){
                $s["id"] = $this->db->insert("skills",$s);
                if(!$s["id"]){
                    prettyprint($s);
                    die("Skill ".$s["name"]." for user ('.$this->meetup_id.') could not be added ");
                }else{
                    $this->skills[$s["id"]] = $s;
                    unset($this->skills["new_".$s["meetup_skill_id"]]);
                }
            }
        }

        // Insert new user_skills
        $skills = $this->getUserSkills();
        /*echo "UserSkills:";
        prettyprint($skills);
        die("<hr>");*/
        foreach($skills as $s) {
            $this->db -> where("skill_id", $s["skill_id"])
                      -> where("meetup_id", $this->meetup_id);

            $elem = $this->db->getOne("user_skills");
            if(!$elem){
                if ($id = $this->db->insert('user_skills', $s)) {
                    //echo $db->count . ' user_skills were added';
                }else{
                    prettyprint($s);
                    die('user_skills for user ('.$this->meetup_id.') insetion failed: ' . $this->db->getLastError());
                }
            }else{
                //prettyprint($s);
                $this->db -> where("skill_id", $s["skill_id"])
                          -> where("meetup_id", $this->meetup_id);
                if(!$this->db->update('user_skills', $s)){
                    prettyprint($s);
                    die("User ('.$this->meetup_id.') skills could not be updated");
                }

            }
        }


        //$member = new Member(array("meetup_id" =>$this->meetup_id));
        $this->updateProgress();


        return true;
    }

    // Check if it is already registered
    public function isRegistered()
    {
        return ($this->email)? true : false;
    }

    public function updateProgress()
    {
        $this->db->join("users u", "u.meetup_id=p.meetup_id", "LEFT");
        $this->db->where("u.meetup_id", $this->meetup_id);
        $user = $this->db->getOne("profiles p");
        $progress = 0;

        // Position 10%
        if($user["position"]){ $progress += 5; }
        // Studies 10%
        if($user["studies"]){ $progress += 5; }
        // Occupation 10%
        if($user["occupation"]){ $progress += 5; }
        // Have picture 10%
        if(strpos($user["photo_url"],"www.gravatar.com") != -1 && $user["photo_url"]){
            $progress += 5;
        }

        if($user["bio"]){ $progress += 5; }
        if($user["twitter_url"]){ $progress += 5; }
        if($user["linkedin_url"]){ $progress += 10; }

        $this->db->join("user_skills us", "us.skill_id=s.id", "LEFT");
        $this->db->where("us.meetup_id", $this->meetup_id);
        $this->db->where("s.is_gis", 1);
        $gis_skills = $this->db->get("skills s");

        // Have GIS skills 10%
        if($gis_skills){
            $progress += 10;
            $all_filled = true;
            foreach($gis_skills as $skill){
                if($skill["level"] == 0){
                    $all_filled = false;
                }
            }
            if($all_filled){
                // Have them all filled 25%
                $progress += 25;
            }
        }

        $this->db->join("user_skills us", "us.skill_id=s.id", "LEFT");
        $this->db->where("us.meetup_id", $this->meetup_id);
        $this->db->where("s.is_gis", NULL, " is ");
        $this->db->where("s.is_important", 1);
        $other_skills = $this->db->get("skills s");

        // Have NON-GIS skills 10%
        if($other_skills){
            $progress += 10;
            $all_filled = true;
            foreach($other_skills as $skill){
                if($skill["level"] == 0){
                    $all_filled = false;
                }
            }
            if($all_filled){
                // Have them all filled 15%
                $progress += 15;
            }
        }


        //echo "Meetupid = $this->meetup_id, Progress = $progress<br>";

        $this->db->where("meetup_id", $this->meetup_id);
        $this->db->update("profiles", array("progress" => $progress));


    }

    public function loadFromMeetup($meetup_response = NULL){
        global $meetup_group_id, $meetup_group_urlname, $meetup_api_key;;

        $client = DMS\Service\Meetup\MeetupKeyAuthClient::factory(array('key' => $meetup_api_key));

        if(!$meetup_response){
            $response = $client->getMember(array('id' => $this->meetup_id));
        }else{
            $response = $meetup_response;
        }

        $this->name = $response["name"];
        $this->meetup_id = $response["id"];
        $this->location = $response["city"].", ".$response["country"];
        $this->meetup_url = $response["link"];
        $this->lat = $response["lat"];
        $this->lon = $response["lon"];
        $this->name = $response["name"];

        if(isset($response["photo"])){
            if (isset($response["photo"]["highres_link"])) {
                $this->photo_url = $response["photo"]["highres_link"];
            } elseif (isset($response["photo"]["photo_link"])) {
                $this->photo_url = $response["photo"]["photo_link"];
            } elseif (isset($response["photo"]["thumb_link"])) {
                $this->photo_url = $response["photo"]["thumb_link"];
            }
        }elseif (isset($response["photo_url"])) {
            $this->photo_url = $response["photo_url"];
        }else{
            $email = strtolower( $this->meetup_id."@gmail.com" );
            $this->photo_url = "http://www.gravatar.com/avatar/".md5($email);
        }

        if(isset($response["other_services"]) && is_array($response["other_services"])) {
            foreach ($response["other_services"] as $key => $service) {
                $s = $service["identifier"];

                switch ($key) {
                    case "twitter":
                        $this->twitter_url = $s;
                        break;
                    case "flickr":
                        $this->flickr_url = $s;
                        break;
                    case "facebook":
                        $this->facebook_url = $s;
                        break;
                    case "linkedin":
                        $this->facebook_url = $s;
                        break;
                }
            }
        }

        $service = new Skill();

        if(isset($response["topics"]) && is_array($response["topics"])) {
            foreach ($response["topics"] as $topic) {
                $s = $service->find(array(
                    "meetup_skill_id" => $topic["id"]
                ));

                if ($s) {
                    $this->skills[$s["id"]] = $s;
                } else {
                    $this->skills["new_".$topic["id"]] = array(
                        "meetup_skill_id" => $topic["id"],
                        "is_gis" => 0,
                        "synonyms" => NULL,
                        "name" => $topic["name"],
                        "slug" => $topic["urlkey"],
                    );
                }
            }
        }

        $options = array(
            'group_urlname' => $meetup_group_urlname,
            'group_id'      => $meetup_group_id,
            'member_id'     => $this->meetup_id
        );

        $profiles = $client->getProfiles($options);

        if($profiles->count() > 0){

            // Find relevant skills in open answers and add them to the profile
            foreach($profiles as $p){
                $answers = "";

                foreach ($p["answers"] as $a) {
                    if(isset($a["answer"])){
                        $answers .= $a["answer"]." ";
                    }
                }
                $answers = strtolower($answers);
                $r = $service->extractRelevantSkills($answers);
                $this->merge_skills($r);

                //When user joined
                $this->joined = $this->parseEpoch($p["created"]);
                $this->last_visit= $this->parseEpoch($p["visited"]);

                if(isset($p["bio"])){
                    $this->bio = $p["bio"];
                }

                if(isset($p["photo"])){
                    if (isset($p["photo"]["highres_link"])) {
                        $this->photo_url = $p["photo"]["highres_link"];
                    } elseif (isset($p["photo"]["photo_link"])) {
                        $this->photo_url = $p["photo"]["photo_link"];
                    } elseif (isset($p["photo"]["thumb_link"])) {
                        $this->photo_url = $p["photo"]["thumb_link"];
                    }
                }elseif (isset($p["photo_url"])) {
                    $this->photo_url = $p["photo_url"];
                }

                if(isset($p["profile_url"])){
                    $this->meetup_url = $p["profile_url"];
                }

                //TODO: check if other services
            }

        }

    }

    /*
     * This method allows us to load the object
     *
     *
     * Params:
     * $args = array(
     *      "id"    => "meetup_id"
     *      "array" =>
     * )
     */
    public function parseEpoch($date){
        $epoch = $date;
        $epoch = substr($epoch,0, -3);
        $dt = new DateTime("@$epoch");
        return $dt->format('Y-m-d');
    }

    public function merge_skills($new_skills){
        $a = $this->skills;
        $b = $new_skills;

        if(sizeof($a) >= sizeof($b)){
            $mixed = $a;
            $iter = $b;
        }else{
            $mixed = $b;
            $iter = $a;
        }

        foreach($iter as $i){
            $hash_array = false;
            foreach($mixed as $m){
                if($m["id"] == $i["id"]){
                    $hash_array = true;
                    break;
                }
            }
            if(!$hash_array){
                array_push($mixed,$i);
            }
        }

        $this->skills = $mixed;


    }
    //function

}
?>