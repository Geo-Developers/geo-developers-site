<?php

require_once '../config.php';
require_once 'init.php';

if( isset($_SESSION['user']['meetup_id']) ){
    $GeodevDB = new GeodevDB();
    $video = $GeodevDB->getVideo(array(
        "youtubeId" => $_GET["id"],
        "meetupId" => $_SESSION['user']['meetup_id']
    ));
    
    
    if($video["length"] == 0){
        header('Location: '.$ROOT.'academy/');
    }

    // Get user preferences
    $user = new Member(array("meetup_id" => $_SESSION["user"]["meetup_id"]));
    $preferences = $user->getPreferences();

    $smarty->assign('INTERESTS', $preferences["interests"]);
    $smarty->assign('GROUPINGS', $preferences["groupings"]);

    $smarty->assign('VIDEO', $video);

    $smarty->assign('TYPE', "academy");
	$smarty->display('view.tpl');
}else{
  $_SESSION['returnURL'] = "http://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
  header('Location: '.$ROOT.'login/');
}

?>