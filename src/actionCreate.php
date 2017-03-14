<?php


//Connexion ˆ la base de donnees
include 'cnx.php';

// autoincremement

if ($_REQUEST['nom']=='') $s_nom = ''; else $s_nom= addslashes($_REQUEST['nom']);
if ($_REQUEST['notes']=='') $s_notes = ''; else $s_notes= addslashes($_REQUEST['notes']);
if ($_REQUEST['cle']=='') $s_cle = ''; else $s_cle= addslashes($_REQUEST['cle']);
if ($_REQUEST['date_creation']=='') $s_date_creation = '0000-00-00'; else $s_date_creation= substr($_REQUEST['date_creation'],-4)."-".substr($_REQUEST['date_creation'],-7,2)."-".substr($_REQUEST['date_creation'],-10,2);
if ($_REQUEST['fichier_joint']=='') $s_fichier_joint = ''; else $s_fichier_joint= addslashes($_REQUEST['fichier_joint']);
if ($_REQUEST['creation_par']=='') $s_creation_par = ''; else $s_creation_par= addslashes($_REQUEST['creation_par']);
if ($_REQUEST['type']=='') $s_type = ''; else $s_type= addslashes($_REQUEST['type']);
if ($_REQUEST['date_modification']=='') $s_date_modification = '0000-00-00'; else $s_date_modification= substr($_REQUEST['date_modification'],-4)."-".substr($_REQUEST['date_modification'],-7,2)."-".substr($_REQUEST['date_modification'],-10,2);
if ($_REQUEST['heure_creation']=='') $s_heure_creation = ''; else $s_heure_creation= addslashes($_REQUEST['heure_creation']);
if ($_REQUEST['modification_par']=='') $s_modification_par = ''; else $s_modification_par= addslashes($_REQUEST['modification_par']);
if ($_REQUEST['statut']=='') $s_statut = ''; else $s_statut= addslashes($_REQUEST['statut']);
if ($_REQUEST['heure_modification']=='') $s_heure_modification = ''; else $s_heure_modification= addslashes($_REQUEST['heure_modification']);
if ($_REQUEST['priorite']=='') $s_priorite = ''; else $s_priorite= addslashes($_REQUEST['priorite']);
if ($_REQUEST['annee']=='') $s_annee = ''; else $s_annee= addslashes($_REQUEST['annee']);
if ($_REQUEST['date_fin']=='') $s_date_fin = '0000-00-00'; else $s_date_fin= substr($_REQUEST['date_fin'],-4)."-".substr($_REQUEST['date_fin'],-7,2)."-".substr($_REQUEST['date_fin'],-10,2);
if ($_REQUEST['heure_fin']=='') $s_heure_fin = ''; else $s_heure_fin= addslashes($_REQUEST['heure_fin']);
if ($_REQUEST['societe']=='') $s_societe = ''; else $s_societe= addslashes($_REQUEST['societe']);
if ($_REQUEST['projet']=='') $s_projet = ''; else $s_projet= addslashes($_REQUEST['projet']);
if ($_REQUEST['fournisseur']=='') $s_fournisseur = ''; else $s_fournisseur= addslashes($_REQUEST['fournisseur']);
if ($_REQUEST['utilisateur']=='') $s_utilisateur = ''; else $s_utilisateur= addslashes($_REQUEST['utilisateur']);
if ($_REQUEST['utilisateur_cc']=='') $s_utilisateur_cc = ''; else $s_utilisateur_cc= addslashes($_REQUEST['utilisateur_cc']);
if ($_REQUEST['date_debut']=='') $s_date_debut = '0000-00-00'; else $s_date_debut= substr($_REQUEST['date_debut'],-4)."-".substr($_REQUEST['date_debut'],-7,2)."-".substr($_REQUEST['date_debut'],-10,2);
if ($_REQUEST['heure_debut']=='') $s_heure_debut = ''; else $s_heure_debut= addslashes($_REQUEST['heure_debut']);
if ($_REQUEST['duree']=='') $s_duree = '0'; else $s_duree= addslashes($_REQUEST['duree']);


// Requete
$query = "INSERT INTO action (nom, 
notes, 
cle, 
date_creation, 
fichier_joint, 
creation_par, 
type, 
date_modification, 
heure_creation, 
modification_par, 
statut, 
heure_modification, 
priorite, 
annee, 
date_fin, 
heure_fin, 
societe, 
projet, 
fournisseur, 
utilisateur, 
utilisateur_cc, 
date_debut, 
heure_debut, 
duree) values('".$s_nom."', 
'".$s_notes."', 
'".$s_cle."', 
'".$s_date_creation."', 
'".$s_fichier_joint."', 
'".$s_creation_par."', 
'".$s_type."', 
'".$s_date_modification."', 
'".$s_heure_creation."', 
'".$s_modification_par."', 
'".$s_statut."', 
'".$s_heure_modification."', 
'".$s_priorite."', 
'".$s_annee."', 
'".$s_date_fin."', 
'".$s_heure_fin."', 
'".$s_societe."', 
'".$s_projet."', 
'".$s_fournisseur."', 
'".$s_utilisateur."', 
'".$s_utilisateur_cc."', 
'".$s_date_debut."', 
'".$s_heure_debut."', 
'".$s_duree."')";
$result = mysql_query( $query );
echo $query;
?>

