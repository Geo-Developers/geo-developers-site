<?php

require_once '../config.php';
require_once 'init.php';

$GeodevDB = new GeodevDB();

if(isset($_GET['tech']) && $_GET['tech']){
    $users = $GeodevDB->getExperts(array("tech" => $_GET['tech']));
    $smarty->assign('TECH', $_GET['tech']);
}else{
    $users = $GeodevDB->getMembers();
}

$smarty->assign('SKILLS',       $GeodevDB->getSkills(array("type" => "other")));
$smarty->assign('GEOSKILLS',    $GeodevDB->getSkills(array("type" => "geo")));
$smarty->assign('TOTALUSERS',   $db->getValue("profiles", "count(meetup_id)"));
$smarty->assign('USERS',        $users);
$smarty->display('miembros.tpl');
?>