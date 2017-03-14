<?php
$textsearch = $_REQUEST['search'];
$field = $_REQUEST['field'];
$view = $_REQUEST['view'];

switch ($view) {
	case 'Par défaut':
	$search="";
	break;
	

}

if ($field=='Tous'){
	if ($textsearch!='') $search.=" and nom like '%$textsearch%'";
}else{
	if ($textsearch!='') $search.=" and $field like '%$textsearch%'";
}

//Connexion à la base de données
include 'cnx.php';


// Requête
$query = "SELECT * from bon_commande where 1 ".$search;
$result = mysql_query( $query );

print "<bon_commandeList>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	
   </item>\n";
}
print "</bon_commandeList>"; 
?>

