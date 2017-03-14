<?php
header("Content-Type:text/html; charset=iso-8859-15");

$textsearch = '';
$field =  '';
$view =  '';
$search = '';
$user = '';
$group = '';
$session = '';

if(isset($_REQUEST['search'])){
	$textsearch = addslashes($_REQUEST['search']);
}

if(isset($_REQUEST['field'])){
	$field = addslashes($_REQUEST['field']);
}

if(isset($_REQUEST['view'])){
	$view = addslashes($_REQUEST['view']);
	if($view=='') $view='Par d�faut';
}

if(isset($_REQUEST['user'])){
	$user = addslashes($_REQUEST['user']);
}

if(isset($_REQUEST['group'])){
	$group = addslashes($_REQUEST['group']);
}

if(isset($_REQUEST['sql'])){
	$session = addslashes($_REQUEST['sql']);
}

//Connexion � la base de donn�es
include 'cnx.php';
session_start();

	// Appliquer les permissions
	$array_group = explode(', ',$group);
	$value_group = "";
	$lecture="";
	foreach ($array_group as $value) {
		$query_permission = "SELECT * from permission where categorie='fournisseur_attestation'";
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
				// V�rif dans visualisation selective
				if (in_array($value, $visualisation_selective)){
					// Si le groupe est en visualisation s�lective alors afficher que les donn�es du groupe (tous les utilisateurs du groupe)
					print "$value trouve dans visualisation s�lective / " ;
					
					if($champ_utilisateur==''){
						// Rechercher tous les utilisateurs du groupe
						echo $query_user_groupe = "SELECT * from utilisateur where groupe like '%$value%'";
						$result_user_groupe = mysql_query( $query_user_groupe );
						while( $row_user_groupe = mysql_fetch_object( $result_user_groupe ) ){
							$utilisateur_cle = $row_user_groupe->cle;
							$value_group .= "$champ = '$utilisateur_cle' OR ";
						}
					}else{
						// Permission par rapport � une connexion de la fiche utilisateur
						$query_user = "SELECT * from utilisateur where cle='$user'";
						$result_user = mysql_query( $query_user );
						while( $row_user = mysql_fetch_object( $result_user ) ){
							$value_champ_utilisateur = $row_user->$champ_utilisateur;
							$array_value_champ_utilisateur = explode(', ',$value_champ_utilisateur);
							foreach ($array_value_champ_utilisateur as $user_value) {
								$value_group .= "$champ = '$user_value' OR ";
							}
						
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
	$query_vue = "SELECT * from vue where categorie='fournisseur_attestation' and intitule='$view'";
	$result_vue = mysql_query( $query_vue );
	while( $row_vue = mysql_fetch_object( $result_vue ) ){
		$where = str_replace('(-me-)',$user,$row_vue->view_where);
		$column = $row_vue->view_column;
		$select = $row_vue->view_select;
		$from = $row_vue->view_from;
		$join = $row_vue->view_jointure;
		$style = $row_vue->view_color;
		$group1 = $row_vue->group1;
		$group2 = $row_vue->group2;
		$group3 = $row_vue->group3;	
		$expanded = $row_vue->expanded;	
		$vue_cle =  $row_vue->cle;
	}

	print $column."\n";
	print $style."\n";

	print "<grouping>
	<group1>$group1</group1>
	<group2>$group2</group2>
	<group3>$group3</group3>
	<expanded>$expanded</expanded>
	</grouping>\n";

	// SUMMARY
	print '<summary>
	<item field="" />';

	// Query number field
	$query_vue_champ = "SELECT datafield from vue_champ where category='fournisseur_attestation' and format='number' and vue='$vue_cle'";
	$result_vue_champ = mysql_query( $query_vue_champ );
	while( $row_vue_champ = mysql_fetch_object( $result_vue_champ ) ){
		echo '<item field="'.$row_vue_champ->datafield.'" />';
	}
	print '</summary>';


	// R�cup�rer tous les champs et appliquer le filtre � ces champs
	if ($textsearch!=''){
		$select_fields = explode(', ', $select);
		foreach($select_fields as $value){
			$select_as = explode(' as ',$value);
			$select_as_ .= $select_as[0]." like '%$textsearch%' OR ";
		}

		if ($field=='Tous'){
			if ($textsearch!='') $search.=" and ( ".substr($select_as_,0,-3)." ) ";
		}else{
			if ($textsearch!='') $search.=" and $field like '%$textsearch%' ";
		}
	}
	$search .= $where;

	// Requ�te
	$query = "SELECT $select from $from $join where 1 ".$search;
	$result = mysql_query( $query );

	print "<fournisseur_attestationList>\n";
	while($tab=mysql_fetch_row($result)){
		echo "<item>\n";
			for($i=0;$i<mysql_num_fields($result);$i++){
				echo "\t<".mysql_field_name($result, $i)."><![CDATA[$tab[$i]]]></".mysql_field_name($result, $i).">\n";		  
			}
		echo "</item>\n";
	 }

	print "</fournisseur_attestationList>";
?>