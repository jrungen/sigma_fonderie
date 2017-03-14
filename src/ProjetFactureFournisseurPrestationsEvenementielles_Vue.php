<?php

//Connexion à la base de données
include 'cnx.php';


// Requête
$query = "SELECT * from facture_fournisseur where 1 AND projet='".$_REQUEST['cle']."' AND type='Factures fournisseurs' AND objet = 'Prestation événementielles' order by societe";
$result = mysql_query( $query );

print "<facture_fournisseurList>\n";
while( $row = mysql_fetch_object( $result ) )
{

$montantht = $row->montant_ht;

if($montantht<=0){
	$montantht = $row->total_acompte_ht;
}
   print "<item>
<montant_tva_locale>".$row->montant_tva_locale."</montant_tva_locale>
<pays>".$row->pays."</pays>
<date_facture>".substr($row->date_facture,-2)."/".substr($row->date_facture,-5,2)."/".substr($row->date_facture,-10,4)."</date_facture>
<numero>".$row->numero."</numero>
<societe>".$row->societe."</societe>
<montant_ht>".$montantht."</montant_ht>
<montant_ttc>".$row->montant_ttc."</montant_ttc>
<total_regle>".$row->total_regle."</total_regle>
<montant_restant_du>".$row->montant_restant_du_facturation."</montant_restant_du>
<idfacture_fournisseur>".$row->idfacture_fournisseur."</idfacture_fournisseur>
<cle>".$row->cle."</cle>
<type>".$row->type."</type>

   </item>\n";
}
print "</facture_fournisseurList>"; 
?>

