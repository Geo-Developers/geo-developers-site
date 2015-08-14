<?php
require_once '../config.php';
require_once 'init.php';

$db->join("users u", "u.meetup_id=p.meetup_id", "LEFT");
$db->where("u.meetup_id", $_GET["query"]);
$user = $db->getOne("profiles p");

if($user){
    $db->where("meetup_id", $_GET["query"])->where("is_gis", 1);
    $db->join("user_skills u", "u.skill_id=s.id", "LEFT");
    $db->orderBy("u.level","desc");
    $skillsGis = $db->get("skills s");

    $db->where("meetup_id", $_GET["query"])->where("is_gis IS NULL")->where("is_important",1);
    $db->join("user_skills u", "u.skill_id=s.id", "LEFT");
    $db->orderBy("u.level","desc");
    $skills = $db->get("skills s", null , "u.level, s.name");

    $numSkillsGIS = sizeof($skillsGis);
    $numSkills = sizeof($skills);



    $user["joined"] = date('d/m/Y', strtotime($user["joined"]));
    if(isset($user["twitter_url"])){
        $user["twitter_name"] = $user["twitter_url"];
        $user["twitter_url"] = "http://www.twitter.com/".substr($user["twitter_url"], 1);
    }

    $db->where("refered", $_GET["query"]);
    $db->join("votes v", "v.referrer=p.meetup_id", "LEFT");
    //$db->orderBy("u.level","desc");
    $referrers = $db->get("profiles p");

    $smarty->assign('ISRECOMMENDED', false);
    if(isset($_SESSION["user"])){
        $db->where("refered", $_GET["query"])->where("v.referrer",$_SESSION["user"]["meetup_id"]);
        $db->join("votes v", "v.referrer=p.meetup_id", "LEFT");
        //$db->orderBy("u.level","desc");
        if($db->getOne("profiles p")){
            $smarty->assign('ISRECOMMENDED', true);
        }
    }

    $smarty->assign('PROFILE', $user);

    $smarty->assign('NREFERRERS', sizeof($referrers));
    $smarty->assign('REFERRERS', $referrers);

    $smarty->assign('NUMSKILLSGIS', $numSkillsGIS);
    $smarty->assign('NUMSKILLS', $numSkills);
    $smarty->assign('SKILLSGIS', $skillsGis);
    $smarty->assign('SKILLS', $skills);
    //$smarty->assign('USERPROFILE', $user);
    $smarty->display('perfil.tpl');
}else{
    echo "Error el usuario no existe en la base de datos";
}
?>