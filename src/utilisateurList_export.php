<?php
header("Content-Type:text/html; charset=iso-8859-15");
$textsearch = $_REQUEST['search'];
$field = $_REQUEST['field'];
$view = $_REQUEST['view'];
$s_profil = $_REQUEST['profil'];


$search="";
switch ($view) {
	case 'Par défaut':
	$search="";
	break;
	

}

if ($s_profil!='') $search.="and profil = '".$s_profil."' ";


if ($field=='Tous'){
	if ($textsearch!='') $search.=" and (idutilisateur like '%$textsearch%' OR login like '%$textsearch%' OR profil like '%$textsearch%' OR password like '%$textsearch%' OR cle like '%$textsearch%' ) ";
}else{
	if ($textsearch!='') $search.=" and $field like '%$textsearch%' ";
}

//Connexion à la base de données
include 'cnx.php';

// Requête
$query = "SELECT idutilisateur, login, profil, password, cle from utilisateur where 1 ".$search;

require_once("csv/csv.lib.php");
require_once("csv/dbmysql.class.php");
$db = new DbMySQL(DB_HOST, DB_NAME, DB_USER, DB_PASS);
$db->connect();

// Envoi le résultat sur Excel
// Requête
$cvs_array = $db->select($query);
$db2csv = new export2CSV(",","\n");
$csv = $db2csv->create_csv_file($cvs_array);
header("Content-type: application/eml");
header("Content-Disposition: attachment; filename=utilisateur.csv");
echo $csv;

?>

