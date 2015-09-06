<?php

require_once '../../config.php';
require_once 'init.php';

$GeodevDB = new GeodevDB();
$video = $GeodevDB->getVideo(array("youtubeId" => $_GET["id"]));

$smarty->assign('VIDEO', $video);
$smarty->assign('TYPE', "webinars");
$smarty->display('view.tpl');

?>