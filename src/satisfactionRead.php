<?php
$id = addslashes($_REQUEST['idsatisfaction']);
$cle = addslashes($_REQUEST['cle']);

//Connexion à la base de données
include 'cnx.php';

// Requête
if($cle==''){
	$query = "SELECT * from satisfaction where idsatisfaction = '$id'";
}else{
	$query = "SELECT * from satisfaction where cle = '$cle'";
}
$result = mysql_query( $query );

/* print out your own XML */
print "<satisfactionRead>\n";
while( $row = mysql_fetch_object( $result ) )
{
//---------------------------
// Gestion des connexions
//---------------------------

// Connexion_fournisseur
//---------------------------
$query_connexion_fournisseur = "SELECT cle from fournisseur where cle='".$row->fournisseur."'";
$result_connexion_fournisseur = mysql_query( $query_connexion_fournisseur );
$row_connexion_fournisseur = mysql_fetch_object( $result_connexion_fournisseur );
$connexion_fournisseur = '';
if (mysql_num_rows($result_connexion_fournisseur)>0){
$connexion_fournisseur = $row_connexion_fournisseur->cle;
}
//---------------------------

// Connexion_projet
//---------------------------
$query_connexion_projet = "SELECT cle from projet where cle='".$row->projet."'";
$result_connexion_projet = mysql_query( $query_connexion_projet );
$row_connexion_projet = mysql_fetch_object( $result_connexion_projet );
$connexion_projet = '';
if (mysql_num_rows($result_connexion_projet)>0){
$connexion_projet = $row_connexion_projet->cle;
}
//---------------------------

// Connexion_utilisateur
//---------------------------
$query_connexion_utilisateur = "SELECT cle from utilisateur where cle='".$row->utilisateur."'";
$result_connexion_utilisateur = mysql_query( $query_connexion_utilisateur );
$row_connexion_utilisateur = mysql_fetch_object( $result_connexion_utilisateur );
$connexion_utilisateur = '';
if (mysql_num_rows($result_connexion_utilisateur)>0){
$connexion_utilisateur = $row_connexion_utilisateur->cle;
}
//---------------------------

// Connexion_eval_preparation
//---------------------------
$query_connexion_eval_preparation = "SELECT cle from utilisateur where cle='".$row->eval_preparation."'";
$result_connexion_eval_preparation = mysql_query( $query_connexion_eval_preparation );
$row_connexion_eval_preparation = mysql_fetch_object( $result_connexion_eval_preparation );
$connexion_eval_preparation = '';
if (mysql_num_rows($result_connexion_eval_preparation)>0){
$connexion_eval_preparation = $row_connexion_eval_preparation->cle;
}
//---------------------------

// Connexion_eval_realisation
//---------------------------
$query_connexion_eval_realisation = "SELECT cle from utilisateur where cle='".$row->eval_realisation."'";
$result_connexion_eval_realisation = mysql_query( $query_connexion_eval_realisation );
$row_connexion_eval_realisation = mysql_fetch_object( $result_connexion_eval_realisation );
$connexion_eval_realisation = '';
if (mysql_num_rows($result_connexion_eval_realisation)>0){
$connexion_eval_realisation = $row_connexion_eval_realisation->cle;
}
//---------------------------





   print "<item>
	<cle><![CDATA[".$row->cle."]]></cle>
<idsatisfaction><![CDATA[".$row->idsatisfaction."]]></idsatisfaction>
<creation_par><![CDATA[".$row->creation_par."]]></creation_par>
<date_creation><![CDATA[".$row->date_creation."]]></date_creation>
<date_modification><![CDATA[".$row->date_modification."]]></date_modification>
<modification_par><![CDATA[".$row->modification_par."]]></modification_par>
<heure_creation><![CDATA[".$row->heure_creation."]]></heure_creation>
<heure_modification><![CDATA[".$row->heure_modification."]]></heure_modification>
<annee><![CDATA[".$row->annee."]]></annee>
<fournisseur><![CDATA[".$connexion_fournisseur."]]></fournisseur>
<fournisseur_cle><![CDATA[".$row->fournisseur."]]></fournisseur_cle>
<projet><![CDATA[".$connexion_projet."]]></projet>
<projet_cle><![CDATA[".$row->projet."]]></projet_cle>
<utilisateur><![CDATA[".$connexion_utilisateur."]]></utilisateur>
<utilisateur_cle><![CDATA[".$row->utilisateur."]]></utilisateur_cle>
<ca_ht><![CDATA[".$row->ca_ht."]]></ca_ht>
<eval_preparation><![CDATA[".$connexion_eval_preparation."]]></eval_preparation>
<eval_preparation_cle><![CDATA[".$row->eval_preparation."]]></eval_preparation_cle>
<date_preparation><![CDATA[".$row->date_preparation."]]></date_preparation>
<eval_realisation><![CDATA[".$connexion_eval_realisation."]]></eval_realisation>
<eval_realisation_cle><![CDATA[".$row->eval_realisation."]]></eval_realisation_cle>
<liste_preparation><![CDATA[".$row->liste_preparation."]]></liste_preparation>
<date_realisation><![CDATA[".$row->date_realisation."]]></date_realisation>
<liste_realisation><![CDATA[".$row->liste_realisation."]]></liste_realisation>
<note_preparation><![CDATA[".$row->note_preparation."]]></note_preparation>
<note_realisation><![CDATA[".$row->note_realisation."]]></note_realisation>

	</item>\n";
}
print "</satisfactionRead>";

?>

