<?php
echo "<?xml version='1.0' encoding='iso-8859-1'?>";
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
$query = "select * from action where idaction='$id'";
//echo $query;
$result = mysql_query( $query );
while( $row = mysql_fetch_object( $result ) ){
	$action_cle = $row->cle;
	$action_idaction = $row->idaction;
	$action_nom = $row->nom;
	$action_notes = $row->notes;
	$action_date_creation = substr($row->date_creation,-2)."/".substr($row->date_creation,-5,2)."/".substr($row->date_creation,-10,4);
	$action_fichier_joint = $row->fichier_joint;
	$action_creation_par = $row->creation_par;
	$action_type = $row->type;
	$action_date_modification = substr($row->date_modification,-2)."/".substr($row->date_modification,-5,2)."/".substr($row->date_modification,-10,4);
	$action_heure_creation = $row->heure_creation;
	$action_modification_par = $row->modification_par;
	$action_date_fin = substr($row->date_fin,-2)."/".substr($row->date_fin,-5,2)."/".substr($row->date_fin,-10,4);
	$action_statut = $row->statut;
	$action_heure_modification = $row->heure_modification;
	$action_heure_fin = $row->heure_fin;
	$action_priorite = $row->priorite;
	$action_annee = $row->annee;
	$action_date_debut = substr($row->date_debut,-2)."/".substr($row->date_debut,-5,2)."/".substr($row->date_debut,-10,4);
	$action_heure_debut = $row->heure_debut;
	$action_duree = $row->duree;
	$action_fournisseur = $row->fournisseur;
	$action_utilisateur = $row->utilisateur;

// fournisseur
 $query = "select * from fournisseur where cle = '$action_fournisseur'";
$result = mysql_query( $query );
$fournisseur_idfournisseur = '';
$fournisseur_nom = '';
$fournisseur_tel = '';
$fournisseur_cle = '';
$fournisseur_fax = '';
$fournisseur_adresse = '';
$fournisseur_date_creation = '';
$fournisseur_creation_par = '';
$fournisseur_email = '';
$fournisseur_adressesuite = '';
$fournisseur_heure_creation = '';
$fournisseur_cp = '';
$fournisseur_siret = '';
$fournisseur_date_modification = '';
$fournisseur_modification_par = '';
$fournisseur_ville = '';
$fournisseur_pays = '';
$fournisseur_compte_tiers = '';
$fournisseur_heure_modification = '';
$fournisseur_tva_intra = '';
$fournisseur_annee = '';
$fournisseur_nouveau = '';
$fournisseur_date_demande_attestation = '';
$fournisseur_date_relance1 = '';
$fournisseur_date_relance2 = '';
$fournisseur_date_reception = '';
$fournisseur_date_renouvellement = '';
$fournisseur_date_document = '';


while( $row = mysql_fetch_object( $result ) ){
$fournisseur_idfournisseur = $row->idfournisseur;
$fournisseur_nom = $row->nom;
$fournisseur_tel = $row->tel;
$fournisseur_cle = $row->cle;
$fournisseur_fax = $row->fax;
$fournisseur_adresse = $row->adresse;
$fournisseur_date_creation = $row->date_creation;
$fournisseur_creation_par = $row->creation_par;
$fournisseur_email = $row->email;
$fournisseur_adressesuite = $row->adressesuite;
$fournisseur_heure_creation = $row->heure_creation;
$fournisseur_cp = $row->cp;
$fournisseur_siret = $row->siret;
$fournisseur_date_modification = $row->date_modification;
$fournisseur_modification_par = $row->modification_par;
$fournisseur_ville = $row->ville;
$fournisseur_pays = $row->pays;
$fournisseur_compte_tiers = $row->compte_tiers;
$fournisseur_heure_modification = $row->heure_modification;
$fournisseur_tva_intra = $row->tva_intra;
$fournisseur_annee = $row->annee;
$fournisseur_nouveau = $row->nouveau;
$fournisseur_date_demande_attestation = $row->date_demande_attestation;
$fournisseur_date_relance1 = $row->date_relance1;
$fournisseur_date_relance2 = $row->date_relance2;
$fournisseur_date_reception = $row->date_reception;
$fournisseur_date_renouvellement = $row->date_renouvellement;
$fournisseur_date_document = $row->date_document;
}

// action_date_demance
 $query = "select date_debut from action where fournisseur = '$fournisseur_cle' and type = 'Demande attestation' order by date_debut desc limit 0,1";

$result = mysql_query( $query );
$action_date_demance_date_debut = '';

	while( $row = mysql_fetch_object( $result ) ){
	$action_date_demance_date_debut = substr($row->date_debut,-2)."/".substr($row->date_debut,5,2)."/".substr($row->date_debut,0,4);
	}

// Action_1ère_relance
 $query_r1 = "select date_debut from action where fournisseur = '$fournisseur_cle' and type like 'Demande attestation 1%' order by date_debut desc limit 0,1";
 
$result_r1 = mysql_query( $query_r1 );
$action_1_relance_date_debut = '';

	while( $row_r1 = mysql_fetch_object( $result_r1 ) ){
	$action_1_relance_date_debut = substr($row_r1->date_debut,-2)."/".substr($row_r1->date_debut,5,2)."/".substr($row_r1->date_debut,0,4);
	}
	
// utilisateur
 $query = "select * from utilisateur where cle = '$action_utilisateur'";
$result = mysql_query( $query );
$utilisateur_idutilisateur = '';
$utilisateur_login = '';
$utilisateur_password = '';
$utilisateur_cle = '';
$utilisateur_profil = '';
$utilisateur_societe = '';
$utilisateur_heure_modification = '';
$utilisateur_heure_creation = '';
$utilisateur_annee = '';
$utilisateur_date_modification = '';
$utilisateur_date_creation = '';
$utilisateur_modification_par = '';
$utilisateur_creation_par = '';
$utilisateur_subordonnes = '';


while( $row = mysql_fetch_object( $result ) ){
$utilisateur_idutilisateur = $row->idutilisateur;
$utilisateur_login = $row->login;
$utilisateur_password = $row->password;
$utilisateur_cle = $row->cle;
$utilisateur_profil = $row->profil;
$utilisateur_societe = $row->societe;
$utilisateur_heure_modification = $row->heure_modification;
$utilisateur_heure_creation = $row->heure_creation;
$utilisateur_annee = $row->annee;
$utilisateur_date_modification = $row->date_modification;
$utilisateur_date_creation = $row->date_creation;
$utilisateur_modification_par = $row->modification_par;
$utilisateur_creation_par = $row->creation_par;
$utilisateur_subordonnes = $row->subordonnes;
}

}

$content = file_get_contents($destination);
$content = str_replace('Â«action_idactionÂ»', $action_idaction, $content);
$content = str_replace('Â«action_nomÂ»', $action_nom, $content);
$content = str_replace('Â«action_notesÂ»', $action_notes, $content);
$content = str_replace('Â«action_cleÂ»', $action_cle, $content);
$content = str_replace('Â«action_date_creationÂ»', $action_date_creation, $content);
$content = str_replace('Â«action_fichier_jointÂ»', $action_fichier_joint, $content);
$content = str_replace('Â«action_creation_parÂ»', $action_creation_par, $content);
$content = str_replace('Â«action_typeÂ»', $action_type, $content);
$content = str_replace('Â«action_date_modificationÂ»', $action_date_modification, $content);
$content = str_replace('Â«action_heure_creationÂ»', $action_heure_creation, $content);
$content = str_replace('Â«action_modification_parÂ»', $action_modification_par, $content);
$content = str_replace('Â«action_date_finÂ»', $action_date_fin, $content);
$content = str_replace('Â«action_statutÂ»', $action_statut, $content);
$content = str_replace('Â«action_heure_modificationÂ»', $action_heure_modification, $content);
$content = str_replace('Â«action_heure_finÂ»', $action_heure_fin, $content);
$content = str_replace('Â«action_prioriteÂ»', $action_priorite, $content);
$content = str_replace('Â«action_anneeÂ»', $action_annee, $content);
$content = str_replace('Â«action_fournisseurÂ»', $action_fournisseur, $content);
$content = str_replace('Â«action_utilisateurÂ»', $action_utilisateur, $content);
$content = str_replace('Â«action_date_debutÂ»', $action_date_debut, $content);
$content = str_replace('Â«action_heure_debutÂ»', $action_heure_debut, $content);
$content = str_replace('Â«action_dureeÂ»', $action_duree, $content);

// fournisseur
$content = str_replace('Â«fournisseur_idfournisseurÂ»', $fournisseur_idfournisseur, $content);
$content = str_replace('Â«fournisseur_nomÂ»', $fournisseur_nom, $content);
$content = str_replace('Â«fournisseur_telÂ»', $fournisseur_tel, $content);
$content = str_replace('Â«fournisseur_cleÂ»', $fournisseur_cle, $content);
$content = str_replace('Â«fournisseur_faxÂ»', $fournisseur_fax, $content);
$content = str_replace('Â«fournisseur_adresseÂ»', $fournisseur_adresse, $content);
$content = str_replace('Â«fournisseur_date_creationÂ»', $fournisseur_date_creation, $content);
$content = str_replace('Â«fournisseur_creation_parÂ»', $fournisseur_creation_par, $content);
$content = str_replace('Â«fournisseur_emailÂ»', $fournisseur_email, $content);
$content = str_replace('Â«fournisseur_adressesuiteÂ»', $fournisseur_adressesuite, $content);
$content = str_replace('Â«fournisseur_heure_creationÂ»', $fournisseur_heure_creation, $content);
$content = str_replace('Â«fournisseur_cpÂ»', $fournisseur_cp, $content);
$content = str_replace('Â«fournisseur_siretÂ»', $fournisseur_siret, $content);
$content = str_replace('Â«fournisseur_date_modificationÂ»', $fournisseur_date_modification, $content);
$content = str_replace('Â«fournisseur_modification_parÂ»', $fournisseur_modification_par, $content);
$content = str_replace('Â«fournisseur_villeÂ»', $fournisseur_ville, $content);
$content = str_replace('Â«fournisseur_paysÂ»', $fournisseur_pays, $content);
$content = str_replace('Â«fournisseur_compte_tiersÂ»', $fournisseur_compte_tiers, $content);
$content = str_replace('Â«fournisseur_heure_modificationÂ»', $fournisseur_heure_modification, $content);
$content = str_replace('Â«fournisseur_tva_intraÂ»', $fournisseur_tva_intra, $content);
$content = str_replace('Â«fournisseur_anneeÂ»', $fournisseur_annee, $content);
$content = str_replace('Â«fournisseur_nouveauÂ»', $fournisseur_nouveau, $content);
$content = str_replace('Â«fournisseur_date_demande_attestationÂ»', $fournisseur_date_demande_attestation, $content);
$content = str_replace('Â«fournisseur_date_relance1Â»', $fournisseur_date_relance1, $content);
$content = str_replace('Â«fournisseur_date_relance2Â»', $fournisseur_date_relance2, $content);
$content = str_replace('Â«fournisseur_date_receptionÂ»', $fournisseur_date_reception, $content);
$content = str_replace('Â«fournisseur_date_renouvellementÂ»', $fournisseur_date_renouvellement, $content);
$content = str_replace('Â«fournisseur_date_documentÂ»', $fournisseur_date_document, $content);

// action_date_demance
$content = str_replace('Â«action_date_demance_date_debutÂ»', $action_date_demance_date_debut, $content);

// Action_1ère_relance
$content = str_replace('Â«action_1_relance_date_debutÂ»', $action_1_relance_date_debut, $content);

// utilisateur
$content = str_replace('Â«utilisateur_idutilisateurÂ»', $utilisateur_idutilisateur, $content);
$content = str_replace('Â«utilisateur_loginÂ»', $utilisateur_login, $content);
$content = str_replace('Â«utilisateur_passwordÂ»', $utilisateur_password, $content);
$content = str_replace('Â«utilisateur_cleÂ»', $utilisateur_cle, $content);
$content = str_replace('Â«utilisateur_profilÂ»', $utilisateur_profil, $content);
$content = str_replace('Â«utilisateur_societeÂ»', $utilisateur_societe, $content);
$content = str_replace('Â«utilisateur_heure_modificationÂ»', $utilisateur_heure_modification, $content);
$content = str_replace('Â«utilisateur_heure_creationÂ»', $utilisateur_heure_creation, $content);
$content = str_replace('Â«utilisateur_anneeÂ»', $utilisateur_annee, $content);
$content = str_replace('Â«utilisateur_date_modificationÂ»', $utilisateur_date_modification, $content);
$content = str_replace('Â«utilisateur_date_creationÂ»', $utilisateur_date_creation, $content);
$content = str_replace('Â«utilisateur_modification_parÂ»', $utilisateur_modification_par, $content);
$content = str_replace('Â«utilisateur_creation_parÂ»', $utilisateur_creation_par, $content);
$content = str_replace('Â«utilisateur_subordonnesÂ»', $utilisateur_subordonnes, $content);

//print($content);
$modif_content = file_put_contents($destination, $content);
header("Location: $destination");

?>