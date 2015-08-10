<?php
require_once '../config.php';
require_once 'init.php';

$db->where("meetup_id", $_GET["query"]);
$user = $db->getOne("users");

if($user){
    $db->where("meetup_id", $_GET["query"]);
    $db->join("user_skills u", "u.meetup_skill_id=s.meetup_skill_id", "LEFT");
    $db->orderBy("u.level","desc");
    $skills = $db->get("skills s", null , "u.level, s.name, s.slug");

    $numSkills = sizeof($skills)-1;
    $profile = $db->where("meetup_id", $_GET["query"])->getOne("profiles");


    $smarty->assign('PROFILE', $profile);
    $smarty->assign('NUMSKILLS', $numSkills);
    $smarty->assign('SKILLS', $skills);
    $smarty->assign('USERPROFILE', $user);
    $smarty->display('perfil.tpl');
}else{
    echo "Error el usuario no existe en la base de datos";
}
?>