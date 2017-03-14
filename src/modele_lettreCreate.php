<?php


//Connexion ˆ la base de donnees
include 'cnx.php';

// autoincremement

if ($_REQUEST['cle']=='') $s_cle = ''; else $s_cle= addslashes($_REQUEST['cle']);
if ($_REQUEST['intitule']=='') $s_intitule = ''; else $s_intitule= addslashes($_REQUEST['intitule']);
if ($_REQUEST['date_creation']=='') $s_date_creation = '0000-00-00'; else $s_date_creation= substr($_REQUEST['date_creation'],-4)."-".substr($_REQUEST['date_creation'],-7,2)."-".substr($_REQUEST['date_creation'],-10,2);
if ($_REQUEST['creation_par']=='') $s_creation_par = ''; else $s_creation_par= addslashes($_REQUEST['creation_par']);
if ($_REQUEST['categorie']=='') $s_categorie = ''; else $s_categorie= addslashes($_REQUEST['categorie']);
if ($_REQUEST['note']=='') $s_note = ''; else $s_note= addslashes($_REQUEST['note']);
if ($_REQUEST['date_modification']=='') $s_date_modification = '0000-00-00'; else $s_date_modification= substr($_REQUEST['date_modification'],-4)."-".substr($_REQUEST['date_modification'],-7,2)."-".substr($_REQUEST['date_modification'],-10,2);
if ($_REQUEST['heure_creation']=='') $s_heure_creation = ''; else $s_heure_creation= addslashes($_REQUEST['heure_creation']);
if ($_REQUEST['modification_par']=='') $s_modification_par = ''; else $s_modification_par= addslashes($_REQUEST['modification_par']);
if ($_REQUEST['fichier']=='') $s_fichier = ''; else $s_fichier= addslashes($_REQUEST['fichier']);
if ($_REQUEST['heure_modification']=='') $s_heure_modification = ''; else $s_heure_modification= addslashes($_REQUEST['heure_modification']);
if ($_REQUEST['annee']=='') $s_annee = ''; else $s_annee= addslashes($_REQUEST['annee']);


// Requete
$query = "INSERT INTO modele_lettre (cle, 
intitule, 
date_creation, 
creation_par, 
categorie, 
note, 
date_modification, 
heure_creation, 
modification_par, 
fichier, 
heure_modification, 
annee) values('".$s_cle."', 
'".$s_intitule."', 
'".$s_date_creation."', 
'".$s_creation_par."', 
'".$s_categorie."', 
'".$s_note."', 
'".$s_date_modification."', 
'".$s_heure_creation."', 
'".$s_modification_par."', 
'".$s_fichier."', 
'".$s_heure_modification."', 
'".$s_annee."')";
$result = mysql_query( $query );
echo $query;
?>

