<?php

require_once '../config.php';
require_once 'init.php';

if( isset($_SESSION['user']['meetup_id']) ){
    $GeodevDB = new GeodevDB();
    $video = $GeodevDB->getVideo(array(
        "youtubeId" => $_GET["id"],
        "meetupId" => $_SESSION['user']['meetup_id']
    ));

    $smarty->assign('VIDEO', $video);

    $smarty->assign('TYPE', "academy");
	$smarty->display('view.tpl');
}else{
  $_SESSION['returnURL'] = "http://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
  header('Location: '.$ROOT.'login/');
}

?>