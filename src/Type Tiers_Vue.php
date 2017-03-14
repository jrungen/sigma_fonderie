<?php

//Connexion à la base de données
include 'cnx.php';


// Requête
$query = "SELECT * from societe where 1 AND type='Tiers'";
$result = mysql_query( $query );

print "<societeList>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	
   </item>\n";
}
print "</societeList>"; 
?>

