<?php


//Connexion ˆ la base de donnees
include 'cnx.php';

if ($_REQUEST['cle']=='') $s_cle = ''; else $s_cle= addslashes($_REQUEST['cle']);
if ($_REQUEST['facture_client']=='') $s_facture_client = ''; else $s_facture_client= addslashes($_REQUEST['facture_client']);
if ($_REQUEST['date_creation']=='') $s_date_creation = '0000-00-00'; else $s_date_creation= substr($_REQUEST['date_creation'],-4)."-".substr($_REQUEST['date_creation'],-7,2)."-".substr($_REQUEST['date_creation'],-10,2);
if ($_REQUEST['creation_par']=='') $s_creation_par = ''; else $s_creation_par= addslashes($_REQUEST['creation_par']);
if ($_REQUEST['heure_creation']=='') $s_heure_creation = ''; else $s_heure_creation= addslashes($_REQUEST['heure_creation']);
if ($_REQUEST['taux_tva']=='') $s_taux_tva = ''; else $s_taux_tva= addslashes($_REQUEST['taux_tva']);
if ($_REQUEST['designation']=='') $s_designation = ''; else $s_designation= addslashes($_REQUEST['designation']);
if ($_REQUEST['date_modification']=='') $s_date_modification = '0000-00-00'; else $s_date_modification= substr($_REQUEST['date_modification'],-4)."-".substr($_REQUEST['date_modification'],-7,2)."-".substr($_REQUEST['date_modification'],-10,2);
if ($_REQUEST['modification_par']=='') $s_modification_par = ''; else $s_modification_par= addslashes($_REQUEST['modification_par']);
if ($_REQUEST['qte']=='') $s_qte = '0'; else $s_qte= addslashes($_REQUEST['qte']);
if ($_REQUEST['heure_modification']=='') $s_heure_modification = ''; else $s_heure_modification= addslashes($_REQUEST['heure_modification']);
if ($_REQUEST['puht']=='') $s_puht = '0'; else $s_puht= addslashes($_REQUEST['puht']);
if ($_REQUEST['annee']=='') $s_annee = ''; else $s_annee= addslashes($_REQUEST['annee']);
if ($_REQUEST['cas']=='') $s_cas = ''; else $s_cas= addslashes($_REQUEST['cas']);
if ($_REQUEST['puttc']=='') $s_puttc = '0'; else $s_puttc= addslashes($_REQUEST['puttc']);
if ($_REQUEST['total_montant_ht']=='') $s_total_montant_ht = '0'; else $s_total_montant_ht= addslashes($_REQUEST['total_montant_ht']);
if ($_REQUEST['total_montant_ttc']=='') $s_total_montant_ttc = '0'; else $s_total_montant_ttc= addslashes($_REQUEST['total_montant_ttc']);
if ($_REQUEST['objet_parent']=='') $s_objet_parent = ''; else $s_objet_parent= addslashes($_REQUEST['objet_parent']);
if ($_REQUEST['type']=='') $s_type = ''; else $s_type= addslashes($_REQUEST['type']);


// Requete
$query = "INSERT INTO facture_client_ligne (cle, 
facture_client, 
date_creation, 
creation_par, 
heure_creation, 
taux_tva,
designation, 
date_modification, 
modification_par, 
qte, 
heure_modification, 
puht, 
annee, 
cas, 
puttc, 
total_montant_ht, 
total_montant_ttc, 
objet_parent,
type) values('".$s_cle."', 
'".$s_facture_client."', 
'".$s_date_creation."', 
'".$s_creation_par."', 
'".$s_heure_creation."', 
'".$s_taux_tva."', 
'".$s_designation."', 
'".$s_date_modification."', 
'".$s_modification_par."', 
'".$s_qte."', 
'".$s_heure_modification."', 
'".$s_puht."', 
'".$s_annee."', 
'".$s_cas."', 
'".$s_puttc."', 
'".$s_total_montant_ht."', 
'".$s_total_montant_ttc."', 
'".$s_objet_parent."',
'".$s_type."')";
$result = mysql_query( $query );
// echo $query;
?>

