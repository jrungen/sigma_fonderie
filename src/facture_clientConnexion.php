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
if ($textsearch!='') $search.=" and (cle like '%$textsearch%' OR societe like '%$textsearch%' OR montant_ttc like '%$textsearch%' OR projet like '%$textsearch%' OR operation like '%$textsearch%' OR utilisateur like '%$textsearch%' OR date_facture like '%$textsearch%' OR numero like '%$textsearch%' OR acompte_total like '%$textsearch%' OR montant_restant like '%$textsearch%' ) ";
if ($valeur1!='') $search.=" and $filtre1='$valeur1' ";
if ($valeur2!='') $search.=" and $filtre2='$valeur2' ";


// Requête
$query = "SELECT * from facture_client where 1 ".$search." order by cle";
$result = mysql_query( $query );

print "<items>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<cle><![CDATA[".$row->cle."]]></cle>
<societe><![CDATA[".$row->societe."]]></societe>
<montant_ttc><![CDATA[".$row->montant_ttc."]]></montant_ttc>
<projet><![CDATA[".$row->projet."]]></projet>
<operation><![CDATA[".$row->operation."]]></operation>
<utilisateur><![CDATA[".$row->utilisateur."]]></utilisateur>
<date_facture><![CDATA[".substr($row->date_facture,-2)."/".substr($row->date_facture,-5,2)."/".substr($row->date_facture,-10,4)."]]></date_facture>
<numero><![CDATA[".$row->numero."]]></numero>
<acompte_total><![CDATA[".$row->acompte_total."]]></acompte_total>
<montant_restant><![CDATA[".$row->montant_restant."]]></montant_restant>

   </item>\n";
}
print "</items>"; 
?>

