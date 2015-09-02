<?php

require_once '../config.php';
require_once 'init.php';


    $db->orderBy("publishedAt","desc");
    $date = getdate();
    $db->where('eventDate',$date["year"] ."-". $date["mon"]."-".$date["mday"],"<");
    $db->where('status', 2);
    $videos = $db->get('videos');

    if ($db->count > 0){
        $tags = array();
        for ($i=0; $i<sizeof($videos); $i++) {
            $videos[$i]["publishedAt"] = date('d-m-Y', strtotime($videos[$i]["publishedAt"]));
            if($videos[$i]["duration"]) {
                $videos[$i]["duration"] = covtime($videos[$i]["duration"]);
            }
            $videos[$i]["arrayTags"] = explode(",", $videos[$i]["tags"]);
            foreach($videos[$i]["arrayTags"] as $t){
                $t = trim($t);
                if(!in_array($t, $tags) && $t){
                    array_push($tags, $t);
                }
            }
        }
        sort($tags);
        $smarty->assign('TAGS', $tags);
        $smarty->assign('VIDEOS', $videos);
        $smarty->assign('NUMVIDEOS', $db->count - 1);
    }
    $smarty->display('academy.tpl');

?>