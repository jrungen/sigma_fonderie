<?php

$search=" where idpays = '".$_REQUEST['id']."'";

//Connexion ˆ la base de donnees
include 'cnx.php';

if ($_REQUEST['cle']=='') $s_cle = ''; else $s_cle= addslashes($_REQUEST['cle']);
if ($_REQUEST['taux_tva_normal']=='') $s_taux_tva_normal = ''; else $s_taux_tva_normal= addslashes($_REQUEST['taux_tva_normal']);
if ($_REQUEST['taux_tva_reduit']=='') $s_taux_tva_reduit = ''; else $s_taux_tva_reduit= addslashes($_REQUEST['taux_tva_reduit']);


// Requête
$query = "UPDATE pays set cle='". $s_cle."',
taux_tva_normal='". $s_taux_tva_normal."',
taux_tva_reduit='". $s_taux_tva_reduit."' $search";


$result = mysql_query( $query );

?>



