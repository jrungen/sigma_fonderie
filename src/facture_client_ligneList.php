<?php
$textsearch = $_REQUEST['search'];
$field = $_REQUEST['field'];
$view = $_REQUEST['view'];
$s_annee = $_REQUEST['annee'];


$search="";
switch ($view) {
	case 'Par défaut':
	$search="";
	break;
}

if ($s_annee!='') $search.="and annee = '".$s_annee."' ";

if ($field=='Tous'){
	if ($textsearch!='') $search.=" and (cle like '%$textsearch%' OR idfacture_client_ligne like '%$textsearch%' ) ";
}else{
	if ($textsearch!='') $search.=" and $field like '%$textsearch%' ";
}

//Connexion à la base de données
include 'cnx.php';


// Requête
$query = "SELECT * from facture_client_ligne where 1 ".$search;
$result = mysql_query( $query );

print "<facture_client_ligneList>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<cle>".$row->cle."</cle>
	<idfacture_client_ligne>".$row->idfacture_client_ligne."</idfacture_client_ligne>
   </item>\n";
}
print "</facture_client_ligneList>"; 
?>

