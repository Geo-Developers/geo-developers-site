<?php
require_once("../../config.php");
require_once("init.php");

$db->orderBy("publishedAt","desc");
$date = getdate();
$db->where('eventDate',$date["year"] ."-". $date["mon"]."-".$date["mday"],">=");
$webinars = $db->get('videos');
if ($db->count > 0){

    $smarty->assign('WEBINARS', $webinars);
}

$smarty->display('webinars.tpl');

?>