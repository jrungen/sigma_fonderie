<?php
$textsearch = addslashes($_REQUEST['search']);
$field = addslashes($_REQUEST['field']);
$view = addslashes($_REQUEST['view']);
$user = addslashes($_REQUEST['user']);
if($view=='') $view='Par défaut';
$search='';

// si navigateur chrome on met dans la variable $cle l'encode utf-8
if (preg_match("/\bChrome\b/i", $_SERVER["HTTP_USER_AGENT"])){
	$view = utf8_decode($_REQUEST['view']);
} else {
	$view = $_REQUEST['view'];
}





//Connexion à la base de données
include 'cnx.php';

// Requete dans les vues
$query_vue = "SELECT * from vue where categorie='fournisseur_attestation' and intitule='$view'";
$result_vue = mysql_query( $query_vue );
while( $row_vue = mysql_fetch_object( $result_vue ) ){
	$where = str_replace('(-me-)',$user,$row_vue->view_where);
	$column = $row_vue->view_column;
	$select = $row_vue->view_select;
	$from = $row_vue->view_from;
	$join = $row_vue->view_jointure;
	$style = $row_vue->view_color;
	$group1 = $row_vue->group1;
	$group2 = $row_vue->group2;
	$group3 = $row_vue->group3;	
	$expanded = $row_vue->expanded;	
	$vue_cle =  $row_vue->cle;
}

// Récupérer tous les champs et appliquer le filtre à ces champs

if ($textsearch!=''){
$select_fields = explode(', ',$select);

	foreach($select_fields as $value){
		$select_as = explode(' as ',$value);
		$select_as_ .= $select_as[0]." like '%$textsearch%' OR ";
	}

	if ($field=='Tous'){
		if ($textsearch!='') $search.=" and ( ".substr($select_as_,0,-3)." ) ";
	}else{
		if ($textsearch!='') $search.=" and $field like '%$textsearch%' ";
	}
}
$search .= $where;

// Requête
$query = "SELECT $select from $from $join where 1 ".$search;
$result = mysql_query( $query );

require_once("module/csv/csv.lib.php");
require_once("module/csv/dbmysql.class.php");
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
header("Content-type: application/csv");
header("Content-Disposition: attachment; filename=$view.csv");
echo $csv;
?>

