<?php

require_once '../config.php';
require_once 'init.php';

$total = $db->getValue("profiles", "count(meetup_id)");

$db->join("users u", "u.meetup_id=p.meetup_id", "LEFT");
$db->orderBy("p.progress","desc");
//$db->where("u.id", 6);
$users = $db->get("profiles p", null /*24*/, "u.meetup_id, u.name, p.meetup_url, p.progress, p.photo_url, p.location");

$smarty->assign('TOTALUSERS', $total);
$smarty->assign('NUMUSERS', sizeof($users)-1);
$smarty->assign('USERS', $users);
$smarty->display('miembros.tpl');

?>