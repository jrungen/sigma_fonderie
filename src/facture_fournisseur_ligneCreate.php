<?php


//Connexion ˆ la base de donnees
include 'cnx.php';

if ($_REQUEST['facture_fournisseur']=='') $s_facture_fournisseur = ''; else $s_facture_fournisseur= addslashes($_REQUEST['facture_fournisseur']);
if ($_REQUEST['cle']=='') $s_cle = ''; else $s_cle= addslashes($_REQUEST['cle']);
if ($_REQUEST['type_depenses']=='') $s_type_depenses = ''; else $s_type_depenses= addslashes($_REQUEST['type_depenses']);
if ($_REQUEST['acompte_reglement']=='') $s_acompte_reglement = '0'; else $s_acompte_reglement= addslashes($_REQUEST['acompte_reglement']);
if ($_REQUEST['acompte_reglement_ht']=='') $s_acompte_reglement_ht = '0'; else $s_acompte_reglement_ht= addslashes($_REQUEST['acompte_reglement_ht']);
if ($_REQUEST['date_creation']=='') $s_date_creation = '0000-00-00'; else $s_date_creation= substr($_REQUEST['date_creation'],-4)."-".substr($_REQUEST['date_creation'],-7,2)."-".substr($_REQUEST['date_creation'],-10,2);
if ($_REQUEST['creation_par']=='') $s_creation_par = ''; else $s_creation_par= addslashes($_REQUEST['creation_par']);
if ($_REQUEST['designation']=='') $s_designation = ''; else $s_designation= addslashes($_REQUEST['designation']);
if ($_REQUEST['date_reglement']=='') $s_date_reglement = '0000-00-00'; else $s_date_reglement= substr($_REQUEST['date_reglement'],-4)."-".substr($_REQUEST['date_reglement'],-7,2)."-".substr($_REQUEST['date_reglement'],-10,2);
if ($_REQUEST['heure_creation']=='') $s_heure_creation = ''; else $s_heure_creation= addslashes($_REQUEST['heure_creation']);
if ($_REQUEST['pj_reglement']=='') $s_pj_reglement = ''; else $s_pj_reglement= addslashes($_REQUEST['pj_reglement']);
if ($_REQUEST['date_modification']=='') $s_date_modification = '0000-00-00'; else $s_date_modification= substr($_REQUEST['date_modification'],-4)."-".substr($_REQUEST['date_modification'],-7,2)."-".substr($_REQUEST['date_modification'],-10,2);
if ($_REQUEST['modification_par']=='') $s_modification_par = ''; else $s_modification_par= addslashes($_REQUEST['modification_par']);
if ($_REQUEST['devise']=='') $s_devise = ''; else $s_devise= addslashes($_REQUEST['devise']);
if ($_REQUEST['cas']=='') $s_cas = ''; else $s_cas= addslashes($_REQUEST['cas']);
if ($_REQUEST['type_reglement']=='') $s_type_reglement = ''; else $s_type_reglement= addslashes($_REQUEST['type_reglement']);
if ($_REQUEST['heure_modification']=='') $s_heure_modification = ''; else $s_heure_modification= addslashes($_REQUEST['heure_modification']);
if ($_REQUEST['autre_devise']=='') $s_autre_devise = ''; else $s_autre_devise= addslashes($_REQUEST['autre_devise']);
if ($_REQUEST['annee']=='') $s_annee = ''; else $s_annee= addslashes($_REQUEST['annee']);
if ($_REQUEST['montant_devise']=='') $s_montant_devise = '0'; else $s_montant_devise= addslashes($_REQUEST['montant_devise']);
if ($_REQUEST['autres']=='') $s_autres = ''; else $s_autres= addslashes($_REQUEST['autres']);
if ($_REQUEST['note']=='') $s_note = ''; else $s_note= addslashes($_REQUEST['note']);
if ($_REQUEST['beneficiaire']=='') $s_beneficiaire = ''; else $s_beneficiaire= addslashes($_REQUEST['beneficiaire']);
if ($_REQUEST['nom_banque']=='') $s_nom_banque = ''; else $s_nom_banque= addslashes($_REQUEST['nom_banque']);
if ($_REQUEST['domiciliation']=='') $s_domiciliation = ''; else $s_domiciliation= addslashes($_REQUEST['domiciliation']);
if ($_REQUEST['acompte_paye']=='') $s_acompte_paye = '0'; else $s_acompte_paye= addslashes($_REQUEST['acompte_paye']);
if ($_REQUEST['code_banque']=='') $s_code_banque = ''; else $s_code_banque= addslashes($_REQUEST['code_banque']);
if ($_REQUEST['date_paye']=='') $s_date_paye = '0000-00-00'; else $s_date_paye= substr($_REQUEST['date_paye'],-4)."-".substr($_REQUEST['date_paye'],-7,2)."-".substr($_REQUEST['date_paye'],-10,2);
if ($_REQUEST['code_guichet']=='') $s_code_guichet = ''; else $s_code_guichet= addslashes($_REQUEST['code_guichet']);
if ($_REQUEST['pj_paye']=='') $s_pj_paye = ''; else $s_pj_paye= addslashes($_REQUEST['pj_paye']);
if ($_REQUEST['num_compte']=='') $s_num_compte = ''; else $s_num_compte= addslashes($_REQUEST['num_compte']);
if ($_REQUEST['num_cheque']=='') $s_num_cheque = ''; else $s_num_cheque= addslashes($_REQUEST['num_cheque']);
if ($_REQUEST['cle_banque']=='') $s_cle_banque = ''; else $s_cle_banque= addslashes($_REQUEST['cle_banque']);
if ($_REQUEST['iban']=='') $s_iban = ''; else $s_iban= addslashes($_REQUEST['iban']);
if ($_REQUEST['code_swift']=='') $s_code_swift = ''; else $s_code_swift= addslashes($_REQUEST['code_swift']);
if ($_REQUEST['statut']=='') $s_statut = ''; else $s_statut= addslashes($_REQUEST['statut']);
if ($_REQUEST['statut_compta']=='') $s_statut_compta = ''; else $s_statut_compta= addslashes($_REQUEST['statut_compta']);
if ($_REQUEST['banque']=='') $s_banque = ''; else $s_banque= addslashes($_REQUEST['banque']);

// Requete
$query = "INSERT INTO facture_fournisseur_ligne (facture_fournisseur, 
cle, 
type_depenses, 
acompte_reglement, 
acompte_reglement_ht, 
date_creation, 
creation_par, 
designation, 
date_reglement, 
heure_creation, 
pj_reglement, 
date_modification, 
modification_par, 
devise, 
cas, 
type_reglement, 
heure_modification, 
autre_devise, 
annee, 
montant_devise, 
autres, 
note, 
beneficiaire, 
nom_banque, 
domiciliation, 
acompte_paye, 
code_banque, 
date_paye, 
code_guichet, 
pj_paye, 
num_compte, 
num_cheque, 
cle_banque, 
iban, 
code_swift, 
statut,
statut_compta,
banque) values('".$s_facture_fournisseur."', 
'".$s_cle."', 
'".$s_type_depenses."', 
'".$s_acompte_reglement."', 
'".$s_acompte_reglement_ht."', 
'".$s_date_creation."', 
'".$s_creation_par."', 
'".$s_designation."', 
'".$s_date_reglement."', 
'".$s_heure_creation."', 
'".$s_pj_reglement."', 
'".$s_date_modification."', 
'".$s_modification_par."', 
'".$s_devise."', 
'".$s_cas."', 
'".$s_type_reglement."', 
'".$s_heure_modification."', 
'".$s_autre_devise."', 
'".$s_annee."', 
'".$s_montant_devise."', 
'".$s_autres."', 
'".$s_note."', 
'".$s_beneficiaire."', 
'".$s_nom_banque."', 
'".$s_domiciliation."', 
'".$s_acompte_paye."', 
'".$s_code_banque."', 
'".$s_date_paye."', 
'".$s_code_guichet."', 
'".$s_pj_paye."', 
'".$s_num_compte."', 
'".$s_num_cheque."', 
'".$s_cle_banque."', 
'".$s_iban."', 
'".$s_code_swift."', 
'".$s_statut."',
'".$s_statut_compta."',
'".$s_banque."')";
$result = mysql_query( $query );
echo $query;
?>

