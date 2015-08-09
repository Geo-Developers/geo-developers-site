<?php
require_once '../config.php';
require_once 'init.php';

$db->where ("id", $_GET["query"]);
$user = $db->getOne ("users");
if($user){
    $db->where ("user_id", $_GET["query"]);
    $db->orderBy("level","desc");
    $skills = $db->get ("skills");
    $numSkills = sizeof($skills)-1;
    $profile = $db->where("meetup_id", $_GET["query"])->getOne("profiles");


    $smarty->assign('PROFILE', $profile);
    $smarty->assign('NUMSKILLS', $numSkills);
    $smarty->assign('SKILLS', $skills);

    $smarty->assign('USER', $user);
    $smarty->display('perfil.tpl');
}else{
    echo "Error el usuario no existe en la base de datos";
}
?>