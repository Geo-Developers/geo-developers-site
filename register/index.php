<?php

require_once("../config.php");
require_once("init.php");

//First we will check if the user is already registered
$mysqli = mysqli_connect($dbhost, $dbuser, $dbpass, $dbname);
if ($mysqli->connect_error) {
  die('Connect Error (' . $mysqli->connect_errno . ') '. $mysqli->connect_error);
}

$query = 'SELECT * FROM `users` WHERE id='.$_SESSION['user_id'];

if (!$result = $mysqli->query($query)) {
  die('Invalid query: '. $query . mysql_error());
}else{
  if($result->num_rows == 0){
    $new_user = true;
  }else{
    $_SESSION['logged'] = true;
    
    $obj = $result->fetch_object();
    $_SESSION['email'] = $obj->email;
    $_SESSION['name'] = $obj->name;
    header('Location: '.$returnURL);
  }
  $result->close();
}

//New user without trying to register
if($new_user && isset($_POST["name"]) ){
	$name = $_POST["name"];
  $id = $_POST["id"];
  $email = $_POST["email"];
  
  $query= "INSERT INTO `geodevelopers`.`users` (`id`, `name`, `email`) VALUES ('$id', '$name', '$email')";

  if ($mysqli->query($query) !== TRUE) {
    die("The user could not be added, please contact to the webmaster at root@geodevelopers.org");
  }else{
    $_SESSION['logged'] = true;
    $_SESSION['email'] = $email;
    $_SESSION['name'] = $name;
    header('Location: '. $returnURL);
  }
}

if( isset($_SESSION['user_id']) && !isset($_SESSION['logged']) ){
 $smarty->assign('USER_ID', $_SESSION['user_id']);
 $smarty->assign('NAME', $_SESSION['name']);
 $smarty->assign('PHOTO', $_SESSION['photo']);
 if(isset($_SESSION['returnURL'])){
  $smarty->assign('returnURL', $_SESSION['returnURL']);
}
$smarty->display('register.tpl');

}else{
 
 if(isset($_GET['returnURL'])){
  header('Location: '.$_GET['returnURL']);
}else{
  header('Location: '.$ROOT);
}  
}
?>