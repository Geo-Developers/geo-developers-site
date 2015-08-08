<?php

require_once '../config.php';
require_once 'init.php';

$smarty->assign('ROOT', $ROOT);
$smarty->display('miembros.tpl');

?>