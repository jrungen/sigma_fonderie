<?php
header("Content-Type:text/html; charset=iso-8859-15");
$textsearch = $_REQUEST['search'];
$field = $_REQUEST['field'];
$view = $_REQUEST['view'];


$search="";
switch ($view) {
	case 'Par d�faut':
	$search="";
	break;
	

}




if ($field=='Tous'){
	if ($textsearch!='') $search.=" and (cle like '%$textsearch%' OR idaction_type like '%$textsearch%' OR intitule like '%$textsearch%' ) ";
}else{
	if ($textsearch!='') $search.=" and $field like '%$textsearch%' ";
}

//Connexion � la base de donn�es
include 'cnx.php';

// Requ�te
$query = "SELECT cle, idaction_type, intitule from action_type where 1 ".$search;

require_once("csv/csv.lib.php");
require_once("csv/dbmysql.class.php");
$db = new DbMySQL(DB_HOST, DB_NAME, DB_USER, DB_PASS);
$db->connect();

// Envoi le r�sultat sur Excel
// Requ�te
$cvs_array = $db->select($query);
$db2csv = new export2CSV(",","\n");
$csv = $db2csv->create_csv_file($cvs_array);
header("Content-type: application/eml");
header("Content-Disposition: attachment; filename=action_type.csv");
echo $csv;

?>

