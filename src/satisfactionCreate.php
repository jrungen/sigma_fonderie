<?php


//Connexion ˆ la base de donnees
include 'cnx.php';

// autoincremement

if ($_REQUEST['cle']=='') $s_cle = ''; else $s_cle= addslashes($_REQUEST['cle']);
if ($_REQUEST['creation_par']=='') $s_creation_par = ''; else $s_creation_par= addslashes($_REQUEST['creation_par']);
if ($_REQUEST['date_creation']=='') $s_date_creation = '0000-00-00'; else $s_date_creation= substr($_REQUEST['date_creation'],-4)."-".substr($_REQUEST['date_creation'],-7,2)."-".substr($_REQUEST['date_creation'],-10,2);
if ($_REQUEST['date_modification']=='') $s_date_modification = '0000-00-00'; else $s_date_modification= substr($_REQUEST['date_modification'],-4)."-".substr($_REQUEST['date_modification'],-7,2)."-".substr($_REQUEST['date_modification'],-10,2);
if ($_REQUEST['modification_par']=='') $s_modification_par = ''; else $s_modification_par= addslashes($_REQUEST['modification_par']);
if ($_REQUEST['heure_creation']=='') $s_heure_creation = ''; else $s_heure_creation= addslashes($_REQUEST['heure_creation']);
if ($_REQUEST['heure_modification']=='') $s_heure_modification = ''; else $s_heure_modification= addslashes($_REQUEST['heure_modification']);
if ($_REQUEST['annee']=='') $s_annee = ''; else $s_annee= addslashes($_REQUEST['annee']);
if ($_REQUEST['fournisseur']=='') $s_fournisseur = ''; else $s_fournisseur= addslashes($_REQUEST['fournisseur']);
if ($_REQUEST['projet']=='') $s_projet = ''; else $s_projet= addslashes($_REQUEST['projet']);
if ($_REQUEST['utilisateur']=='') $s_utilisateur = ''; else $s_utilisateur= addslashes($_REQUEST['utilisateur']);
if ($_REQUEST['ca_ht']=='') $s_ca_ht = '0'; else $s_ca_ht= addslashes($_REQUEST['ca_ht']);
if ($_REQUEST['eval_preparation']=='') $s_eval_preparation = ''; else $s_eval_preparation= addslashes($_REQUEST['eval_preparation']);
if ($_REQUEST['date_preparation']=='') $s_date_preparation = '0000-00-00'; else $s_date_preparation= substr($_REQUEST['date_preparation'],-4)."-".substr($_REQUEST['date_preparation'],-7,2)."-".substr($_REQUEST['date_preparation'],-10,2);
if ($_REQUEST['eval_realisation']=='') $s_eval_realisation = ''; else $s_eval_realisation= addslashes($_REQUEST['eval_realisation']);
if ($_REQUEST['liste_preparation']=='') $s_liste_preparation = ''; else $s_liste_preparation= addslashes($_REQUEST['liste_preparation']);
if ($_REQUEST['date_realisation']=='') $s_date_realisation = '0000-00-00'; else $s_date_realisation= substr($_REQUEST['date_realisation'],-4)."-".substr($_REQUEST['date_realisation'],-7,2)."-".substr($_REQUEST['date_realisation'],-10,2);
if ($_REQUEST['liste_realisation']=='') $s_liste_realisation = ''; else $s_liste_realisation= addslashes($_REQUEST['liste_realisation']);
if ($_REQUEST['note_preparation']=='') $s_note_preparation = ''; else $s_note_preparation= addslashes($_REQUEST['note_preparation']);
if ($_REQUEST['note_realisation']=='') $s_note_realisation = ''; else $s_note_realisation= addslashes($_REQUEST['note_realisation']);


// Requete
$query = "INSERT INTO satisfaction (cle, 
creation_par, 
date_creation, 
date_modification, 
modification_par, 
heure_creation, 
heure_modification, 
annee, 
fournisseur, 
projet, 
utilisateur, 
ca_ht, 
eval_preparation, 
date_preparation, 
eval_realisation, 
liste_preparation, 
date_realisation, 
liste_realisation, 
note_preparation, 
note_realisation) values('".$s_cle."', 
'".$s_creation_par."', 
'".$s_date_creation."', 
'".$s_date_modification."', 
'".$s_modification_par."', 
'".$s_heure_creation."', 
'".$s_heure_modification."', 
'".$s_annee."', 
'".$s_fournisseur."', 
'".$s_projet."', 
'".$s_utilisateur."', 
'".$s_ca_ht."', 
'".$s_eval_preparation."', 
'".$s_date_preparation."', 
'".$s_eval_realisation."', 
'".$s_liste_preparation."', 
'".$s_date_realisation."', 
'".$s_liste_realisation."', 
'".$s_note_preparation."', 
'".$s_note_realisation."')";
$result = mysql_query( $query );
echo $query;
?>

