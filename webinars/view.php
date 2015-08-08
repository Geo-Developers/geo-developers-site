<?php

require_once '../config.php';
require_once 'init.php';

$smarty->assign('TYPE', "webinars");
$smarty->display('view.tpl');

?>