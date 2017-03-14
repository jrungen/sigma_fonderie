<?php

//Connexion à la base de données
include 'cnx.php';


// Requête
$query = "SELECT sum(ca_ht) as marge_ht, societe as client FROM projet where datedebut >= '20110101' and statut='Terminé' group by client;";
$result = mysql_query( $query );
print "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
print "<items>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item client=\"".$row->client."\" value=\"".$row->marge_ht."\" />\n";
}
print "</items>"; 
?>

