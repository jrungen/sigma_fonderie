<?php

//Connexion � la base de donn�es
include 'cnx.php';


// Requ�te
$query = "SELECT sum(ca_ht) as ca_ht, type as localisation FROM projet where datedebut >= '20110101' group by type";
$result = mysql_query( $query );

print "<dashboard>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<localisation>".$row->localisation."</localisation>
	<ca_ht>".$row->ca_ht."</ca_ht>
	</item>\n";
}
print "</dashboard>"; 
?>

