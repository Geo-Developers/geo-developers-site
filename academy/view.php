<?php

session_start();

$ROOT = "../";
include($ROOT."init.php");

if( isset($_SESSION['user_id']) ){
	$smarty->assign('ROOT', $ROOT);
	$smarty->assign('TYPE', "academy");

	$smarty->display('view.tpl');
}else{
  $_SESSION['returnURL'] = "http://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
  header('Location: ../login/');
}

?>