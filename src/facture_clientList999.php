<?php
$textsearch = $_REQUEST['search'];
$field = $_REQUEST['field'];
$view = $_REQUEST['view'];

switch ($view) {
	case 'Par défaut':
	$search="";
	break;
	
	case 'Facture Client':
	$search="AND type='Facture client'";
	break;

	case 'Facture Avoir Client':
	$search="AND type='Facture d\'avoir client'";
	break;

	case 'Facture accompagnant':
	$search="AND type='Facture accompagnant'";
	break;

	case 'Facture autre':
	$search="AND type='Facture autre'";
	break;

	case 'Réglé':
	$search="AND reglee='Payée'";
	break;

	case 'A régler':
	$search="AND reglee=''";
	break;

	case '2011':
	$search="AND date_facture like '2011%' ";
	break;

	case '2012':
	$search="AND date_facture like '2012%' ";
	break;


}

if ($field=='Tous'){
	if ($textsearch!='') $search.=" and cle like '%$textsearch%' OR societe like '%$textsearch%' OR montant_ttc like '%$textsearch%' OR projet like '%$textsearch%' OR operation like '%$textsearch%' OR utilisateur like '%$textsearch%' OR date_facture like '%$textsearch%' OR numero like '%$textsearch%' OR acompte_total like '%$textsearch%' OR montant_restant like '%$textsearch%' ";
}else{
	if ($textsearch!='') $search.=" and $field like '%$textsearch%'";
}

//Connexion à la base de données
include 'cnx.php';


// Requête
$query = "SELECT * from facture_client where 1 ".$search." and projet='999'";
$result = mysql_query( $query );

print "<facture_clientList>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<cle>".$row->cle."</cle>
<societe>".$row->societe."</societe>
<montant_ttc>".$row->montant_ttc."</montant_ttc>
<projet>".$row->projet."</projet>
<operation>".$row->operation."</operation>
<utilisateur>".$row->utilisateur."</utilisateur>
<date_facture>".substr($row->date_facture,-2)."/".substr($row->date_facture,-5,2)."/".substr($row->date_facture,-10,4)."</date_facture>
<numero>".$row->numero."</numero>
<acompte_total>".$row->acompte_total."</acompte_total>
<montant_restant>".$row->montant_restant."</montant_restant>

   </item>\n";
}
print "</facture_clientList>"; 
?>

