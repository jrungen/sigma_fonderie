<?php

$textsearch = '';
$field = '';
$view = '';
$s_reglee = '';
$s_annee = '';
$s_comptable = '';

if (isset ($_REQUEST['search'])) $textsearch = $_REQUEST['search'];
if (isset ($_REQUEST['field'])) $field = $_REQUEST['field'];
if (isset ($_REQUEST['view'])) $view = addslashes($_REQUEST['view']);
if (isset ($_REQUEST['reglee'])) $s_reglee = $_REQUEST['reglee'];
if (isset ($_REQUEST['annee'])) $s_annee = $_REQUEST['annee'];
if (isset ($_REQUEST['comptable'])) $s_comptable = $_REQUEST['comptable'];

$table = "facture_client";
$search="";
switch ($view) {
	case 'Par défaut':
	$search="";
	break;
	
	case 'Facture Client et Autre TA':
	$search="AND facture_client.type IN ('Facture client','Facture autre') AND facture_client.objet = 'Prestation tourisme d\'affaires'";
	break;
	
	case 'Facture Client et Autre PE-PS':
	$search="AND facture_client.type IN ('Facture client','Facture autre') AND facture_client.objet <> 'Prestation tourisme d\'affaires'";
	break;
	
	case 'Facture Avoir TA':
	$search="AND facture_client.type='Facture d\'avoir client' AND facture_client.objet = 'Prestation tourisme d\'affaires'";
	break;
	
	case 'Facture Avoir PE-PS':
	$search="AND facture_client.type='Facture d\'avoir client' AND facture_client.objet <> 'Prestation tourisme d\'affaires'";
	break;

	case 'Facture Avoir Client':
	$search="AND facture_client.type='Facture d\'avoir client'";
	break;

	case 'Facture Accompagnant':
	$search="AND facture_client.type='Facture accompagnant'";
	break;

	case 'Facture Avoir Accompagnant':
	$search="AND facture_client.type='Facture d\'avoir accompagnant'";
	break;

	case 'Facture Autre':
	$search="AND facture_client.type='Facture autre'";
	break;
	
	case 'Corinne':
	$table = "facture_client, projet";
	$search="AND projet.cle=facture_client.projet and projet.comptable='Corinne' ";
	break;
	
	case 'Benjamin':
	$table = "facture_client, projet";
	$search="AND projet.cle=facture_client.projet and projet.comptable='Benjamin' ";
	break;
	
	case 'Kevin':
	$table = "facture_client, projet";
	$search="AND projet.cle=facture_client.projet and projet.comptable in ('Benjamin','Kevin') ";
	break;
	
	case 'Facture a comptabiliser':
	$table = "facture_client";
	$search="AND statut_compta='A comptabiliser' ";
	break;
	
	case 'Facture en attente':
	$table = "facture_client";
	$search="AND statut_compta='En attente' ";
	break;
	
	case 'Facture comptabilisee':
	$table = "facture_client";
	$search="AND statut_compta like 'Comptabilis%' ";
	break;
	
	case 'Paiement a comptabiliser':
	$table = "facture_client";
	$search="AND ( statut_compta_paiement='A comptabiliser' or statut_compta_paiement2='A comptabiliser' or statut_compta_paiement3='A comptabiliser') ";
	break;
	
	case 'Paiement en attente':
	$table = "facture_client";
	$search="AND ( statut_compta_paiement='En attente' or statut_compta_paiement2='En attente' or statut_compta_paiement3='En attente') ";
	break;
	
	case 'Paiement comptabilisee':
	$table = "facture_client";
	$search="AND ( statut_compta_paiement like 'Comptabilis%' or statut_compta_paiement2 like 'Comptabilis%' or statut_compta_paiement3 like 'Comptabilis%') ";
	break;
}
if($s_comptable=='Corinne'){
	$table .= ", projet";
	$search .=" AND projet.cle=facture_client.projet and projet.comptable='Corinne' ";
}

if($s_comptable=='Benjamin'){
	$table .= ", projet";
	$search .=" AND projet.cle=facture_client.projet and projet.comptable='Benjamin' ";
}

if($s_comptable=='Kevin'){
	$table .= ", projet";
	$search .=" AND projet.cle=facture_client.projet and projet.comptable in ('Benjamin','Kevin') ";
}

// USER
$user = "'".$_COOKIE['cookie_flex_sigma_cle']."'";

if($_COOKIE['cookie_flex_sigma_profil']!=''){
	if($_COOKIE['cookie_flex_sigma_profil']=='admin'){
		if ($s_reglee!='') $search.="and reglee = '".$s_reglee."' ";if ($s_annee!='') $search.="and year(date_facture) = '".$s_annee."' ";
	}else{
		if ($s_reglee!='') $search.="and reglee = '".$s_reglee."' ";if ($s_annee!='') $search.="and year(date_facture) = '".$s_annee."'";
		$search.= " and utilisateur in(".$user.")";
	}
}else{
	$search.="and annee = 'rien' ";
}

if ($field=='Tous'){
	if ($textsearch!='') $search.=" and (cle like '%$textsearch%' OR societe like '%$textsearch%' OR montant_ttc like '%$textsearch%' OR projet like '%$textsearch%' OR operation like '%$textsearch%' OR utilisateur like '%$textsearch%' OR date_facture like '%$textsearch%' OR numero like '%$textsearch%' OR acompte_total like '%$textsearch%' OR montant_restant like '%$textsearch%' ) ";
}else{
	if ($textsearch!='') $search.=" and $field like '%$textsearch%' ";
}

//Connexion a la base de donn�es
include 'cnx.php';

// Requete
$query = "SELECT facture_client.cle,
facture_client.idfacture_client, 
facture_client.projet, 
facture_client.objet, 
facture_client.numero,
facture_client.societe, 
facture_client.date_facture,
facture_client.montant_ht,
facture_client.montant_ttc,
facture_client.operation,
facture_client.utilisateur,
facture_client.acompte_total,
facture_client.montant_restant,facture_client.statut_compta,facture_client.statut_compta_paiement,facture_client.banque
 from $table where 1 ".$search." order by date_facture desc";

$result = mysql_query( $query );
//echo $query;
print "<facture_clientList>\n";
while( $row = mysql_fetch_object( $result ) )
{
	$montant_ht = '';
	if ($row->objet == "Prestation tourisme d'affaires"){
		$montant_ht = $row->montant_ttc;
	}else{
		$montant_ht = $row->montant_ht;
	}
   print "<item>
	<cle>".$row->cle."</cle>
	<idfacture_client>".$row->idfacture_client."</idfacture_client>
	<societe>".$row->societe."</societe>
	<montant_ht>".$montant_ht."</montant_ht>
	<projet>".$row->projet."</projet>
	<operation>".$row->operation."</operation>
	<utilisateur>".$row->utilisateur."</utilisateur>
	<date_facture>".substr($row->date_facture,-2)."/".substr($row->date_facture,-5,2)."/".substr($row->date_facture,-10,4)."</date_facture>
	<numero>".$row->numero."</numero>
	<acompte_total>".$row->acompte_total."</acompte_total>
	<montant_restant>".$row->montant_restant."</montant_restant>
	<statut_compta>".$row->statut_compta."</statut_compta>
	<statut_compta_paiement>".$row->statut_compta_paiement."</statut_compta_paiement>
	<statut_compta_paiement2>".$row->statut_compta_paiement2."</statut_compta_paiement2>
	<statut_compta_paiement3>".$row->statut_compta_paiement3."</statut_compta_paiement3>
	<banque>".$row->banque."</banque>
</item>\n";
}
print "</facture_clientList>"; 
?>