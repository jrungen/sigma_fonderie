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
if ($textsearch!='') $search.=" and (cle like '%$textsearch%' OR idpays like '%$textsearch%' OR taux_tva_normal like '%$textsearch%' OR taux_tva_reduit like '%$textsearch%' ) ";
if ($valeur1!='') $search.=" and $filtre1='$valeur1' ";
if ($valeur2!='') $search.=" and $filtre2='$valeur2' ";


// Requête
$query = "SELECT * from pays where 1 ".$search." order by cle";
$result = mysql_query( $query );

print "<items>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<cle><![CDATA[".$row->cle."]]></cle>
<idpays><![CDATA[".$row->idpays."]]></idpays>
<taux_tva_normal><![CDATA[".$row->taux_tva_normal."]]></taux_tva_normal>
<taux_tva_reduit><![CDATA[".$row->taux_tva_reduit."]]></taux_tva_reduit>

   </item>\n";
}
print "</items>"; 
?>

