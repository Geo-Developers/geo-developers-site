<?php
session_start();
header('Content-Type: application/json');
require '../vendor/slim/slim/Slim/Slim.php';
require_once ('../vendor/joshcam/mysqli-database-class/MysqliDb.php');
require_once ('../config.php');

$db = new MysqliDb (Array (
        'host' => $dbhost,
        'username' => $dbuser,
        'password' => $dbpass,
        'db'=> $dbname,
        'charset' => 'utf8')
);

\Slim\Slim::registerAutoloader();

$app = new \Slim\Slim();

$app->get('/user/:userid', function ($userid) use ($app, $db){

});

$app->post('/user/:userid/update', function ($userId) use ($app, $db){

    if(isset($_SESSION['user_id'])){
        if(intval($userId) !== intval($_SESSION['user_id'])){
            $data = array(
                'response' => 'error',
                'message' => 'Tu no eres este!, eres'.$_SESSION['user_id']
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
                'response' => 'success',
                'message' => $message
            );
        }
    }else{
        $data = array(
            'response' => 'error',
            'message' => 'Debes estar autenticado'
        );
    }
    echo json_encode($data);
});
$app->run();
?>