<?php
$id = addslashes($_REQUEST['idaction']);
$cle = addslashes($_REQUEST['cle']);

//Connexion à la base de données
include 'cnx.php';

// Requête
if($cle==''){
	$query = "SELECT * from action where idaction = '$id'";
}else{
	$query = "SELECT * from action where cle = '$cle'";
}
$result = mysql_query( $query );

/* print out your own XML */
print "<actionRead>\n";
while( $row = mysql_fetch_object( $result ) )
{
//---------------------------
// Gestion des connexions
//---------------------------

// Connexion_type
//---------------------------
$query_connexion_type = "SELECT cle from action_type where cle='".$row->type."'";
$result_connexion_type = mysql_query( $query_connexion_type );
$row_connexion_type = mysql_fetch_object( $result_connexion_type );
$connexion_type = '';
if (mysql_num_rows($result_connexion_type)>0){
$connexion_type = $row_connexion_type->cle;
}
//---------------------------

// Connexion_societe
//---------------------------
$query_connexion_societe = "SELECT cle from societe where cle='".$row->societe."'";
$result_connexion_societe = mysql_query( $query_connexion_societe );
$row_connexion_societe = mysql_fetch_object( $result_connexion_societe );
$connexion_societe = '';
if (mysql_num_rows($result_connexion_societe)>0){
$connexion_societe = $row_connexion_societe->cle;
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

// Connexion_utilisateur_cc
//---------------------------
$query_connexion_utilisateur_cc = "SELECT cle from utilisateur where cle='".$row->utilisateur_cc."'";
$result_connexion_utilisateur_cc = mysql_query( $query_connexion_utilisateur_cc );
$row_connexion_utilisateur_cc = mysql_fetch_object( $result_connexion_utilisateur_cc );
$connexion_utilisateur_cc = '';
if (mysql_num_rows($result_connexion_utilisateur_cc)>0){
$connexion_utilisateur_cc = $row_connexion_utilisateur_cc->cle;
}
//---------------------------





   print "<item>
	<nom><![CDATA[".$row->nom."]]></nom>
<idaction><![CDATA[".$row->idaction."]]></idaction>
<notes><![CDATA[".$row->notes."]]></notes>
<cle><![CDATA[".$row->cle."]]></cle>
<date_creation><![CDATA[".$row->date_creation."]]></date_creation>
<fichier_joint><![CDATA[".$row->fichier_joint."]]></fichier_joint>
<creation_par><![CDATA[".$row->creation_par."]]></creation_par>
<type><![CDATA[".$connexion_type."]]></type>
<type_cle><![CDATA[".$row->type."]]></type_cle>
<date_modification><![CDATA[".$row->date_modification."]]></date_modification>
<heure_creation><![CDATA[".$row->heure_creation."]]></heure_creation>
<modification_par><![CDATA[".$row->modification_par."]]></modification_par>
<statut><![CDATA[".$row->statut."]]></statut>
<heure_modification><![CDATA[".$row->heure_modification."]]></heure_modification>
<priorite><![CDATA[".$row->priorite."]]></priorite>
<annee><![CDATA[".$row->annee."]]></annee>
<date_fin><![CDATA[".$row->date_fin."]]></date_fin>
<heure_fin><![CDATA[".$row->heure_fin."]]></heure_fin>
<societe><![CDATA[".$connexion_societe."]]></societe>
<societe_cle><![CDATA[".$row->societe."]]></societe_cle>
<projet><![CDATA[".$connexion_projet."]]></projet>
<projet_cle><![CDATA[".$row->projet."]]></projet_cle>
<fournisseur><![CDATA[".$connexion_fournisseur."]]></fournisseur>
<fournisseur_cle><![CDATA[".$row->fournisseur."]]></fournisseur_cle>
<utilisateur><![CDATA[".$connexion_utilisateur."]]></utilisateur>
<utilisateur_cle><![CDATA[".$row->utilisateur."]]></utilisateur_cle>
<utilisateur_cc><![CDATA[".$connexion_utilisateur_cc."]]></utilisateur_cc>
<utilisateur_cc_cle><![CDATA[".$row->utilisateur_cc."]]></utilisateur_cc_cle>
<date_debut><![CDATA[".$row->date_debut."]]></date_debut>
<heure_debut><![CDATA[".$row->heure_debut."]]></heure_debut>
<duree><![CDATA[".$row->duree."]]></duree>

	</item>\n";
}
print "</actionRead>";

?>

