<?php



$ROOT = "../";
include($ROOT."init.php");

if( isset($_SESSION['logged']) ){
	$smarty->assign('ROOT', $ROOT);
	


	$smarty->display('academy.tpl');


}else{
	$_SESSION['returnURL'] = "http://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
  header('Location: ../login/');
}


?>