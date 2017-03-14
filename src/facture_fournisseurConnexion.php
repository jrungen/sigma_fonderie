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
if ($textsearch!='') $search.=" and (idfacture_fournisseur like '%$textsearch%' OR date_facture like '%$textsearch%' OR cle like '%$textsearch%' OR projet like '%$textsearch%' OR item like '%$textsearch%' OR utilisateur like '%$textsearch%' OR societe like '%$textsearch%' OR numero like '%$textsearch%' OR total_acompte like '%$textsearch%' OR montant_restant_du like '%$textsearch%' OR montant_ttc like '%$textsearch%' OR facture_regle like '%$textsearch%' ) ";
if ($valeur1!='') $search.=" and $filtre1='$valeur1' ";
if ($valeur2!='') $search.=" and $filtre2='$valeur2' ";


// Requête
$query = "SELECT * from facture_fournisseur where 1 ".$search." order by cle";
$result = mysql_query( $query );

print "<items>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<idfacture_fournisseur><![CDATA[".$row->idfacture_fournisseur."]]></idfacture_fournisseur>
<date_facture><![CDATA[".substr($row->date_facture,-2)."/".substr($row->date_facture,-5,2)."/".substr($row->date_facture,-10,4)."]]></date_facture>
<cle><![CDATA[".$row->cle."]]></cle>
<projet><![CDATA[".$row->projet."]]></projet>
<item><![CDATA[".$row->item."]]></item>
<utilisateur><![CDATA[".$row->utilisateur."]]></utilisateur>
<societe><![CDATA[".$row->societe."]]></societe>
<numero><![CDATA[".$row->numero."]]></numero>
<total_acompte><![CDATA[".$row->total_acompte."]]></total_acompte>
<montant_restant_du><![CDATA[".$row->montant_restant_du."]]></montant_restant_du>
<montant_ttc><![CDATA[".$row->montant_ttc."]]></montant_ttc>
<facture_regle><![CDATA[".$row->facture_regle."]]></facture_regle>

   </item>\n";
}
print "</items>"; 
?>

