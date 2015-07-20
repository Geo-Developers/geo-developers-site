<?php

$ROOT = "../";
include($ROOT."init.php");

$smarty->assign('ROOT', $ROOT);
$smarty->display('tutoriales.tpl');

?>