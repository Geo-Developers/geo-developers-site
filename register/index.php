<?php
require_once '../config.php';
require_once 'init.php';
require_once 'modules/getMeetupMember.php';
require_once 'modules/Member.php';
require_once 'modules/Skill.php';

// The constructor loads all information available from
// the database or directly using the Meetup API
if(!isset($_SESSION["user"])){
    header('Location: '. $ROOT.'login');
}

$member = new Member(array(
    "meetup_id" => $_SESSION["user"]["meetup_id"]
));


if(isset($_SESSION['returnURL'])){
    $returnURL = $_SESSION['returnURL'];
}

if($member->isRegistered()){
    $_SESSION['logged'] = true;
    $_SESSION["user"]['email'] = $member->email;
    $_SESSION["user"]['name'] = $member->name;
    if(isset($returnURL)){
        unset($_SESSION['returnURL']);
        header('Location: '. $returnURL);
    }else{
        header('Location: '. $ROOT);
    }
}else{
    $new_user = true;
}

//Add new user to the database $_POST
if($new_user && isset($_POST["name"]) ){

    // Firts join to meetup if neccessary
    $answers = array();

    if(isset($_POST['skills'])){
        $service = new Skill();
        for($i=0; $i< sizeof($_POST['skills']); $i++){
            $skill=$_POST['skills'][$i];
            $s = $service->find(array("name" => $skill));

            //TODO: FIX THIS and submit profile
            if(!isset($member->skills[$s["name"]])){
                $member->skills[$s["name"]] = $s;
            }

            if($i < sizeof($_POST['skills']) - 2){
              $answers["answer_6865152"] .= $s["name"] . ", ";
            }elseif($i == sizeof($_POST['skills']) - 2){
              $answers["answer_6865152"] .= $s["name"] . " y ";
            }else{
              $answers["answer_6865152"] .= $s["name"] . ".";
            }
        }
    }

    if(isset($_POST['linkedin_url'])){
        $answers["answer_8151456"] = $_POST['linkedin_url'];
    }

    if(!$member->joined){
        $member->joinToMeetup($answers);
        $member->loadFromMeetup();
    }

    if(!$member->joined){
      $member->loadFromMeetup();
    }

    $member->email = $_POST["email"];
    $member->name = $_POST["name"];
    $member->last_name = $_POST["last_name"];

    if(isset($_POST['linkedin_url'])) {
        $member->linkedin_url = $_POST["linkedin_url"];
    }

    $member->save();

    $_SESSION['logged'] = true;
    $_SESSION["user"]['email'] = $member->email;
    $_SESSION["user"]['name'] = $member->name;
    if(isset($returnURL)){
        unset($_SESSION['returnURL']);
        header('Location: '. $returnURL);
    }else{
        header('Location: '. $ROOT);
    }
}

// Register $_GET
if( isset($_SESSION["user"]['meetup_id']) && !isset($_SESSION['logged']) ){

    $GeodevDB = new GeodevDB(array("meetup_id" => $member->meetup_id));
    $userprofile = $GeodevDB->getUser(array("type" => "userprofile"));

    if($userprofile){
        //User is in the database
        $smarty->assign('USER', $userprofile);
    }elseif(isset($_SESSION["meetup_member"])){
      // TODO: is that right? if never joined before do we have a joined date?
      $smarty->assign('USER', array(
        "name" => $_SESSION["meetup_member"]->name,
        "joined" => $member->parseEpoch($_SESSION["meetup_member"]->joined),
        "photo_url" => $_SESSION['photo_url']
      ));
    }

    $smarty->assign('GEOSKILLS', $GeodevDB->getSkills(array("type" => "geo")));
    $smarty->assign("SESSION",$_SESSION);


    $smarty->display('register.tpl');

}else{
    if(isset($_GET['returnURL'])){
        header('Location: '.$_GET['returnURL']);
    }else{
        header('Location: '.$ROOT);
    }
}
?>