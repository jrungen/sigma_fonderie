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
if ($textsearch!='') $search.=" and (tel like '%$textsearch%' OR nom like '%$textsearch%' OR idsociete like '%$textsearch%' OR cle like '%$textsearch%' OR adresse like '%$textsearch%' OR adressesuite like '%$textsearch%' OR cp like '%$textsearch%' OR pays like '%$textsearch%' OR ville like '%$textsearch%' ) ";
if ($valeur1!='') $search.=" and $filtre1='$valeur1' ";
if ($valeur2!='') $search.=" and $filtre2='$valeur2' ";


// Requête
$query = "SELECT * from societe where 1 ".$search." order by cle";
$result = mysql_query( $query );

print "<items>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<tel><![CDATA[".$row->tel."]]></tel>
<nom><![CDATA[".$row->nom."]]></nom>
<idsociete><![CDATA[".$row->idsociete."]]></idsociete>
<cle><![CDATA[".$row->cle."]]></cle>
<adresse><![CDATA[".$row->adresse."]]></adresse>
<adressesuite><![CDATA[".$row->adressesuite."]]></adressesuite>
<cp><![CDATA[".$row->cp."]]></cp>
<pays><![CDATA[".$row->pays."]]></pays>
<ville><![CDATA[".$row->ville."]]></ville>

   </item>\n";
}
print "</items>"; 
?>

