<?php
$textsearch = $_REQUEST['search'];
$field = $_REQUEST['field'];
$view = $_REQUEST['view'];
$s_action = $_REQUEST['action'];
$s_annee = $_REQUEST['annee'];
$s_comptable = $_REQUEST['comptable'];

$table = "facture_fournisseur";
$search="";
switch ($view) {
	case 'Par défaut':
	$search="";
	break;
	
	case 'Facture fournisseur a regler':
	$table .= ", facture_fournisseur_ligne";
	$search=utf8_decode("AND facture_fournisseur.type='Factures fournisseurs' and facture_fournisseur_ligne.facture_fournisseur=facture_fournisseur.cle and facture_fournisseur_ligne.statut='A régler' ");
	break;

	case 'Facture fournisseur reglee':
	$table .= ", facture_fournisseur_ligne";
	$search=utf8_decode("AND facture_fournisseur.type='Factures fournisseurs' and facture_fournisseur_ligne.facture_fournisseur=facture_fournisseur.cle and facture_fournisseur_ligne.statut='Réglée' ");
	break;
	
	case 'Facture Avoir Fournisseur':
	$search="AND type='Factures d\'avoirs'";
	break;

	case '2011':
	$search="AND date_facture like '2011%'";
	break;

	case '2012':
	$search="AND date_facture like '2012%'";
	break;
	
	case 'Corinne':
	$table .= ", projet";
	$search="AND projet.cle=facture_fournisseur.projet and projet.comptable='Corinne' ";
	break;
	
	case 'Benjamin':
	$table .= ", projet";
	$search=" AND projet.cle=facture_fournisseur.projet and projet.comptable='Benjamin' ";
	break;
	
	case 'Kevin':
	$table .= ", projet";
	$search=" AND projet.cle=facture_fournisseur.projet and projet.comptable in ('Benjamin','Kevin') ";
	break;

	case 'Facture a comptabiliser':
	$table = "facture_fournisseur";
	$search="AND statut_compta='A comptabiliser' ";
	break;
	
	case 'Facture en attente':
	$table = "facture_fournisseur";
	$search="AND statut_compta='En attente' ";
	break;
	
	case 'Facture comptabilisee':
	$table = "facture_fournisseur";
	$search=utf8_decode("AND statut_compta='Comptabilisée' ");
	break;
}

if($s_comptable=='Corinne'){
	$table .= ", projet";
	$search .=" AND projet.cle=facture_fournisseur.projet and projet.comptable='Corinne' ";
}

if($s_comptable=='Benjamin'){
	$table .= ", projet";
	$search.=" AND projet.cle=facture_fournisseur.projet and projet.comptable='Benjamin' ";
}

if($s_comptable=='Kevin'){
	$table .= ", projet";
	$search.=" AND projet.cle=facture_fournisseur.projet and projet.comptable in ('Benjamin','Kevin') ";
}
// USER
$user = "'".$_COOKIE['cookie_flex_sigma_cle']."'";
if($_COOKIE['cookie_flex_sigma_subordonnes']!='') $user.= ', '.$_COOKIE['cookie_flex_sigma_subordonnes'];
//echo $user;
//echo $_COOKIE['cookie_flex_sigma_profil'];

if($_COOKIE['cookie_flex_sigma_profil']!=''){
	if($_COOKIE['cookie_flex_sigma_profil']=='admin'){
		if ($s_action!='') $search.="and facture_fournisseur.action = '".$s_action."' ";if ($s_annee!='') $search.="and facture_fournisseur.annee = '".$s_annee."' ";
	}else{
		if ($s_action!='') $search.="and facture_fournisseur.action = '".$s_action."' ";if ($s_annee!='') $search.="and facture_fournisseur.annee = '".$s_annee."' ";
		$search.= " and facture_fournisseur.utilisateur in(".$user.")";
	}
}else{
	$search.="and facture_fournisseur.annee = 'rien' ";
}
//echo $search;


if ($field=='Tous'){
	if ($textsearch!='') $search.=" and (idfacture_fournisseur like '%$textsearch%' OR date_facture like '%$textsearch%' OR cle like '%$textsearch%' OR projet like '%$textsearch%' OR item like '%$textsearch%' OR utilisateur like '%$textsearch%' OR societe like '%$textsearch%' OR numero like '%$textsearch%' OR total_acompte like '%$textsearch%' OR montant_restant_du like '%$textsearch%' OR montant_ttc like '%$textsearch%' OR facture_regle like '%$textsearch%' ) ";
}else{
	if ($textsearch!='') $search.=" and $field like '%$textsearch%' ";
}

//Connexion à la base de données
include 'cnx.php';


// Requête
$query = "SELECT facture_fournisseur.projet, facture_fournisseur.cle, facture_fournisseur.idfacture_fournisseur, facture_fournisseur.utilisateur, facture_fournisseur.date_facture,
facture_fournisseur.item, facture_fournisseur.societe, facture_fournisseur.numero, facture_fournisseur.total_acompte, facture_fournisseur.montant_ht, facture_fournisseur.montant_ttc, 
facture_fournisseur.montant_restant_du_facturation,facture_fournisseur.facture_regle, facture_fournisseur.statut_compta, facture_fournisseur.pointe
FROM ".$table."
where 1 ".$search;
$result = mysql_query( $query );
// echo $query;
print "<facture_fournisseurList>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
<idfacture_fournisseur>".$row->idfacture_fournisseur."</idfacture_fournisseur>
<date_facture>".substr($row->date_facture,-2)."/".substr($row->date_facture,-5,2)."/".substr($row->date_facture,-10,4)."</date_facture>
<cle>".$row->cle."</cle>
<projet>".$row->projet."</projet>
<item>".$row->item."</item>
<utilisateur>".$row->utilisateur."</utilisateur>
<societe>".$row->societe."</societe>
<numero>".$row->numero."</numero>
<total_acompte>".$row->total_acompte."</total_acompte>
<montant_restant_du>".$row->montant_restant_du_facturation."</montant_restant_du>
<montant_ht>".$row->montant_ht."</montant_ht>
<montant_ttc>".$row->montant_ttc."</montant_ttc>
<facture_regle>".$row->facture_regle."</facture_regle>
<statut_compta>".$row->statut_compta."</statut_compta>
<pointe>".$row->pointe."</pointe>
</item>\n";
}
print "</facture_fournisseurList>";
?>