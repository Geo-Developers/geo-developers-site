<?php
$ROOT = "../";
include($ROOT."init.php");

if( !isset($_SESSION['user_id']) ){
	$smarty->assign('ROOT', $ROOT);
	if(isset($_SESSION['returnURL'])){
		$smarty->assign('returnURL', $_SESSION['returnURL']);
	}
	$smarty->display('login.tpl');
}else{
	if( !isset($_SESSION['logged']) ){
		header('Location: ../register/');
	}else{
		header('Location: '.$_GET['returnURL']);
	}
	
}
?>