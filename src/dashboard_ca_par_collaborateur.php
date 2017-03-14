<?php

//Connexion à la base de données
include 'cnx.php';


// Requête
$query = "SELECT sum(ca_ht) as ca_ht, utilisateur as utilisateur FROM projet where datedebut >= '20110101' group by utilisateur;";
$result = mysql_query( $query );

print "<dashboard>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<utilisateur>".$row->utilisateur."</utilisateur>
	<ca_ht>".$row->ca_ht."</ca_ht>
	</item>\n";
}
print "</dashboard>"; 
?>

