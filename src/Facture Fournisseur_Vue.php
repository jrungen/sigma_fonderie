<?php

//Connexion à la base de données
include 'cnx.php';


// Requête
$query = "SELECT * from facture_fournisseur where 1 AND type='Factures fournisseurs'";
$result = mysql_query( $query );

print "<facture_fournisseurList>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<type_depenses>".$row->type_depenses."</type_depenses>
<designation>".$row->designation."</designation>
<date_reglement>".substr($row->date_reglement,-2)."/".substr($row->date_reglement,-5,2)."/".substr($row->date_reglement,-10,4)."</date_reglement>
<acompte_reglement>".$row->acompte_reglement."</acompte_reglement>
<statut>".$row->statut."</statut>
<date_paye>".substr($row->date_paye,-2)."/".substr($row->date_paye,-5,2)."/".substr($row->date_paye,-10,4)."</date_paye>
<acompte_paye>".$row->acompte_paye."</acompte_paye>
<idfacture_fournisseur_ligne>".$row->idfacture_fournisseur_ligne."</idfacture_fournisseur_ligne>
<cle>".$row->cle."</cle>

   </item>\n";
}
print "</facture_fournisseurList>"; 
?>

