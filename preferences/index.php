<?php

require_once '../config.php';
require_once 'init.php';


if( isset($_SESSION['logged']) ){

    // Get user preferences
    $user = new Member(array("meetup_id" => $_SESSION["user"]["meetup_id"]));
    $preferences = $user->getPreferences();

    $smarty->assign('INTERESTS', $preferences["interests"]);
    $smarty->assign('GROUPINGS', $preferences["groupings"]);

    $smarty->display('avisos.tpl');
}else{
    $_SESSION['returnURL'] = "http://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
    header('Location: '.$ROOT.'login/');
}

?>