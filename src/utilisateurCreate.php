<?php


//Connexion ˆ la base de donnees
include 'cnx.php';

// autoincremement

if ($_REQUEST['creation_par']=='') $s_creation_par = ''; else $s_creation_par= addslashes($_REQUEST['creation_par']);
if ($_REQUEST['login']=='') $s_login = ''; else $s_login= addslashes($_REQUEST['login']);
if ($_REQUEST['date_creation']=='') $s_date_creation = '0000-00-00'; else $s_date_creation= substr($_REQUEST['date_creation'],-4)."-".substr($_REQUEST['date_creation'],-7,2)."-".substr($_REQUEST['date_creation'],-10,2);
if ($_REQUEST['heure_creation']=='') $s_heure_creation = ''; else $s_heure_creation= addslashes($_REQUEST['heure_creation']);
if ($_REQUEST['password']=='') $s_password = ''; else $s_password= addslashes($_REQUEST['password']);
if ($_REQUEST['modification_par']=='') $s_modification_par = ''; else $s_modification_par= addslashes($_REQUEST['modification_par']);
if ($_REQUEST['date_modification']=='') $s_date_modification = '0000-00-00'; else $s_date_modification= substr($_REQUEST['date_modification'],-4)."-".substr($_REQUEST['date_modification'],-7,2)."-".substr($_REQUEST['date_modification'],-10,2);
if ($_REQUEST['cle']=='') $s_cle = ''; else $s_cle= addslashes($_REQUEST['cle']);
if ($_REQUEST['heure_modification']=='') $s_heure_modification = ''; else $s_heure_modification= addslashes($_REQUEST['heure_modification']);
if ($_REQUEST['profil']=='') $s_profil = ''; else $s_profil= addslashes($_REQUEST['profil']);
if ($_REQUEST['annee']=='') $s_annee = ''; else $s_annee= addslashes($_REQUEST['annee']);
if ($_REQUEST['subordonnes']=='') $s_subordonnes = ''; else $s_subordonnes= addslashes($_REQUEST['subordonnes']);


// Requete
$query = "INSERT INTO utilisateur (creation_par, 
login, 
date_creation, 
heure_creation, 
password, 
modification_par, 
date_modification, 
cle, 
heure_modification, 
profil, 
annee, 
subordonnes) values('".$s_creation_par."', 
'".$s_login."', 
'".$s_date_creation."', 
'".$s_heure_creation."', 
'".$s_password."', 
'".$s_modification_par."', 
'".$s_date_modification."', 
'".$s_cle."', 
'".$s_heure_modification."', 
'".$s_profil."', 
'".$s_annee."', 
'".$s_subordonnes."')";
$result = mysql_query( $query );
echo $query;
?>

