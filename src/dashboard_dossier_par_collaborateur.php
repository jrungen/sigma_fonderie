<?php

//Connexion � la base de donn�es
include 'cnx.php';


// Requ�te
$query = "SELECT count(numero) as nb, utilisateur as utilisateur FROM projet where datedebut >= '20110101' group by utilisateur;";
$result = mysql_query( $query );

print "<dashboard>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<utilisateur>".$row->utilisateur."</utilisateur>
	<nb>".$row->nb."</nb>
	</item>\n";
}
print "</dashboard>"; 
?>

