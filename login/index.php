<?php
require_once '../config.php';
require_once 'init.php';

if( !isset($_SESSION['user_id']) ){
	if(isset($_SESSION['returnURL'])){
		$smarty->assign('returnURL', $_SESSION['returnURL']);
	}
	$smarty->display('login.tpl');
}else{
	if( !isset($_SESSION['logged']) ){
		header('Location: '.$ROOT.'register/');
	}else{
		header('Location: '.$_GET['returnURL']);
	}
	
}
?>