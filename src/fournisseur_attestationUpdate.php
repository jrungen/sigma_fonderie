<?php
$synclog = 0;
$search=" where idfournisseur_attestation = '".$_REQUEST['id']."'";
$user = $_REQUEST['user'];

//Connexion ˆ la base de donnees
include 'cnx.php';

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
$query = "UPDATE fournisseur_attestation set fournisseur='". $s_fournisseur."',
annee='". $s_annee."',
cle='". $s_cle."',
creation_par='". $s_creation_par."',
date_creation='". $s_date_creation."',
date_modification='". $s_date_modification."',
heure_creation='". $s_heure_creation."',
heure_modification='". $s_heure_modification."',
modification_par='". $s_modification_par."',
note='". $s_note."',
pj_kbis='". $s_pj_kbis."',
pj_urssaf_rsi='". $s_pj_urssaf_rsi."',
pj_autre='". $s_pj_autre."',
date_attestation='". $s_date_attestation."',
date_document='". $s_date_document."' $search";


$result = mysql_query( $query );

?>



