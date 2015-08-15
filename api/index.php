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

$app->delete('/user/:userid/skill', function ($userId) use ($app, $db) {

    if(isset($_SESSION['user']['meetup_id'])) {
        $meetup_id = $_SESSION['user']['meetup_id'];

        if (intval($userId) !== intval($meetup_id)) {
            $data = array(
                'status' => 'error',
                'message' => 'Forbidden, you are: ' . $meetup_id
            );
        } else {
            $db->where("skill_id",$_POST["skill_id"]);
            if($db->delete('user_skills')){
                $data = array(
                    'status' => 'success',
                    'message' => 'Skill removed from the user'
                );
            }else{
                $data = array(
                    'status' => 'error',
                    'message' => 'The skill could not be removed from the user'
                );
            }
        }
    }else{
        $data = array(
            'status' => 'error',
            'message' => 'You must be authenticated'
        );
    }

    echo json_encode($data);
});

$app->post('/user/:userid/skill', function ($userId) use ($app, $db) {
    if(isset($_SESSION['user']['meetup_id'])) {
        $meetup_id = $_SESSION['user']['meetup_id'];

        if (intval($userId) !== intval($meetup_id)) {
            $data = array(
                'status' => 'error',
                'message' => 'Forbidden, you are: ' . $meetup_id
            );
        } else {
            $skill_name = $_POST["skill_name"];
            $db->where("name", $skill_name);
            $elem = $db->getOne("skills");


            if(!$elem){
                // Its a new skill
                $data = array(
                    "name" => $skill_name,
                    "is_important" => 1
                );
                if(isset($_POST["is_gis"])){
                    $data["is_gis"] = 1;
                }
                $id = $db->insert("skills",$data);
                if(!$id){
                    $data = array(
                        'status' => 'error',
                        'message' => 'The skill could not be added to the database'
                    );
                }
            }else{
                $id = $elem["id"];
            }



            $db->where("skill_id", $id);
            $db->where("meetup_id", $meetup_id);
            $elem = $db->getOne("user_skills");

            if(!$elem){
                $res = $db->insert("user_skills",array(
                    "meetup_id" => $meetup_id,
                    "skill_id" => $id
                ));
                if($res){
                    $data = array(
                        'status' => 'success',
                        'message' => $id
                    );
                }else{
                    $data = array(
                        'status' => 'error',
                        'message' => 'The skill could not be added to the user'
                    );
                }
            }else{
                $db->where("skill_id", $id);
                $db->where("meetup_id", $meetup_id);
                $res = $db->update("user_skills",array(
                    "meetup_id" => $meetup_id,
                    "skill_id" => $id,
                    "level" => $_POST["level"]
                ));
                if($res){
                    $data = array(
                        'status' => 'success',
                        'message' => $id
                    );
                }else{
                    $data = array(
                        'status' => 'error',
                        'message' => 'The skill could not be added to the user'
                    );
                }
            }
            /*{
                //This is not a new skill
                $data = array(
                    'status' => 'error',
                    'message' => 'You already have this skill'
                );
            }*/


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