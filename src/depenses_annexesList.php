<?php
$textsearch = $_REQUEST['search'];
$field = $_REQUEST['field'];
$view = $_REQUEST['view'];
$s_action = $_REQUEST['action'];
$s_statut = $_REQUEST['statut'];
$s_annee = $_REQUEST['annee'];

$table = "depenses_annexes";
$search="";
switch ($view) {
	case 'Par défaut':
	$search="";
	break;
	
	case 'Corinne':
	$table = "depenses_annexes, projet";
	$search="AND projet.cle=depenses_annexes.projet and projet.comptable='Corinne' ";
	break;
	
	case 'Benjamin':
	$table = "depenses_annexes, projet";
	$search="AND projet.cle=depenses_annexes.projet and projet.comptable='Benjamin' ";
	break;
	
	case 'Facture à comptabiliser':
	$table = "depenses_annexes";
	$search="AND (statut_compta='A comptabiliser' or statut_compta_banque= 'A comptabiliser') ";
	break;
	
	case 'Facture en attente':
	$table = "depenses_annexes";
	$search="AND (statut_compta='En attente' or statut_compta_banque= 'En attente') ";
	break;
	
	case 'Facture comptabilisée':
	$table = "depenses_annexes";
	$search="AND (statut_compta='Comptabilisée' or statut_compta_banque= 'Comptabilisée') ";
	break;
}

// USER
$user = "'".$_COOKIE['cookie_flex_sigma_cle']."'";
if($_COOKIE['cookie_flex_sigma_subordonnes']!='') $user.= ', '.$_COOKIE['cookie_flex_sigma_subordonnes'];
//echo $user;
//echo $_COOKIE['cookie_flex_sigma_profil'];

if($_COOKIE['cookie_flex_sigma_profil']!=''){
	if($_COOKIE['cookie_flex_sigma_profil']=='admin'){
		if ($s_action!='') $search.="and depenses_annexes.action = '".$s_action."' ";if ($s_statut!='') $search.="and depenses_annexes.statut = '".$s_statut."' ";if ($s_annee!='') $search.="and depenses_annexes.annee = '".$s_annee."' ";
	}else{
		if ($s_action!='') $search.="and depenses_annexes.action = '".$s_action."' ";if ($s_statut!='') $search.="and depenses_annexes.statut = '".$s_statut."' ";if ($s_annee!='') $search.="and depenses_annexes.annee = '".$s_annee."' ";
		$search.= " and depenses_annexes.utilisateur in(".$user.")";
	}
}else{
	$search.="and depenses_annexes.annee = 'rien' ";
}

if ($field=='Tous'){
	if ($textsearch!='') $search.=" and (cle like '%$textsearch%' OR date like '%$textsearch%' OR iddepenses_annexes like '%$textsearch%' OR type_depense like '%$textsearch%' OR num_comptable like '%$textsearch%' OR montant_ttc like '%$textsearch%' OR regle_le like '%$textsearch%' ) ";
}else{
	if ($textsearch!='') $search.=" and $field like '%$textsearch%' ";
}

//Connexion à la base de données
include 'cnx.php';


// Requête
$query = "SELECT depenses_annexes.date,
depenses_annexes.type_depense,
depenses_annexes.num_comptable,
depenses_annexes.libelle,
depenses_annexes.montant_reglement_ttc,
depenses_annexes.regle_le,
depenses_annexes.utilisateur, 
depenses_annexes.pointe, 
depenses_annexes.projet, 
depenses_annexes.cle, depenses_annexes.iddepenses_annexes
 from $table where 1 ".$search." order by depenses_annexes.date desc";
echo $query;
$result = mysql_query( $query );

print "<depenses_annexesList>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<cle>".$row->cle."</cle>
	<iddepenses_annexes>".$row->iddepenses_annexes."</iddepenses_annexes>
	<date>".substr($row->date,-2)."/".substr($row->date,-5,2)."/".substr($row->date,-10,4)."</date>
	<projet>".$row->projet."</projet>
	<type_depense>".$row->type_depense."</type_depense>
	<num_comptable>".$row->num_comptable."</num_comptable>
	<montant_ttc>".$row->montant_ttc."</montant_ttc>
	<montant_reglement_ttc>".$row->montant_reglement_ttc."</montant_reglement_ttc>
	<libelle>".$row->libelle."</libelle>
	<regle_le>".substr($row->regle_le,-2)."/".substr($row->regle_le,-5,2)."/".substr($row->regle_le,-10,4)."</regle_le>
	<utilisateur>".$row->utilisateur."</utilisateur>
	<pointe>".$row->pointe."</pointe>
</item>\n";
}
print "</depenses_annexesList>"; 
?>

