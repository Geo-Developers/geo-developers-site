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
/*
    $ids = $db->subQuery ();
    $ids->where ("qty", 2, ">");
    $ids->get ("products", null, "userId");

    $db->where ("id", $ids, 'in');
    $res = $db->get ("users");*/
    $users = $db->rawQuery($query);

    $smarty->assign('TECH', $_GET['tech']);
}else{
    $db->join("users u", "u.meetup_id=p.meetup_id", "LEFT");
    $db->orderBy("p.progress","desc");
    $users = $db->get("profiles p", 24, "u.meetup_id, u.name,  p.progress, p.photo_url, p.location");
}

$total = $db->getValue("profiles", "count(meetup_id)");

$db->where("is_gis","1");
$db->orderBy("name","asc");
$skills = $db->get("skills");

$smarty->assign('NUMGEOSKILLS', sizeof($skills)-1);
$smarty->assign('GEOSKILLS', $skills);
$smarty->assign('TOTALUSERS', $total);
$smarty->assign('NUMUSERS', sizeof($users));
$smarty->assign('USERS', $users);
$smarty->display('miembros.tpl');
?>