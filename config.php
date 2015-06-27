<?php
	

	require($ROOT.'smarty-3.1.21/libs/Smarty.class.php');
	ini_set('date.timezone', 'Europe/Berlin');
	$smarty = new Smarty();

	$smarty->setTemplateDir($ROOT.'smarty/templates');
	$smarty->setCompileDir($ROOT.'smarty/templates_c');
	$smarty->setCacheDir($ROOT.'smarty/cache');
	$smarty->setConfigDir($ROOT.'smarty/configs');
 
?>