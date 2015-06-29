<?php

$ROOT = "../";
include($ROOT."config.php");

$smarty->assign('ROOT', $ROOT);
$smarty->assign('TYPE', "webinars");
$smarty->display('view.tpl');

?>