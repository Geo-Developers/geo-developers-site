<?php
require_once '../config.php';
require_once 'init.php';

$GeodevDB = new GeodevDB(array("meetup_id" => $_GET["query"]));

$userprofile = $GeodevDB->getUser(array("type" => "userprofile"));

if($userprofile){

    $smarty->assign('PROFILE', $userprofile);
    $smarty->assign('SKILLSGIS', $GeodevDB->getUserSkills(array("type" => "gis")));
    $smarty->assign('SKILLS', $GeodevDB->getUserSkills(array("type" => "other")));
    $smarty->assign('REFERRERS', $referrers = $GeodevDB->getReferrers());
    $smarty->assign('ACTION', "view");

    $smarty->assign('ISRECOMMENDED', false);
    if(isset($_SESSION["user"])){
        if($GeodevDB->getIsReferred(array("referrer" => $_SESSION["user"]["meetup_id"]))){
            $smarty->assign('ISRECOMMENDED', true);
        }
    }

    $smarty->display('profile.tpl');
}else{
    echo "Error el usuario no existe en la base de datos";
}
?>