<?php


//Connexion ˆ la base de donnees
include 'cnx.php';

if ($_REQUEST['cle']=='') $s_cle = ''; else $s_cle= addslashes($_REQUEST['cle']);
if ($_REQUEST['date_creation']=='') $s_date_creation = '0000-00-00'; else $s_date_creation= substr($_REQUEST['date_creation'],-4)."-".substr($_REQUEST['date_creation'],-7,2)."-".substr($_REQUEST['date_creation'],-10,2);
if ($_REQUEST['montant_ht']=='') $s_montant_ht = '0'; else $s_montant_ht= addslashes($_REQUEST['montant_ht']);
if ($_REQUEST['clt_reference']=='') $s_clt_reference = ''; else $s_clt_reference= addslashes($_REQUEST['clt_reference']);
if ($_REQUEST['creation_par']=='') $s_creation_par = ''; else $s_creation_par= addslashes($_REQUEST['creation_par']);
if ($_REQUEST['objet']=='') $s_objet = ''; else $s_objet= addslashes($_REQUEST['objet']);
if ($_REQUEST['acc_ref']=='') $s_acc_ref = ''; else $s_acc_ref= addslashes($_REQUEST['acc_ref']);
if ($_REQUEST['societe']=='') $s_societe = ''; else $s_societe= addslashes($_REQUEST['societe']);
if ($_REQUEST['acompte1']=='') $s_acompte1 = '0'; else $s_acompte1= addslashes($_REQUEST['acompte1']);
if ($_REQUEST['montant_tva']=='') $s_montant_tva = '0'; else $s_montant_tva= addslashes($_REQUEST['montant_tva']);
if ($_REQUEST['heure_creation']=='') $s_heure_creation = ''; else $s_heure_creation= addslashes($_REQUEST['heure_creation']);
if ($_REQUEST['type']=='') $s_type = ''; else $s_type= addslashes($_REQUEST['type']);
if ($_REQUEST['acc_civilite']=='') $s_acc_civilite = ''; else $s_acc_civilite= addslashes($_REQUEST['acc_civilite']);
if ($_REQUEST['acc_nb_personne']=='') $s_acc_nb_personne = ''; else $s_acc_nb_personne= addslashes($_REQUEST['acc_nb_personne']);
if ($_REQUEST['projet']=='') $s_projet = ''; else $s_projet= addslashes($_REQUEST['projet']);
if ($_REQUEST['date1']=='') $s_date1 = '0000-00-00'; else $s_date1= substr($_REQUEST['date1'],-4)."-".substr($_REQUEST['date1'],-7,2)."-".substr($_REQUEST['date1'],-10,2);
if ($_REQUEST['date_modification']=='') $s_date_modification = '0000-00-00'; else $s_date_modification= substr($_REQUEST['date_modification'],-4)."-".substr($_REQUEST['date_modification'],-7,2)."-".substr($_REQUEST['date_modification'],-10,2);
if ($_REQUEST['acc_date_depart']=='') $s_acc_date_depart = '0000-00-00'; else $s_acc_date_depart= substr($_REQUEST['acc_date_depart'],-4)."-".substr($_REQUEST['acc_date_depart'],-7,2)."-".substr($_REQUEST['acc_date_depart'],-10,2);
if ($_REQUEST['montant_ttc']=='') $s_montant_ttc = '0'; else $s_montant_ttc= addslashes($_REQUEST['montant_ttc']);
if ($_REQUEST['acc_nom']=='') $s_acc_nom = ''; else $s_acc_nom= addslashes($_REQUEST['acc_nom']);
if ($_REQUEST['modification_par']=='') $s_modification_par = ''; else $s_modification_par= addslashes($_REQUEST['modification_par']);
if ($_REQUEST['pays_projet']=='') $s_pays_projet = ''; else $s_pays_projet= addslashes($_REQUEST['pays_projet']);
if ($_REQUEST['contact']=='') $s_contact = ''; else $s_contact= addslashes($_REQUEST['contact']);
if ($_REQUEST['acc_date_retour']=='') $s_acc_date_retour = '0000-00-00'; else $s_acc_date_retour= substr($_REQUEST['acc_date_retour'],-4)."-".substr($_REQUEST['acc_date_retour'],-7,2)."-".substr($_REQUEST['acc_date_retour'],-10,2);
if ($_REQUEST['pj1']=='') $s_pj1 = ''; else $s_pj1= addslashes($_REQUEST['pj1']);
if ($_REQUEST['acc_facturation_adresse1']=='') $s_acc_facturation_adresse1 = ''; else $s_acc_facturation_adresse1= addslashes($_REQUEST['acc_facturation_adresse1']);
if ($_REQUEST['cas']=='') $s_cas = ''; else $s_cas= addslashes($_REQUEST['cas']);
if ($_REQUEST['heure_modification']=='') $s_heure_modification = ''; else $s_heure_modification= addslashes($_REQUEST['heure_modification']);
if ($_REQUEST['facturation_adresse1']=='') $s_facturation_adresse1 = ''; else $s_facturation_adresse1= addslashes($_REQUEST['facturation_adresse1']);
if ($_REQUEST['operation']=='') $s_operation = ''; else $s_operation= addslashes($_REQUEST['operation']);
if ($_REQUEST['utilisateur']=='') $s_utilisateur = ''; else $s_utilisateur= addslashes($_REQUEST['utilisateur']);
if ($_REQUEST['facturation_adresse2']=='') $s_facturation_adresse2 = ''; else $s_facturation_adresse2= addslashes($_REQUEST['facturation_adresse2']);
if ($_REQUEST['note']=='') $s_note = ''; else $s_note= addslashes($_REQUEST['note']);
if ($_REQUEST['annee']=='') $s_annee = ''; else $s_annee= addslashes($_REQUEST['annee']);
if ($_REQUEST['facturation_cp']=='') $s_facturation_cp = ''; else $s_facturation_cp= addslashes($_REQUEST['facturation_cp']);
if ($_REQUEST['acc_facturation_cp']=='') $s_acc_facturation_cp = ''; else $s_acc_facturation_cp= addslashes($_REQUEST['acc_facturation_cp']);
if ($_REQUEST['acc_note']=='') $s_acc_note = ''; else $s_acc_note= addslashes($_REQUEST['acc_note']);
if ($_REQUEST['date_facture']=='') $s_date_facture = '0000-00-00'; else $s_date_facture= substr($_REQUEST['date_facture'],-4)."-".substr($_REQUEST['date_facture'],-7,2)."-".substr($_REQUEST['date_facture'],-10,2);
if ($_REQUEST['acompte2']=='') $s_acompte2 = '0'; else $s_acompte2= addslashes($_REQUEST['acompte2']);
if ($_REQUEST['facturation_ville']=='') $s_facturation_ville = ''; else $s_facturation_ville= addslashes($_REQUEST['facturation_ville']);
if ($_REQUEST['acc_facturation_ville']=='') $s_acc_facturation_ville = ''; else $s_acc_facturation_ville= addslashes($_REQUEST['acc_facturation_ville']);
if ($_REQUEST['date2']=='') $s_date2 = '0000-00-00'; else $s_date2= substr($_REQUEST['date2'],-4)."-".substr($_REQUEST['date2'],-7,2)."-".substr($_REQUEST['date2'],-10,2);
if ($_REQUEST['numero']=='') $s_numero = ''; else $s_numero= addslashes($_REQUEST['numero']);
if ($_REQUEST['pays']=='') $s_pays = ''; else $s_pays= addslashes($_REQUEST['pays']);
if ($_REQUEST['acc_hop']=='') $s_acc_hop = ''; else $s_acc_hop= addslashes($_REQUEST['acc_hop']);
if ($_REQUEST['pj2']=='') $s_pj2 = ''; else $s_pj2= addslashes($_REQUEST['pj2']);
if ($_REQUEST['libelle']=='') $s_libelle = ''; else $s_libelle= addslashes($_REQUEST['libelle']);
if ($_REQUEST['acc_service_hop']=='') $s_acc_service_hop = ''; else $s_acc_service_hop= addslashes($_REQUEST['acc_service_hop']);
if ($_REQUEST['acompte3']=='') $s_acompte3 = '0'; else $s_acompte3= addslashes($_REQUEST['acompte3']);
if ($_REQUEST['date3']=='') $s_date3 = '0000-00-00'; else $s_date3= substr($_REQUEST['date3'],-4)."-".substr($_REQUEST['date3'],-7,2)."-".substr($_REQUEST['date3'],-10,2);
if ($_REQUEST['pj3']=='') $s_pj3 = ''; else $s_pj3= addslashes($_REQUEST['pj3']);
if ($_REQUEST['acompte_total']=='') $s_acompte_total = '0'; else $s_acompte_total= addslashes($_REQUEST['acompte_total']);
if ($_REQUEST['montant_restant']=='') $s_montant_restant = '0'; else $s_montant_restant= addslashes($_REQUEST['montant_restant']);
if ($_REQUEST['reglee']=='') $s_reglee = ''; else $s_reglee= addslashes($_REQUEST['reglee']);
if ($_REQUEST['statut']=='') $s_statut = ''; else $s_statut= addslashes($_REQUEST['statut']);
if ($_REQUEST['delai_paiement']=='') $s_delai_paiement = ''; else $s_delai_paiement= addslashes($_REQUEST['delai_paiement']);
if ($_REQUEST['pj']=='') $s_pj = ''; else $s_pj= addslashes($_REQUEST['pj']);
if ($_REQUEST['montant_total_paiement_ttc']=='') $s_montant_total_paiement_ttc = '0'; else $s_montant_total_paiement_ttc= addslashes($_REQUEST['montant_total_paiement_ttc']);
if ($_REQUEST['tva']=='') $s_tva = ''; else $s_tva= addslashes($_REQUEST['tva']);
if ($_REQUEST['acompte_regle']=='') $s_acompte_regle = '0'; else $s_acompte_regle= addslashes($_REQUEST['acompte_regle']);
if ($_REQUEST['pourcentage1']=='') $s_pourcentage1 = ''; else $s_pourcentage1= addslashes($_REQUEST['pourcentage1']);
if ($_REQUEST['acompte_clt_1']=='') $s_acompte_clt_1 = '0'; else $s_acompte_clt_1= addslashes($_REQUEST['acompte_clt_1']);
if ($_REQUEST['acompte_date1']=='') $s_acompte_date1 = '0000-00-00'; else $s_acompte_date1= substr($_REQUEST['acompte_date1'],-4)."-".substr($_REQUEST['acompte_date1'],-7,2)."-".substr($_REQUEST['acompte_date1'],-10,2);
if ($_REQUEST['pourcentage2']=='') $s_pourcentage2 = ''; else $s_pourcentage2= addslashes($_REQUEST['pourcentage2']);
if ($_REQUEST['acompte_clt_2']=='') $s_acompte_clt_2 = '0'; else $s_acompte_clt_2= addslashes($_REQUEST['acompte_clt_2']);
if ($_REQUEST['acompte_date2']=='') $s_acompte_date2 = '0000-00-00'; else $s_acompte_date2= substr($_REQUEST['acompte_date2'],-4)."-".substr($_REQUEST['acompte_date2'],-7,2)."-".substr($_REQUEST['acompte_date2'],-10,2);
if ($_REQUEST['statut_compta']=='') $s_statut_compta = ''; else $s_statut_compta= addslashes($_REQUEST['statut_compta']);
if ($_REQUEST['statut_compta_paiement']=='') $s_statut_compta_paiement = '0'; else $s_statut_compta_paiement= addslashes($_REQUEST['statut_compta_paiement']);
if ($_REQUEST['banque']=='') $s_banque = ''; else $s_banque= addslashes($_REQUEST['banque']);
if ($_REQUEST['compte_produit']=='') $s_compte_produit = ''; else $s_compte_produit= addslashes($_REQUEST['compte_produit']);
if ($_REQUEST['compte_tva']=='') $s_compte_tva = ''; else $s_compte_tva= addslashes($_REQUEST['compte_tva']);
if ($_REQUEST['nouveau']=='') $s_nouveau = ''; else $s_nouveau= addslashes($_REQUEST['nouveau']);
if ($_REQUEST['statut_compta_paiement2']=='') $s_statut_compta_paiement2 = '0'; else $s_statut_compta_paiement2= addslashes($_REQUEST['statut_compta_paiement2']);
if ($_REQUEST['statut_compta_paiement3']=='') $s_statut_compta_paiement3 = '0'; else $s_statut_compta_paiement3= addslashes($_REQUEST['statut_compta_paiement3']);

// Requete
$query = "INSERT INTO facture_client (cle, 
date_creation, 
montant_ht, 
clt_reference, 
creation_par, 
objet, 
acc_ref, 
societe, 
acompte1, 
montant_tva, 
heure_creation, 
type, 
acc_civilite, 
acc_nb_personne, 
projet, 
date1, 
date_modification, 
acc_date_depart, 
montant_ttc, 
acc_nom, 
modification_par, 
pays_projet, 
contact, 
acc_date_retour, 
pj1, 
acc_facturation_adresse1, 
cas, 
heure_modification, 
facturation_adresse1, 
operation, 
utilisateur, 
facturation_adresse2, 
note, 
annee, 
facturation_cp, 
acc_facturation_cp, 
acc_note, 
date_facture, 
acompte2, 
facturation_ville, 
acc_facturation_ville, 
date2, 
numero, 
pays, 
acc_hop, 
pj2, 
libelle, 
acc_service_hop, 
acompte3, 
date3, 
pj3, 
acompte_total, 
montant_restant, 
reglee, 
statut, 
delai_paiement, 
pj, 
montant_total_paiement_ttc, 
tva, 
acompte_regle, 
pourcentage1, 
acompte_clt_1, 
acompte_date1, 
pourcentage2, 
acompte_clt_2, 
acompte_date2,
statut_compta,
statut_compta_paiement,
banque,
compte_produit,
compte_tva,
nouveau,
statut_compta_paiement2,
statut_compta_paiement3) values('".$s_cle."', 
'".$s_date_creation."', 
'".$s_montant_ht."', 
'".$s_clt_reference."', 
'".$s_creation_par."', 
'".$s_objet."', 
'".$s_acc_ref."', 
'".$s_societe."', 
'".$s_acompte1."', 
'".$s_montant_tva."', 
'".$s_heure_creation."', 
'".$s_type."', 
'".$s_acc_civilite."', 
'".$s_acc_nb_personne."', 
'".$s_projet."', 
'".$s_date1."', 
'".$s_date_modification."', 
'".$s_acc_date_depart."', 
'".$s_montant_ttc."', 
'".$s_acc_nom."', 
'".$s_modification_par."', 
'".$s_pays_projet."',  
'".$s_contact."', 
'".$s_acc_date_retour."', 
'".$s_pj1."', 
'".$s_acc_facturation_adresse1."', 
'".$s_cas."', 
'".$s_heure_modification."', 
'".$s_facturation_adresse1."', 
'".$s_operation."', 
'".$s_utilisateur."', 
'".$s_facturation_adresse2."', 
'".$s_note."', 
'".$s_annee."', 
'".$s_facturation_cp."', 
'".$s_acc_facturation_cp."', 
'".$s_acc_note."', 
'".$s_date_facture."', 
'".$s_acompte2."', 
'".$s_facturation_ville."', 
'".$s_acc_facturation_ville."', 
'".$s_date2."', 
'".$s_numero."', 
'".$s_pays."', 
'".$s_acc_hop."', 
'".$s_pj2."', 
'".$s_libelle."', 
'".$s_acc_service_hop."', 
'".$s_acompte3."', 
'".$s_date3."', 
'".$s_pj3."', 
'".$s_acompte_total."', 
'".$s_montant_restant."', 
'".$s_reglee."', 
'".$s_statut."', 
'".$s_delai_paiement."', 
'".$s_pj."', 
'".$s_montant_total_paiement_ttc."', 
'".$s_tva."', 
'".$s_acompte_regle."', 
'".$s_pourcentage1."', 
'".$s_acompte_clt_1."', 
'".$s_acompte_date1."', 
'".$s_pourcentage2."', 
'".$s_acompte_clt_2."', 
'".$s_acompte_date2."',
'".$s_statut_compta."',
'".$s_statut_compta_paiement."',
'".$s_banque."',
'".$s_compte_produit."',
'".$s_compte_tva."',
'".$s_nouveau."',
'".$s_statut_compta_paiement2."',
'".$s_statut_compta_paiement3."'
)";
$result = mysql_query( $query );
echo $query;
?>

