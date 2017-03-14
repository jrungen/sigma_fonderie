<?php
$cle = $_REQUEST['cle'];

//Connexion � la base de donn�es
include 'cnx.php';

// Requ�te
$query = "SELECT * from projet where cle = '$cle'";
$result = mysql_query( $query );

/* print out your own XML */
print "<projetRead>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<societe>".$row->societe."</societe>
<idprojet>".$row->idprojet."</idprojet>
<type>".$row->type."</type>
<cle>".$row->cle."</cle>
<date_creation>".substr($row->date_creation,-2)."/".substr($row->date_creation,-5,2)."/".substr($row->date_creation,-10,4)."</date_creation>
<nom>".$row->nom."</nom>
<ta_montant_recette_ttc>".$row->ta_montant_recette_ttc."</ta_montant_recette_ttc>
<pe_montant_recette_ht>".$row->pe_montant_recette_ht."</pe_montant_recette_ht>
<lieu>".$row->lieu."</lieu>
<apporteur_affaire>".$row->apporteur_affaire."</apporteur_affaire>
<creation_par>".$row->creation_par."</creation_par>
<datedebut>".substr($row->datedebut,-2)."/".substr($row->datedebut,-5,2)."/".substr($row->datedebut,-10,4)."</datedebut>
<pe_montant_depense_ht>".$row->pe_montant_depense_ht."</pe_montant_depense_ht>
<ta_montant_recette_accompagnant>".$row->ta_montant_recette_accompagnant."</ta_montant_recette_accompagnant>
<heure_creation>".$row->heure_creation."</heure_creation>
<datefin>".substr($row->datefin,-2)."/".substr($row->datefin,-5,2)."/".substr($row->datefin,-10,4)."</datefin>
<date_modification>".substr($row->date_modification,-2)."/".substr($row->date_modification,-5,2)."/".substr($row->date_modification,-10,4)."</date_modification>
<ta_marge_ht>".$row->ta_marge_ht."</ta_marge_ht>
<pe_marge_ht>".$row->pe_marge_ht."</pe_marge_ht>
<ta_montant_recette_total_ttc>".$row->ta_montant_recette_total_ttc."</ta_montant_recette_total_ttc>
<numero>".$row->numero."</numero>
<modification_par>".$row->modification_par."</modification_par>
<ta_montant_depense_ttc>".$row->ta_montant_depense_ttc."</ta_montant_depense_ttc>
<cas>".$row->cas."</cas>
<numero_code>".$row->numero_code."</numero_code>
<heure_modification>".$row->heure_modification."</heure_modification>
<utilisateur>".$row->utilisateur."</utilisateur>
<statut>".$row->statut."</statut>
<annee>".$row->annee."</annee>
<ta_marge_ttc>".$row->ta_marge_ttc."</ta_marge_ttc>
<pays>".$row->pays."</pays>
<ta_tva_marge>".$row->ta_tva_marge."</ta_tva_marge>
<ps_montant_recette_ht>".$row->ps_montant_recette_ht."</ps_montant_recette_ht>
<ca_ht>".$row->ca_ht."</ca_ht>
<recette2_previsionnelle>".$row->recette2_previsionnelle."</recette2_previsionnelle>
<total_marge>".$row->total_marge."</total_marge>
<recette1_previsionnelle>".$row->recette1_previsionnelle."</recette1_previsionnelle>
<ps_montant_depense_ht>".$row->ps_montant_depense_ht."</ps_montant_depense_ht>
<depense2_previsionnelle>".$row->depense2_previsionnelle."</depense2_previsionnelle>
<taux_marge>".$row->taux_marge."</taux_marge>
<ps_marge_ht>".$row->ps_marge_ht."</ps_marge_ht>
<depense1_previsionnelle>".$row->depense1_previsionnelle."</depense1_previsionnelle>
<marge2_previsionnelle>".$row->marge2_previsionnelle."</marge2_previsionnelle>
<ps_tva_marge>".$row->ps_tva_marge."</ps_tva_marge>
<montant_total_tva_locale>".$row->montant_total_tva_locale."</montant_total_tva_locale>
<marge1_previsionnelle>".$row->marge1_previsionnelle."</marge1_previsionnelle>
<date1_previsionnelle>".substr($row->date1_previsionnelle,-2)."/".substr($row->date1_previsionnelle,-5,2)."/".substr($row->date1_previsionnelle,-10,4)."</date1_previsionnelle>
<pj1_previsionnelle>".$row->pj1_previsionnelle."</pj1_previsionnelle>
<date2_previsionnelle>".substr($row->date2_previsionnelle,-2)."/".substr($row->date2_previsionnelle,-5,2)."/".substr($row->date2_previsionnelle,-10,4)."</date2_previsionnelle>
<pj3_previsionnelle>".$row->pj3_previsionnelle."</pj3_previsionnelle>
<pj2_previsionnelle>".$row->pj2_previsionnelle."</pj2_previsionnelle>
<str_tourisme_affaire>".$row->str_tourisme_affaire."</str_tourisme_affaire>
<std_tourisme_affaire>".$row->std_tourisme_affaire."</std_tourisme_affaire>
<date3_previsionnelle>".substr($row->date3_previsionnelle,-2)."/".substr($row->date3_previsionnelle,-5,2)."/".substr($row->date3_previsionnelle,-10,4)."</date3_previsionnelle>
<pj_confirmee>".$row->pj_confirmee."</pj_confirmee>
<str_presta_evenement>".$row->str_presta_evenement."</str_presta_evenement>
<std_presta_evenement>".$row->std_presta_evenement."</std_presta_evenement>
<str_total>".$row->str_total."</str_total>
<std_total>".$row->std_total."</std_total>
<pays_client>".$row->pays_client."</pays_client>
<st_total_balance>".$row->st_total_balance."</st_total_balance>
<nb_reunion_prev>".$row->nb_reunion_prev."</nb_reunion_prev>
<nb_reunion_confirme>".$row->nb_reunion_confirme."</nb_reunion_confirme>
<ta_soustotal_autres_facturation>".$row->ta_soustotal_autres_facturation."</ta_soustotal_autres_facturation>
<comptable>".$row->comptable."</comptable>
<libelle>".$row->libelle."</libelle>
<nouveau>".$row->nouveau."</nouveau>
<departement>".$row->departement."</departement>
	</item>\n";
}
print "</projetRead>";

?>

