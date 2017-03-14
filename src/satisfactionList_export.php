<?php
header("Content-Type:text/html; charset=iso-8859-15");
$textsearch = $_REQUEST['search'];
$field = $_REQUEST['field'];
//$view = $_REQUEST['view'];


$search="";

if ($field=='Tous'){
	if ($textsearch!='') $search.=" and (cle like '%$textsearch%' OR idsatisfaction like '%$textsearch%' OR fournisseur like '%$textsearch%' OR projet like '%$textsearch%' OR utilisateur like '%$textsearch%' OR ca_ht like '%$textsearch%' OR eval_preparation like '%$textsearch%' OR date_preparation like '%$textsearch%' OR eval_realisation like '%$textsearch%' OR liste_preparation like '%$textsearch%' OR date_realisation like '%$textsearch%' OR liste_realisation like '%$textsearch%' ) ";
}else{
	if ($textsearch!='') $search.=" and $field like '%$textsearch%' ";
}

//Connexion à la base de données
include 'cnx.php';

// Requête
$query = "SELECT 
			cle,
			idsatisfaction,
			fournisseur,
			projet,
			utilisateur,
			ca_ht,
			date_preparation,
			eval_preparation as evaluation_par,
			liste_preparation as avis_preparation,
			note_preparation as commentaire_preparation,
			date_realisation,
			eval_realisation as realisation_par,
			liste_realisation as avis_realisation,
			note_realisation as commentaire_realisation
		from satisfaction
		where 1 ".$search;

require_once("csv/csv.lib.php");
require_once("csv/dbmysql.class.php");
define("DB_NAME", "$mysql_bdd");
define("DB_HOST", "$mysql_host");
define("DB_USER", "$mysql_login");
define("DB_PASS", "$mysql_password");
$db = new DbMySQL(DB_HOST, DB_NAME, DB_USER, DB_PASS);
$db->connect();

// Envoi le résultat sur Excel
// Requête
$cvs_array = $db->select($query);
$db2csv = new export2CSV(",","\n");
$csv = $db2csv->create_csv_file($cvs_array);
header("Content-type: application/eml");
header("Content-Disposition: attachment; filename=satisfaction.csv");
echo $csv;

?>