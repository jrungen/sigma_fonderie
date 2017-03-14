<?php

//Connexion à la base de données
include 'cnx.php';


// Requête
$query = "SELECT * from depenses_annexes where 1 AND projet='".$_REQUEST['cle']."' AND type='Facture dépenses annexesr' AND objet ='Prestation tourisme d\'affaires'";
$result = mysql_query( $query );

print "<depenses_annexesList>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<montant_ttc>".$row->montant_ttc."</montant_ttc>
<montant_ht>".$row->montant_ht."</montant_ht>
<type_depense>".$row->type_depense."</type_depense>
<iddepenses_annexes>".$row->iddepenses_annexes."</iddepenses_annexes>
<cle>".$row->cle."</cle>

   </item>\n";
}
print "</depenses_annexesList>"; 
?>

