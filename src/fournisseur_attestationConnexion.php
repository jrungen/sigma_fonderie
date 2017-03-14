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
if ($textsearch!='') $search.=" and (fournisseur like '%$textsearch%' OR cle like '%$textsearch%' OR date_attestation like '%$textsearch%' OR idfournisseur_attestation like '%$textsearch%' ) ";
if ($valeur1!='') $search.=" and $filtre1='$valeur1' ";
if ($valeur2!='') $search.=" and $filtre2='$valeur2' ";


// Requête
$query = "SELECT * from fournisseur_attestation where 1 ".$search." order by cle";
$result = mysql_query( $query );

print "<items>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<fournisseur><![CDATA[".$row->fournisseur."]]></fournisseur>
<cle><![CDATA[".$row->cle."]]></cle>
<date_attestation><![CDATA[".substr($row->date_attestation,-2)."/".substr($row->date_attestation,-5,2)."/".substr($row->date_attestation,-10,4)."]]></date_attestation>
<idfournisseur_attestation><![CDATA[".$row->idfournisseur_attestation."]]></idfournisseur_attestation>

   </item>\n";
}
print "</items>"; 
?>

