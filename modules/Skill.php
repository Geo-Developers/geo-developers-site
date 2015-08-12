<?php
require("../config.php");

class Skill
{
    // Class properties and methods go here
    private $db;

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