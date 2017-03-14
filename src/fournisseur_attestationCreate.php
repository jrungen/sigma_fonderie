<?php


//Connexion ˆ la base de donnees
include 'cnx.php';

// autoincremement

if ($_REQUEST['fournisseur']=='') $s_fournisseur = ''; else $s_fournisseur= addslashes($_REQUEST['fournisseur']);
if ($_REQUEST['annee']=='') $s_annee = ''; else $s_annee= addslashes($_REQUEST['annee']);
if ($_REQUEST['cle']=='') $s_cle = ''; else $s_cle= addslashes($_REQUEST['cle']);
if ($_REQUEST['creation_par']=='') $s_creation_par = ''; else $s_creation_par= addslashes($_REQUEST['creation_par']);
if ($_REQUEST['date_creation']=='') $s_date_creation = '0000-00-00'; else $s_date_creation= substr($_REQUEST['date_creation'],-4)."-".substr($_REQUEST['date_creation'],-7,2)."-".substr($_REQUEST['date_creation'],-10,2);
if ($_REQUEST['date_modification']=='') $s_date_modification = '0000-00-00'; else $s_date_modification= substr($_REQUEST['date_modification'],-4)."-".substr($_REQUEST['date_modification'],-7,2)."-".substr($_REQUEST['date_modification'],-10,2);
if ($_REQUEST['heure_creation']=='') $s_heure_creation = ''; else $s_heure_creation= addslashes($_REQUEST['heure_creation']);
if ($_REQUEST['heure_modification']=='') $s_heure_modification = ''; else $s_heure_modification= addslashes($_REQUEST['heure_modification']);
if ($_REQUEST['modification_par']=='') $s_modification_par = ''; else $s_modification_par= addslashes($_REQUEST['modification_par']);
if ($_REQUEST['note']=='') $s_note = ''; else $s_note= addslashes($_REQUEST['note']);
if ($_REQUEST['pj_kbis']=='') $s_pj_kbis = ''; else $s_pj_kbis= addslashes($_REQUEST['pj_kbis']);
if ($_REQUEST['pj_urssaf_rsi']=='') $s_pj_urssaf_rsi = ''; else $s_pj_urssaf_rsi= addslashes($_REQUEST['pj_urssaf_rsi']);
if ($_REQUEST['pj_autre']=='') $s_pj_autre = ''; else $s_pj_autre= addslashes($_REQUEST['pj_autre']);
if ($_REQUEST['date_attestation']=='') $s_date_attestation = '0000-00-00'; else $s_date_attestation= substr($_REQUEST['date_attestation'],-4)."-".substr($_REQUEST['date_attestation'],-7,2)."-".substr($_REQUEST['date_attestation'],-10,2);
if ($_REQUEST['date_document']=='') $s_date_document = '0000-00-00'; else $s_date_document= substr($_REQUEST['date_document'],-4)."-".substr($_REQUEST['date_document'],-7,2)."-".substr($_REQUEST['date_document'],-10,2);


// Requete
$query = "INSERT INTO fournisseur_attestation (fournisseur, 
annee, 
cle, 
creation_par, 
date_creation, 
date_modification, 
heure_creation, 
heure_modification, 
modification_par, 
note, 
pj_kbis, 
pj_urssaf_rsi, 
pj_autre, 
date_attestation, 
date_document) values('".$s_fournisseur."', 
'".$s_annee."', 
'".$s_cle."', 
'".$s_creation_par."', 
'".$s_date_creation."', 
'".$s_date_modification."', 
'".$s_heure_creation."', 
'".$s_heure_modification."', 
'".$s_modification_par."', 
'".$s_note."', 
'".$s_pj_kbis."', 
'".$s_pj_urssaf_rsi."', 
'".$s_pj_autre."', 
'".$s_date_attestation."', 
'".$s_date_document."')";
$result = mysql_query( $query );

$UID = mysql_insert_id(); 
if(!$result){
	// Error message
	$UID = ''; 
	echo "<id>$UID</id>\n";
	echo "<message>impossible d'ajouter la fiche.</message>";
}else{
	// Return new ID
	echo "<id>$UID</id>\n";
	echo "<message>Fiche ajoutee</message>";
}

echo $query;
?>

