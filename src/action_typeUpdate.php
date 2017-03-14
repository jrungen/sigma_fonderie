<?php

$search=" where idaction_type = '".$_REQUEST['id']."'";
$user = $_REQUEST['user'];

//Connexion ˆ la base de donnees
include 'cnx.php';

if ($_REQUEST['cle']=='') $s_cle = ''; else $s_cle= addslashes($_REQUEST['cle']);
if ($_REQUEST['intitule']=='') $s_intitule = ''; else $s_intitule= addslashes($_REQUEST['intitule']);
if ($_REQUEST['creation_par']=='') $s_creation_par = ''; else $s_creation_par= addslashes($_REQUEST['creation_par']);
if ($_REQUEST['date_creation']=='') $s_date_creation = '0000-00-00'; else $s_date_creation= substr($_REQUEST['date_creation'],-4)."-".substr($_REQUEST['date_creation'],-7,2)."-".substr($_REQUEST['date_creation'],-10,2);
if ($_REQUEST['modification_par']=='') $s_modification_par = ''; else $s_modification_par= addslashes($_REQUEST['modification_par']);
if ($_REQUEST['heure_creation']=='') $s_heure_creation = ''; else $s_heure_creation= addslashes($_REQUEST['heure_creation']);
if ($_REQUEST['date_modification']=='') $s_date_modification = '0000-00-00'; else $s_date_modification= substr($_REQUEST['date_modification'],-4)."-".substr($_REQUEST['date_modification'],-7,2)."-".substr($_REQUEST['date_modification'],-10,2);
if ($_REQUEST['heure_modification']=='') $s_heure_modification = ''; else $s_heure_modification= addslashes($_REQUEST['heure_modification']);
if ($_REQUEST['annee']=='') $s_annee = ''; else $s_annee= addslashes($_REQUEST['annee']);


// Audit trail
// Vérifier si le(s) champ(s) ont été modifié(s)


//Créer Synclog
$synclog_date_modification = date('Y-m-d');
date_default_timezone_set('Europe/Paris');
$synclog_heure_modification = date('H:i:s');

$query_synclog = "insert into synclog (user, categorie, id, cle, type, date_update, time_update, status)
 values('$user','compte','".$_REQUEST['id']."','$s_cle','update','$synclog_date_modification','$synclog_heure_modification','0')";
$result_synclog = mysql_query( $query_synclog );

// Requête
$query = "UPDATE action_type set cle='". $s_cle."',
intitule='". $s_intitule."',
creation_par='". $s_creation_par."',
date_creation='". $s_date_creation."',
modification_par='". $s_modification_par."',
heure_creation='". $s_heure_creation."',
date_modification='". $s_date_modification."',
heure_modification='". $s_heure_modification."',
annee='". $s_annee."' $search";


$result = mysql_query( $query );

?>



