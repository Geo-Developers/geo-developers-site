<?php
require_once("../../config.php");
require_once("init.php");

$db->orderBy("publishedAt","desc");
$date = getdate();
$db->where('eventDate',$date["year"] ."-". $date["mon"]."-".$date["mday"],">=");
$webinars = $db->get('videos');
if ($db->count > 0){

    /*for ($i=0; $i<sizeof($videos); $i++) {
        $webinars[$i]["publishedAt"] = date('d-m-Y', strtotime($webinars[$i]["publishedAt"]));
        if($webinars[$i]["duration"]){
            $webinars[$i]["duration"] = covtime($videos[$i]["duration"]);
        }
    }*/

    $smarty->assign('WEBINARS', $webinars);
}

$smarty->display('webinars.tpl');

?>