<?php

$ROOT = "../";
include($ROOT."config.php");

$smarty->assign('ROOT', $ROOT);
$smarty->display('recursos.tpl');

?>