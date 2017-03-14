<?php
$textsearch = $_REQUEST['search'];
$field = $_REQUEST['field'];
$view = $_REQUEST['view'];


$search="";
switch ($view) {
	case 'Par défaut':
	$search="";
	break;
	
	case 'Type client':
	$search="AND type='Client'";
	break;

	case 'Type Tiers':
	$search="AND type='Tiers'";
	break;


}


if ($field=='Tous'){
	if ($textsearch!='') $search.=" and (nom like '%$textsearch%' OR idsociete like '%$textsearch%' OR tel like '%$textsearch%' OR cle like '%$textsearch%' OR adresse like '%$textsearch%' OR adressesuite like '%$textsearch%' OR cp like '%$textsearch%' OR ville like '%$textsearch%' OR pays like '%$textsearch%' OR compte_tiers like '%$textsearch%' ) ";
}else{
	if ($textsearch!='') $search.=" and $field like '%$textsearch%' ";
}

//Connexion à la base de données
include 'cnx.php';


// Requête
$query = "SELECT * from societe where 1 ".$search;
$result = mysql_query( $query );

print "<societeList>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<nom>".$row->nom."</nom>
<idsociete>".$row->idsociete."</idsociete>
<tel>".$row->tel."</tel>
<cle>".$row->cle."</cle>
<adresse>".$row->adresse."</adresse>
<adressesuite>".$row->adressesuite."</adressesuite>
<cp>".$row->cp."</cp>
<ville>".$row->ville."</ville>
<pays>".$row->pays."</pays>
<compte_tiers><![CDATA[".$row->compte_tiers."]]></compte_tiers>
<nouveau><![CDATA[".$row->nouveau."]]></nouveau>

   </item>\n";
}
print "</societeList>"; 
?>

