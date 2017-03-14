<?php
$textsearch = $_REQUEST['search'];
$field = $_REQUEST['field'];
$view = $_REQUEST['view'];
//$s_annee = $_REQUEST['annee'];
$s_statut = $_REQUEST['statut'];
$s_comptable = $_REQUEST['comptable'];
$table = "facture_fournisseur_ligne, facture_fournisseur, projet";
$search =" AND projet.cle=facture_fournisseur.projet and facture_fournisseur_ligne.facture_fournisseur=facture_fournisseur.cle ";

switch ($view) {
	case 'Par défaut':
	$search.="";
	break;
	
	case 'Facture à comptabiliser':
	$table = "facture_fournisseur_ligne";
	$search="AND statut_compta='A comptabiliser' ";
	break;
	
	case 'Facture en attente':
	$table = "facture_fournisseur_ligne";
	$search="AND statut_compta='En attente' ";
	break;
	
	case 'Facture comptabilisée':
	$table = "facture_fournisseur_ligne";
	$search="AND statut_compta='Comptabilisée' ";
	break;
}

if ($s_statut!='') $search.="and facture_fournisseur_ligne.statut = '".$s_statut."' ";

if($s_comptable=='Corinne'){
	$search .=" and projet.comptable='Corinne' ";
}

if($s_comptable=='Benjamin'){
	$search .=" and projet.comptable='Benjamin' ";
}

if ($field=='Tous'){
	if ($textsearch!='') $search.=" and (facture_fournisseur_ligne.cle like '%$textsearch%' OR idfacture_fournisseur_ligne like '%$textsearch%' OR facture_fournisseur_ligne.type_depenses like '%$textsearch%' ) ";
}else{
	if ($textsearch!='') $search.=" and $field like '%$textsearch%' ";
}


//Connexion à la base de données
include 'cnx.php';


// Requête
$query = "SELECT facture_fournisseur_ligne.cle,
facture_fournisseur_ligne.idfacture_fournisseur_ligne,
facture_fournisseur_ligne.type_depenses, 
facture_fournisseur_ligne.date_reglement, 
facture_fournisseur_ligne.beneficiaire, 
facture_fournisseur_ligne.designation, 
facture_fournisseur_ligne.statut, 
facture_fournisseur_ligne.acompte_reglement,
facture_fournisseur_ligne.acompte_paye,
facture_fournisseur_ligne.statut_compta,
projet.numero as projet
from $table where 1 ".$search;
//echo $query;
$result = mysql_query( $query );

print "<facture_fournisseur_ligneList>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<cle>".$row->cle."</cle>
<idfacture_fournisseur_ligne>".$row->idfacture_fournisseur_ligne."</idfacture_fournisseur_ligne>
<type_depenses>".$row->type_depenses."</type_depenses>
<date_reglement>".$row->date_reglement."</date_reglement>
<beneficiaire>".$row->beneficiaire."</beneficiaire>
<designation>".$row->designation."</designation>
<statut>".$row->statut."</statut>
<acompte_reglement>".$row->acompte_reglement."</acompte_reglement>
<acompte_paye>".$row->acompte_paye."</acompte_paye>
<projet>".$row->projet."</projet>
   </item>\n";
}
print "</facture_fournisseur_ligneList>"; 
?>

