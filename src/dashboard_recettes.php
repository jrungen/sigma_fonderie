<?php

//Connexion à la base de données
include 'cnx.php';


// Requête
$query = "SELECT sum(montant_ht) as montant_ht, month(date_facture) as mois FROM facture_client group by mois;";
$result = mysql_query( $query );

print "<dashboard>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<mois>".$row->mois."</mois>
	<montant_ht>".$row->montant_ht."</montant_ht>
	</item>\n";
}
print "</dashboard>"; 
?>

