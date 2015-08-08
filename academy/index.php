<?php

require_once '../config.php';
require_once 'init.php';

if( isset($_SESSION['logged']) ){
	$smarty->display('academy.tpl');
}else{
	$_SESSION['returnURL'] = "http://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
  header('Location: '.$ROOT.'login/');
}

?>