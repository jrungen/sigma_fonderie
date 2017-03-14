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
	if ($textsearch!='') $search.=" and (cle like '%$textsearch%' OR idtiers like '%$textsearch%' OR civilite like '%$textsearch%' OR nom like '%$textsearch%' OR prenom like '%$textsearch%' OR societe like '%$textsearch%' OR service like '%$textsearch%' OR email like '%$textsearch%' ) ";
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
	$query_permission = "SELECT * from permission where categorie='tiers'";
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
$query_vue = "SELECT clause from vue where categorie='tiers' and intitule='$view'";
$result_vue = mysql_query( $query_vue );
while( $row_vue = mysql_fetch_object( $result_vue ) ){
	$search.= str_replace('(-me-)',$user,$row_vue->clause);
}

// Requête
$query = "SELECT cle, idtiers, civilite, nom, prenom, societe, service, email from tiers where 1 ".$search;
$result = mysql_query( $query );

print "<tiersList>\n";
while( $row = mysql_fetch_object( $result ) )
{
//---------------------------
// Gestion des connexions
//---------------------------


print "<item>
<cle><![CDATA[".$row->cle."]]></cle>
<idtiers><![CDATA[".$row->idtiers."]]></idtiers>
<civilite><![CDATA[".$row->civilite."]]></civilite>
<nom><![CDATA[".$row->nom."]]></nom>
<prenom><![CDATA[".$row->prenom."]]></prenom>
<societe><![CDATA[".$row->societe."]]></societe>
<service><![CDATA[".$row->service."]]></service>
<email><![CDATA[".$row->email."]]></email>

</item>\n";
}
print "</tiersList>"; 
?>

