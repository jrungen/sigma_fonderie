<?php

$search=" where idfacture_fournisseur = '".$_REQUEST['id']."'";

//Connexion ˆ la base de donnees
include 'cnx.php';

if ($_REQUEST['date_facture']=='') $s_date_facture = '0000-00-00'; else $s_date_facture= substr($_REQUEST['date_facture'],-4)."-".substr($_REQUEST['date_facture'],-7,2)."-".substr($_REQUEST['date_facture'],-10,2);
if ($_REQUEST['action']=='') $s_action = ''; else $s_action= addslashes($_REQUEST['action']);
if ($_REQUEST['cle']=='') $s_cle = ''; else $s_cle= addslashes($_REQUEST['cle']);
if ($_REQUEST['fourniseur']=='') $s_fourniseur = ''; else $s_fourniseur= addslashes($_REQUEST['fourniseur']);
if ($_REQUEST['date_creation']=='') $s_date_creation = '0000-00-00'; else $s_date_creation= substr($_REQUEST['date_creation'],-4)."-".substr($_REQUEST['date_creation'],-7,2)."-".substr($_REQUEST['date_creation'],-10,2);
if ($_REQUEST['objet']=='') $s_objet = ''; else $s_objet= addslashes($_REQUEST['objet']);
if ($_REQUEST['creation_par']=='') $s_creation_par = ''; else $s_creation_par= addslashes($_REQUEST['creation_par']);
if ($_REQUEST['projet']=='') $s_projet = ''; else $s_projet= addslashes($_REQUEST['projet']);
if ($_REQUEST['item']=='') $s_item = ''; else $s_item= addslashes($_REQUEST['item']);
if ($_REQUEST['heure_creation']=='') $s_heure_creation = ''; else $s_heure_creation= addslashes($_REQUEST['heure_creation']);
if ($_REQUEST['utilisateur']=='') $s_utilisateur = ''; else $s_utilisateur= addslashes($_REQUEST['utilisateur']);
if ($_REQUEST['date_modification']=='') $s_date_modification = '0000-00-00'; else $s_date_modification= substr($_REQUEST['date_modification'],-4)."-".substr($_REQUEST['date_modification'],-7,2)."-".substr($_REQUEST['date_modification'],-10,2);
if ($_REQUEST['type']=='') $s_type = ''; else $s_type= addslashes($_REQUEST['type']);
if ($_REQUEST['taux_tva']=='') $s_taux_tva = ''; else $s_taux_tva= addslashes($_REQUEST['taux_tva']);
if ($_REQUEST['cas']=='') $s_cas = ''; else $s_cas= addslashes($_REQUEST['cas']);
if ($_REQUEST['modification_par']=='') $s_modification_par = ''; else $s_modification_par= addslashes($_REQUEST['modification_par']);
if ($_REQUEST['heure_modification']=='') $s_heure_modification = ''; else $s_heure_modification= addslashes($_REQUEST['heure_modification']);
if ($_REQUEST['annee']=='') $s_annee = ''; else $s_annee= addslashes($_REQUEST['annee']);
if ($_REQUEST['societe']=='') $s_societe = ''; else $s_societe= addslashes($_REQUEST['societe']);
if ($_REQUEST['pays']=='') $s_pays = ''; else $s_pays= addslashes($_REQUEST['pays']);
if ($_REQUEST['montant_tva_19_6']=='') $s_montant_tva_19_6 = '0'; else $s_montant_tva_19_6= addslashes($_REQUEST['montant_tva_19_6']);
if ($_REQUEST['montant_ht_19_6']=='') $s_montant_ht_19_6 = '0'; else $s_montant_ht_19_6= addslashes($_REQUEST['montant_ht_19_6']);
if ($_REQUEST['taxe_pays']=='') $s_taxe_pays = '0'; else $s_taxe_pays= addslashes($_REQUEST['taxe_pays']);
if ($_REQUEST['taxe_pays_reduit']=='') $s_taxe_pays_reduit = '0'; else $s_taxe_pays_reduit= addslashes($_REQUEST['taxe_pays_reduit']);
if ($_REQUEST['montant_tva_55']=='') $s_montant_tva_55 = '0'; else $s_montant_tva_55= addslashes($_REQUEST['montant_tva_55']);
if ($_REQUEST['montant_ht_55']=='') $s_montant_ht_55 = '0'; else $s_montant_ht_55= addslashes($_REQUEST['montant_ht_55']);
if ($_REQUEST['montant_tva_7']=='') $s_montant_tva_7 = '0'; else $s_montant_tva_7= addslashes($_REQUEST['montant_tva_7']);
if ($_REQUEST['montant_ht_7']=='') $s_montant_ht_7 = '0'; else $s_montant_ht_7= addslashes($_REQUEST['montant_ht_7']);
if ($_REQUEST['montant_tva_locale']=='') $s_montant_tva_locale = '0'; else $s_montant_tva_locale= addslashes($_REQUEST['montant_tva_locale']);
if ($_REQUEST['montant_ht_locale']=='') $s_montant_ht_locale = '0'; else $s_montant_ht_locale= addslashes($_REQUEST['montant_ht_locale']);
if ($_REQUEST['montant_tva_locale_reduit']=='') $s_montant_tva_locale_reduit = '0'; else $s_montant_tva_locale_reduit= addslashes($_REQUEST['montant_tva_locale_reduit']);
if ($_REQUEST['montant_ht_locale_reduit']=='') $s_montant_ht_locale_reduit = '0'; else $s_montant_ht_locale_reduit= addslashes($_REQUEST['montant_ht_locale_reduit']);
if ($_REQUEST['numero']=='') $s_numero = ''; else $s_numero= addslashes($_REQUEST['numero']);
if ($_REQUEST['pj']=='') $s_pj = ''; else $s_pj= addslashes($_REQUEST['pj']);
if ($_REQUEST['montant_ht_0']=='') $s_montant_ht_0 = '0'; else $s_montant_ht_0= addslashes($_REQUEST['montant_ht_0']);
if ($_REQUEST['total_acompte']=='') $s_total_acompte = '0'; else $s_total_acompte= addslashes($_REQUEST['total_acompte']);
if ($_REQUEST['total_acompte_ht']=='') $s_total_acompte_ht = '0'; else $s_total_acompte_ht= addslashes($_REQUEST['total_acompte_ht']);
if ($_REQUEST['frais_port_ht']=='') $s_frais_port_ht = '0'; else $s_frais_port_ht= addslashes($_REQUEST['frais_port_ht']);
if ($_REQUEST['montant_restant_du']=='') $s_montant_restant_du = '0'; else $s_montant_restant_du= addslashes($_REQUEST['montant_restant_du']);
if ($_REQUEST['commission_ht']=='') $s_commission_ht = '0'; else $s_commission_ht= addslashes($_REQUEST['commission_ht']);
if ($_REQUEST['montant_ht']=='') $s_montant_ht = '0'; else $s_montant_ht= addslashes($_REQUEST['montant_ht']);
if ($_REQUEST['note']=='') $s_note = ''; else $s_note= addslashes($_REQUEST['note']);
if ($_REQUEST['tva_s_commission']=='') $s_tva_s_commission = '0'; else $s_tva_s_commission= addslashes($_REQUEST['tva_s_commission']);
if ($_REQUEST['montant_tva']=='') $s_montant_tva = '0'; else $s_montant_tva= addslashes($_REQUEST['montant_tva']);
if ($_REQUEST['tva_s_commission_55']=='') $s_tva_s_commission_55 = '0'; else $s_tva_s_commission_55= addslashes($_REQUEST['tva_s_commission_55']);
if ($_REQUEST['Remise']=='') $s_Remise = '0'; else $s_Remise= addslashes($_REQUEST['Remise']);
if ($_REQUEST['frais_port']=='') $s_frais_port = '0'; else $s_frais_port= addslashes($_REQUEST['frais_port']);
if ($_REQUEST['tva_s_commission_locale']=='') $s_tva_s_commission_locale = '0'; else $s_tva_s_commission_locale= addslashes($_REQUEST['tva_s_commission_locale']);
if ($_REQUEST['ttc_commission']=='') $s_ttc_commission = '0'; else $s_ttc_commission= addslashes($_REQUEST['ttc_commission']);
if ($_REQUEST['montant_ttc']=='') $s_montant_ttc = '0'; else $s_montant_ttc= addslashes($_REQUEST['montant_ttc']);
if ($_REQUEST['facture_regle']=='') $s_facture_regle = ''; else $s_facture_regle= addslashes($_REQUEST['facture_regle']);
if ($_REQUEST['total_regle']=='') $s_total_regle = '0'; else $s_total_regle= addslashes($_REQUEST['total_regle']);
if ($_REQUEST['montant_restant_du_facturation']=='') $s_montant_restant_du_facturation = '0'; else $s_montant_restant_du_facturation= addslashes($_REQUEST['montant_restant_du_facturation']);
if ($_REQUEST['validation']=='') $s_validation = ''; else $s_validation= addslashes($_REQUEST['validation']);
if ($_REQUEST['note_comptable']=='') $s_note_comptable = ''; else $s_note_comptable= addslashes($_REQUEST['note_comptable']);
if ($_REQUEST['statut_compta']=='') $s_statut_compta = ''; else $s_statut_compta= addslashes($_REQUEST['statut_compta']);
if ($_REQUEST['compte_charge']=='') $s_compte_charge = ''; else $s_compte_charge= addslashes($_REQUEST['compte_charge']);
if ($_REQUEST['compte_tva']=='') $s_compte_tva = ''; else $s_compte_tva= addslashes($_REQUEST['compte_tva']);
if ($_REQUEST['nouveau']=='') $s_nouveau = ''; else $s_nouveau= addslashes($_REQUEST['nouveau']);
if ($_REQUEST['pointe']=='') $s_pointe = ''; else $s_pointe= addslashes($_REQUEST['pointe']);


// Requête
$query = "UPDATE facture_fournisseur set date_facture='". $s_date_facture."',
action='". $s_action."',
cle='". $s_cle."',
fourniseur='". $s_fourniseur."',
date_creation='". $s_date_creation."',
objet='". $s_objet."',
creation_par='". $s_creation_par."',
projet='". $s_projet."',
item='". $s_item."',
heure_creation='". $s_heure_creation."',
utilisateur='". $s_utilisateur."',
date_modification='". $s_date_modification."',
type='". $s_type."',
taux_tva='". $s_taux_tva."',
cas='". $s_cas."',
modification_par='". $s_modification_par."',
heure_modification='". $s_heure_modification."',
annee='". $s_annee."',
societe='". $s_societe."',
pays='". $s_pays."',
montant_tva_19_6='". $s_montant_tva_19_6."',
montant_ht_19_6='". $s_montant_ht_19_6."',
taxe_pays='". $s_taxe_pays."',
taxe_pays_reduit='". $s_taxe_pays_reduit."',
montant_tva_55='". $s_montant_tva_55."',
montant_ht_55='". $s_montant_ht_55."',
montant_tva_7='". $s_montant_tva_7."',
montant_ht_7='". $s_montant_ht_7."',
montant_tva_locale='". $s_montant_tva_locale."',
montant_ht_locale='". $s_montant_ht_locale."',
montant_tva_locale_reduit='". $s_montant_tva_locale_reduit."',
montant_ht_locale_reduit='". $s_montant_ht_locale_reduit."',
numero='". $s_numero."',
pj='". $s_pj."',
montant_ht_0='". $s_montant_ht_0."',
total_acompte='". $s_total_acompte."',
total_acompte_ht='". $s_total_acompte_ht."',
frais_port_ht='". $s_frais_port_ht."',
montant_restant_du='". $s_montant_restant_du."',
commission_ht='". $s_commission_ht."',
montant_ht='". $s_montant_ht."',
note='". $s_note."',
tva_s_commission='". $s_tva_s_commission."',
montant_tva='". $s_montant_tva."',
tva_s_commission_55='". $s_tva_s_commission_55."',
Remise='". $s_Remise."',
frais_port='". $s_frais_port."',
tva_s_commission_locale='". $s_tva_s_commission_locale."',
ttc_commission='". $s_ttc_commission."',
montant_ttc='". $s_montant_ttc."',
facture_regle='". $s_facture_regle."',
total_regle='". $s_total_regle."',
montant_restant_du_facturation='". $s_montant_restant_du_facturation."',
validation='". $s_validation."',
note_comptable='". $s_note_comptable."',
statut_compta='". $s_statut_compta."',
compte_charge='". $s_compte_charge."',
compte_tva='". $s_compte_tva."',
nouveau='". $s_nouveau."',
pointe='". $s_pointe."' $search";
echo $query;

$result = mysql_query( $query );

?>



