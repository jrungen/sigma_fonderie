<?php

//Connexion � la base de donn�es
include 'cnx.php';


// Requ�te
$query = "SELECT * from facture_fournisseur where 1 AND facture_regle = 'R�gl�'";
$result = mysql_query( $query );

print "<facture_fournisseurList>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	
   </item>\n";
}
print "</facture_fournisseurList>"; 
?>

