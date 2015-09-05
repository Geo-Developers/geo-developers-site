<?php
require("config.php");

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

    // The function search (matches) in a description field any skill that we have un the database
    public function extractRelevantSkills($string){

        $this->db->where('is_important',1);
        $skills = $this->db->get('skills');

        $relevants = array();
        $special_character = "[ |\.|,|;|\?|¿|!|¡|:|-|(|)|_]";
        foreach($skills as $s){
            //$pos = strpos($string, ));
            $regex = "~".$special_character.$s["name"].$special_character."~i";
            $found = preg_match($regex, $string);
            if($found){
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
                    $regex = "/".$special_character.$synonym.$special_character."/i";
                    $found = preg_match($regex, $string);
                    if($found){
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
    // it returns false if the skill doesn't exist
    public function find($skill)
    {
        if(isset($skill["meetup_skill_id"])){
            $this->db->where("meetup_skill_id",$skill["meetup_skill_id"]);
            $s = $this->db->getOne("skills");
            if($s){
                return $s;
            }
        }

        if(isset($skill["name"])){
            $this->db->where("name", $skill["name"]);
            $s = $this->db->getOne("skills");
            if($s){
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
                }else{
                    prettyprint($skill);
                    die('skill insetion failed: ' . $this->db->getLastError());
                }
            }
        }
    }
}