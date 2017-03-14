<?php
echo "<?xml version='1.0' encoding='UTF-8'?>";
$id = $_REQUEST['id'];
$file = $_REQUEST['file'];

//Connexion ˆ la base de donnees
include 'cnx.php';

mysql_query("SET NAMES 'utf8'");

// Modèle Word
$source = 'files/modele_lettre/'.$file;
$destination = 'files/modele_lettre/merged/'.$file.'_'.$id.'_'.date('YmdHHis').'.doc';

// Copie du fichier
copy($source, $destination);

// Requete
$query = "select * from satisfaction where idsatisfaction='$id'";
$result = mysql_query( $query );
while( $row = mysql_fetch_object( $result ) ){
	//$contrat_salarie = $row->salarie;
	$satisfaction_cle = $row->cle;
$satisfaction_idsatisfaction = $row->idsatisfaction;
$satisfaction_creation_par = $row->creation_par;
$satisfaction_date_creation = substr($row->date_creation,-2)."/".substr($row->date_creation,-5,2)."/".substr($row->date_creation,-10,4);
$satisfaction_date_modification = substr($row->date_modification,-2)."/".substr($row->date_modification,-5,2)."/".substr($row->date_modification,-10,4);
$satisfaction_modification_par = $row->modification_par;
$satisfaction_heure_creation = $row->heure_creation;
$satisfaction_heure_modification = $row->heure_modification;
$satisfaction_annee = $row->annee;
$satisfaction_fournisseur = $row->fournisseur;
$satisfaction_projet = $row->projet;
$satisfaction_utilisateur = $row->utilisateur;
$satisfaction_ca_ht = $row->ca_ht;
$satisfaction_eval_preparation = $row->eval_preparation;
$satisfaction_date_preparation = substr($row->date_preparation,-2)."/".substr($row->date_preparation,-5,2)."/".substr($row->date_preparation,-10,4);
$satisfaction_eval_realisation = $row->eval_realisation;
$satisfaction_liste_preparation = $row->liste_preparation;
$satisfaction_date_realisation = substr($row->date_realisation,-2)."/".substr($row->date_realisation,-5,2)."/".substr($row->date_realisation,-10,4);
$satisfaction_liste_realisation = $row->liste_realisation;
$satisfaction_note_preparation = $row->note_preparation;
$satisfaction_note_realisation = $row->note_realisation;

	// fournisseur
 $query = "select annee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idfournisseur, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idprojet, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idutilisateur, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idfournisseur, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idprojet, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idutilisateur, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idfournisseur, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idprojet, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idutilisateur, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idfournisseur, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idprojet, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idutilisateur, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idfournisseur, intitule, modification_par from fournisseur where fournisseur.cle ='$satisfaction_cle'";
$result = mysql_query( $query );
while( $row = mysql_fetch_object( $result ) ){
$fournisseur_annee = $row->annee;
$fournisseur_cle = $row->cle;
$fournisseur_creation_par = $row->creation_par;
$fournisseur_date_creation = $row->date_creation;
$fournisseur_date_modification = $row->date_modification;
$fournisseur_heure_creation = $row->heure_creation;
$fournisseur_heure_modification = $row->heure_modification;
$fournisseur_idfournisseur = $row->idfournisseur;
$fournisseur_intitule = $row->intitule;
$fournisseur_modification_par = $row->modification_par;

}
// projet
 $query = "select annee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idfournisseur, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idprojet, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idutilisateur, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idfournisseur, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idprojet, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idutilisateur, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idfournisseur, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idprojet, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idutilisateur, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idfournisseur, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idprojet, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idutilisateur, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idfournisseur, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idprojet, intitule, modification_par from projet where projet.cle ='$satisfaction_cle'";
$result = mysql_query( $query );
while( $row = mysql_fetch_object( $result ) ){
$projet_annee = $row->annee;
$projet_cle = $row->cle;
$projet_creation_par = $row->creation_par;
$projet_date_creation = $row->date_creation;
$projet_date_modification = $row->date_modification;
$projet_heure_creation = $row->heure_creation;
$projet_heure_modification = $row->heure_modification;
$projet_idprojet = $row->idprojet;
$projet_intitule = $row->intitule;
$projet_modification_par = $row->modification_par;

}
// utilisateur
 $query = "select annee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idfournisseur, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idprojet, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idutilisateur, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idfournisseur, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idprojet, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idutilisateur, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idfournisseur, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idprojet, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idutilisateur, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idfournisseur, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idprojet, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idutilisateur, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idfournisseur, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idprojet, intitule, modification_parannee, cle, creation_par, date_creation, date_modification, heure_creation, heure_modification, idutilisateur, intitule, modification_par from utilisateur where utilisateur.cle ='$satisfaction_cle'";
$result = mysql_query( $query );
while( $row = mysql_fetch_object( $result ) ){
$utilisateur_annee = $row->annee;
$utilisateur_cle = $row->cle;
$utilisateur_creation_par = $row->creation_par;
$utilisateur_date_creation = $row->date_creation;
$utilisateur_date_modification = $row->date_modification;
$utilisateur_heure_creation = $row->heure_creation;
$utilisateur_heure_modification = $row->heure_modification;
$utilisateur_idutilisateur = $row->idutilisateur;
$utilisateur_intitule = $row->intitule;
$utilisateur_modification_par = $row->modification_par;

}

}

$content = file_get_contents($destination);
//$content = str_replace('«contrat_salarie»', $contrat_salarie, $content);
$content = str_replace('«satisfaction_cle»', $satisfaction_cle, $content);

$content = str_replace('«satisfaction_idsatisfaction»', $satisfaction_idsatisfaction, $content);

$content = str_replace('«satisfaction_creation_par»', $satisfaction_creation_par, $content);

$content = str_replace('«satisfaction_date_creation»', $satisfaction_date_creation, $content);

$content = str_replace('«satisfaction_date_modification»', $satisfaction_date_modification, $content);

$content = str_replace('«satisfaction_modification_par»', $satisfaction_modification_par, $content);

$content = str_replace('«satisfaction_heure_creation»', $satisfaction_heure_creation, $content);

$content = str_replace('«satisfaction_heure_modification»', $satisfaction_heure_modification, $content);

$content = str_replace('«satisfaction_annee»', $satisfaction_annee, $content);

$content = str_replace('«satisfaction_fournisseur»', $satisfaction_fournisseur, $content);
// fournisseur
$content = str_replace('«fournisseur_annee»', $fournisseur_annee, $content);
$content = str_replace('«fournisseur_cle»', $fournisseur_cle, $content);
$content = str_replace('«fournisseur_creation_par»', $fournisseur_creation_par, $content);
$content = str_replace('«fournisseur_date_creation»', $fournisseur_date_creation, $content);
$content = str_replace('«fournisseur_date_modification»', $fournisseur_date_modification, $content);
$content = str_replace('«fournisseur_heure_creation»', $fournisseur_heure_creation, $content);
$content = str_replace('«fournisseur_heure_modification»', $fournisseur_heure_modification, $content);
$content = str_replace('«fournisseur_idfournisseur»', $fournisseur_idfournisseur, $content);
$content = str_replace('«fournisseur_intitule»', $fournisseur_intitule, $content);
$content = str_replace('«fournisseur_modification_par»', $fournisseur_modification_par, $content);
// projet
$content = str_replace('«projet_annee»', $projet_annee, $content);
$content = str_replace('«projet_cle»', $projet_cle, $content);
$content = str_replace('«projet_creation_par»', $projet_creation_par, $content);
$content = str_replace('«projet_date_creation»', $projet_date_creation, $content);
$content = str_replace('«projet_date_modification»', $projet_date_modification, $content);
$content = str_replace('«projet_heure_creation»', $projet_heure_creation, $content);
$content = str_replace('«projet_heure_modification»', $projet_heure_modification, $content);
$content = str_replace('«projet_idprojet»', $projet_idprojet, $content);
$content = str_replace('«projet_intitule»', $projet_intitule, $content);
$content = str_replace('«projet_modification_par»', $projet_modification_par, $content);
// utilisateur
$content = str_replace('«utilisateur_annee»', $utilisateur_annee, $content);
$content = str_replace('«utilisateur_cle»', $utilisateur_cle, $content);
$content = str_replace('«utilisateur_creation_par»', $utilisateur_creation_par, $content);
$content = str_replace('«utilisateur_date_creation»', $utilisateur_date_creation, $content);
$content = str_replace('«utilisateur_date_modification»', $utilisateur_date_modification, $content);
$content = str_replace('«utilisateur_heure_creation»', $utilisateur_heure_creation, $content);
$content = str_replace('«utilisateur_heure_modification»', $utilisateur_heure_modification, $content);
$content = str_replace('«utilisateur_idutilisateur»', $utilisateur_idutilisateur, $content);
$content = str_replace('«utilisateur_intitule»', $utilisateur_intitule, $content);
$content = str_replace('«utilisateur_modification_par»', $utilisateur_modification_par, $content);

$content = str_replace('«satisfaction_projet»', $satisfaction_projet, $content);
// fournisseur
$content = str_replace('«fournisseur_annee»', $fournisseur_annee, $content);
$content = str_replace('«fournisseur_cle»', $fournisseur_cle, $content);
$content = str_replace('«fournisseur_creation_par»', $fournisseur_creation_par, $content);
$content = str_replace('«fournisseur_date_creation»', $fournisseur_date_creation, $content);
$content = str_replace('«fournisseur_date_modification»', $fournisseur_date_modification, $content);
$content = str_replace('«fournisseur_heure_creation»', $fournisseur_heure_creation, $content);
$content = str_replace('«fournisseur_heure_modification»', $fournisseur_heure_modification, $content);
$content = str_replace('«fournisseur_idfournisseur»', $fournisseur_idfournisseur, $content);
$content = str_replace('«fournisseur_intitule»', $fournisseur_intitule, $content);
$content = str_replace('«fournisseur_modification_par»', $fournisseur_modification_par, $content);
// projet
$content = str_replace('«projet_annee»', $projet_annee, $content);
$content = str_replace('«projet_cle»', $projet_cle, $content);
$content = str_replace('«projet_creation_par»', $projet_creation_par, $content);
$content = str_replace('«projet_date_creation»', $projet_date_creation, $content);
$content = str_replace('«projet_date_modification»', $projet_date_modification, $content);
$content = str_replace('«projet_heure_creation»', $projet_heure_creation, $content);
$content = str_replace('«projet_heure_modification»', $projet_heure_modification, $content);
$content = str_replace('«projet_idprojet»', $projet_idprojet, $content);
$content = str_replace('«projet_intitule»', $projet_intitule, $content);
$content = str_replace('«projet_modification_par»', $projet_modification_par, $content);
// utilisateur
$content = str_replace('«utilisateur_annee»', $utilisateur_annee, $content);
$content = str_replace('«utilisateur_cle»', $utilisateur_cle, $content);
$content = str_replace('«utilisateur_creation_par»', $utilisateur_creation_par, $content);
$content = str_replace('«utilisateur_date_creation»', $utilisateur_date_creation, $content);
$content = str_replace('«utilisateur_date_modification»', $utilisateur_date_modification, $content);
$content = str_replace('«utilisateur_heure_creation»', $utilisateur_heure_creation, $content);
$content = str_replace('«utilisateur_heure_modification»', $utilisateur_heure_modification, $content);
$content = str_replace('«utilisateur_idutilisateur»', $utilisateur_idutilisateur, $content);
$content = str_replace('«utilisateur_intitule»', $utilisateur_intitule, $content);
$content = str_replace('«utilisateur_modification_par»', $utilisateur_modification_par, $content);

$content = str_replace('«satisfaction_utilisateur»', $satisfaction_utilisateur, $content);
// fournisseur
$content = str_replace('«fournisseur_annee»', $fournisseur_annee, $content);
$content = str_replace('«fournisseur_cle»', $fournisseur_cle, $content);
$content = str_replace('«fournisseur_creation_par»', $fournisseur_creation_par, $content);
$content = str_replace('«fournisseur_date_creation»', $fournisseur_date_creation, $content);
$content = str_replace('«fournisseur_date_modification»', $fournisseur_date_modification, $content);
$content = str_replace('«fournisseur_heure_creation»', $fournisseur_heure_creation, $content);
$content = str_replace('«fournisseur_heure_modification»', $fournisseur_heure_modification, $content);
$content = str_replace('«fournisseur_idfournisseur»', $fournisseur_idfournisseur, $content);
$content = str_replace('«fournisseur_intitule»', $fournisseur_intitule, $content);
$content = str_replace('«fournisseur_modification_par»', $fournisseur_modification_par, $content);
// projet
$content = str_replace('«projet_annee»', $projet_annee, $content);
$content = str_replace('«projet_cle»', $projet_cle, $content);
$content = str_replace('«projet_creation_par»', $projet_creation_par, $content);
$content = str_replace('«projet_date_creation»', $projet_date_creation, $content);
$content = str_replace('«projet_date_modification»', $projet_date_modification, $content);
$content = str_replace('«projet_heure_creation»', $projet_heure_creation, $content);
$content = str_replace('«projet_heure_modification»', $projet_heure_modification, $content);
$content = str_replace('«projet_idprojet»', $projet_idprojet, $content);
$content = str_replace('«projet_intitule»', $projet_intitule, $content);
$content = str_replace('«projet_modification_par»', $projet_modification_par, $content);
// utilisateur
$content = str_replace('«utilisateur_annee»', $utilisateur_annee, $content);
$content = str_replace('«utilisateur_cle»', $utilisateur_cle, $content);
$content = str_replace('«utilisateur_creation_par»', $utilisateur_creation_par, $content);
$content = str_replace('«utilisateur_date_creation»', $utilisateur_date_creation, $content);
$content = str_replace('«utilisateur_date_modification»', $utilisateur_date_modification, $content);
$content = str_replace('«utilisateur_heure_creation»', $utilisateur_heure_creation, $content);
$content = str_replace('«utilisateur_heure_modification»', $utilisateur_heure_modification, $content);
$content = str_replace('«utilisateur_idutilisateur»', $utilisateur_idutilisateur, $content);
$content = str_replace('«utilisateur_intitule»', $utilisateur_intitule, $content);
$content = str_replace('«utilisateur_modification_par»', $utilisateur_modification_par, $content);

$content = str_replace('«satisfaction_ca_ht»', $satisfaction_ca_ht, $content);
// fournisseur
$content = str_replace('«fournisseur_annee»', $fournisseur_annee, $content);
$content = str_replace('«fournisseur_cle»', $fournisseur_cle, $content);
$content = str_replace('«fournisseur_creation_par»', $fournisseur_creation_par, $content);
$content = str_replace('«fournisseur_date_creation»', $fournisseur_date_creation, $content);
$content = str_replace('«fournisseur_date_modification»', $fournisseur_date_modification, $content);
$content = str_replace('«fournisseur_heure_creation»', $fournisseur_heure_creation, $content);
$content = str_replace('«fournisseur_heure_modification»', $fournisseur_heure_modification, $content);
$content = str_replace('«fournisseur_idfournisseur»', $fournisseur_idfournisseur, $content);
$content = str_replace('«fournisseur_intitule»', $fournisseur_intitule, $content);
$content = str_replace('«fournisseur_modification_par»', $fournisseur_modification_par, $content);
// projet
$content = str_replace('«projet_annee»', $projet_annee, $content);
$content = str_replace('«projet_cle»', $projet_cle, $content);
$content = str_replace('«projet_creation_par»', $projet_creation_par, $content);
$content = str_replace('«projet_date_creation»', $projet_date_creation, $content);
$content = str_replace('«projet_date_modification»', $projet_date_modification, $content);
$content = str_replace('«projet_heure_creation»', $projet_heure_creation, $content);
$content = str_replace('«projet_heure_modification»', $projet_heure_modification, $content);
$content = str_replace('«projet_idprojet»', $projet_idprojet, $content);
$content = str_replace('«projet_intitule»', $projet_intitule, $content);
$content = str_replace('«projet_modification_par»', $projet_modification_par, $content);
// utilisateur
$content = str_replace('«utilisateur_annee»', $utilisateur_annee, $content);
$content = str_replace('«utilisateur_cle»', $utilisateur_cle, $content);
$content = str_replace('«utilisateur_creation_par»', $utilisateur_creation_par, $content);
$content = str_replace('«utilisateur_date_creation»', $utilisateur_date_creation, $content);
$content = str_replace('«utilisateur_date_modification»', $utilisateur_date_modification, $content);
$content = str_replace('«utilisateur_heure_creation»', $utilisateur_heure_creation, $content);
$content = str_replace('«utilisateur_heure_modification»', $utilisateur_heure_modification, $content);
$content = str_replace('«utilisateur_idutilisateur»', $utilisateur_idutilisateur, $content);
$content = str_replace('«utilisateur_intitule»', $utilisateur_intitule, $content);
$content = str_replace('«utilisateur_modification_par»', $utilisateur_modification_par, $content);

$content = str_replace('«satisfaction_eval_preparation»', $satisfaction_eval_preparation, $content);
// fournisseur
$content = str_replace('«fournisseur_annee»', $fournisseur_annee, $content);
$content = str_replace('«fournisseur_cle»', $fournisseur_cle, $content);
$content = str_replace('«fournisseur_creation_par»', $fournisseur_creation_par, $content);
$content = str_replace('«fournisseur_date_creation»', $fournisseur_date_creation, $content);
$content = str_replace('«fournisseur_date_modification»', $fournisseur_date_modification, $content);
$content = str_replace('«fournisseur_heure_creation»', $fournisseur_heure_creation, $content);
$content = str_replace('«fournisseur_heure_modification»', $fournisseur_heure_modification, $content);
$content = str_replace('«fournisseur_idfournisseur»', $fournisseur_idfournisseur, $content);
$content = str_replace('«fournisseur_intitule»', $fournisseur_intitule, $content);
$content = str_replace('«fournisseur_modification_par»', $fournisseur_modification_par, $content);
// projet
$content = str_replace('«projet_annee»', $projet_annee, $content);
$content = str_replace('«projet_cle»', $projet_cle, $content);
$content = str_replace('«projet_creation_par»', $projet_creation_par, $content);
$content = str_replace('«projet_date_creation»', $projet_date_creation, $content);
$content = str_replace('«projet_date_modification»', $projet_date_modification, $content);
$content = str_replace('«projet_heure_creation»', $projet_heure_creation, $content);
$content = str_replace('«projet_heure_modification»', $projet_heure_modification, $content);
$content = str_replace('«projet_idprojet»', $projet_idprojet, $content);
$content = str_replace('«projet_intitule»', $projet_intitule, $content);
$content = str_replace('«projet_modification_par»', $projet_modification_par, $content);
// utilisateur
$content = str_replace('«utilisateur_annee»', $utilisateur_annee, $content);
$content = str_replace('«utilisateur_cle»', $utilisateur_cle, $content);
$content = str_replace('«utilisateur_creation_par»', $utilisateur_creation_par, $content);
$content = str_replace('«utilisateur_date_creation»', $utilisateur_date_creation, $content);
$content = str_replace('«utilisateur_date_modification»', $utilisateur_date_modification, $content);
$content = str_replace('«utilisateur_heure_creation»', $utilisateur_heure_creation, $content);
$content = str_replace('«utilisateur_heure_modification»', $utilisateur_heure_modification, $content);
$content = str_replace('«utilisateur_idutilisateur»', $utilisateur_idutilisateur, $content);
$content = str_replace('«utilisateur_intitule»', $utilisateur_intitule, $content);
$content = str_replace('«utilisateur_modification_par»', $utilisateur_modification_par, $content);

$content = str_replace('«satisfaction_date_preparation»', $satisfaction_date_preparation, $content);
// fournisseur
$content = str_replace('«fournisseur_annee»', $fournisseur_annee, $content);
$content = str_replace('«fournisseur_cle»', $fournisseur_cle, $content);
$content = str_replace('«fournisseur_creation_par»', $fournisseur_creation_par, $content);
$content = str_replace('«fournisseur_date_creation»', $fournisseur_date_creation, $content);
$content = str_replace('«fournisseur_date_modification»', $fournisseur_date_modification, $content);
$content = str_replace('«fournisseur_heure_creation»', $fournisseur_heure_creation, $content);
$content = str_replace('«fournisseur_heure_modification»', $fournisseur_heure_modification, $content);
$content = str_replace('«fournisseur_idfournisseur»', $fournisseur_idfournisseur, $content);
$content = str_replace('«fournisseur_intitule»', $fournisseur_intitule, $content);
$content = str_replace('«fournisseur_modification_par»', $fournisseur_modification_par, $content);
// projet
$content = str_replace('«projet_annee»', $projet_annee, $content);
$content = str_replace('«projet_cle»', $projet_cle, $content);
$content = str_replace('«projet_creation_par»', $projet_creation_par, $content);
$content = str_replace('«projet_date_creation»', $projet_date_creation, $content);
$content = str_replace('«projet_date_modification»', $projet_date_modification, $content);
$content = str_replace('«projet_heure_creation»', $projet_heure_creation, $content);
$content = str_replace('«projet_heure_modification»', $projet_heure_modification, $content);
$content = str_replace('«projet_idprojet»', $projet_idprojet, $content);
$content = str_replace('«projet_intitule»', $projet_intitule, $content);
$content = str_replace('«projet_modification_par»', $projet_modification_par, $content);
// utilisateur
$content = str_replace('«utilisateur_annee»', $utilisateur_annee, $content);
$content = str_replace('«utilisateur_cle»', $utilisateur_cle, $content);
$content = str_replace('«utilisateur_creation_par»', $utilisateur_creation_par, $content);
$content = str_replace('«utilisateur_date_creation»', $utilisateur_date_creation, $content);
$content = str_replace('«utilisateur_date_modification»', $utilisateur_date_modification, $content);
$content = str_replace('«utilisateur_heure_creation»', $utilisateur_heure_creation, $content);
$content = str_replace('«utilisateur_heure_modification»', $utilisateur_heure_modification, $content);
$content = str_replace('«utilisateur_idutilisateur»', $utilisateur_idutilisateur, $content);
$content = str_replace('«utilisateur_intitule»', $utilisateur_intitule, $content);
$content = str_replace('«utilisateur_modification_par»', $utilisateur_modification_par, $content);

$content = str_replace('«satisfaction_eval_realisation»', $satisfaction_eval_realisation, $content);
// fournisseur
$content = str_replace('«fournisseur_annee»', $fournisseur_annee, $content);
$content = str_replace('«fournisseur_cle»', $fournisseur_cle, $content);
$content = str_replace('«fournisseur_creation_par»', $fournisseur_creation_par, $content);
$content = str_replace('«fournisseur_date_creation»', $fournisseur_date_creation, $content);
$content = str_replace('«fournisseur_date_modification»', $fournisseur_date_modification, $content);
$content = str_replace('«fournisseur_heure_creation»', $fournisseur_heure_creation, $content);
$content = str_replace('«fournisseur_heure_modification»', $fournisseur_heure_modification, $content);
$content = str_replace('«fournisseur_idfournisseur»', $fournisseur_idfournisseur, $content);
$content = str_replace('«fournisseur_intitule»', $fournisseur_intitule, $content);
$content = str_replace('«fournisseur_modification_par»', $fournisseur_modification_par, $content);
// projet
$content = str_replace('«projet_annee»', $projet_annee, $content);
$content = str_replace('«projet_cle»', $projet_cle, $content);
$content = str_replace('«projet_creation_par»', $projet_creation_par, $content);
$content = str_replace('«projet_date_creation»', $projet_date_creation, $content);
$content = str_replace('«projet_date_modification»', $projet_date_modification, $content);
$content = str_replace('«projet_heure_creation»', $projet_heure_creation, $content);
$content = str_replace('«projet_heure_modification»', $projet_heure_modification, $content);
$content = str_replace('«projet_idprojet»', $projet_idprojet, $content);
$content = str_replace('«projet_intitule»', $projet_intitule, $content);
$content = str_replace('«projet_modification_par»', $projet_modification_par, $content);
// utilisateur
$content = str_replace('«utilisateur_annee»', $utilisateur_annee, $content);
$content = str_replace('«utilisateur_cle»', $utilisateur_cle, $content);
$content = str_replace('«utilisateur_creation_par»', $utilisateur_creation_par, $content);
$content = str_replace('«utilisateur_date_creation»', $utilisateur_date_creation, $content);
$content = str_replace('«utilisateur_date_modification»', $utilisateur_date_modification, $content);
$content = str_replace('«utilisateur_heure_creation»', $utilisateur_heure_creation, $content);
$content = str_replace('«utilisateur_heure_modification»', $utilisateur_heure_modification, $content);
$content = str_replace('«utilisateur_idutilisateur»', $utilisateur_idutilisateur, $content);
$content = str_replace('«utilisateur_intitule»', $utilisateur_intitule, $content);
$content = str_replace('«utilisateur_modification_par»', $utilisateur_modification_par, $content);

$content = str_replace('«satisfaction_liste_preparation»', $satisfaction_liste_preparation, $content);
// fournisseur
$content = str_replace('«fournisseur_annee»', $fournisseur_annee, $content);
$content = str_replace('«fournisseur_cle»', $fournisseur_cle, $content);
$content = str_replace('«fournisseur_creation_par»', $fournisseur_creation_par, $content);
$content = str_replace('«fournisseur_date_creation»', $fournisseur_date_creation, $content);
$content = str_replace('«fournisseur_date_modification»', $fournisseur_date_modification, $content);
$content = str_replace('«fournisseur_heure_creation»', $fournisseur_heure_creation, $content);
$content = str_replace('«fournisseur_heure_modification»', $fournisseur_heure_modification, $content);
$content = str_replace('«fournisseur_idfournisseur»', $fournisseur_idfournisseur, $content);
$content = str_replace('«fournisseur_intitule»', $fournisseur_intitule, $content);
$content = str_replace('«fournisseur_modification_par»', $fournisseur_modification_par, $content);
// projet
$content = str_replace('«projet_annee»', $projet_annee, $content);
$content = str_replace('«projet_cle»', $projet_cle, $content);
$content = str_replace('«projet_creation_par»', $projet_creation_par, $content);
$content = str_replace('«projet_date_creation»', $projet_date_creation, $content);
$content = str_replace('«projet_date_modification»', $projet_date_modification, $content);
$content = str_replace('«projet_heure_creation»', $projet_heure_creation, $content);
$content = str_replace('«projet_heure_modification»', $projet_heure_modification, $content);
$content = str_replace('«projet_idprojet»', $projet_idprojet, $content);
$content = str_replace('«projet_intitule»', $projet_intitule, $content);
$content = str_replace('«projet_modification_par»', $projet_modification_par, $content);
// utilisateur
$content = str_replace('«utilisateur_annee»', $utilisateur_annee, $content);
$content = str_replace('«utilisateur_cle»', $utilisateur_cle, $content);
$content = str_replace('«utilisateur_creation_par»', $utilisateur_creation_par, $content);
$content = str_replace('«utilisateur_date_creation»', $utilisateur_date_creation, $content);
$content = str_replace('«utilisateur_date_modification»', $utilisateur_date_modification, $content);
$content = str_replace('«utilisateur_heure_creation»', $utilisateur_heure_creation, $content);
$content = str_replace('«utilisateur_heure_modification»', $utilisateur_heure_modification, $content);
$content = str_replace('«utilisateur_idutilisateur»', $utilisateur_idutilisateur, $content);
$content = str_replace('«utilisateur_intitule»', $utilisateur_intitule, $content);
$content = str_replace('«utilisateur_modification_par»', $utilisateur_modification_par, $content);

$content = str_replace('«satisfaction_date_realisation»', $satisfaction_date_realisation, $content);
// fournisseur
$content = str_replace('«fournisseur_annee»', $fournisseur_annee, $content);
$content = str_replace('«fournisseur_cle»', $fournisseur_cle, $content);
$content = str_replace('«fournisseur_creation_par»', $fournisseur_creation_par, $content);
$content = str_replace('«fournisseur_date_creation»', $fournisseur_date_creation, $content);
$content = str_replace('«fournisseur_date_modification»', $fournisseur_date_modification, $content);
$content = str_replace('«fournisseur_heure_creation»', $fournisseur_heure_creation, $content);
$content = str_replace('«fournisseur_heure_modification»', $fournisseur_heure_modification, $content);
$content = str_replace('«fournisseur_idfournisseur»', $fournisseur_idfournisseur, $content);
$content = str_replace('«fournisseur_intitule»', $fournisseur_intitule, $content);
$content = str_replace('«fournisseur_modification_par»', $fournisseur_modification_par, $content);
// projet
$content = str_replace('«projet_annee»', $projet_annee, $content);
$content = str_replace('«projet_cle»', $projet_cle, $content);
$content = str_replace('«projet_creation_par»', $projet_creation_par, $content);
$content = str_replace('«projet_date_creation»', $projet_date_creation, $content);
$content = str_replace('«projet_date_modification»', $projet_date_modification, $content);
$content = str_replace('«projet_heure_creation»', $projet_heure_creation, $content);
$content = str_replace('«projet_heure_modification»', $projet_heure_modification, $content);
$content = str_replace('«projet_idprojet»', $projet_idprojet, $content);
$content = str_replace('«projet_intitule»', $projet_intitule, $content);
$content = str_replace('«projet_modification_par»', $projet_modification_par, $content);
// utilisateur
$content = str_replace('«utilisateur_annee»', $utilisateur_annee, $content);
$content = str_replace('«utilisateur_cle»', $utilisateur_cle, $content);
$content = str_replace('«utilisateur_creation_par»', $utilisateur_creation_par, $content);
$content = str_replace('«utilisateur_date_creation»', $utilisateur_date_creation, $content);
$content = str_replace('«utilisateur_date_modification»', $utilisateur_date_modification, $content);
$content = str_replace('«utilisateur_heure_creation»', $utilisateur_heure_creation, $content);
$content = str_replace('«utilisateur_heure_modification»', $utilisateur_heure_modification, $content);
$content = str_replace('«utilisateur_idutilisateur»', $utilisateur_idutilisateur, $content);
$content = str_replace('«utilisateur_intitule»', $utilisateur_intitule, $content);
$content = str_replace('«utilisateur_modification_par»', $utilisateur_modification_par, $content);

$content = str_replace('«satisfaction_liste_realisation»', $satisfaction_liste_realisation, $content);
// fournisseur
$content = str_replace('«fournisseur_annee»', $fournisseur_annee, $content);
$content = str_replace('«fournisseur_cle»', $fournisseur_cle, $content);
$content = str_replace('«fournisseur_creation_par»', $fournisseur_creation_par, $content);
$content = str_replace('«fournisseur_date_creation»', $fournisseur_date_creation, $content);
$content = str_replace('«fournisseur_date_modification»', $fournisseur_date_modification, $content);
$content = str_replace('«fournisseur_heure_creation»', $fournisseur_heure_creation, $content);
$content = str_replace('«fournisseur_heure_modification»', $fournisseur_heure_modification, $content);
$content = str_replace('«fournisseur_idfournisseur»', $fournisseur_idfournisseur, $content);
$content = str_replace('«fournisseur_intitule»', $fournisseur_intitule, $content);
$content = str_replace('«fournisseur_modification_par»', $fournisseur_modification_par, $content);
// projet
$content = str_replace('«projet_annee»', $projet_annee, $content);
$content = str_replace('«projet_cle»', $projet_cle, $content);
$content = str_replace('«projet_creation_par»', $projet_creation_par, $content);
$content = str_replace('«projet_date_creation»', $projet_date_creation, $content);
$content = str_replace('«projet_date_modification»', $projet_date_modification, $content);
$content = str_replace('«projet_heure_creation»', $projet_heure_creation, $content);
$content = str_replace('«projet_heure_modification»', $projet_heure_modification, $content);
$content = str_replace('«projet_idprojet»', $projet_idprojet, $content);
$content = str_replace('«projet_intitule»', $projet_intitule, $content);
$content = str_replace('«projet_modification_par»', $projet_modification_par, $content);
// utilisateur
$content = str_replace('«utilisateur_annee»', $utilisateur_annee, $content);
$content = str_replace('«utilisateur_cle»', $utilisateur_cle, $content);
$content = str_replace('«utilisateur_creation_par»', $utilisateur_creation_par, $content);
$content = str_replace('«utilisateur_date_creation»', $utilisateur_date_creation, $content);
$content = str_replace('«utilisateur_date_modification»', $utilisateur_date_modification, $content);
$content = str_replace('«utilisateur_heure_creation»', $utilisateur_heure_creation, $content);
$content = str_replace('«utilisateur_heure_modification»', $utilisateur_heure_modification, $content);
$content = str_replace('«utilisateur_idutilisateur»', $utilisateur_idutilisateur, $content);
$content = str_replace('«utilisateur_intitule»', $utilisateur_intitule, $content);
$content = str_replace('«utilisateur_modification_par»', $utilisateur_modification_par, $content);

$content = str_replace('«satisfaction_note_preparation»', $satisfaction_note_preparation, $content);
// fournisseur
$content = str_replace('«fournisseur_annee»', $fournisseur_annee, $content);
$content = str_replace('«fournisseur_cle»', $fournisseur_cle, $content);
$content = str_replace('«fournisseur_creation_par»', $fournisseur_creation_par, $content);
$content = str_replace('«fournisseur_date_creation»', $fournisseur_date_creation, $content);
$content = str_replace('«fournisseur_date_modification»', $fournisseur_date_modification, $content);
$content = str_replace('«fournisseur_heure_creation»', $fournisseur_heure_creation, $content);
$content = str_replace('«fournisseur_heure_modification»', $fournisseur_heure_modification, $content);
$content = str_replace('«fournisseur_idfournisseur»', $fournisseur_idfournisseur, $content);
$content = str_replace('«fournisseur_intitule»', $fournisseur_intitule, $content);
$content = str_replace('«fournisseur_modification_par»', $fournisseur_modification_par, $content);
// projet
$content = str_replace('«projet_annee»', $projet_annee, $content);
$content = str_replace('«projet_cle»', $projet_cle, $content);
$content = str_replace('«projet_creation_par»', $projet_creation_par, $content);
$content = str_replace('«projet_date_creation»', $projet_date_creation, $content);
$content = str_replace('«projet_date_modification»', $projet_date_modification, $content);
$content = str_replace('«projet_heure_creation»', $projet_heure_creation, $content);
$content = str_replace('«projet_heure_modification»', $projet_heure_modification, $content);
$content = str_replace('«projet_idprojet»', $projet_idprojet, $content);
$content = str_replace('«projet_intitule»', $projet_intitule, $content);
$content = str_replace('«projet_modification_par»', $projet_modification_par, $content);
// utilisateur
$content = str_replace('«utilisateur_annee»', $utilisateur_annee, $content);
$content = str_replace('«utilisateur_cle»', $utilisateur_cle, $content);
$content = str_replace('«utilisateur_creation_par»', $utilisateur_creation_par, $content);
$content = str_replace('«utilisateur_date_creation»', $utilisateur_date_creation, $content);
$content = str_replace('«utilisateur_date_modification»', $utilisateur_date_modification, $content);
$content = str_replace('«utilisateur_heure_creation»', $utilisateur_heure_creation, $content);
$content = str_replace('«utilisateur_heure_modification»', $utilisateur_heure_modification, $content);
$content = str_replace('«utilisateur_idutilisateur»', $utilisateur_idutilisateur, $content);
$content = str_replace('«utilisateur_intitule»', $utilisateur_intitule, $content);
$content = str_replace('«utilisateur_modification_par»', $utilisateur_modification_par, $content);

$content = str_replace('«satisfaction_note_realisation»', $satisfaction_note_realisation, $content);
// fournisseur
$content = str_replace('«fournisseur_annee»', $fournisseur_annee, $content);
$content = str_replace('«fournisseur_cle»', $fournisseur_cle, $content);
$content = str_replace('«fournisseur_creation_par»', $fournisseur_creation_par, $content);
$content = str_replace('«fournisseur_date_creation»', $fournisseur_date_creation, $content);
$content = str_replace('«fournisseur_date_modification»', $fournisseur_date_modification, $content);
$content = str_replace('«fournisseur_heure_creation»', $fournisseur_heure_creation, $content);
$content = str_replace('«fournisseur_heure_modification»', $fournisseur_heure_modification, $content);
$content = str_replace('«fournisseur_idfournisseur»', $fournisseur_idfournisseur, $content);
$content = str_replace('«fournisseur_intitule»', $fournisseur_intitule, $content);
$content = str_replace('«fournisseur_modification_par»', $fournisseur_modification_par, $content);
// projet
$content = str_replace('«projet_annee»', $projet_annee, $content);
$content = str_replace('«projet_cle»', $projet_cle, $content);
$content = str_replace('«projet_creation_par»', $projet_creation_par, $content);
$content = str_replace('«projet_date_creation»', $projet_date_creation, $content);
$content = str_replace('«projet_date_modification»', $projet_date_modification, $content);
$content = str_replace('«projet_heure_creation»', $projet_heure_creation, $content);
$content = str_replace('«projet_heure_modification»', $projet_heure_modification, $content);
$content = str_replace('«projet_idprojet»', $projet_idprojet, $content);
$content = str_replace('«projet_intitule»', $projet_intitule, $content);
$content = str_replace('«projet_modification_par»', $projet_modification_par, $content);
// utilisateur
$content = str_replace('«utilisateur_annee»', $utilisateur_annee, $content);
$content = str_replace('«utilisateur_cle»', $utilisateur_cle, $content);
$content = str_replace('«utilisateur_creation_par»', $utilisateur_creation_par, $content);
$content = str_replace('«utilisateur_date_creation»', $utilisateur_date_creation, $content);
$content = str_replace('«utilisateur_date_modification»', $utilisateur_date_modification, $content);
$content = str_replace('«utilisateur_heure_creation»', $utilisateur_heure_creation, $content);
$content = str_replace('«utilisateur_heure_modification»', $utilisateur_heure_modification, $content);
$content = str_replace('«utilisateur_idutilisateur»', $utilisateur_idutilisateur, $content);
$content = str_replace('«utilisateur_intitule»', $utilisateur_intitule, $content);
$content = str_replace('«utilisateur_modification_par»', $utilisateur_modification_par, $content);



//print($content);
$modif_content = file_put_contents($destination, $content);
header("Location: $destination");

?>


