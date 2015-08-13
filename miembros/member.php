<?php
require_once '../config.php';
require_once 'init.php';

$db->where("meetup_id", $_GET["query"]);
$user = $db->getOne("users");

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
    $profile = $db->where("meetup_id", $_GET["query"])->getOne("profiles");
    $profile["joined"] = date('d/m/Y', strtotime($profile["joined"]));
    if(isset($profile["twitter_url"])){
        $profile["twitter_name"] = $profile["twitter_url"];
        $profile["twitter_url"] = "http://www.twitter.com/".substr($profile["twitter_url"], 1);
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

    $smarty->assign('PROFILE', $profile);

    $smarty->assign('NREFERRERS', sizeof($referrers));
    $smarty->assign('REFERRERS', $referrers);

    $smarty->assign('NUMSKILLSGIS', $numSkillsGIS);
    $smarty->assign('NUMSKILLS', $numSkills);
    $smarty->assign('SKILLSGIS', $skillsGis);
    $smarty->assign('SKILLS', $skills);
    $smarty->assign('USERPROFILE', $user);
    $smarty->display('perfil.tpl');
}else{
    echo "Error el usuario no existe en la base de datos";
}
?>