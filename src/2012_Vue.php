<?php

//Connexion � la base de donn�es
include 'cnx.php';


// Requ�te
$query = "SELECT * from projet where 1 AND datedebut like '2012%' ";
$result = mysql_query( $query );

print "<projetList>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	
   </item>\n";
}
print "</projetList>"; 
?>

