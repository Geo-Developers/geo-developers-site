<?php
require_once '../config.php';

function getMeetupMember($idOrArray, $type)
{
    global $meetup_api_key;

    if(is_array($idOrArray)){
        $response = $idOrArray;
        $meetup_id = $idOrArray["id"];
    }else{
        $client = DMS\Service\Meetup\MeetupKeyAuthClient::factory(array('key' => $meetup_api_key));
        $response = $client->getMember(array('id' => $idOrArray));
        $meetup_id = $idOrArray;
    }

    switch($type){
        case "profile":
            //TODO: change this using profile joined
            // This is when he joined to meetup, not to
            $epoch = $response["joined"];
            $epoch = substr($epoch,0, -3);
            $dt = new DateTime("@$epoch");
            $date = $dt->format('Y-m-d');

            $data = array(
                "meetup_id"     => $response["id"],
                "location"      => $response["city"],
                "joined"        => $date,
                "meetup_url"    => $response["link"],
                "lat"           => $response["lat"],
                "lon"           => $response["lon"]
            );

            if (isset($response["photo"]["highres_link"])) {
                $data["photo_url"] = $response["photo"]["highres_link"];
            } elseif (isset($response["photo"]["photo_link"])) {
                $data["photo_url"] = $response["photo"]["photo_link"];
            } elseif (isset($response["photo"]["thumb_link"])) {
                $data["photo_url"] = $response["photo"]["thumb_link"];
            }

            foreach ($response["other_services"] as $key => $service) {
                $data[$key . "_url"] = $service["identifier"];
            }

            return $data;

            break;
        case "skills":
            $skills = array();
            $user_skills = array();

            foreach($response["topics"] as $topic) {
                array_push($skills, array(
                    "meetup_skill_id"   => $topic["id"],
                    "name"              => $topic["name"],
                    "slug"              => $topic["urlkey"],
                ));

                array_push($user_skills, array(
                    "meetup_skill_id"   => $topic["id"],
                    "meetup_id"         => $meetup_id
                ));
            }

            return array(
                "skills"        => $skills,
                "user_skills"   => $user_skills
            );

            break;
        default:
            die("Add a $type to getMeetupMember!");
    }
}

?>