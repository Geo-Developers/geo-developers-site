<?php
require("../config.php");

class Skill
{
    // Class properties and methods go here
    private $db;
    public $skills;

    public function __construct()
    {
        global $dbhost, $dbuser, $dbpass, $dbname;

        $this->db = new MysqliDb (Array(
                'host' => $dbhost,
                'username' => $dbuser,
                'password' => $dbpass,
                'db' => $dbname,
                'charset' => 'utf8')
        );
    }

    public function extractRelevantSkills($string){

        // TODO: change is_gis for is_relevant
        // Not use $this->skill (not all of them)
        $this->db->where('is_gis',1);
        $skills = $this->db->get('skills');

        $relevants = array();
        foreach($skills as $s){
            $pos = strpos($string, strtolower($s["name"]));
            if($pos){
                //echo "<hr>Encontrado ".$s["name"];
                //echo " | strpos=".$pos;

                array_push($relevants, $s);
            }elseif(isset($s["synonyms"])){
                //echo "<hr>Compruebo sinónimos de ".$s["name"];
                $synoms = explode(",",$s["synonyms"]);
                $synoms = array_map("trim",$synoms);
                $synoms = array_map("strtolower",$synoms);
                //echo "<br>Sinónimos:";
                //prettyprint($synoms);
                foreach($synoms as $synonym) {
                    if(strpos($string, $synonym)){
                        //echo "<br>Está el sinónimo ".$synonym;
                        //echo ": strpos=".strpos($string, $synonym);
                        array_push($relevants, $s);
                    }
                }
            }
        }

        return $relevants;

    }

    // Find an skill in the database
    // Param skill is an array with a key "meetup_skill_id" or a "name"
    public function find($skill)
    {
        if(isset($skill["meetup_skill_id"])){
            $this->db->where("meetup_skill_id",$skill["meetup_skill_id"]);
            $s = $this->db->getOne("skills");
            if($s){
                return $s;
            }
        }

        $skills = $this->db->get("skills");

        foreach($skills as $s){
            echo "find(), skill=";
            prettyprint($s);
            if(strtolower($s["name"]) == strtolower($skill["name"])){
                return $s;
            }
        }
        return false;
    }

    /*
     * Add skills to the database
     * Params: $s must be and array of skills
     */
    public function add($s){
        // Adding new skills to the database
        foreach($s as $skill){
            $elem = $this->find(array("meetup_skill_id"=>$skill["meetup_skill_id"]));
            if(!$elem){
                if ($id = $this->db->insert('skills', $skill)){
                    //echo $db->count . ' skills were added';
                }else
                    die('insetion failed: ' . $this->db->getLastError());
            }
        }
    }
}