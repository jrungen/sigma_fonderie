<?php
$cle = $_REQUEST['cle'];

//Connexion à la base de données
include 'cnx.php';

// Requête
$query = "SELECT * from facture_fournisseur where cle = '$cle'";
$result = mysql_query( $query );

/* print out your own XML */
print "<facture_fournisseurRead>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<date_facture>".substr($row->date_facture,-2)."/".substr($row->date_facture,-5,2)."/".substr($row->date_facture,-10,4)."</date_facture>
	<idfacture_fournisseur>".$row->idfacture_fournisseur."</idfacture_fournisseur>
	<action>".$row->action."</action>
	<cle>".$row->cle."</cle>
	<fourniseur>".$row->fourniseur."</fourniseur>
	<date_creation>".substr($row->date_creation,-2)."/".substr($row->date_creation,-5,2)."/".substr($row->date_creation,-10,4)."</date_creation>
	<objet>".$row->objet."</objet>
	<creation_par>".$row->creation_par."</creation_par>
	<projet>".$row->projet."</projet>
	<item>".$row->item."</item>
	<heure_creation>".$row->heure_creation."</heure_creation>
	<utilisateur>".$row->utilisateur."</utilisateur>
	<date_modification>".substr($row->date_modification,-2)."/".substr($row->date_modification,-5,2)."/".substr($row->date_modification,-10,4)."</date_modification>
	<type>".$row->type."</type>
	<taux_tva>".$row->taux_tva."</taux_tva>
	<cas>".$row->cas."</cas>
	<modification_par>".$row->modification_par."</modification_par>
	<heure_modification>".$row->heure_modification."</heure_modification>
	<annee>".$row->annee."</annee>
	<societe>".$row->societe."</societe>
	<pays>".$row->pays."</pays>
	<montant_tva_19_6>".$row->montant_tva_19_6."</montant_tva_19_6>
	<montant_ht_19_6>".$row->montant_ht_19_6."</montant_ht_19_6>
	<taxe_pays>".$row->taxe_pays."</taxe_pays>
	<taxe_pays_reduit>".$row->taxe_pays_reduit."</taxe_pays_reduit>
	<montant_tva_55>".$row->montant_tva_55."</montant_tva_55>
	<montant_ht_55>".$row->montant_ht_55."</montant_ht_55>
	<montant_tva_7>".$row->montant_tva_7."</montant_tva_7>
	<montant_ht_7>".$row->montant_ht_7."</montant_ht_7>
	<montant_tva_locale>".$row->montant_tva_locale."</montant_tva_locale>
	<montant_ht_locale>".$row->montant_ht_locale."</montant_ht_locale>
	<montant_tva_locale_reduit>".$row->montant_tva_locale_reduit."</montant_tva_locale_reduit>
	<montant_ht_locale_reduit>".$row->montant_ht_locale_reduit."</montant_ht_locale_reduit>
	<numero>".$row->numero."</numero>
	<pj>".$row->pj."</pj>
	<montant_ht_0>".$row->montant_ht_0."</montant_ht_0>
	<total_acompte>".$row->total_acompte."</total_acompte>
	<total_acompte_ht>".$row->total_acompte_ht."</total_acompte_ht>
	<frais_port_ht>".$row->frais_port_ht."</frais_port_ht>
	<montant_restant_du>".$row->montant_restant_du."</montant_restant_du>
	<note>".$row->note."</note>
	<commission_ht>".$row->commission_ht."</commission_ht>
	<montant_ht>".$row->montant_ht."</montant_ht>
	<tva_s_commission>".$row->tva_s_commission."</tva_s_commission>
	<montant_tva>".$row->montant_tva."</montant_tva>
	<tva_s_commission_55>".$row->tva_s_commission_55."</tva_s_commission_55>
	<Remise>".$row->Remise."</Remise>
	<frais_port>".$row->frais_port."</frais_port>
	<tva_s_commission_locale>".$row->tva_s_commission_locale."</tva_s_commission_locale>
	<ttc_commission>".$row->ttc_commission."</ttc_commission>
	<montant_ttc>".$row->montant_ttc."</montant_ttc>
	<facture_regle>".$row->facture_regle."</facture_regle>
	<total_regle>".$row->total_regle."</total_regle>
	<validation>".$row->validation."</validation>
	<montant_restant_du_facturation>".$row->montant_restant_du_facturation."</montant_restant_du_facturation>
	<note_comptable>".$row->note_comptable."</note_comptable>
	<statut_compta>".$row->statut_compta."</statut_compta>
	<compte_charge>".$row->compte_charge."</compte_charge>
	<compte_tva>".$row->compte_tva."</compte_tva>
	<nouveau>".$row->nouveau."</nouveau>
	<pointe>".$row->pointe."</pointe>
	</item>\n";
}
	print "</facture_fournisseurRead>";
?>