<?php

//Connexion à la base de données
include 'cnx.php';

$textsearch = $_REQUEST['search'];
$textfiltre = explode("-", $_REQUEST['filtre']);
$filtre1 = $textfiltre[0];
$valeur1 = $textfiltre[1];
$filtre2 = $textfiltre[2];
$valeur2 = $textfiltre[3];

$search = "";
if ($textsearch!='') $search.=" and (idfournisseur like '%$textsearch%' OR cle like '%$textsearch%' OR nom like '%$textsearch%' OR tel like '%$textsearch%' OR adresse like '%$textsearch%' OR adressesuite like '%$textsearch%' OR cp like '%$textsearch%' OR ville like '%$textsearch%' OR pays like '%$textsearch%' OR compte_tiers like '%$textsearch%' ) ";
if ($valeur1!='') $search.=" and $filtre1='$valeur1' ";
if ($valeur2!='') $search.=" and $filtre2='$valeur2' ";


// Requête
$query = "SELECT * from fournisseur where 1 ".$search." order by cle";
$result = mysql_query( $query );

print "<items>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<idfournisseur><![CDATA[".$row->idfournisseur."]]></idfournisseur>
<cle><![CDATA[".$row->cle."]]></cle>
<nom><![CDATA[".$row->nom."]]></nom>
<tel><![CDATA[".$row->tel."]]></tel>
<adresse><![CDATA[".$row->adresse."]]></adresse>
<adressesuite><![CDATA[".$row->adressesuite."]]></adressesuite>
<cp><![CDATA[".$row->cp."]]></cp>
<ville><![CDATA[".$row->ville."]]></ville>
<pays><![CDATA[".$row->pays."]]></pays>
<compte_tiers><![CDATA[".$row->compte_tiers."]]></compte_tiers>

   </item>\n";
}
print "</items>"; 
?>

