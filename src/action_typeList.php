<?php
header("Content-Type:text/html; charset=iso-8859-15");
$textsearch = addslashes($_REQUEST['search']);
$field = addslashes($_REQUEST['field']);
$view = addslashes($_REQUEST['view']);
$user = addslashes($_REQUEST['user']);
if($view=='') $view='Par défaut';
$group = addslashes($_REQUEST['group']);
if($_REQUEST['sql']!='') $search = ' and '.urldecode($_REQUEST['sql']);






if ($field=='Tous'){
	if ($textsearch!='') $search.=" and (cle like '%$textsearch%' OR idaction_type like '%$textsearch%' OR intitule like '%$textsearch%' ) ";
}else{
	if ($textsearch!='') $search.=" and $field like '%$textsearch%' ";
}

//Connexion à la base de données
include 'cnx.php';

// Requete dans les vues
$query_vue = "SELECT clause from vue where categorie='action_type' and intitule='$view'";
$result_vue = mysql_query( $query_vue );
while( $row_vue = mysql_fetch_object( $result_vue ) ){
	$search.= str_replace('(-me-)',$user,$row_vue->clause);
}

// Appliquer les permissions
$array_group = explode(', ',$group);
$value_group = "";
$lecture="";
foreach ($array_group as $value) {
	$query_permission = "SELECT * from permission where categorie='action_type'";
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
$query = "SELECT cle, idaction_type, intitule from action_type where 1 ".$search;
$result = mysql_query( $query );

print "<action_typeList>\n";
while( $row = mysql_fetch_object( $result ) )
{
//---------------------------
// Gestion des connexions
//---------------------------


print "<item>
<cle><![CDATA[".$row->cle."]]></cle>
<idaction_type><![CDATA[".$row->idaction_type."]]></idaction_type>
<intitule><![CDATA[".$row->intitule."]]></intitule>

</item>\n";
}
print "</action_typeList>"; 
?>

