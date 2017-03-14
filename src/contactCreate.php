<?php


//Connexion ˆ la base de donnees
include 'cnx.php';

if ($_REQUEST['cle']=='') $s_cle = ''; else $s_cle= addslashes($_REQUEST['cle']);
if ($_REQUEST['tel']=='') $s_tel = ''; else $s_tel= addslashes($_REQUEST['tel']);
if ($_REQUEST['nom']=='') $s_nom = ''; else $s_nom= addslashes($_REQUEST['nom']);
if ($_REQUEST['prenom']=='') $s_prenom = ''; else $s_prenom= addslashes($_REQUEST['prenom']);
if ($_REQUEST['mobile']=='') $s_mobile = ''; else $s_mobile= addslashes($_REQUEST['mobile']);
if ($_REQUEST['date_creation']=='') $s_date_creation = '0000-00-00'; else $s_date_creation= substr($_REQUEST['date_creation'],-4)."-".substr($_REQUEST['date_creation'],-7,2)."-".substr($_REQUEST['date_creation'],-10,2);
if ($_REQUEST['creation_par']=='') $s_creation_par = ''; else $s_creation_par= addslashes($_REQUEST['creation_par']);
if ($_REQUEST['fonction']=='') $s_fonction = ''; else $s_fonction= addslashes($_REQUEST['fonction']);
if ($_REQUEST['fax']=='') $s_fax = ''; else $s_fax= addslashes($_REQUEST['fax']);
if ($_REQUEST['heure_creation']=='') $s_heure_creation = ''; else $s_heure_creation= addslashes($_REQUEST['heure_creation']);
if ($_REQUEST['societe']=='') $s_societe = ''; else $s_societe= addslashes($_REQUEST['societe']);
if ($_REQUEST['email']=='') $s_email = ''; else $s_email= addslashes($_REQUEST['email']);
if ($_REQUEST['date_modification']=='') $s_date_modification = '0000-00-00'; else $s_date_modification= substr($_REQUEST['date_modification'],-4)."-".substr($_REQUEST['date_modification'],-7,2)."-".substr($_REQUEST['date_modification'],-10,2);
if ($_REQUEST['modification_par']=='') $s_modification_par = ''; else $s_modification_par= addslashes($_REQUEST['modification_par']);
if ($_REQUEST['heure_modification']=='') $s_heure_modification = ''; else $s_heure_modification= addslashes($_REQUEST['heure_modification']);
if ($_REQUEST['annee']=='') $s_annee = ''; else $s_annee= addslashes($_REQUEST['annee']);


// Requete
$query = "INSERT INTO contact (cle, 
tel, 
nom, 
prenom, 
mobile, 
date_creation, 
creation_par, 
fonction, 
fax, 
heure_creation, 
societe, 
email, 
date_modification, 
modification_par, 
heure_modification, 
annee) values('".$s_cle."', 
'".$s_tel."', 
'".$s_nom."', 
'".$s_prenom."', 
'".$s_mobile."', 
'".$s_date_creation."', 
'".$s_creation_par."', 
'".$s_fonction."', 
'".$s_fax."', 
'".$s_heure_creation."', 
'".$s_societe."', 
'".$s_email."', 
'".$s_date_modification."', 
'".$s_modification_par."', 
'".$s_heure_modification."', 
'".$s_annee."')";
$result = mysql_query( $query );
echo $query;
?>

