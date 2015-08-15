<?php

require_once '../config.php';
require_once 'init.php';

$service = new GeodevDB();

if(isset($_GET['tech']) && $_GET['tech']){
    $users = $service->getExperts(array("tech" => $_GET['tech']));
    $smarty->assign('TECH', $_GET['tech']);
}else{
    $users = $service->getMembers();
}

$total = $db->getValue("profiles", "count(meetup_id)");
$skills = $service->getSkills(array("type" => "other"));
$geoskills = $service->getSkills(array("type" => "geo"));

$smarty->assign('SKILLS', $skills);
$smarty->assign('GEOSKILLS', $geoskills);
$smarty->assign('TOTALUSERS', $total);
$smarty->assign('USERS', $users);
$smarty->display('miembros.tpl');
?>