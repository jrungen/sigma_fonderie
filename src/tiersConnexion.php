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
if ($textsearch!='') $search.=" and (cle like '%$textsearch%' OR idtiers like '%$textsearch%' OR civilite like '%$textsearch%' OR nom like '%$textsearch%' OR prenom like '%$textsearch%' OR email like '%$textsearch%' ) ";
if ($valeur1!='') $search.=" and $filtre1='$valeur1' ";
if ($valeur2!='') $search.=" and $filtre2='$valeur2' ";


// Requête
$query = "SELECT * from tiers where 1 ".$search." order by cle";
$result = mysql_query( $query );

print "<items>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<cle><![CDATA[".$row->cle."]]></cle>
<idtiers><![CDATA[".$row->idtiers."]]></idtiers>
<civilite><![CDATA[".$row->civilite."]]></civilite>
<nom><![CDATA[".$row->nom."]]></nom>
<prenom><![CDATA[".$row->prenom."]]></prenom>
<email><![CDATA[".$row->email."]]></email>

   </item>\n";
}
print "</items>"; 
?>

