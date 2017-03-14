<?php
$cle = $_REQUEST['cle'];

//Connexion � la base de donn�es
include 'cnx.php';

// Requ�te
$query = "SELECT * from facture_client where cle = '$cle'";
$result = mysql_query( $query );

/* print out your own XML */
print "<facture_clientRead>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<idfacture_client>".$row->idfacture_client."</idfacture_client>
<cle>".$row->cle."</cle>
<date_creation>".substr($row->date_creation,-2)."/".substr($row->date_creation,-5,2)."/".substr($row->date_creation,-10,4)."</date_creation>
<objet>".$row->objet."</objet>
<montant_ht>".$row->montant_ht."</montant_ht>
<clt_reference>".$row->clt_reference."</clt_reference>
<creation_par>".$row->creation_par."</creation_par>
<acc_ref>".$row->acc_ref."</acc_ref>
<societe>".$row->societe."</societe>
<type>".$row->type."</type>
<acc_civilite>".$row->acc_civilite."</acc_civilite>
<acompte1>".$row->acompte1."</acompte1>
<montant_tva>".$row->montant_tva."</montant_tva>
<heure_creation>".$row->heure_creation."</heure_creation>
<acc_nb_personne>".$row->acc_nb_personne."</acc_nb_personne>
<projet>".$row->projet."</projet>
<date1>".substr($row->date1,-2)."/".substr($row->date1,-5,2)."/".substr($row->date1,-10,4)."</date1>
<date_modification>".substr($row->date_modification,-2)."/".substr($row->date_modification,-5,2)."/".substr($row->date_modification,-10,4)."</date_modification>
<acc_date_depart>".substr($row->acc_date_depart,-2)."/".substr($row->acc_date_depart,-5,2)."/".substr($row->acc_date_depart,-10,4)."</acc_date_depart>
<montant_ttc>".$row->montant_ttc."</montant_ttc>
<acc_nom>".$row->acc_nom."</acc_nom>
<modification_par>".$row->modification_par."</modification_par>
<pays_projet>".$row->pays_projet."</pays_projet>
<contact>".$row->contact."</contact>
<acc_date_retour>".substr($row->acc_date_retour,-2)."/".substr($row->acc_date_retour,-5,2)."/".substr($row->acc_date_retour,-10,4)."</acc_date_retour>
<pj1>".$row->pj1."</pj1>
<operation>".$row->operation."</operation>
<acc_facturation_adresse1>".$row->acc_facturation_adresse1."</acc_facturation_adresse1>
<cas>".$row->cas."</cas>
<heure_modification>".$row->heure_modification."</heure_modification>
<facturation_adresse1>".$row->facturation_adresse1."</facturation_adresse1>
<utilisateur>".$row->utilisateur."</utilisateur>
<annee>".$row->annee."</annee>
<note>".$row->note."</note>
<acc_note>".$row->acc_note."</acc_note>
<facturation_adresse2>".$row->facturation_adresse2."</facturation_adresse2>
<facturation_cp>".$row->facturation_cp."</facturation_cp>
<acc_facturation_cp>".$row->acc_facturation_cp."</acc_facturation_cp>
<date_facture>".substr($row->date_facture,-2)."/".substr($row->date_facture,-5,2)."/".substr($row->date_facture,-10,4)."</date_facture>
<acompte2>".$row->acompte2."</acompte2>
<facturation_ville>".$row->facturation_ville."</facturation_ville>
<acc_facturation_ville>".$row->acc_facturation_ville."</acc_facturation_ville>
<date2>".substr($row->date2,-2)."/".substr($row->date2,-5,2)."/".substr($row->date2,-10,4)."</date2>
<numero>".$row->numero."</numero>
<pays>".$row->pays."</pays>
<acc_hop>".$row->acc_hop."</acc_hop>
<pj2>".$row->pj2."</pj2>
<libelle>".$row->libelle."</libelle>
<acc_service_hop>".$row->acc_service_hop."</acc_service_hop>
<acompte3>".$row->acompte3."</acompte3>
<date3>".substr($row->date3,-2)."/".substr($row->date3,-5,2)."/".substr($row->date3,-10,4)."</date3>
<pj3>".$row->pj3."</pj3>
<acompte_total>".$row->acompte_total."</acompte_total>
<montant_restant>".$row->montant_restant."</montant_restant>
<reglee>".$row->reglee."</reglee>
<statut>".$row->statut."</statut>
<delai_paiement>".$row->delai_paiement."</delai_paiement>
<pj>".$row->pj."</pj>
<montant_total_paiement_ttc>".$row->montant_total_paiement_ttc."</montant_total_paiement_ttc>
<tva>".$row->tva."</tva>
<acompte_regle>".$row->acompte_regle."</acompte_regle>
<pourcentage1>".$row->pourcentage1."</pourcentage1>
<acompte_clt_1>".$row->acompte_clt_1."</acompte_clt_1>
<acompte_date1>".substr($row->acompte_date1,-2)."/".substr($row->acompte_date1,-5,2)."/".substr($row->acompte_date1,-10,4)."</acompte_date1>
<pourcentage2>".$row->pourcentage2."</pourcentage2>
<acompte_clt_2>".$row->acompte_clt_2."</acompte_clt_2>
<acompte_date2>".substr($row->acompte_date2,-2)."/".substr($row->acompte_date2,-5,2)."/".substr($row->acompte_date2,-10,4)."</acompte_date2>
<statut_compta>".$row->statut_compta."</statut_compta>
<statut_compta_paiement>".$row->statut_compta_paiement."</statut_compta_paiement>
<banque>".$row->banque."</banque>
<compte_produit>".$row->compte_produit."</compte_produit>
<compte_tva>".$row->compte_tva."</compte_tva>
<nouveau>".$row->nouveau."</nouveau>
<statut_compta_paiement2>".$row->statut_compta_paiement2."</statut_compta_paiement2>
<statut_compta_paiement3>".$row->statut_compta_paiement3."</statut_compta_paiement3>
	</item>\n";
}
print "</facture_clientRead>";

?>

