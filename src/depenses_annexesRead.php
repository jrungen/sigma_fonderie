<?php
$cle = $_REQUEST['cle'];

//Connexion � la base de donn�es
include 'cnx.php';

// Requ�te
$query = "SELECT * from depenses_annexes where cle = '$cle'";
$result = mysql_query( $query );

/* print out your own XML */
print "<depenses_annexesRead>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<utilisateur>".$row->utilisateur."</utilisateur>
	<cle>".$row->cle."</cle>
	<date>".substr($row->date,-2)."/".substr($row->date,-5,2)."/".substr($row->date,-10,4)."</date>
	<iddepenses_annexes>".$row->iddepenses_annexes."</iddepenses_annexes>
	<libelle>".$row->libelle."</libelle>
	<objet>".$row->objet."</objet>
	<date_creation>".substr($row->date_creation,-2)."/".substr($row->date_creation,-5,2)."/".substr($row->date_creation,-10,4)."</date_creation>
	<creation_par>".$row->creation_par."</creation_par>
	<type_depense>".$row->type_depense."</type_depense>
	<tiers>".$row->tiers."</tiers>
	<projet>".$row->projet."</projet>
	<heure_creation>".$row->heure_creation."</heure_creation>
	<pays>".$row->pays."</pays>
	<action>".$row->action."</action>
	<taux_tva>".$row->taux_tva."</taux_tva>
	<date_modification>".substr($row->date_modification,-2)."/".substr($row->date_modification,-5,2)."/".substr($row->date_modification,-10,4)."</date_modification>
	<modification_par>".$row->modification_par."</modification_par>
	<heure_modification>".$row->heure_modification."</heure_modification>
	<num_comptable>".$row->num_comptable."</num_comptable>
	<montant_reglement_ttc>".$row->montant_reglement_ttc."</montant_reglement_ttc>
	<annee>".$row->annee."</annee>
	<date_reglement>".substr($row->date_reglement,-2)."/".substr($row->date_reglement,-5,2)."/".substr($row->date_reglement,-10,4)."</date_reglement>
	<montant_ht_196>".$row->montant_ht_196."</montant_ht_196>
	<montant_tva_196>".$row->montant_tva_196."</montant_tva_196>
	<pj>".$row->pj."</pj>
	<statut>".$row->statut."</statut>
	<montant_ht_55>".$row->montant_ht_55."</montant_ht_55>
	<montant_tva_55>".$row->montant_tva_55."</montant_tva_55>
	<total_ht>".$row->total_ht."</total_ht>
	<montant_na_tva>".$row->montant_na_tva."</montant_na_tva>
	<reglements>".$row->reglements."</reglements>
	<montant_ht>".$row->montant_ht."</montant_ht>
	<montant_tva>".$row->montant_tva."</montant_tva>
	<beneficiaires>".$row->beneficiaires."</beneficiaires>
	<montant_ttc>".$row->montant_ttc."</montant_ttc>
	<rib>".$row->rib."</rib>
	<depenses>".$row->depenses."</depenses>
	<montant_restant_du>".$row->montant_restant_du."</montant_restant_du>
	<regle_le>".substr($row->regle_le,-2)."/".substr($row->regle_le,-5,2)."/".substr($row->regle_le,-10,4)."</regle_le>
	<validation>".$row->validation."</validation>
	<num_cheque>".$row->num_cheque."</num_cheque>
	<montant_ht_7>".$row->montant_ht_7."</montant_ht_7>
	<montant_tva_7>".$row->montant_tva_7."</montant_tva_7>
	<total_reglement>".$row->total_reglement."</total_reglement>
	<compte_charge>".$row->compte_charge."</compte_charge>
	<compte_charge_pas_tva>".$row->compte_charge_pas_tva."</compte_charge_pas_tva>
	<compte_tva>".$row->compte_tva."</compte_tva>
	<compte_tier>".$row->compte_tier."</compte_tier>
	<nouveau>".$row->nouveau."</nouveau>
	<statut_compta>".$row->statut_compta."</statut_compta>
	<statut_compta_banque>".$row->statut_compta_banque."</statut_compta_banque>
	<statut_compta_banque_od>".$row->statut_compta_banque_od."</statut_compta_banque_od>
	<banque>".$row->banque."</banque>
	<pointe>".$row->pointe."</pointe>
	</item>\n";
}
print "</depenses_annexesRead>";

?>

