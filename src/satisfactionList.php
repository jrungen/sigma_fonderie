<?php
header("Content-Type:text/html; charset=iso-8859-15");
$textsearch = addslashes($_REQUEST['search']);
$field = addslashes($_REQUEST['field']);
$view = addslashes($_REQUEST['view']);
$user = addslashes($_REQUEST['user']);
if($view=='') $view='Par défaut';
$group = addslashes($_REQUEST['group']);
$search='';
if($_REQUEST['sql']!='') $search = ' and '.urldecode($_REQUEST['sql']);






if ($field=='Tous'){
	if ($textsearch!='') $search.=" and (cle like '%$textsearch%' OR idsatisfaction like '%$textsearch%' OR fournisseur like '%$textsearch%' OR projet like '%$textsearch%' OR utilisateur like '%$textsearch%' OR ca_ht like '%$textsearch%' OR eval_preparation like '%$textsearch%' OR date_preparation like '%$textsearch%' OR eval_realisation like '%$textsearch%' OR liste_preparation like '%$textsearch%' OR date_realisation like '%$textsearch%' OR liste_realisation like '%$textsearch%' ) ";
}else{
	if ($textsearch!='') $search.=" and $field like '%$textsearch%' ";
}

//Connexion à la base de données
include 'cnx.php';

// Appliquer les permissions
$array_group = explode(', ',$group);
$value_group = "";
$lecture="";
foreach ($array_group as $value) {
	$query_permission = "SELECT * from permission where categorie='satisfaction'";
	$result_permission = mysql_query( $query_permission );
	echo 'PERMISSION = '.$value.' / ';
	while( $row_permission = mysql_fetch_object( $result_permission ) ){
		// Visualisation
		$visualisation = explode(', ',$row_permission->visualisation);
		$visualisation_selective = explode(', ',$row_permission->visualisation_selective);
		$champ = $row_permission->champ;
		$champ_utilisateur = $row_permission->champ_utilisateur;
		
		//On recherche le group dans la permission lecture
		if (in_array($value, $visualisation)){
			print "$value trouve dans visualisation / " ; 
			$lecture= 'LECTURE';
		}else{
			// Vérif dans visualisation selective
			if (in_array($value, $visualisation_selective)){
				// Si le groupe est en visualisation sélective alors afficher que les données du groupe (tous les utilisateurs du groupe)
				print "$value trouve dans visualisation sélective / " ;
				
				// Rechercher tous les utilisateurs du groupe
				$query_user = "SELECT * from utilisateur where cle='$user'";
				$result_user = mysql_query( $query_user );
				while( $row_user = mysql_fetch_object( $result_user ) ){
					$value_champ_utilisateur = $row_user->$champ_utilisateur;
					$array_value_champ_utilisateur = explode(', ',$value_champ_utilisateur);
					foreach ($array_value_champ_utilisateur as $user_value) {
						$value_group .= "$champ = '$user_value' OR ";
					}
				}
		
			}else{
				// Aucune permission
				print "$value NO PERMISSION / " ; 
				$value_group .= "$champ like 'NO PERMISSION' OR ";
			}
		}
		// Suppression
	}
}

$value_group = substr($value_group,0,strlen($value_group)-4);
if($lecture!='LECTURE'){
	if($value_group!='') $search .= " AND ($value_group)";
}

// Requete dans les vues
$query_vue = "SELECT clause from vue where categorie='satisfaction' and intitule='$view'";
$result_vue = mysql_query( $query_vue );
while( $row_vue = mysql_fetch_object( $result_vue ) ){
	$search.= str_replace('(-me-)',$user,$row_vue->clause);
}

// Requête
$query = "SELECT cle, idsatisfaction, fournisseur, projet, utilisateur, ca_ht, eval_preparation, date_preparation, eval_realisation, liste_preparation, date_realisation, liste_realisation from satisfaction where 1 ".$search;
$result = mysql_query( $query );

print "<satisfactionList>\n";
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
<fournisseur><![CDATA[".$connexion_fournisseur."]]></fournisseur>
<projet><![CDATA[".$connexion_projet."]]></projet>
<utilisateur><![CDATA[".$connexion_utilisateur."]]></utilisateur>
<ca_ht><![CDATA[".$row->ca_ht."]]></ca_ht>
<eval_preparation><![CDATA[".$connexion_eval_preparation."]]></eval_preparation>
<date_preparation><![CDATA[".$row->date_preparation."]]></date_preparation>
<eval_realisation><![CDATA[".$connexion_eval_realisation."]]></eval_realisation>
<liste_preparation><![CDATA[".$row->liste_preparation."]]></liste_preparation>
<date_realisation><![CDATA[".$row->date_realisation."]]></date_realisation>
<liste_realisation><![CDATA[".$row->liste_realisation."]]></liste_realisation>

</item>\n";
}
print "</satisfactionList>"; 
?>

