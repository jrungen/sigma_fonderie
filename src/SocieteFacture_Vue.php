<?php

//Connexion à la base de données
include 'cnx.php';
if ($_REQUEST['search']!=''){
	$search =  "and annee = '".$_REQUEST['search']."'";
}else{
	$search = "";
}

// Requête
$query = "SELECT * from facture_client where 1 AND societe='".$_REQUEST['cle']."' ".$search." ";
echo $query;
$result = mysql_query( $query );

print "<facture_clientList>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<cle>".$row->cle."</cle>
	<idfacture_client>".$row->idfacture_client."</idfacture_client>
	<date_facture>".$row->date_facture."</date_facture>
	<type>".$row->type."</type>
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

