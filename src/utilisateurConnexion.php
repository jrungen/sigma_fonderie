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
if ($textsearch!='') $search.=" and (idutilisateur like '%$textsearch%' OR login like '%$textsearch%' OR password like '%$textsearch%' OR cle like '%$textsearch%' OR profil like '%$textsearch%' OR subordonnes like '%$textsearch%' ) ";
if ($valeur1!='') $search.=" and $filtre1='$valeur1' ";
if ($valeur2!='') $search.=" and $filtre2='$valeur2' ";


// Requête
$query = "SELECT * from utilisateur where 1 ".$search." order by cle";
$result = mysql_query( $query );

print "<items>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<idutilisateur><![CDATA[".$row->idutilisateur."]]></idutilisateur>
<login><![CDATA[".$row->login."]]></login>
<password><![CDATA[".$row->password."]]></password>
<cle><![CDATA[".$row->cle."]]></cle>
<profil><![CDATA[".$row->profil."]]></profil>
<subordonnes><![CDATA[".$row->subordonnes."]]></subordonnes>

   </item>\n";
}
print "</items>"; 
?>

