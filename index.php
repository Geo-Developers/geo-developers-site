<?php

$ROOT = "";
include($ROOT."init.php");

$smarty->assign('ROOT', $ROOT);
//$smarty->assign('USER_ID', null);
$smarty->display('index.tpl');

?>