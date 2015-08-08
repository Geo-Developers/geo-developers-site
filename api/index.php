<?php

header('Content-Type: application/json');
require_once '../config.php';
require_once 'init.php';
require_once 'vendor/slim/slim/Slim/Slim.php';

\Slim\Slim::registerAutoloader();

$app = new \Slim\Slim();

$app->get('/user/:userid', function ($userid) use ($app, $db){

});

$app->post('/user/:userid/update', function ($userId) use ($app, $db){

    if(isset($_SESSION['user_id'])){
        if(intval($userId) !== intval($_SESSION['user_id'])){
            $data = array(
                'status' => 'error',
                'message' => 'Forbidden, you are: '.$_SESSION['user_id']
            );
        }else{
            $data = array();
            $userAttrs = array("cookies", "newsletter");

            foreach($userAttrs as $attr){
                if(isset($_POST[$attr])){
                    $data[$attr] = $_POST[$attr];
                }
            }

            $db->where("id", $userId);
            if ($db->update('users', $data))
                $message = $db->count . ' records were updated';
            else
                $message = 'update failed: ' . $db->getLastError();

            $data = array(
                'status' => 'success',
                'message' => $message
            );
        }
    }else{
        $data = array(
            'status' => 'error',
            'message' => 'You must be authenticated'
        );
    }
    echo json_encode($data);
});
$app->run();
?>