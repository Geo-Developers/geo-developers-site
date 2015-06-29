<?php

$ROOT = "../";
include($ROOT."config.php");

$smarty->assign('ROOT', $ROOT);
$smarty->assign('TYPE', "academy");
$smarty->display('view.tpl');

?>