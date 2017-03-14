<?php
header("Content-Type:text/html; charset=iso-8859-15");
$textsearch = $_REQUEST['search'];
$field = $_REQUEST['field'];
$view = $_REQUEST['view'];


$search="";
switch ($view) {
	case 'Par défaut':
	$search="";
	break;
	

}




if ($field=='Tous'){
	if ($textsearch!='') $search.=" and (cle like '%$textsearch%' OR idtiers like '%$textsearch%' OR civilite like '%$textsearch%' OR nom like '%$textsearch%' OR prenom like '%$textsearch%' OR societe like '%$textsearch%' OR service like '%$textsearch%' OR email like '%$textsearch%' ) ";
}else{
	if ($textsearch!='') $search.=" and $field like '%$textsearch%' ";
}

//Connexion à la base de données
include 'cnx.php';

// Requête
$query = "SELECT cle, idtiers, civilite, nom, prenom, societe, service, email from tiers where 1 ".$search;

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
header("Content-Disposition: attachment; filename=tiers.csv");
echo $csv;

?>

