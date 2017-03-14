<?php

//Connexion ˆ la base de donnees
include 'cnx.php';

// autoincremement

if ($_REQUEST['utilisateur']=='') $s_utilisateur = ''; else $s_utilisateur= addslashes($_REQUEST['utilisateur']);
if ($_REQUEST['cle']=='') $s_cle = ''; else $s_cle= addslashes($_REQUEST['cle']);
if ($_REQUEST['date']=='') $s_date = '0000-00-00'; else $s_date= substr($_REQUEST['date'],-4)."-".substr($_REQUEST['date'],-7,2)."-".substr($_REQUEST['date'],-10,2);
if ($_REQUEST['libelle']=='') $s_libelle = ''; else $s_libelle= addslashes($_REQUEST['libelle']);
if ($_REQUEST['objet']=='') $s_objet = ''; else $s_objet= addslashes($_REQUEST['objet']);
if ($_REQUEST['date_creation']=='') $s_date_creation = '0000-00-00'; else $s_date_creation= substr($_REQUEST['date_creation'],-4)."-".substr($_REQUEST['date_creation'],-7,2)."-".substr($_REQUEST['date_creation'],-10,2);
if ($_REQUEST['creation_par']=='') $s_creation_par = ''; else $s_creation_par= addslashes($_REQUEST['creation_par']);
if ($_REQUEST['type_depense']=='') $s_type_depense = ''; else $s_type_depense= addslashes($_REQUEST['type_depense']);
if ($_REQUEST['tiers']=='') $s_tiers = ''; else $s_tiers= addslashes($_REQUEST['tiers']);
if ($_REQUEST['projet']=='') $s_projet = ''; else $s_projet= addslashes($_REQUEST['projet']);
if ($_REQUEST['heure_creation']=='') $s_heure_creation = ''; else $s_heure_creation= addslashes($_REQUEST['heure_creation']);
if ($_REQUEST['pays']=='') $s_pays = ''; else $s_pays= addslashes($_REQUEST['pays']);
if ($_REQUEST['action']=='') $s_action = ''; else $s_action= addslashes($_REQUEST['action']);
if ($_REQUEST['taux_tva']=='') $s_taux_tva = ''; else $s_taux_tva= addslashes($_REQUEST['taux_tva']);
if ($_REQUEST['date_modification']=='') $s_date_modification = '0000-00-00'; else $s_date_modification= substr($_REQUEST['date_modification'],-4)."-".substr($_REQUEST['date_modification'],-7,2)."-".substr($_REQUEST['date_modification'],-10,2);
if ($_REQUEST['modification_par']=='') $s_modification_par = ''; else $s_modification_par= addslashes($_REQUEST['modification_par']);
if ($_REQUEST['heure_modification']=='') $s_heure_modification = ''; else $s_heure_modification= addslashes($_REQUEST['heure_modification']);
if ($_REQUEST['num_comptable']=='') $s_num_comptable = ''; else $s_num_comptable= addslashes($_REQUEST['num_comptable']);
if ($_REQUEST['montant_reglement_ttc']=='') $s_montant_reglement_ttc = '0'; else $s_montant_reglement_ttc= addslashes($_REQUEST['montant_reglement_ttc']);
if ($_REQUEST['annee']=='') $s_annee = ''; else $s_annee= addslashes($_REQUEST['annee']);
if ($_REQUEST['date_reglement']=='') $s_date_reglement = '0000-00-00'; else $s_date_reglement= substr($_REQUEST['date_reglement'],-4)."-".substr($_REQUEST['date_reglement'],-7,2)."-".substr($_REQUEST['date_reglement'],-10,2);
if ($_REQUEST['montant_ht_196']=='') $s_montant_ht_196 = '0'; else $s_montant_ht_196= addslashes($_REQUEST['montant_ht_196']);
if ($_REQUEST['montant_tva_196']=='') $s_montant_tva_196 = '0'; else $s_montant_tva_196= addslashes($_REQUEST['montant_tva_196']);
if ($_REQUEST['pj']=='') $s_pj = ''; else $s_pj= addslashes($_REQUEST['pj']);
if ($_REQUEST['statut']=='') $s_statut = ''; else $s_statut= addslashes($_REQUEST['statut']);
if ($_REQUEST['montant_ht_55']=='') $s_montant_ht_55 = '0'; else $s_montant_ht_55= addslashes($_REQUEST['montant_ht_55']);
if ($_REQUEST['montant_tva_55']=='') $s_montant_tva_55 = '0'; else $s_montant_tva_55= addslashes($_REQUEST['montant_tva_55']);
if ($_REQUEST['total_ht']=='') $s_total_ht = '0'; else $s_total_ht= addslashes($_REQUEST['total_ht']);
if ($_REQUEST['montant_na_tva']=='') $s_montant_na_tva = '0'; else $s_montant_na_tva= addslashes($_REQUEST['montant_na_tva']);
if ($_REQUEST['reglements']=='') $s_reglements = ''; else $s_reglements= addslashes($_REQUEST['reglements']);
if ($_REQUEST['montant_ht']=='') $s_montant_ht = '0'; else $s_montant_ht= addslashes($_REQUEST['montant_ht']);
if ($_REQUEST['montant_tva']=='') $s_montant_tva = '0'; else $s_montant_tva= addslashes($_REQUEST['montant_tva']);
if ($_REQUEST['beneficiaires']=='') $s_beneficiaires = ''; else $s_beneficiaires= addslashes($_REQUEST['beneficiaires']);
if ($_REQUEST['montant_ttc']=='') $s_montant_ttc = '0'; else $s_montant_ttc= addslashes($_REQUEST['montant_ttc']);
if ($_REQUEST['rib']=='') $s_rib = ''; else $s_rib= addslashes($_REQUEST['rib']);
if ($_REQUEST['depenses']=='') $s_depenses = ''; else $s_depenses= addslashes($_REQUEST['depenses']);
if ($_REQUEST['montant_restant_du']=='') $s_montant_restant_du = '0'; else $s_montant_restant_du= addslashes($_REQUEST['montant_restant_du']);
if ($_REQUEST['regle_le']=='') $s_regle_le = '0000-00-00'; else $s_regle_le= substr($_REQUEST['regle_le'],-4)."-".substr($_REQUEST['regle_le'],-7,2)."-".substr($_REQUEST['regle_le'],-10,2);
if ($_REQUEST['validation']=='') $s_validation = ''; else $s_validation= addslashes($_REQUEST['validation']);
if ($_REQUEST['num_cheque']=='') $s_num_cheque = ''; else $s_num_cheque= addslashes($_REQUEST['num_cheque']);
if ($_REQUEST['montant_ht_7']=='') $s_montant_ht_7 = '0'; else $s_montant_ht_7= addslashes($_REQUEST['montant_ht_7']);
if ($_REQUEST['montant_tva_7']=='') $s_montant_tva_7 = '0'; else $s_montant_tva_7= addslashes($_REQUEST['montant_tva_7']);
if ($_REQUEST['total_reglement']=='') $s_total_reglement = '0'; else $s_total_reglement= addslashes($_REQUEST['total_reglement']);
if ($_REQUEST['compte_charge']=='') $s_compte_charge = '0'; else $s_compte_charge= addslashes($_REQUEST['compte_charge']);
if ($_REQUEST['compte_charge_pas_tva']=='') $s_compte_charge_pas_tva = '0'; else $s_compte_charge_pas_tva= addslashes($_REQUEST['compte_charge_pas_tva']);
if ($_REQUEST['compte_tva']=='') $s_compte_tva = '0'; else $s_compte_tva= addslashes($_REQUEST['compte_tva']);
if ($_REQUEST['compte_tier']=='') $s_compte_tier = '0'; else $s_compte_tier= addslashes($_REQUEST['compte_tier']);
if ($_REQUEST['nouveau']=='') $s_nouveau = '0'; else $s_nouveau= addslashes($_REQUEST['nouveau']);
if ($_REQUEST['statut_compta']=='') $s_statut_compta = ''; else $s_statut_compta= addslashes($_REQUEST['statut_compta']);
if ($_REQUEST['statut_compta_banque']=='') $s_statut_compta_banque = ''; else $s_statut_compta_banque= addslashes($_REQUEST['statut_compta_banque']);
if ($_REQUEST['statut_compta_banque_od']=='') $s_statut_compta_banque_od = ''; else $s_statut_compta_banque_od= addslashes($_REQUEST['statut_compta_banque_od']);
if ($_REQUEST['banque']=='') $s_banque = ''; else $s_banque= addslashes($_REQUEST['banque']);
if ($_REQUEST['pointe']=='') $s_pointe = ''; else $s_pointe= addslashes($_REQUEST['pointe']);

// Requete
$query = "INSERT INTO depenses_annexes (utilisateur, 
cle, 
date, 
libelle, 
objet, 
date_creation, 
creation_par, 
type_depense, 
tiers, 
projet, 
heure_creation, 
pays, 
action, 
taux_tva, 
date_modification, 
modification_par, 
heure_modification, 
num_comptable, 
montant_reglement_ttc, 
annee, 
date_reglement, 
montant_ht_196, 
montant_tva_196, 
pj, 
statut, 
montant_ht_55, 
montant_tva_55, 
montant_ht_7, 
montant_tva_7, 
total_ht, 
montant_na_tva, 
reglements, 
montant_ht, 
montant_tva, 
beneficiaires, 
montant_ttc, 
rib, 
depenses, 
montant_restant_du, 
regle_le, 
validation, 
num_cheque, 
total_reglement,
compte_charge,
compte_charge_pas_tva,
compte_tva,
compte_tier,
nouveau, 
statut_compta,
statut_compta_banque,
statut_compta_banque_od,
banque,
pointe) values('".$s_utilisateur."', 
'".$s_cle."', 
'".$s_date."', 
'".$s_libelle."', 
'".$s_objet."', 
'".$s_date_creation."', 
'".$s_creation_par."', 
'".$s_type_depense."', 
'".$s_tiers."', 
'".$s_projet."', 
'".$s_heure_creation."', 
'".$s_pays."', 
'".$s_action."', 
'".$s_taux_tva."', 
'".$s_date_modification."', 
'".$s_modification_par."', 
'".$s_heure_modification."', 
'".$s_num_comptable."', 
'".$s_montant_reglement_ttc."', 
'".$s_annee."', 
'".$s_date_reglement."', 
'".$s_montant_ht_196."', 
'".$s_montant_tva_196."', 
'".$s_pj."', 
'".$s_statut."', 
'".$s_montant_ht_55."', 
'".$s_montant_tva_55."', 
'".$s_montant_ht_7."', 
'".$s_montant_tva_7."', 
'".$s_total_ht."', 
'".$s_montant_na_tva."', 
'".$s_reglements."', 
'".$s_montant_ht."', 
'".$s_montant_tva."', 
'".$s_beneficiaires."', 
'".$s_montant_ttc."', 
'".$s_rib."', 
'".$s_depenses."', 
'".$s_montant_restant_du."', 
'".$s_regle_le."', 
'".$s_validation."', 
'".$s_num_cheque."',
'".$s_total_reglement."',
'".$s_compte_charge."',
'".$s_compte_charge_pas_tva."',
'".$s_compte_tva."',
'".$s_compte_tier."',
'".$s_nouveau."',
'".$s_statut_compta."',
'".$s_statut_compta_banque."', 
'".$s_statut_compta_banque_od."', 
'".$s_banque."',
'".$s_pointe."')";

$result = mysql_query( $query );
// echo $query;
?>

