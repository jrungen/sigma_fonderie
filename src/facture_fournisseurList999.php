<?php
$textsearch = $_REQUEST['search'];
$field = $_REQUEST['field'];
$view = $_REQUEST['view'];

switch ($view) {
	case 'Par d�faut':
	$search="";
	break;
	
	case 'Facture Fournisseur':
	$search="AND type='Factures fournisseurs'";
	break;

	case 'Facture Avoir Fournisseur':
	$search="AND type='Factures d\'avoirs'";
	break;

	case 'R�gl�':
	$search="AND facture_regle = 'R�gl�'";
	break;

	case 'A r�gler':
	$search="AND facture_regle = 'A r�gler'";
	break;

	case '2011':
	$search="AND date_facture like '2011%'";
	break;

	case '2012':
	$search="AND date_facture like '2012%'";
	break;


}

if ($field=='Tous'){
	if ($textsearch!='') $search.=" and date_facture like '%$textsearch%' OR projet like '%$textsearch%' OR item like '%$textsearch%' OR utilisateur like '%$textsearch%' OR cle like '%$textsearch%' OR idfacture_fournisseur like '%$textsearch%' OR numero like '%$textsearch%' OR societe like '%$textsearch%' OR facture_regle like '%$textsearch%' OR montant_ttc like '%$textsearch%' OR total_regle like '%$textsearch%' ";
}else{
	if ($textsearch!='') $search.=" and $field like '%$textsearch%'";
}

//Connexion � la base de donn�es
include 'cnx.php';


// Requ�te
$query = "SELECT * from facture_fournisseur where 1 ".$search." and projet='999'";
$result = mysql_query( $query );

print "<facture_fournisseurList>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<date_facture>".substr($row->date_facture,-2)."/".substr($row->date_facture,-5,2)."/".substr($row->date_facture,-10,4)."</date_facture>
<projet>".$row->projet."</projet>
<item>".$row->item."</item>
<utilisateur>".$row->utilisateur."</utilisateur>
<cle>".$row->cle."</cle>
<idfacture_fournisseur>".$row->idfacture_fournisseur."</idfacture_fournisseur>
<numero>".$row->numero."</numero>
<societe>".$row->societe."</societe>
<facture_regle>".$row->facture_regle."</facture_regle>
<montant_ttc>".$row->montant_ttc."</montant_ttc>
<total_regle>".$row->total_regle."</total_regle>

   </item>\n";
}
print "</facture_fournisseurList>"; 
?>

