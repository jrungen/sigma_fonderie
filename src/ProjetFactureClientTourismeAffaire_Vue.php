<?php

//Connexion à la base de données
include 'cnx.php';


// Requête
$query = "SELECT * from facture_client where 1 AND projet='".$_REQUEST['cle']."' AND type='Facture client' AND objet ='Prestation tourisme d\'affaires'";
$result = mysql_query( $query );

print "<facture_clientList>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<montant_ht>".$row->montant_ht."</montant_ht>
<date_facture>".substr($row->date_facture,-2)."/".substr($row->date_facture,-5,2)."/".substr($row->date_facture,-10,4)."</date_facture>
<numero>".$row->numero."</numero>
<libelle>".$row->libelle."</libelle>
<montant_ttc>".$row->montant_ttc."</montant_ttc>
<acompte_total>".$row->acompte_total."</acompte_total>
<montant_restant>".$row->montant_restant."</montant_restant>
<cle>".$row->cle."</cle>
<idfacture_client>".$row->idfacture_client."</idfacture_client>

   </item>\n";
}
print "</facture_clientList>"; 
?>

