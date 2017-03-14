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
if ($textsearch!='') $search.=" and (cle like '%$textsearch%' OR idfacture_fournisseur_ligne like '%$textsearch%' OR type_depenses like '%$textsearch%' ) ";
if ($valeur1!='') $search.=" and $filtre1='$valeur1' ";
if ($valeur2!='') $search.=" and $filtre2='$valeur2' ";


// Requête
$query = "SELECT * from facture_fournisseur_ligne where 1 ".$search." order by cle";
$result = mysql_query( $query );

print "<items>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<cle><![CDATA[".$row->cle."]]></cle>
<idfacture_fournisseur_ligne><![CDATA[".$row->idfacture_fournisseur_ligne."]]></idfacture_fournisseur_ligne>
<type_depenses><![CDATA[".$row->type_depenses."]]></type_depenses>

   </item>\n";
}
print "</items>"; 
?>

