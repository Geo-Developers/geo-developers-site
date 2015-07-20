<?php

session_start();

$ROOT = "../";
include($ROOT."init.php");

if( isset($_SESSION['user_id']) ){
	$smarty->assign('ROOT', $ROOT);
	
	$smarty->assign('USER_ID', $_SESSION['user_id']);
  $smarty->assign('BIO', $_SESSION['bio']);
  $smarty->assign('NAME', $_SESSION['name']);
  $smarty->assign('MEMBER_URL', $_SESSION['member_url']);
  $smarty->assign('PHOTO', $_SESSION['photo']);
  $smarty->assign('TWITTER', $_SESSION['twitter']);
  $smarty->assign('CITY', $_SESSION['city']);

	$smarty->display('academy.tpl');


}else{
	$_SESSION['returnURL'] = "http://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
  header('Location: ../login/');
}


?>