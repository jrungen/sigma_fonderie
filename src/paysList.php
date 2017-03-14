<?php
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
	if ($textsearch!='') $search.=" and (cle like '%$textsearch%' OR idpays like '%$textsearch%' OR taux_tva_normal like '%$textsearch%' OR taux_tva_reduit like '%$textsearch%' ) ";
}else{
	if ($textsearch!='') $search.=" and $field like '%$textsearch%' ";
}

//Connexion à la base de données
include 'cnx.php';


// Requête
$query = "SELECT * from pays where 1 ".$search;
$result = mysql_query( $query );

print "<paysList>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<cle>".$row->cle."</cle>
<idpays>".$row->idpays."</idpays>
<taux_tva_normal>".$row->taux_tva_normal."</taux_tva_normal>
<taux_tva_reduit>".$row->taux_tva_reduit."</taux_tva_reduit>

   </item>\n";
}
print "</paysList>"; 
?>

