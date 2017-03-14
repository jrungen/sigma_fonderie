<?php
$synclog = 0;
$search=" where idtiers = '".$_REQUEST['id']."'";
$user = $_REQUEST['user'];

//Connexion ˆ la base de donnees
include 'cnx.php';

if ($_REQUEST['cle']=='') $s_cle = ''; else $s_cle= addslashes($_REQUEST['cle']);
if ($_REQUEST['civilite']=='') $s_civilite = ''; else $s_civilite= addslashes($_REQUEST['civilite']);
if ($_REQUEST['creation_par']=='') $s_creation_par = ''; else $s_creation_par= addslashes($_REQUEST['creation_par']);
if ($_REQUEST['date_creation']=='') $s_date_creation = '0000-00-00'; else $s_date_creation= substr($_REQUEST['date_creation'],-4)."-".substr($_REQUEST['date_creation'],-7,2)."-".substr($_REQUEST['date_creation'],-10,2);
if ($_REQUEST['nom']=='') $s_nom = ''; else $s_nom= addslashes($_REQUEST['nom']);
if ($_REQUEST['date_modification']=='') $s_date_modification = '0000-00-00'; else $s_date_modification= substr($_REQUEST['date_modification'],-4)."-".substr($_REQUEST['date_modification'],-7,2)."-".substr($_REQUEST['date_modification'],-10,2);
if ($_REQUEST['heure_creation']=='') $s_heure_creation = ''; else $s_heure_creation= addslashes($_REQUEST['heure_creation']);
if ($_REQUEST['modification_par']=='') $s_modification_par = ''; else $s_modification_par= addslashes($_REQUEST['modification_par']);
if ($_REQUEST['prenom']=='') $s_prenom = ''; else $s_prenom= addslashes($_REQUEST['prenom']);
if ($_REQUEST['heure_modification']=='') $s_heure_modification = ''; else $s_heure_modification= addslashes($_REQUEST['heure_modification']);
if ($_REQUEST['societe']=='') $s_societe = ''; else $s_societe= addslashes($_REQUEST['societe']);
if ($_REQUEST['service']=='') $s_service = ''; else $s_service= addslashes($_REQUEST['service']);
if ($_REQUEST['annee']=='') $s_annee = ''; else $s_annee= addslashes($_REQUEST['annee']);
if ($_REQUEST['adresse']=='') $s_adresse = ''; else $s_adresse= addslashes($_REQUEST['adresse']);
if ($_REQUEST['adresse2']=='') $s_adresse2 = ''; else $s_adresse2= addslashes($_REQUEST['adresse2']);
if ($_REQUEST['cp']=='') $s_cp = ''; else $s_cp= addslashes($_REQUEST['cp']);
if ($_REQUEST['ville']=='') $s_ville = ''; else $s_ville= addslashes($_REQUEST['ville']);
if ($_REQUEST['tel']=='') $s_tel = ''; else $s_tel= addslashes($_REQUEST['tel']);
if ($_REQUEST['compte_tiers']=='') $s_compte_tiers = ''; else $s_compte_tiers= addslashes($_REQUEST['compte_tiers']);
if ($_REQUEST['fax']=='') $s_fax = ''; else $s_fax= addslashes($_REQUEST['fax']);
if ($_REQUEST['tva_intra']=='') $s_tva_intra = ''; else $s_tva_intra= addslashes($_REQUEST['tva_intra']);
if ($_REQUEST['email']=='') $s_email = ''; else $s_email= addslashes($_REQUEST['email']);
if ($_REQUEST['siret']=='') $s_siret = ''; else $s_siret= addslashes($_REQUEST['siret']);
if ($_REQUEST['pays']=='') $s_pays = ''; else $s_pays= addslashes($_REQUEST['pays']);
if ($_REQUEST['nouveau']=='') $s_nouveau = ''; else $s_nouveau= addslashes($_REQUEST['nouveau']);


// Audit trail
// Vérifier si le(s) champ(s) ont été modifié(s)
$audit_trail = '';



//Créer Synclog
if($synclog==1){
	$synclog_date_modification = date('Y-m-d');
	//date_default_timezone_set('Europe/Paris');
	$synclog_heure_modification = date('H:i:s');

	$query_synclog = "insert into synclog (user, categorie, id, cle, type, date_update, time_update, status)
	 values('$user','compte','".$_REQUEST['id']."','$s_cle','update','$synclog_date_modification','$synclog_heure_modification','0')";
	$result_synclog = mysql_query( $query_synclog );
}

// Requête
$query = "UPDATE tiers set cle='". $s_cle."',
civilite='". $s_civilite."',
creation_par='". $s_creation_par."',
date_creation='". $s_date_creation."',
nom='". $s_nom."',
date_modification='". $s_date_modification."',
heure_creation='". $s_heure_creation."',
modification_par='". $s_modification_par."',
prenom='". $s_prenom."',
heure_modification='". $s_heure_modification."',
societe='". $s_societe."',
service='". $s_service."',
annee='". $s_annee."',
adresse='". $s_adresse."',
adresse2='". $s_adresse2."',
cp='". $s_cp."',
ville='". $s_ville."',
tel='". $s_tel."',
compte_tiers='". $s_compte_tiers."',
fax='". $s_fax."',
tva_intra='". $s_tva_intra."',
email='". $s_email."',
siret='". $s_siret."',
pays='". $s_pays."',
nouveau='". $s_nouveau."' $search";


$result = mysql_query( $query );

?>



