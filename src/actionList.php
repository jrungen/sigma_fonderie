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

$s_priorite = $_REQUEST['priorite'];
$s_statut = $_REQUEST['statut'];


if ($s_priorite!='') $search.="and priorite = '".$s_priorite."' ";if ($s_statut!='') $search.="and statut = '".$s_statut."' ";


if ($field=='Tous'){
	if ($textsearch!='') $search.=" and (nom like '%$textsearch%' OR idaction like '%$textsearch%' OR cle like '%$textsearch%' OR type like '%$textsearch%' OR statut like '%$textsearch%' OR date_fin like '%$textsearch%' OR societe like '%$textsearch%' OR utilisateur like '%$textsearch%' OR date_debut like '%$textsearch%' OR duree like '%$textsearch%' ) ";
}else{
	if ($textsearch!='') $search.=" and $field like '%$textsearch%' ";
}

//Connexion à la base de données
include 'cnx.php';

// Requete dans les vues
$query_vue = "SELECT clause from vue where categorie='action' and intitule='$view'";
$result_vue = mysql_query( $query_vue );
while( $row_vue = mysql_fetch_object( $result_vue ) ){
	$search.= str_replace('(-me-)',$user,$row_vue->clause);
}

// Appliquer les permissions
$array_group = explode(', ',$group);
$value_group = "";
$lecture="";
foreach ($array_group as $value) {
	$query_permission = "SELECT * from permission where categorie='action'";
	$result_permission = mysql_query( $query_permission );
	echo 'PERMISSION = '.$value.' / ';
	while( $row_permission = mysql_fetch_object( $result_permission ) ){
		// Visualisation
		$visualisation = explode(', ',$row_permission->visualisation);
		$visualisation_selective = explode(', ',$row_permission->visualisation_selective);
		$champ = $row_permission->champ;
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
				$query_group_user = "SELECT * from utilisateur where groupe='$value'";
				$result_group_user = mysql_query( $query_group_user );
				while( $row_group_user = mysql_fetch_object( $result_group_user ) ){
					$value_group .= "$champ like '%".$row_group_user->cle."%' OR ";
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


// Requête
$query = "SELECT nom, idaction, cle, type, statut, date_fin, societe, utilisateur, date_debut, duree from action where 1 ".$search;
$result = mysql_query( $query );

print "<actionList>\n";
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



print "<item>
<nom><![CDATA[".$row->nom."]]></nom>
<idaction><![CDATA[".$row->idaction."]]></idaction>
<cle><![CDATA[".$row->cle."]]></cle>
<type><![CDATA[".$connexion_type."]]></type>
<statut><![CDATA[".$row->statut."]]></statut>
<date_fin><![CDATA[".$row->date_fin."]]></date_fin>
<societe><![CDATA[".$connexion_societe."]]></societe>
<utilisateur><![CDATA[".$connexion_utilisateur."]]></utilisateur>
<date_debut><![CDATA[".$row->date_debut."]]></date_debut>
<duree><![CDATA[".$row->duree."]]></duree>

</item>\n";
}
print "</actionList>"; 
?>

