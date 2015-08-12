<?php
require_once '../config.php';
require_once 'init.php';

$db->where("meetup_id", $_GET["query"]);
$user = $db->getOne("users");

if($user){
    $db->where("meetup_id", $_GET["query"])->where("is_gis", 1);
    $db->join("user_skills u", "u.skill_id=s.id", "LEFT");
    $db->orderBy("u.level","desc");
    $skillsGis = $db->get("skills s", null , "u.level, s.name, s.slug");

    $db->where("meetup_id", $_GET["query"])->where("is_gis IS NULL")->where("is_important",1);
    $db->join("user_skills u", "u.skill_id=s.id", "LEFT");
    $db->orderBy("u.level","desc");
    $skills = $db->get("skills s", null , "u.level, s.name, s.slug");

    $numSkillsGIS = sizeof($skillsGis);
    $numSkills = sizeof($skills);
    $profile = $db->where("meetup_id", $_GET["query"])->getOne("profiles");
    $profile["joined"] = date('d/m/Y', strtotime($profile["joined"]));

    $smarty->assign('PROFILE', $profile);
    $smarty->assign('NUMSKILLSGIS', $numSkillsGIS);
    $smarty->assign('NUMSKILLS', $numSkills);
    $smarty->assign('SKILLSGIS', $skillsGis);
    $smarty->assign('SKILLS', $skills);
    $smarty->assign('USERPROFILE', $user);
    $smarty->display('perfil.tpl');
}else{
    echo "Error el usuario no existe en la base de datos";
}
?>