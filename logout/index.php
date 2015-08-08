<?php

require_once '../config.php';
require_once 'init.php';

session_start();
session_destroy();

header('Location: '. $ROOT);

?>