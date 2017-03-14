<?php
echo "<?xml version='1.0' encoding='UTF-8'?>";
$id = $_REQUEST['id'];
$file = $_REQUEST['file'];

//Connexion � la base de donnees
include 'cnx.php';

mysql_query("SET NAMES 'utf8'");

// Mod�le Word
$source = 'files/modele_lettre/'.$file;
$destination = 'files/modele_lettre/merged/'.$file.'_'.$id.'_'.date('YmdHHis').'.doc';

// Copie du fichier
copy($source, $destination);

// Requete
$query = "select * from fournisseur_attestation where idfournisseur_attestation='$id'";
$result = mysql_query( $query );
while( $row = mysql_fetch_object( $result ) ){
	$fournisseur_attestation_fournisseur = $row->fournisseur;
$fournisseur_attestation_cle = $row->cle;
$fournisseur_attestation_date_attestation = substr($row->date_attestation,-2)."/".substr($row->date_attestation,-5,2)."/".substr($row->date_attestation,-10,4);
$fournisseur_attestation_date_document = substr($row->date_document,-2)."/".substr($row->date_document,-5,2)."/".substr($row->date_document,-10,4);
$fournisseur_attestation_idfournisseur_attestation = $row->idfournisseur_attestation;
$fournisseur_attestation_note = $row->note;
$fournisseur_attestation_creation_par = $row->creation_par;
$fournisseur_attestation_pj_kbis = $row->pj_kbis;
$fournisseur_attestation_modification_par = $row->modification_par;
$fournisseur_attestation_pj_urssaf_rsi = $row->pj_urssaf_rsi;
$fournisseur_attestation_date_creation = substr($row->date_creation,-2)."/".substr($row->date_creation,-5,2)."/".substr($row->date_creation,-10,4);
$fournisseur_attestation_pj_autre = $row->pj_autre;
$fournisseur_attestation_date_modification = substr($row->date_modification,-2)."/".substr($row->date_modification,-5,2)."/".substr($row->date_modification,-10,4);
$fournisseur_attestation_heure_creation = $row->heure_creation;
$fournisseur_attestation_heure_modification = $row->heure_modification;
$fournisseur_attestation_annee = $row->annee;

	// fournisseur
 $query = "select * from fournisseur where cle = '$fournisseur_attestation_fournisseur'";
$result = mysql_query( $query );

while( $row = mysql_fetch_object( $result ) ){

}

}

$content = file_get_contents($destination);
//$content = str_replace('�contrat_salarie�', $contrat_salarie, $content);
$content = str_replace('«fournisseur_attestation_fournisseur»', $fournisseur_attestation_fournisseur, $content);
$content = str_replace('«fournisseur_attestation_cle»', $fournisseur_attestation_cle, $content);
$content = str_replace('«fournisseur_attestation_date_attestation»', $fournisseur_attestation_date_attestation, $content);
$content = str_replace('«fournisseur_attestation_date_document»', $fournisseur_attestation_date_document, $content);
$content = str_replace('«fournisseur_attestation_idfournisseur_attestation»', $fournisseur_attestation_idfournisseur_attestation, $content);
$content = str_replace('«fournisseur_attestation_note»', $fournisseur_attestation_note, $content);
$content = str_replace('«fournisseur_attestation_creation_par»', $fournisseur_attestation_creation_par, $content);
$content = str_replace('«fournisseur_attestation_pj_kbis»', $fournisseur_attestation_pj_kbis, $content);
$content = str_replace('«fournisseur_attestation_modification_par»', $fournisseur_attestation_modification_par, $content);
$content = str_replace('«fournisseur_attestation_pj_urssaf_rsi»', $fournisseur_attestation_pj_urssaf_rsi, $content);
$content = str_replace('«fournisseur_attestation_date_creation»', $fournisseur_attestation_date_creation, $content);
$content = str_replace('«fournisseur_attestation_pj_autre»', $fournisseur_attestation_pj_autre, $content);
$content = str_replace('«fournisseur_attestation_date_modification»', $fournisseur_attestation_date_modification, $content);
$content = str_replace('«fournisseur_attestation_heure_creation»', $fournisseur_attestation_heure_creation, $content);
$content = str_replace('«fournisseur_attestation_heure_modification»', $fournisseur_attestation_heure_modification, $content);
$content = str_replace('«fournisseur_attestation_annee»', $fournisseur_attestation_annee, $content);

// fournisseur



//print($content);
$modif_content = file_put_contents($destination, $content);
header("Location: $destination");

?>


