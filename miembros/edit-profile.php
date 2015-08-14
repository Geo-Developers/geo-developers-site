<?php
require_once '../config.php';
require_once 'init.php';

if(intval($_SESSION["user"]["meetup_id"]) === intval($_GET["meetup_id"])){

    $GeodevDB = new GeodevDB(array("meetup_id" => $_GET["meetup_id"]));

    $smarty->assign('PROFILE', $GeodevDB->getUser(array("type" => "userprofile")));
    $smarty->assign('SKILLSGIS', $GeodevDB->getUserSkills(array("type" => "gis")));
    $smarty->assign('SKILLS', $GeodevDB->getUserSkills(array("type" => "other")));
    $smarty->assign('REFERRERS', $referrers = $GeodevDB->getReferrers());
    $smarty->assign('ACTION', 'edit');
    $smarty->display('profile.tpl');

}else{
    echo "Estás intentando editar el perfil de otro usuario, si crees que esto es un error por favor contacta con root@geodevelopers.org";
    echo $_SESSION["user"]["meetup_id"].",".$_GET["meetup_id"];
}

?>
