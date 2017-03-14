<?php

//Connexion à la base de données
include 'cnx.php';


// Requête
$query = "SELECT * from facture_client where 1 AND type='Facture client'";
$result = mysql_query( $query );

print "<facture_clientList>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	
   </item>\n";
}
print "</facture_clientList>"; 
?>

