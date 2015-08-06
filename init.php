<?php
	
	
	require($ROOT.'smarty-3.1.21/libs/Smarty.class.php');
	ini_set('date.timezone', 'Europe/Berlin');
	$smarty = new Smarty();

	$smarty->setTemplateDir($ROOT.'smarty/templates');
	$smarty->setCompileDir($ROOT.'smarty/templates_c');
	$smarty->setCacheDir($ROOT.'smarty/cache');
	$smarty->setConfigDir($ROOT.'smarty/configs');

	if( isset($_SESSION['user_id']) ){
		$smarty->assign('USER_ID', $_SESSION['user_id']);
	  $smarty->assign('BIO', $_SESSION['bio']);
	  $smarty->assign('NAME', $_SESSION['name']);
	  $smarty->assign('MEMBER_URL', $_SESSION['member_url']);
	  $smarty->assign('PHOTO', $_SESSION['photo']);
	  $smarty->assign('TWITTER', $_SESSION['twitter']);
	  $smarty->assign('CITY', $_SESSION['city']);
	}
 
?>