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
if ($textsearch!='') $search.=" and (societe like '%$textsearch%' OR cle like '%$textsearch%' OR idprojet like '%$textsearch%' OR lieu like '%$textsearch%' OR nom like '%$textsearch%' OR datedebut like '%$textsearch%' OR datefin like '%$textsearch%' OR numero like '%$textsearch%' OR numero_code like '%$textsearch%' OR utilisateur like '%$textsearch%' OR ca_ht like '%$textsearch%' OR total_marge like '%$textsearch%' OR taux_marge like '%$textsearch%' ) ";
if ($valeur1!='') $search.=" and $filtre1='$valeur1' ";
if ($valeur2!='') $search.=" and $filtre2='$valeur2' ";


// Requête
$query = "SELECT * from projet where 1 ".$search." order by cle";
$result = mysql_query( $query );

print "<items>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<societe><![CDATA[".$row->societe."]]></societe>
<cle><![CDATA[".$row->cle."]]></cle>
<idprojet><![CDATA[".$row->idprojet."]]></idprojet>
<lieu><![CDATA[".$row->lieu."]]></lieu>
<nom><![CDATA[".$row->nom."]]></nom>
<datedebut><![CDATA[".substr($row->datedebut,-2)."/".substr($row->datedebut,-5,2)."/".substr($row->datedebut,-10,4)."]]></datedebut>
<datefin><![CDATA[".substr($row->datefin,-2)."/".substr($row->datefin,-5,2)."/".substr($row->datefin,-10,4)."]]></datefin>
<numero><![CDATA[".$row->numero."]]></numero>
<numero_code><![CDATA[".$row->numero_code."]]></numero_code>
<utilisateur><![CDATA[".$row->utilisateur."]]></utilisateur>
<ca_ht><![CDATA[".$row->ca_ht."]]></ca_ht>
<total_marge><![CDATA[".$row->total_marge."]]></total_marge>
<taux_marge><![CDATA[".$row->taux_marge."]]></taux_marge>

   </item>\n";
}
print "</items>"; 
?>

