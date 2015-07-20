<?php
	$ROOT = "../";
	include($ROOT."init.php");

	session_start();
	session_destroy();

	header('Location: '. $ROOT);
?>