<?php
require_once '../config.php';
require_once 'init.php';

/*prettyprint($_POST);
die("ya!");*/

if(!isset($_SESSION["logged"])){
    header('Location: '.$ROOT.'login/?returnURL='.$_SERVER['REQUEST_URI']);
}

if(intval($_SESSION["user"]["meetup_id"]) === intval($_GET["meetup_id"])){
    $GeodevDB = new GeodevDB(array("meetup_id" => $_GET["meetup_id"]));

    if(!empty($_POST)){
        $user = new Member(array("meetup_id" => $_SESSION["user"]["meetup_id"]));

        /*prettyprint($_POST);
        die("Ya");*/
        $errorMessage = "";
        if($_FILES["photo"]["name"]){
            $path = uploadFile($_SESSION["user"]["meetup_id"]);
            if($path["status"] === "error"){
                $errorMessage .= $path["response"];
            }else{
                $user->photo_url = $path["response"];
            }
        }

        //die("Path = ".$path);

        $user->update($_POST);

        if($user->save() && $errorMessage !== ""){
            $smarty->assign('MESSAGE', "El perfil ha sido actualizado con éxito");
        }
        else{
            $smarty->assign('MESSAGE', $errorMessage);
        }

        $userprofile = $user->getUserProfile();
        $_SESSION['user'] = $userprofile;

    }else{
        $userprofile = $GeodevDB->getUser(array("type" => "userprofile"));
    }

    $smarty->assign('PROFILE',      $userprofile);
    $smarty->assign('SKILLSGIS',    $GeodevDB->getUserSkills(array("type" => "gis")));
    $smarty->assign('SKILLS',       $GeodevDB->getUserSkills(array("type" => "other")));
    $smarty->assign('REFERRERS',    $GeodevDB->getReferrers());
    $smarty->assign('ACTION',       'edit');

    $smarty->display('profile.tpl');

}else{
    prettyprint($_SESSION);
    echo "Estás intentando editar el perfil de otro usuario, si crees que esto es un error por favor contacta con root@geodevelopers.org";
    echo $_SESSION["user"]["meetup_id"].",".$_GET["meetup_id"];
}

function uploadFile($name){
    global $ROOT;
    $target_dir = "../images/photos/";

    $tmp_name = $target_dir . basename($_FILES["photo"]["name"]);
    $imageFileType = pathinfo($tmp_name,PATHINFO_EXTENSION);
    $target_file = $target_dir . basename($_SESSION["user"]["meetup_id"].".".$imageFileType);
    // Check if image file is a actual image or fake image
    if(isset($_POST["submit"])) {
        $check = getimagesize($_FILES["photo"]["tmp_name"]);
        if($check === false) {
            return array(
                "status" => "error",
                "response" => "File is not an image."
            );
        }
    }
    if (file_exists($target_file)) {
        unlink($target_file);
    }
    // Check file size
    if ($_FILES["photo"]["size"] > 500000) {
        return array(
            "status" => "error",
            "response" => "Sorry, your file is too large."
        );
    }
    // Allow certain file formats
    if($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg"
        && $imageFileType != "gif" ) {
        return array(
            "status" => "error",
            "response" => "Sorry, only JPG, JPEG, PNG & GIF files are allowed."
        );
    }

    if (move_uploaded_file($_FILES["photo"]["tmp_name"], $target_file)) {
        echo "The file ". basename( $_FILES["photo"]["name"]). " has been uploaded.";

        return array(
            "status" => "success",
            "response" => "http://".$_SERVER['HTTP_HOST'].$ROOT."images/photos/".$_SESSION["user"]["meetup_id"].".".$imageFileType
        );
    } else {
        return array(
            "status" => "error",
            "response" => "Sorry, there was an error uploading your file."
        );
    }

}
?>
