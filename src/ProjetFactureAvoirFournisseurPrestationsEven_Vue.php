<?php

//Connexion à la base de données
include 'cnx.php';


// Requête
$query = "SELECT * from facture_fournisseur where 1 AND idprojet='".$_REQUEST['idprojet']."' and type='Avoir'";
$result = mysql_query( $query );

print "<facture_fournisseurList>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	
   </item>\n";
}
print "</facture_fournisseurList>"; 
?>

