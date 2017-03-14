<?php


//Connexion ˆ la base de donnees
include 'cnx.php';

// autoincremement

if ($_REQUEST['cle']=='') $s_cle = ''; else $s_cle= addslashes($_REQUEST['cle']);
if ($_REQUEST['nom']=='') $s_nom = ''; else $s_nom= addslashes($_REQUEST['nom']);
if ($_REQUEST['tel']=='') $s_tel = ''; else $s_tel= addslashes($_REQUEST['tel']);
if ($_REQUEST['date_creation']=='') $s_date_creation = '0000-00-00'; else $s_date_creation= substr($_REQUEST['date_creation'],-4)."-".substr($_REQUEST['date_creation'],-7,2)."-".substr($_REQUEST['date_creation'],-10,2);
if ($_REQUEST['creation_par']=='') $s_creation_par = ''; else $s_creation_par= addslashes($_REQUEST['creation_par']);
if ($_REQUEST['fax']=='') $s_fax = ''; else $s_fax= addslashes($_REQUEST['fax']);
if ($_REQUEST['adresse']=='') $s_adresse = ''; else $s_adresse= addslashes($_REQUEST['adresse']);
if ($_REQUEST['heure_creation']=='') $s_heure_creation = ''; else $s_heure_creation= addslashes($_REQUEST['heure_creation']);
if ($_REQUEST['email']=='') $s_email = ''; else $s_email= addslashes($_REQUEST['email']);
if ($_REQUEST['adressesuite']=='') $s_adressesuite = ''; else $s_adressesuite= addslashes($_REQUEST['adressesuite']);
if ($_REQUEST['modification_par']=='') $s_modification_par = ''; else $s_modification_par= addslashes($_REQUEST['modification_par']);
if ($_REQUEST['date_modification']=='') $s_date_modification = '0000-00-00'; else $s_date_modification= substr($_REQUEST['date_modification'],-4)."-".substr($_REQUEST['date_modification'],-7,2)."-".substr($_REQUEST['date_modification'],-10,2);
if ($_REQUEST['cp']=='') $s_cp = ''; else $s_cp= addslashes($_REQUEST['cp']);
if ($_REQUEST['siret']=='') $s_siret = ''; else $s_siret= addslashes($_REQUEST['siret']);
if ($_REQUEST['heure_modification']=='') $s_heure_modification = ''; else $s_heure_modification= addslashes($_REQUEST['heure_modification']);
if ($_REQUEST['ville']=='') $s_ville = ''; else $s_ville= addslashes($_REQUEST['ville']);
if ($_REQUEST['pays']=='') $s_pays = ''; else $s_pays= addslashes($_REQUEST['pays']);
if ($_REQUEST['compte_tiers']=='') $s_compte_tiers = ''; else $s_compte_tiers= addslashes($_REQUEST['compte_tiers']);
if ($_REQUEST['annee']=='') $s_annee = ''; else $s_annee= addslashes($_REQUEST['annee']);
if ($_REQUEST['tva_intra']=='') $s_tva_intra = ''; else $s_tva_intra= addslashes($_REQUEST['tva_intra']);
if ($_REQUEST['nouveau']=='') $s_nouveau = ''; else $s_nouveau= addslashes($_REQUEST['nouveau']);
if ($_REQUEST['date_demande_attestation']=='') $s_date_demande_attestation = '0000-00-00'; else $s_date_demande_attestation= substr($_REQUEST['date_demande_attestation'],-4)."-".substr($_REQUEST['date_demande_attestation'],-7,2)."-".substr($_REQUEST['date_demande_attestation'],-10,2);
if ($_REQUEST['date_relance1']=='') $s_date_relance1 = '0000-00-00'; else $s_date_relance1= substr($_REQUEST['date_relance1'],-4)."-".substr($_REQUEST['date_relance1'],-7,2)."-".substr($_REQUEST['date_relance1'],-10,2);
if ($_REQUEST['date_relance2']=='') $s_date_relance2 = '0000-00-00'; else $s_date_relance2= substr($_REQUEST['date_relance2'],-4)."-".substr($_REQUEST['date_relance2'],-7,2)."-".substr($_REQUEST['date_relance2'],-10,2);
if ($_REQUEST['date_reception']=='') $s_date_reception = '0000-00-00'; else $s_date_reception= substr($_REQUEST['date_reception'],-4)."-".substr($_REQUEST['date_reception'],-7,2)."-".substr($_REQUEST['date_reception'],-10,2);
if ($_REQUEST['date_document']=='') $s_date_document = '0000-00-00'; else $s_date_document= substr($_REQUEST['date_document'],-4)."-".substr($_REQUEST['date_document'],-7,2)."-".substr($_REQUEST['date_document'],-10,2);
if ($_REQUEST['date_renouvellement']=='') $s_date_renouvellement = '0000-00-00'; else $s_date_renouvellement= substr($_REQUEST['date_renouvellement'],-4)."-".substr($_REQUEST['date_renouvellement'],-7,2)."-".substr($_REQUEST['date_renouvellement'],-10,2);

// Requete
$query = "INSERT INTO fournisseur (cle, 
nom, 
tel, 
date_creation, 
creation_par, 
fax, 
adresse, 
heure_creation, 
email, 
adressesuite, 
modification_par, 
date_modification, 
cp, 
siret, 
heure_modification, 
ville, 
pays, 
compte_tiers, 
annee, 
tva_intra,
nouveau, 
date_demande_attestation, 
date_relance1, 
date_relance2, 
date_reception, 
date_document, 
date_renouvellement) values('".$s_cle."', 
'".$s_nom."', 
'".$s_tel."', 
'".$s_date_creation."', 
'".$s_creation_par."', 
'".$s_fax."', 
'".$s_adresse."', 
'".$s_heure_creation."', 
'".$s_email."', 
'".$s_adressesuite."', 
'".$s_modification_par."', 
'".$s_date_modification."', 
'".$s_cp."', 
'".$s_siret."', 
'".$s_heure_modification."', 
'".$s_ville."', 
'".$s_pays."', 
'".$s_compte_tiers."', 
'".$s_annee."', 
'".$s_tva_intra."',
'".$s_nouveau."', 
'".$s_date_demande_attestation."', 
'".$s_date_relance1."', 
'".$s_date_relance2."', 
'".$s_date_reception."', 
'".$s_date_document."', 
'".$s_date_renouvellement."')";
$result = mysql_query( $query );
echo $query;
?>

