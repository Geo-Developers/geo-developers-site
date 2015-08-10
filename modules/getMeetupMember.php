<?php
function getMeetupMember($meetup_id, $type)
{
    $client = DMS\Service\Meetup\MeetupKeyAuthClient::factory(array('key' => $meetup_api_key));
    $response = $client->getMember(array('id' => $meetup_id));

    switch($type){
        case "profile":
            //TODO: change this using profile joined
            // This is when he joined to meetup, not to
            $epoch = $response["joined"];
            $epoch = substr($epoch,0, -3);
            $dt = new DateTime("@$epoch");
            $date = $dt->format('Y-m-d');

            $data = array(
                "meetup_id"      => $response["id"],
                "location"      => $response["city"],
                "joined"        => $date,
                "meetup_url"    => $response["link"],
                "lat"           => $response["lat"],
                "lon"          => $response["lon"]
            );

            if (isset($response["photo"]["highres_link"])) {
                $data["photo_url"] = $response["photo"]["highres_link"];
            } elseif (isset($response["photo"]["highres_link"])) {
                $data["photo_url"] = $response["photo"]["photo_link"];
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