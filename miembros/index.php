<?php

require_once '../config.php';
require_once 'init.php';

if(isset($_GET['tech']) && $_GET['tech']){


    $query= "SELECT distinct users.meetup_id, users.name, user_skills.level, profiles.photo_url, profiles.location".
            " FROM users".
            "    INNER JOIN profiles".
            "        ON users.meetup_id = profiles.meetup_id".
            "    INNER JOIN user_skills".
            "        ON profiles.meetup_id = user_skills.meetup_id".
            "    INNER JOIN skills".
            "        ON user_skills.skill_id = skills.id".
            " WHERE skills.name = '".$_GET['tech']."' ORDER BY user_skills.level DESC";

    $users = $db->rawQuery($query);

    $smarty->assign('TECH', $_GET['tech']);
}else{
    $db->join("users u", "u.meetup_id=p.meetup_id", "LEFT");
    $db->orderBy("p.progress","desc");
    $users = $db->get("profiles p",24, "u.meetup_id, u.name,  p.progress, p.photo_url, p.location");
}

$total = $db->getValue("profiles", "count(meetup_id)");


$db->where("is_gis IS NULL")->where("is_important",1);
$db->join("user_skills u", "u.skill_id=s.id", "LEFT");
$db->orderBy("s.name","asc");
$skills = $db->get("skills s", null , "DISTINCT s.name");

$numSkills = sizeof($skills);

$db->where("is_gis","1");
$db->orderBy("name","asc");
$geoskills = $db->get("skills");

$smarty->assign('NUMSKILLS', sizeof($skills)-1);
$smarty->assign('SKILLS', $skills);
$smarty->assign('NUMGEOSKILLS', sizeof($geoskills)-1);
$smarty->assign('GEOSKILLS', $geoskills);
$smarty->assign('TOTALUSERS', $total);
$smarty->assign('NUMUSERS', sizeof($users));
$smarty->assign('USERS', $users);
$smarty->display('miembros.tpl');
?>