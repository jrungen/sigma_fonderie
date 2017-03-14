<?php

//Connexion à la base de données
include 'cnx.php';
if ($_REQUEST['search']!=''){
	$search =  "and annee = '".$_REQUEST['search']."'";
}else{
	$search = "";
}

// Requête
$query = "SELECT * from facture_fournisseur where 1 AND fourniseur='".$_REQUEST['cle']."' ".$search." ";
echo $query;
$result = mysql_query( $query );

print "<facture_fournisseurList>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<date_facture>".substr($row->date_facture,-2)."/".substr($row->date_facture,-5,2)."/".substr($row->date_facture,-10,4)."</date_facture>
	<type>".$row->type."</type>
	<numero>".$row->numero."</numero>
	<societe>".$row->societe."</societe>
	<montant_ht>".$row->montant_ht."</montant_ht>
	<montant_ttc>".$row->montant_ttc."</montant_ttc>
	<total_regle>".$row->total_regle."</total_regle>
	<montant_restant_du>".$row->montant_restant_du_facturation."</montant_restant_du>
	<idfacture_fournisseur>".$row->idfacture_fournisseur."</idfacture_fournisseur>
	<cle>".$row->cle."</cle>
   </item>\n";
}
print "</facture_fournisseurList>"; 
?>