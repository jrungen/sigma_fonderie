<?php

$search=" where idfournisseur = '".$_REQUEST['id']."'";
$user = $_REQUEST['user'];

//Connexion a la base de donnees
include 'cnx.php';

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

// Audit trail
// Verifier si le(s) champ(s) ont ete modifie(s)

// Requete
$query = "UPDATE fournisseur set cle='". $s_cle."',
nom='". $s_nom."',
tel='". $s_tel."',
creation_par='". $s_creation_par."',
fax='". $s_fax."',
adresse='". $s_adresse."',
heure_creation='". $s_heure_creation."',
email='". $s_email."',
adressesuite='". $s_adressesuite."',
modification_par='". $s_modification_par."',
date_modification='". $s_date_modification."',
cp='". $s_cp."',
siret='". $s_siret."',
heure_modification='". $s_heure_modification."',
ville='". $s_ville."',
pays='". $s_pays."',
compte_tiers='". $s_compte_tiers."',
annee='". $s_annee."',
nouveau='". $s_nouveau."',
tva_intra='". $s_tva_intra."',
date_demande_attestation='". $s_date_demande_attestation."',
date_relance1='". $s_date_relance1."',
date_relance2='". $s_date_relance2."',
date_reception='". $s_date_reception."',
date_document='". $s_date_document."',
date_renouvellement='". $s_date_renouvellement."' $search";

echo $query;
$result = mysql_query( $query );

?>