<?php

//Connexion à la base de données
include 'cnx.php';


// Requête
$query = "SELECT * from facture_fournisseur_ligne where 1 and facture_fournisseur='".$_REQUEST['cle']."'";
$result = mysql_query( $query );

print "<facture_fournisseur_ligneList>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<type_depenses>".$row->type_depenses."</type_depenses>
<designation>".$row->designation."</designation>
<date_reglement>".substr($row->date_reglement,-2)."/".substr($row->date_reglement,-5,2)."/".substr($row->date_reglement,-10,4)."</date_reglement>
<acompte_reglement>".$row->acompte_reglement."</acompte_reglement>
<acompte_reglement_ht>".$row->acompte_reglement_ht."</acompte_reglement_ht>
<statut>".$row->statut."</statut>
<date_paye>".substr($row->date_paye,-2)."/".substr($row->date_paye,-5,2)."/".substr($row->date_paye,-10,4)."</date_paye>
<acompte_paye>".$row->acompte_paye."</acompte_paye>
<num_cheque>".$row->num_cheque."</num_cheque>
<idfacture_fournisseur_ligne>".$row->idfacture_fournisseur_ligne."</idfacture_fournisseur_ligne>
<cle>".$row->cle."</cle>

   </item>\n";
}
print "</facture_fournisseur_ligneList>"; 
?>

