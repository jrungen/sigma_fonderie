<?php

$search=" where idsociete = '".$_REQUEST['id']."'";

//Connexion ˆ la base de donnees
include 'cnx.php';

if ($_REQUEST['nom']=='') $s_nom = ''; else $s_nom= addslashes($_REQUEST['nom']);
if ($_REQUEST['tel']=='') $s_tel = ''; else $s_tel= addslashes($_REQUEST['tel']);
if ($_REQUEST['cle']=='') $s_cle = ''; else $s_cle= addslashes($_REQUEST['cle']);
if ($_REQUEST['caht']=='') $s_caht = ''; else $s_caht= addslashes($_REQUEST['caht']);
if ($_REQUEST['fax']=='') $s_fax = ''; else $s_fax= addslashes($_REQUEST['fax']);
if ($_REQUEST['adresse']=='') $s_adresse = ''; else $s_adresse= addslashes($_REQUEST['adresse']);
if ($_REQUEST['date_creation']=='') $s_date_creation = '0000-00-00'; else $s_date_creation= substr($_REQUEST['date_creation'],-4)."-".substr($_REQUEST['date_creation'],-7,2)."-".substr($_REQUEST['date_creation'],-10,2);
if ($_REQUEST['creation_par']=='') $s_creation_par = ''; else $s_creation_par= addslashes($_REQUEST['creation_par']);
if ($_REQUEST['margeht']=='') $s_margeht = ''; else $s_margeht= addslashes($_REQUEST['margeht']);
if ($_REQUEST['email']=='') $s_email = ''; else $s_email= addslashes($_REQUEST['email']);
if ($_REQUEST['adressesuite']=='') $s_adressesuite = ''; else $s_adressesuite= addslashes($_REQUEST['adressesuite']);
if ($_REQUEST['heure_creation']=='') $s_heure_creation = ''; else $s_heure_creation= addslashes($_REQUEST['heure_creation']);
if ($_REQUEST['cp']=='') $s_cp = ''; else $s_cp= addslashes($_REQUEST['cp']);
if ($_REQUEST['siret']=='') $s_siret = ''; else $s_siret= addslashes($_REQUEST['siret']);
if ($_REQUEST['date_modification']=='') $s_date_modification = '0000-00-00'; else $s_date_modification= substr($_REQUEST['date_modification'],-4)."-".substr($_REQUEST['date_modification'],-7,2)."-".substr($_REQUEST['date_modification'],-10,2);
if ($_REQUEST['modification_par']=='') $s_modification_par = ''; else $s_modification_par= addslashes($_REQUEST['modification_par']);
if ($_REQUEST['ville']=='') $s_ville = ''; else $s_ville= addslashes($_REQUEST['ville']);
if ($_REQUEST['pays']=='') $s_pays = ''; else $s_pays= addslashes($_REQUEST['pays']);
if ($_REQUEST['heure_modification']=='') $s_heure_modification = ''; else $s_heure_modification= addslashes($_REQUEST['heure_modification']);
if ($_REQUEST['type']=='') $s_type = ''; else $s_type= addslashes($_REQUEST['type']);
if ($_REQUEST['tva_intra']=='') $s_tva_intra = ''; else $s_tva_intra= addslashes($_REQUEST['tva_intra']);
if ($_REQUEST['annee']=='') $s_annee = ''; else $s_annee= addslashes($_REQUEST['annee']);
if ($_REQUEST['profil']=='') $s_profil = ''; else $s_profil= addslashes($_REQUEST['profil']);
if ($_REQUEST['compte_tiers']=='') $s_compte_tiers = ''; else $s_compte_tiers= addslashes($_REQUEST['compte_tiers']);
if ($_REQUEST['nouveau']=='') $s_nouveau = ''; else $s_nouveau= addslashes($_REQUEST['nouveau']);
// Requête
$query = "UPDATE societe set nom='". $s_nom."',
tel='". $s_tel."',
cle='". $s_cle."',
caht='". $s_caht."',
fax='". $s_fax."',
adresse='". $s_adresse."',
date_creation='". $s_date_creation."',
creation_par='". $s_creation_par."',
margeht='". $s_margeht."',
email='". $s_email."',
adressesuite='". $s_adressesuite."',
heure_creation='". $s_heure_creation."',
cp='". $s_cp."',
siret='". $s_siret."',
date_modification='". $s_date_modification."',
modification_par='". $s_modification_par."',
ville='". $s_ville."',
pays='". $s_pays."',
heure_modification='". $s_heure_modification."',
type='". $s_type."',
tva_intra='". $s_tva_intra."',
annee='". $s_annee."',
compte_tiers='". $s_compte_tiers."',
nouveau='". $s_nouveau."',
profil='". $s_profil."' $search";


$result = mysql_query( $query );

?>



