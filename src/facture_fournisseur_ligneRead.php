<?php
$cle = $_REQUEST['cle'];

//Connexion à la base de données
include 'cnx.php';

// Requête
$query = "SELECT * from facture_fournisseur_ligne where cle = '$cle'";
$result = mysql_query( $query );

/* print out your own XML */
print "<facture_fournisseur_ligneRead>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<facture_fournisseur>".$row->facture_fournisseur."</facture_fournisseur>
<cle>".$row->cle."</cle>
<idfacture_fournisseur_ligne>".$row->idfacture_fournisseur_ligne."</idfacture_fournisseur_ligne>
<type_depenses>".$row->type_depenses."</type_depenses>
<acompte_reglement>".$row->acompte_reglement."</acompte_reglement>
<acompte_reglement_ht>".$row->acompte_reglement_ht."</acompte_reglement_ht>
<date_creation>".substr($row->date_creation,-2)."/".substr($row->date_creation,-5,2)."/".substr($row->date_creation,-10,4)."</date_creation>
<creation_par>".$row->creation_par."</creation_par>
<designation>".$row->designation."</designation>
<date_reglement>".substr($row->date_reglement,-2)."/".substr($row->date_reglement,-5,2)."/".substr($row->date_reglement,-10,4)."</date_reglement>
<heure_creation>".$row->heure_creation."</heure_creation>
<pj_reglement>".$row->pj_reglement."</pj_reglement>
<date_modification>".substr($row->date_modification,-2)."/".substr($row->date_modification,-5,2)."/".substr($row->date_modification,-10,4)."</date_modification>
<modification_par>".$row->modification_par."</modification_par>
<devise>".$row->devise."</devise>
<cas>".$row->cas."</cas>
<type_reglement>".$row->type_reglement."</type_reglement>
<heure_modification>".$row->heure_modification."</heure_modification>
<autre_devise>".$row->autre_devise."</autre_devise>
<annee>".$row->annee."</annee>
<montant_devise>".$row->montant_devise."</montant_devise>
<autres>".$row->autres."</autres>
<note>".$row->note."</note>
<beneficiaire>".$row->beneficiaire."</beneficiaire>
<nom_banque>".$row->nom_banque."</nom_banque>
<domiciliation>".$row->domiciliation."</domiciliation>
<acompte_paye>".$row->acompte_paye."</acompte_paye>
<code_banque>".$row->code_banque."</code_banque>
<date_paye>".substr($row->date_paye,-2)."/".substr($row->date_paye,-5,2)."/".substr($row->date_paye,-10,4)."</date_paye>
<code_guichet>".$row->code_guichet."</code_guichet>
<pj_paye>".$row->pj_paye."</pj_paye>
<num_compte>".$row->num_compte."</num_compte>
<num_cheque>".$row->num_cheque."</num_cheque>
<cle_banque>".$row->cle_banque."</cle_banque>
<iban>".$row->iban."</iban>
<code_swift>".$row->code_swift."</code_swift>
<statut>".$row->statut."</statut>
<statut_compta>".$row->statut_compta."</statut_compta>
<banque>".$row->banque."</banque>
	</item>\n";
}
print "</facture_fournisseur_ligneRead>";

?>

