<?php
header("Content-Type:text/html; charset=iso-8859-15");
$textsearch = addslashes($_REQUEST['search']);
$field = addslashes($_REQUEST['field']);
$view = addslashes($_REQUEST['view']);
$user = addslashes($_REQUEST['user']);
if($view=='') $view='Par défaut';

$search="";
switch ($view) {
	case 'Par d�faut':
	$search="";
	break;
	
	case 'Fournisseur plus de 3000 HT':
	$search=" and (select sum(montant_ht) from facture_fournisseur where fourniseur = fournisseur.cle and facture_fournisseur.annee = year(curdate()) group by fourniseur) > 3000";
	break;
}

$group = addslashes($_REQUEST['group']);
if($_REQUEST['sql']!='') $search = ' and '.urldecode($_REQUEST['sql']);

if ($field=='Tous'){
	if ($textsearch!='') $search.=" and (idfournisseur like '%$textsearch%' OR cle like '%$textsearch%' OR nom like '%$textsearch%' OR tel like '%$textsearch%' OR adresse like '%$textsearch%' OR adressesuite like '%$textsearch%' OR cp like '%$textsearch%' OR ville like '%$textsearch%' OR pays like '%$textsearch%' OR compte_tiers like '%$textsearch%' ) ";
}else{
	if ($textsearch!='') $search.=" and $field like '%$textsearch%' ";
}

//Connexion � la base de donn�es
include 'cnx.php';

// Requete dans les vues
$query_vue = "SELECT clause from vue where categorie='fournisseur' and intitule='$view'";
$result_vue = mysql_query( $query_vue );
while( $row_vue = mysql_fetch_object( $result_vue ) ){
	$search.= str_replace('(-me-)',$user,$row_vue->clause);
}

// Appliquer les permissions
$array_group = explode(', ',$group);
$value_group = "";
$lecture="";
foreach ($array_group as $value) {
	$query_permission = "SELECT * from permission where categorie='fournisseur'";
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
			// V�rif dans visualisation selective
			if (in_array($value, $visualisation_selective)){
				// Si le groupe est en visualisation s�lective alors afficher que les donn�es du groupe (tous les utilisateurs du groupe)
				print "$value trouve dans visualisation s�lective / " ;
				
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


// Requete
$query = "SELECT idfournisseur, cle,(select sum(montant_ht) from facture_fournisseur where fourniseur = fournisseur.cle and facture_fournisseur.annee = year(curdate()) group by fourniseur) as total_ht, nom, tel, adresse, adressesuite, cp, ville, pays, compte_tiers, nouveau from fournisseur where 1 ".$search;
$result = mysql_query( $query );

print "<fournisseurList>\n";
while( $row = mysql_fetch_object( $result ) )
{
//---------------------------
// Gestion des connexions
//---------------------------
// Connexion_pays
//---------------------------
$query_connexion_pays = "SELECT cle from pays where cle='".$row->pays."'";
$result_connexion_pays = mysql_query( $query_connexion_pays );
$row_connexion_pays = mysql_fetch_object( $result_connexion_pays );
$connexion_pays = '';
if (mysql_num_rows($result_connexion_pays)>0){
$connexion_pays = $row_connexion_pays->cle;
}
//---------------------------


print "<item>
<idfournisseur><![CDATA[".$row->idfournisseur."]]></idfournisseur>
<cle><![CDATA[".$row->cle."]]></cle>
<nom><![CDATA[".$row->nom."]]></nom>
<tel><![CDATA[".$row->tel."]]></tel>
<adresse><![CDATA[".$row->adresse."]]></adresse>
<adressesuite><![CDATA[".$row->adressesuite."]]></adressesuite>
<cp><![CDATA[".$row->cp."]]></cp>
<ville><![CDATA[".$row->ville."]]></ville>
<pays><![CDATA[".$connexion_pays."]]></pays>
<compte_tiers><![CDATA[".$row->compte_tiers."]]></compte_tiers>
<total_ht><![CDATA[".$row->total_ht."]]></total_ht>
<nouveau><![CDATA[".$row->nouveau."]]></nouveau>

</item>\n";
}
print "</fournisseurList>"; 
?>