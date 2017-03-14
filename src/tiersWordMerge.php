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
$query = "select * from tiers where idtiers='$id'";
$result = mysql_query( $query );
while( $row = mysql_fetch_object( $result ) ){
	//$contrat_salarie = $row->salarie;
	$tiers_cle = $row->cle;
$tiers_idtiers = $row->idtiers;
$tiers_civilite = $row->civilite;
$tiers_creation_par = $row->creation_par;
$tiers_date_creation = substr($row->date_creation,-2)."/".substr($row->date_creation,-5,2)."/".substr($row->date_creation,-10,4);
$tiers_nom = $row->nom;
$tiers_date_modification = substr($row->date_modification,-2)."/".substr($row->date_modification,-5,2)."/".substr($row->date_modification,-10,4);
$tiers_heure_creation = $row->heure_creation;
$tiers_modification_par = $row->modification_par;
$tiers_prenom = $row->prenom;
$tiers_heure_modification = $row->heure_modification;
$tiers_societe = $row->societe;
$tiers_service = $row->service;
$tiers_annee = $row->annee;
$tiers_adresse = $row->adresse;
$tiers_adresse2 = $row->adresse2;
$tiers_cp = $row->cp;
$tiers_ville = $row->ville;
$tiers_tel = $row->tel;
$tiers_compte_tiers = $row->compte_tiers;
$tiers_fax = $row->fax;
$tiers_tva_intra = $row->tva_intra;
$tiers_email = $row->email;
$tiers_siret = $row->siret;
$tiers_pays = $row->pays;
$tiers_nouveau = $row->nouveau;

	// pays
 $query = "select  from pays where pays.cle ='$tiers_cle'";
$result = mysql_query( $query );
while( $row = mysql_fetch_object( $result ) ){

}

}

$content = file_get_contents($destination);
//$content = str_replace('«contrat_salarie»', $contrat_salarie, $content);
$content = str_replace('«tiers_cle»', $tiers_cle, $content);

$content = str_replace('«tiers_idtiers»', $tiers_idtiers, $content);

$content = str_replace('«tiers_civilite»', $tiers_civilite, $content);

$content = str_replace('«tiers_creation_par»', $tiers_creation_par, $content);

$content = str_replace('«tiers_date_creation»', $tiers_date_creation, $content);

$content = str_replace('«tiers_nom»', $tiers_nom, $content);

$content = str_replace('«tiers_date_modification»', $tiers_date_modification, $content);

$content = str_replace('«tiers_heure_creation»', $tiers_heure_creation, $content);

$content = str_replace('«tiers_modification_par»', $tiers_modification_par, $content);

$content = str_replace('«tiers_prenom»', $tiers_prenom, $content);

$content = str_replace('«tiers_heure_modification»', $tiers_heure_modification, $content);

$content = str_replace('«tiers_societe»', $tiers_societe, $content);

$content = str_replace('«tiers_service»', $tiers_service, $content);

$content = str_replace('«tiers_annee»', $tiers_annee, $content);

$content = str_replace('«tiers_adresse»', $tiers_adresse, $content);

$content = str_replace('«tiers_adresse2»', $tiers_adresse2, $content);

$content = str_replace('«tiers_cp»', $tiers_cp, $content);

$content = str_replace('«tiers_ville»', $tiers_ville, $content);

$content = str_replace('«tiers_tel»', $tiers_tel, $content);

$content = str_replace('«tiers_compte_tiers»', $tiers_compte_tiers, $content);

$content = str_replace('«tiers_fax»', $tiers_fax, $content);

$content = str_replace('«tiers_tva_intra»', $tiers_tva_intra, $content);

$content = str_replace('«tiers_email»', $tiers_email, $content);

$content = str_replace('«tiers_siret»', $tiers_siret, $content);

$content = str_replace('«tiers_pays»', $tiers_pays, $content);
// pays

$content = str_replace('«tiers_nouveau»', $tiers_nouveau, $content);
// pays



//print($content);
$modif_content = file_put_contents($destination, $content);
header("Location: $destination");

?>


