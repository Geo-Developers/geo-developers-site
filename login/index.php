<?php
session_start();
$ROOT = "../";
include($ROOT."init.php");

if( !isset($_SESSION['user_id']) ){
	$smarty->assign('ROOT', $ROOT);
	$smarty->display('login.tpl');
}else{
	if(isset($_GET['returnURL'])){
		header('Location: '.$_GET['returnURL']);
	}else{
		header('Location: /');
	}
  
}
?>