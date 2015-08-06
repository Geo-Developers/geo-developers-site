<?php
session_start();
$ROOT = "../";
include($ROOT."init.php");

if( !isset($_SESSION['user_id']) ){
	$smarty->assign('ROOT', $ROOT);
	if(isset($_SESSION['returnURL'])){
		$smarty->assign('returnURL', $_SESSION['returnURL']);
	}
	$smarty->display('login.tpl');
}else{
	if(isset($_GET['returnURL'])){
		header('Location: '.$_GET['returnURL']);
	}else{
		header('Location: /');
	}
  
}
?>