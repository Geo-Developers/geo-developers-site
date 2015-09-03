<?php

require_once '../config.php';
require_once 'init.php';

$top_gis = "SELECT s.name as name, s.desc, COUNT(*) as count
              FROM `user_skills` u,skills s
              WHERE u.skill_id=s.id AND s.is_gis = true AND s.is_important=1
              GROUP BY u.skill_id
              ORDER BY COUNT(*) DESC
              LIMIT 20
            ";
$top_gis = $db->rawQuery($top_gis);
$smarty->assign('NTOPGIS', sizeof($top_gis));
$smarty->assign('TOPGIS', $top_gis);

$top_others = "SELECT s.name as name, COUNT(*) as count
              FROM `user_skills` u,skills s
              WHERE u.skill_id=s.id AND s.is_gis IS NULL AND s.is_important=1
              GROUP BY u.skill_id
              ORDER BY COUNT(*) DESC
              LIMIT 20
            ";
$top_others = $db->rawQuery($top_others);
$smarty->assign('NTOPOTHERS', sizeof($top_others));
$smarty->assign('TOPOTHERS', $top_others);

$top_giseros = "SELECT u.name, p.meetup_id, p.photo_url,COUNT(*) as count
              FROM user_skills us,skills s, profiles p, users u
              WHERE u.meetup_id=p.meetup_id AND us.meetup_id=p.meetup_id AND us.skill_id=s.id AND s.is_gis = true
              GROUP BY u.meetup_id
              ORDER BY COUNT(*) DESC
              LIMIT 20
            ";
$top_giseros = $db->rawQuery($top_giseros);
$smarty->assign('NTOPGISEROS', sizeof($top_giseros));
$smarty->assign('TOPGISEROS', $top_giseros);

$top_experts = "SELECT u.name, p.meetup_id, p.photo_url,COUNT(*) as count
              FROM user_skills us,skills s, profiles p, users u
              WHERE u.meetup_id=p.meetup_id AND us.meetup_id=p.meetup_id AND us.skill_id=s.id AND is_important=true
              GROUP BY u.meetup_id
              ORDER BY COUNT(*) DESC
              LIMIT 20
            ";
$top_experts = $db->rawQuery($top_experts);
$smarty->assign('NTOPEXPERTS', sizeof($top_experts));
$smarty->assign('TOPEXPERTS', $top_experts);

$top_recommended = "SELECT u.name, p.meetup_id, p.photo_url,COUNT(*) as count
              FROM profiles p, users u, votes v
              WHERE u.meetup_id=p.meetup_id AND v.refered=p.meetup_id
              GROUP BY u.meetup_id
              ORDER BY COUNT(*) DESC
              LIMIT 20
            ";
$top_recommended = $db->rawQuery($top_recommended);
$smarty->assign('NTOPRECOMMENDED', sizeof($top_recommended));
$smarty->assign('TOPRECOMMENDED', $top_recommended);

$smarty->display('rankings.tpl');
//ArcGIS, Sccience, ESRI, ArcGIS-Add-ins
//Contar
//SELECT s.name,COUNT(*) FROM `user_skills` u,skills s WHERE u.skill_id=s.id AND s.is_gis = true GROUP BY u.skill_id ORDER BY COUNT(*) DESC

?>
