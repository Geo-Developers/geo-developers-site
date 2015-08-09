<?php

header('Content-Type: application/json');
require_once '../config.php';
require_once 'init.php';
require_once 'vendor/slim/slim/Slim/Slim.php';

\Slim\Slim::registerAutoloader();

$app = new \Slim\Slim();

$app->get('/user/:userid', function ($userid) use ($app, $db){

});

$app->post('/user/:userid', function ($userId) use ($app, $db){
    $userAttrs = array("cookies", "newsletter");
    /*$data = Array (
        "id" => $_POST["id"],
        "name" => $_POST["name"],
        "email" => $_POST["email"]
    );*/


    if(isset($_SESSION['user_id'])) {
        if (intval($userId) !== intval($_SESSION['user_id'])) {
            $data = array(
                'status' => 'error',
                'message' => 'Forbidden, you are: ' . $_SESSION['user_id']
            );
        } else {
            $userAttrs = array("cookies", "newsletter");
            $data = insertOrUpdate($db, 'users', $userAttrs, $_SESSION['user_id']);
        }
    }else{
        $data = array(
            'status' => 'error',
            'message' => 'You must be authenticated'
        );
    }

    echo json_encode($data);
});

$app->post('/video/:videoid', function ($userId) use ($app, $db){


    if(isset($_SESSION['user_id'])) {

        $videoAttrs = array("id", "title", "publishedAt", "duration", "viewCount", "likeCount", "tags");
        $data = insertOrUpdate($db, 'videos', $videoAttrs, $_POST['id']);

    }
    echo json_encode($data);
});

function insertOrUpdate($db,$table,$attrs,$id){
    $data = array();

    foreach($attrs as $attr){
        if(isset($_POST[$attr])){

            if(is_array($_POST[$attr])){
                //print_r($_POST[$attr]);
                $data[$attr] = implode(',', $_POST[$attr]);
            }else{
                $data[$attr] = $_POST[$attr];
            }
        }
    }

    $db->where("id", $id);
    $elem = $db->getOne($table);
    if($elem){

        $db->where("id", $id);
        if ($db->update($table, $data))
            $message = $db->count . ' records were updated';
        else
            $message = 'update failed: ' . $db->getLastError();
    }else{
        if($id = $db->insert ($table, $data))
            $message = $db->count . ' records were added';
        else
            $message = 'insetion failed: ' . $db->getLastError();
    }
    return array(
        'status' => 'success',
        'message' => $message
    );
}

$app->run();
?>