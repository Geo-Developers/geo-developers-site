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

    if(isset($_SESSION['user']['meetup_id'])) {
        $meetup_id = $_SESSION['user']['meetup_id'];

        if (intval($userId) !== intval($meetup_id)) {
            $data = array(
                'status' => 'error',
                'message' => 'Forbidden, you are: ' . $meetup_id
            );
        } else {
            $userAttrs = array("cookies", "mailchimp_euid");
            $data = insertOrUpdate($db, 'users', $userAttrs, $meetup_id, "meetup_id");
        }
    }else{
        $data = array(
            'status' => 'error',
            'message' => 'You must be authenticated'
        );
    }

    echo json_encode($data);
});

$app->post('/vote/:userid', function ($userId) use ($app, $db){

    if(isset($_SESSION['user']['meetup_id'])) {
        $meetup_id = $_SESSION['user']['meetup_id'];

        if (intval($userId) === intval($meetup_id)) {
            $data = array(
                'status' => 'error',
                'message' => 'You can not vote for yourself'
            );
        } else {

            $db->where("referrer",$meetup_id)->where("refered",$userId);
            if($elem = $db->getOne('votes')){
                $db->where("referrer",$meetup_id)->where("refered",$userId);
                $db->delete('votes');
                $data = array(
                    'status' => 'success',
                    'recommended' => false,
                    'message' => 'Vote successfully removed'
                );
            }else{
                $db->insert('votes', array(
                    "referrer" => $meetup_id,
                    "refered" => $userId
                ));
                $data = array(
                    'status' => 'success',
                    'recommended' => true,
                    'message' => 'Vote successfully added'
                );
            }
            $votesAttrs = array("referrer", "refered");
            //$data = insertOrUpdate($db, 'votes', $votesAttrs, $meetup_id, "meetup_id");
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


    if(isset($_SESSION['user']['meetup_id'])) {
        $videoAttrs = array("id", "title", "publishedAt", "duration", "viewCount", "likeCount", "tags");
        $data = insertOrUpdate($db, 'videos', $videoAttrs, $_POST['id'], "id");

    }
    echo json_encode($data);
});

function insertOrUpdate($db, $table, $attrs, $id, $where){
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

    $db->where($where, $id);
    $elem = $db->getOne($table);
    if($elem){

        $db->where($where, $id);

        if ($db->update($table, $data))
            $message = $db->count . ' records were updated';
        else
            $message = 'update failed: ' . $db->getLastError();
    }else{
        if($id = $db->insert($table, $data))
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