<?php

//Connexion � la base de donn�es
include 'cnx.php';


// Requ�te
$query = "SELECT * from facture_client where 1 AND idprojet='".$_REQUEST['idprojet']."' and type='Avoir'";
$result = mysql_query( $query );

print "<facture_clientList>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	
   </item>\n";
}
print "</facture_clientList>"; 
?>

