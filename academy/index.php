<?php

require_once '../config.php';
require_once 'init.php';

if( isset($_SESSION['logged']) ){
    $db->orderBy("publishedAt","desc");
    $date = getdate();
    $db->where('eventDate',$date["year"] ."-". $date["mon"]."-".$date["mday"],"<");
    $videos = $db->get('videos');
    if ($db->count > 0)

        for ($i=0; $i<sizeof($videos); $i++) {
            $videos[$i]["publishedAt"] = date('d-m-Y', strtotime($videos[$i]["publishedAt"]));
            if($videos[$i]["duration"]) {
                $videos[$i]["duration"] = covtime($videos[$i]["duration"]);
            }
            $videos[$i]["arrayTags"] = explode(",", $videos[$i]["tags"]);
        }
        $smarty->assign('VIDEOS', $videos);
        $smarty->assign('NUMVIDEOS', $db->count - 1);

    $smarty->display('academy.tpl');
}else{
	$_SESSION['returnURL'] = "http://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
  header('Location: '.$ROOT.'login/');
}

function covtime($youtube_time){
    $start = new DateTime('@0'); // Unix epoch
    $start->add(new DateInterval($youtube_time));
    $time = $start->format('H:i:s');
    if(substr($time,0,3)==="00:"){
        $time = substr($time,3);
    }
    return $time;
}
?>