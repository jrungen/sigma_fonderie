<?php
header("Content-Type:text/html; charset=iso-8859-15");
$textsearch = $_REQUEST['search'];
$field = $_REQUEST['field'];
$view = $_REQUEST['view'];
$s_priorite = $_REQUEST['priorite'];
$s_statut = $_REQUEST['statut'];


$search="";
switch ($view) {
	case 'Par défaut':
	$search="";
	break;
	

}

if ($s_priorite!='') $search.="and priorite = '".$s_priorite."' ";if ($s_statut!='') $search.="and statut = '".$s_statut."' ";


if ($field=='Tous'){
	if ($textsearch!='') $search.=" and (nom like '%$textsearch%' OR idaction like '%$textsearch%' OR cle like '%$textsearch%' OR type like '%$textsearch%' OR statut like '%$textsearch%' OR date_fin like '%$textsearch%' OR societe like '%$textsearch%' OR utilisateur like '%$textsearch%' OR date_debut like '%$textsearch%' OR duree like '%$textsearch%' ) ";
}else{
	if ($textsearch!='') $search.=" and $field like '%$textsearch%' ";
}

//Connexion à la base de données
include 'cnx.php';

// Requête
$query = "SELECT nom, idaction, cle, type, statut, date_fin, societe, utilisateur, date_debut, duree from action where 1 ".$search;

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
header("Content-Disposition: attachment; filename=action.csv");
echo $csv;

?>

