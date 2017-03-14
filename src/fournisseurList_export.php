<?php
header("Content-Type:text/html; charset=iso-8859-15");
$textsearch = $_REQUEST['search'];
$field = $_REQUEST['field'];

if ($field=='Tous'){
	if ($textsearch!='') $search.=" and (idfournisseur like '%$textsearch%' OR cle like '%$textsearch%' OR nom like '%$textsearch%' OR tel like '%$textsearch%' OR adresse like '%$textsearch%' OR adressesuite like '%$textsearch%' OR cp like '%$textsearch%' OR ville like '%$textsearch%' OR pays like '%$textsearch%' OR compte_tiers like '%$textsearch%' ) ";
}else{
	if ($textsearch!='') $search.=" and $field like '%$textsearch%' ";
}

//Connexion à la base de données
include 'cnx.php';
define("DB_NAME", $mysql_bdd);
define("DB_HOST", $mysql_host);
define("DB_USER", $mysql_login);
define("DB_PASS", $mysql_password);
// Requete
$query = "SELECT idfournisseur, cle,(select sum(montant_ht) from facture_fournisseur where fourniseur = fournisseur.cle and facture_fournisseur.annee = year(curdate()) group by fourniseur) as total_ht, nom, tel, adresse, adressesuite, cp, ville, pays, compte_tiers, nouveau from fournisseur where 1 ".$search;
//echo $query;
require_once("csv/csv.lib.php");
require_once("csv/dbmysql.class.php");
$db = new DbMySQL(DB_HOST, DB_NAME, DB_USER, DB_PASS);
$db->connect();

// Envoi le resultat sur Excel
// Requete
$cvs_array = $db->select($query);
$db2csv = new export2CSV(",","\n");
$csv = $db2csv->create_csv_file($cvs_array);
header("Content-type: application/eml");
header("Content-Disposition: attachment; filename=fournisseur.csv");
echo $csv;

?>