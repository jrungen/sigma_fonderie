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
if ($textsearch!='') $search.=" and (idmodele_lettre like '%$textsearch%' OR cle like '%$textsearch%' OR intitule like '%$textsearch%' OR categorie like '%$textsearch%' OR note like '%$textsearch%' OR fichier like '%$textsearch%' ) ";
if ($valeur1!='') $search.=" and $filtre1='$valeur1' ";
if ($valeur2!='') $search.=" and $filtre2='$valeur2' ";


// Requête
$query = "SELECT * from modele_lettre where 1 ".$search." order by cle";
$result = mysql_query( $query );

print "<items>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<idmodele_lettre><![CDATA[".$row->idmodele_lettre."]]></idmodele_lettre>
<cle><![CDATA[".$row->cle."]]></cle>
<intitule><![CDATA[".$row->intitule."]]></intitule>
<categorie><![CDATA[".$row->categorie."]]></categorie>
<note><![CDATA[".$row->note."]]></note>
<fichier><![CDATA[".$row->fichier."]]></fichier>

   </item>\n";
}
print "</items>"; 
?>

