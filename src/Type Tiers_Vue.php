<?php

//Connexion � la base de donn�es
include 'cnx.php';


// Requ�te
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

