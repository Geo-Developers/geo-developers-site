<?php

require_once '../config.php';
require_once 'init.php';


if( isset($_SESSION['logged']) ){
    $MailChimp = new \Drewm\MailChimp($mailchimp_apikey);

    if(!empty($_POST)){
        // Update user preferences
        $data = array(
            'email'             => array("euid"=> $user['mailchimp_euid']),
            'merge_vars'        => array('groupings' => array()),
            'id'                => $mailchimp_listid,
            'replace_interests' => true
        );

        foreach($_POST["groups"] as $group){
            $grouping = array(
                'id'=>$group,
                "groups" => array()
            );

            if(!empty($_POST["$group"])){
                foreach($_POST["$group"] as $g){
                    array_push($grouping["groups"],$g);
                }
                array_push($data["merge_vars"]["groupings"],$grouping);
            }
        }

        $result = $MailChimp->call('/lists/update-member', $data);
        $smarty->assign('MESSAGE', "Tus preferencias han sido actualizadas");
    }

    // Get user preferences
    $result = $MailChimp->call('/lists/member-info', array(
            'emails'    => array( array("euid"=> $user['mailchimp_euid'])),
            'id'        => $mailchimp_listid
    ));
    $interests = array();

    $groupings = $result["data"][0]["merges"]["GROUPINGS"];
    foreach($groupings as $grouping){

        foreach($grouping["groups"] as $group){

            if(intval($group["interested"]) === 1){
                $interests[$group["name"]] = true;
            }
        }
    }

    // Get list preferences
    $groupings = $MailChimp->call('lists/interest-groupings', array(
        'id' => $mailchimp_listid
    ));
    for($i=0;$i<sizeof($groupings);$i++) {
        $groupings[$i]["count"] = sizeof($groupings[$i]["groups"])-1;
    }

    $smarty->assign('INTERESTS', $interests);
    $smarty->assign('NUMGROUPINGS', sizeof($groupings)-1);
    $smarty->assign('GROUPINGS', $groupings);
    $smarty->display('avisos.tpl');
}else{
    $_SESSION['returnURL'] = "http://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
    header('Location: '.$ROOT.'login/');
}

?>