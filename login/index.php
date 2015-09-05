<?php
require_once '../config.php';
require_once 'init.php';


if( !isset($_SESSION["user"]['meetup_id']) || !isset($_SESSION["logged"]) ){
	if(isset($_SESSION['returnURL'])){
		$smarty->assign('returnURL', $_SESSION['returnURL']);
	}
	$smarty->display('login.tpl');
}else{
	if( !isset($_SESSION['logged']) ){
		header('Location: '.$ROOT.'register/');
	}else{
		if(isset($_GET['returnURL'])){
            header('Location: '.$_GET['returnURL']);
        }else{
            header('Location: '.$ROOT);
        }
	}
	
}
?>