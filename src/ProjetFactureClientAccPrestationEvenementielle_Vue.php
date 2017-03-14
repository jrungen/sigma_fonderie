<?php

//Connexion à la base de données
include 'cnx.php';


// Requête
$query = "SELECT * from facture_client where 1 AND projet='".$_REQUEST['cle']."' AND type='Facture accompagnant' AND objet in ('Prestation événementielles', 'Prestation de services')";
$result = mysql_query( $query );

print "<facture_clientList>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<idfacture_client>".$row->idfacture_client."</idfacture_client>
<cle>".$row->cle."</cle>
<date_facture>".$row->date_facture."</date_facture>
<numero>".$row->numero."</numero>
<libelle>".$row->libelle."</libelle>
<montant_ht>".$row->montant_ht."</montant_ht>
<montant_ttc>".$row->montant_ttc."</montant_ttc>
<acompte_total>".$row->acompte_total."</acompte_total>
<montant_restant>".$row->montant_restant."</montant_restant>

   </item>\n";
}
print "</facture_clientList>"; 
?>

