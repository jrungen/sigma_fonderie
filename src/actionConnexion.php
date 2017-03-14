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
if ($textsearch!='') $search.=" and (nom like '%$textsearch%' OR idaction like '%$textsearch%' OR cle like '%$textsearch%' OR type like '%$textsearch%' OR date_fin like '%$textsearch%' OR statut like '%$textsearch%' OR societe like '%$textsearch%' OR utilisateur like '%$textsearch%' OR date_debut like '%$textsearch%' OR duree like '%$textsearch%' ) ";
if ($valeur1!='') $search.=" and $filtre1='$valeur1' ";
if ($valeur2!='') $search.=" and $filtre2='$valeur2' ";


// Requête
$query = "SELECT * from action where 1 ".$search." order by cle";
$result = mysql_query( $query );

print "<items>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<nom><![CDATA[".$row->nom."]]></nom>
<idaction><![CDATA[".$row->idaction."]]></idaction>
<cle><![CDATA[".$row->cle."]]></cle>
<type><![CDATA[".$row->type."]]></type>
<date_fin><![CDATA[".substr($row->date_fin,-2)."/".substr($row->date_fin,-5,2)."/".substr($row->date_fin,-10,4)."]]></date_fin>
<statut><![CDATA[".$row->statut."]]></statut>
<societe><![CDATA[".$row->societe."]]></societe>
<utilisateur><![CDATA[".$row->utilisateur."]]></utilisateur>
<date_debut><![CDATA[".substr($row->date_debut,-2)."/".substr($row->date_debut,-5,2)."/".substr($row->date_debut,-10,4)."]]></date_debut>
<duree><![CDATA[".$row->duree."]]></duree>

   </item>\n";
}
print "</items>"; 
?>

