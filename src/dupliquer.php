<?php
$table = $_REQUEST['table'];
$table_liee = $_REQUEST['table_liee'];
$cle = $_REQUEST['cle'];

//Connexion à la base de données
include 'cnx.php';


// Requête liste des champs de la table
$result = mysql_query("SHOW COLUMNS FROM $table");  
if (!$result) {  
	echo 'Impossible d\'exécuter la requête : ' . mysql_error();  
	exit;  
}  
$field_list='';
if (mysql_num_rows($result) > 0) {  
	while ($row = mysql_fetch_object($result)) { 
		if($row->Extra!='auto_increment'){
			if($row->Field!='cle'){
				$field_list .=$row->Field.',';  
			}
		}
	}  
}  
$champs = $field_list.'cle';

// Requête liste des champs de la table liée
$result = mysql_query("SHOW COLUMNS FROM $table_liee");  
if (!$result) {  
	echo 'Impossible d\'exécuter la requête : ' . mysql_error();  
	exit;  
} 

$field_list_table_liee='';
if (mysql_num_rows($result) > 0) {  
	while ($row = mysql_fetch_object($result)) { 
		if($row->Extra!='auto_increment'){
			if($row->Field!='cle'){
				if($row->Field!="$table"){
					$field_list_table_liee .=$row->Field.',';  
				}
			}
		}
	}  
}  
$champs_table_liee = $field_list_table_liee."cle, $table";


$timestamp = date('YmdHis');

// Dupliquer la fiche
$req ="insert into $table ($champs) select $field_list'$cle".$timestamp."' from $table where cle='$cle';";
$result = mysql_query( $req );

// Dupliquer les fiches liées
if($table_liee!=''){
	$req_table_liee = "select * from $table_liee where $table='$cle';";
	//echo $req_table_liee;
	$result_table_liee = mysql_query( $req_table_liee );

	while( $row = mysql_fetch_object( $result_table_liee ) )
	{
		$cle_table_liee = $row->cle;
		$req_creation_fiche_liee ="insert into $table_liee ($champs_table_liee) select $field_list_table_liee'$cle_table_liee".$timestamp."','$cle".$timestamp."' from $table_liee where cle='$cle_table_liee';";
		echo $req_creation_fiche_liee;
		$_creation_fiche_liee = mysql_query( $req_creation_fiche_liee );
	}
}

echo "Fiche dupliquée";


?>


