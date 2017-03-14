<?php

$search=" where idprojet = '".$_REQUEST['id']."'";

//Connexion � la base de donnees
include 'cnx.php';

if ($_REQUEST['societe']=='') $s_societe = ''; else $s_societe= addslashes($_REQUEST['societe']);
if ($_REQUEST['type']=='') $s_type = ''; else $s_type= addslashes($_REQUEST['type']);
if ($_REQUEST['cle']=='') $s_cle = ''; else $s_cle= addslashes($_REQUEST['cle']);
if ($_REQUEST['date_creation']=='') $s_date_creation = '0000-00-00'; else $s_date_creation= substr($_REQUEST['date_creation'],-4)."-".substr($_REQUEST['date_creation'],-7,2)."-".substr($_REQUEST['date_creation'],-10,2);
if ($_REQUEST['lieu']=='') $s_lieu = ''; else $s_lieu= addslashes($_REQUEST['lieu']);
if ($_REQUEST['apporteur_affaire']=='') $s_apporteur_affaire = ''; else $s_apporteur_affaire= addslashes($_REQUEST['apporteur_affaire']);
if ($_REQUEST['ta_montant_recette_ttc']=='') $s_ta_montant_recette_ttc = '0'; else $s_ta_montant_recette_ttc= addslashes($_REQUEST['ta_montant_recette_ttc']);
if ($_REQUEST['pe_montant_recette_ht']=='') $s_pe_montant_recette_ht = '0'; else $s_pe_montant_recette_ht= addslashes($_REQUEST['pe_montant_recette_ht']);
if ($_REQUEST['nom']=='') $s_nom = ''; else $s_nom= addslashes($_REQUEST['nom']);
if ($_REQUEST['creation_par']=='') $s_creation_par = ''; else $s_creation_par= addslashes($_REQUEST['creation_par']);
if ($_REQUEST['datedebut']=='') $s_datedebut = '0000-00-00'; else $s_datedebut= substr($_REQUEST['datedebut'],-4)."-".substr($_REQUEST['datedebut'],-7,2)."-".substr($_REQUEST['datedebut'],-10,2);
if ($_REQUEST['pe_montant_depense_ht']=='') $s_pe_montant_depense_ht = '0'; else $s_pe_montant_depense_ht= addslashes($_REQUEST['pe_montant_depense_ht']);
if ($_REQUEST['ta_montant_recette_accompagnant']=='') $s_ta_montant_recette_accompagnant = '0'; else $s_ta_montant_recette_accompagnant= addslashes($_REQUEST['ta_montant_recette_accompagnant']);
if ($_REQUEST['heure_creation']=='') $s_heure_creation = ''; else $s_heure_creation= addslashes($_REQUEST['heure_creation']);
if ($_REQUEST['datefin']=='') $s_datefin = '0000-00-00'; else $s_datefin= substr($_REQUEST['datefin'],-4)."-".substr($_REQUEST['datefin'],-7,2)."-".substr($_REQUEST['datefin'],-10,2);
if ($_REQUEST['date_modification']=='') $s_date_modification = '0000-00-00'; else $s_date_modification= substr($_REQUEST['date_modification'],-4)."-".substr($_REQUEST['date_modification'],-7,2)."-".substr($_REQUEST['date_modification'],-10,2);
if ($_REQUEST['numero']=='') $s_numero = ''; else $s_numero= addslashes($_REQUEST['numero']);
if ($_REQUEST['ta_marge_ht']=='') $s_ta_marge_ht = '0'; else $s_ta_marge_ht= addslashes($_REQUEST['ta_marge_ht']);
if ($_REQUEST['pe_marge_ht']=='') $s_pe_marge_ht = '0'; else $s_pe_marge_ht= addslashes($_REQUEST['pe_marge_ht']);
if ($_REQUEST['ta_montant_recette_total_ttc']=='') $s_ta_montant_recette_total_ttc = '0'; else $s_ta_montant_recette_total_ttc= addslashes($_REQUEST['ta_montant_recette_total_ttc']);
if ($_REQUEST['modification_par']=='') $s_modification_par = ''; else $s_modification_par= addslashes($_REQUEST['modification_par']);
if ($_REQUEST['ta_montant_depense_ttc']=='') $s_ta_montant_depense_ttc = '0'; else $s_ta_montant_depense_ttc= addslashes($_REQUEST['ta_montant_depense_ttc']);
if ($_REQUEST['cas']=='') $s_cas = ''; else $s_cas= addslashes($_REQUEST['cas']);
if ($_REQUEST['numero_code']=='') $s_numero_code = ''; else $s_numero_code= addslashes($_REQUEST['numero_code']);
if ($_REQUEST['heure_modification']=='') $s_heure_modification = ''; else $s_heure_modification= addslashes($_REQUEST['heure_modification']);
if ($_REQUEST['utilisateur']=='') $s_utilisateur = ''; else $s_utilisateur= addslashes($_REQUEST['utilisateur']);
if ($_REQUEST['ta_marge_ttc']=='') $s_ta_marge_ttc = '0'; else $s_ta_marge_ttc= addslashes($_REQUEST['ta_marge_ttc']);
if ($_REQUEST['statut']=='') $s_statut = ''; else $s_statut= addslashes($_REQUEST['statut']);
if ($_REQUEST['annee']=='') $s_annee = ''; else $s_annee= addslashes($_REQUEST['annee']);
if ($_REQUEST['pays']=='') $s_pays = ''; else $s_pays= addslashes($_REQUEST['pays']);
if ($_REQUEST['ta_tva_marge']=='') $s_ta_tva_marge = '0'; else $s_ta_tva_marge= addslashes($_REQUEST['ta_tva_marge']);
if ($_REQUEST['ps_montant_recette_ht']=='') $s_ps_montant_recette_ht = '0'; else $s_ps_montant_recette_ht= addslashes($_REQUEST['ps_montant_recette_ht']);
if ($_REQUEST['ca_ht']=='') $s_ca_ht = '0'; else $s_ca_ht= addslashes($_REQUEST['ca_ht']);
if ($_REQUEST['recette2_previsionnelle']=='') $s_recette2_previsionnelle = '0'; else $s_recette2_previsionnelle= addslashes($_REQUEST['recette2_previsionnelle']);
if ($_REQUEST['total_marge']=='') $s_total_marge = '0'; else $s_total_marge= addslashes($_REQUEST['total_marge']);
if ($_REQUEST['recette1_previsionnelle']=='') $s_recette1_previsionnelle = '0'; else $s_recette1_previsionnelle= addslashes($_REQUEST['recette1_previsionnelle']);
if ($_REQUEST['ps_montant_depense_ht']=='') $s_ps_montant_depense_ht = '0'; else $s_ps_montant_depense_ht= addslashes($_REQUEST['ps_montant_depense_ht']);
if ($_REQUEST['depense2_previsionnelle']=='') $s_depense2_previsionnelle = '0'; else $s_depense2_previsionnelle= addslashes($_REQUEST['depense2_previsionnelle']);
if ($_REQUEST['taux_marge']=='') $s_taux_marge = '0'; else $s_taux_marge= addslashes($_REQUEST['taux_marge']);
if ($_REQUEST['ps_marge_ht']=='') $s_ps_marge_ht = '0'; else $s_ps_marge_ht= addslashes($_REQUEST['ps_marge_ht']);
if ($_REQUEST['depense1_previsionnelle']=='') $s_depense1_previsionnelle = '0'; else $s_depense1_previsionnelle= addslashes($_REQUEST['depense1_previsionnelle']);
if ($_REQUEST['marge2_previsionnelle']=='') $s_marge2_previsionnelle = '0'; else $s_marge2_previsionnelle= addslashes($_REQUEST['marge2_previsionnelle']);
if ($_REQUEST['ps_tva_marge']=='') $s_ps_tva_marge = '0'; else $s_ps_tva_marge= addslashes($_REQUEST['ps_tva_marge']);
if ($_REQUEST['montant_total_tva_locale']=='') $s_montant_total_tva_locale = '0'; else $s_montant_total_tva_locale= addslashes($_REQUEST['montant_total_tva_locale']);
if ($_REQUEST['marge1_previsionnelle']=='') $s_marge1_previsionnelle = '0'; else $s_marge1_previsionnelle= addslashes($_REQUEST['marge1_previsionnelle']);
if ($_REQUEST['date1_previsionnelle']=='') $s_date1_previsionnelle = '0000-00-00'; else $s_date1_previsionnelle= substr($_REQUEST['date1_previsionnelle'],-4)."-".substr($_REQUEST['date1_previsionnelle'],-7,2)."-".substr($_REQUEST['date1_previsionnelle'],-10,2);
if ($_REQUEST['pj1_previsionnelle']=='') $s_pj1_previsionnelle = ''; else $s_pj1_previsionnelle= addslashes($_REQUEST['pj1_previsionnelle']);
if ($_REQUEST['date2_previsionnelle']=='') $s_date2_previsionnelle = '0000-00-00'; else $s_date2_previsionnelle= substr($_REQUEST['date2_previsionnelle'],-4)."-".substr($_REQUEST['date2_previsionnelle'],-7,2)."-".substr($_REQUEST['date2_previsionnelle'],-10,2);
if ($_REQUEST['pj3_previsionnelle']=='') $s_pj3_previsionnelle = ''; else $s_pj3_previsionnelle= addslashes($_REQUEST['pj3_previsionnelle']);
if ($_REQUEST['pj2_previsionnelle']=='') $s_pj2_previsionnelle = ''; else $s_pj2_previsionnelle= addslashes($_REQUEST['pj2_previsionnelle']);
if ($_REQUEST['str_tourisme_affaire']=='') $s_str_tourisme_affaire = '0'; else $s_str_tourisme_affaire= addslashes($_REQUEST['str_tourisme_affaire']);
if ($_REQUEST['std_tourisme_affaire']=='') $s_std_tourisme_affaire = '0'; else $s_std_tourisme_affaire= addslashes($_REQUEST['std_tourisme_affaire']);
if ($_REQUEST['date3_previsionnelle']=='') $s_date3_previsionnelle = '0000-00-00'; else $s_date3_previsionnelle= substr($_REQUEST['date3_previsionnelle'],-4)."-".substr($_REQUEST['date3_previsionnelle'],-7,2)."-".substr($_REQUEST['date3_previsionnelle'],-10,2);
if ($_REQUEST['str_presta_evenement']=='') $s_str_presta_evenement = '0'; else $s_str_presta_evenement= addslashes($_REQUEST['str_presta_evenement']);
if ($_REQUEST['std_presta_evenement']=='') $s_std_presta_evenement = '0'; else $s_std_presta_evenement= addslashes($_REQUEST['std_presta_evenement']);
if ($_REQUEST['pj_confirmee']=='') $s_pj_confirmee = ''; else $s_pj_confirmee= addslashes($_REQUEST['pj_confirmee']);
if ($_REQUEST['pays_client']=='') $s_pays_client = ''; else $s_pays_client= addslashes($_REQUEST['pays_client']);
if ($_REQUEST['str_total']=='') $s_str_total = '0'; else $s_str_total= addslashes($_REQUEST['str_total']);
if ($_REQUEST['std_total']=='') $s_std_total = '0'; else $s_std_total= addslashes($_REQUEST['std_total']);
if ($_REQUEST['st_total_balance']=='') $s_st_total_balance = '0'; else $s_st_total_balance= addslashes($_REQUEST['st_total_balance']);
if ($_REQUEST['nb_reunion_prev']=='') $s_nb_reunion_prev = ''; else $s_nb_reunion_prev= addslashes($_REQUEST['nb_reunion_prev']);
if ($_REQUEST['nb_reunion_confirme']=='') $s_nb_reunion_confirme = ''; else $s_nb_reunion_confirme= addslashes($_REQUEST['nb_reunion_confirme']);
if ($_REQUEST['ta_soustotal_autres_facturation']=='') $s_ta_soustotal_autres_facturation = '0'; else $s_ta_soustotal_autres_facturation= addslashes($_REQUEST['ta_soustotal_autres_facturation']);
if ($_REQUEST['comptable']=='') $s_comptable = '0'; else $s_comptable= addslashes($_REQUEST['comptable']);
if ($_REQUEST['libelle']=='') $s_libelle = ''; else $s_libelle= addslashes($_REQUEST['libelle']);
if ($_REQUEST['nouveau']=='') $s_nouveau = ''; else $s_nouveau= addslashes($_REQUEST['nouveau']);
if ($_REQUEST['departement']=='') $s_departement = ''; else $s_departement= addslashes($_REQUEST['departement']);

// Requ�te
$query = "UPDATE projet set societe='". $s_societe."',
type='". $s_type."',
cle='". $s_cle."',
date_creation='". $s_date_creation."',
lieu='". $s_lieu."',
apporteur_affaire='". $s_apporteur_affaire."',
ta_montant_recette_ttc='". $s_ta_montant_recette_ttc."',
pe_montant_recette_ht='". $s_pe_montant_recette_ht."',
nom='". $s_nom."',
creation_par='". $s_creation_par."',
datedebut='". $s_datedebut."',
pe_montant_depense_ht='". $s_pe_montant_depense_ht."',
ta_montant_recette_accompagnant='". $s_ta_montant_recette_accompagnant."',
heure_creation='". $s_heure_creation."',
datefin='". $s_datefin."',
date_modification='". $s_date_modification."',
numero='". $s_numero."',
ta_marge_ht='". $s_ta_marge_ht."',
pe_marge_ht='". $s_pe_marge_ht."',
ta_montant_recette_total_ttc='". $s_ta_montant_recette_total_ttc."',
modification_par='". $s_modification_par."',
ta_montant_depense_ttc='". $s_ta_montant_depense_ttc."',
cas='". $s_cas."',
numero_code='". $s_numero_code."',
heure_modification='". $s_heure_modification."',
utilisateur='". $s_utilisateur."',
ta_marge_ttc='". $s_ta_marge_ttc."',
statut='". $s_statut."',
annee='". $s_annee."',
pays='". $s_pays."',
ta_tva_marge='". $s_ta_tva_marge."',
ps_montant_recette_ht='". $s_ps_montant_recette_ht."',
ca_ht='". $s_ca_ht."',
recette2_previsionnelle='". $s_recette2_previsionnelle."',
total_marge='". $s_total_marge."',
recette1_previsionnelle='". $s_recette1_previsionnelle."',
ps_montant_depense_ht='". $s_ps_montant_depense_ht."',
depense2_previsionnelle='". $s_depense2_previsionnelle."',
taux_marge='". $s_taux_marge."',
ps_marge_ht='". $s_ps_marge_ht."',
depense1_previsionnelle='". $s_depense1_previsionnelle."',
marge2_previsionnelle='". $s_marge2_previsionnelle."',
ps_tva_marge='". $s_ps_tva_marge."',
montant_total_tva_locale='". $s_montant_total_tva_locale."',
marge1_previsionnelle='". $s_marge1_previsionnelle."',
date1_previsionnelle='". $s_date1_previsionnelle."',
pj1_previsionnelle='". $s_pj1_previsionnelle."',
date2_previsionnelle='". $s_date2_previsionnelle."',
pj3_previsionnelle='". $s_pj3_previsionnelle."',
pj2_previsionnelle='". $s_pj2_previsionnelle."',
str_tourisme_affaire='". $s_str_tourisme_affaire."',
std_tourisme_affaire='". $s_std_tourisme_affaire."',
date3_previsionnelle='". $s_date3_previsionnelle."',
str_presta_evenement='". $s_str_presta_evenement."',
std_presta_evenement='". $s_std_presta_evenement."',
pj_confirmee='". $s_pj_confirmee."',
pays_client='". $s_pays_client."',
str_total='". $s_str_total."',
std_total='". $s_std_total."',
st_total_balance='". $s_st_total_balance."',
nb_reunion_prev='". $s_nb_reunion_prev."',
nb_reunion_confirme='". $s_nb_reunion_confirme."',
ta_soustotal_autres_facturation='". $s_ta_soustotal_autres_facturation."',
comptable='". $s_comptable."',
libelle='". $s_libelle."',
nouveau='". $s_nouveau."',
departement='". $s_departement."' $search";

$result = mysql_query( $query );

?>