<?php
$id = addslashes($_REQUEST['idfournisseur']);
$cle = addslashes($_REQUEST['cle']);

//Connexion � la base de donn�es
include 'cnx.php';

// Requ�te
if($cle==''){
	$query = "SELECT * from fournisseur where idfournisseur = '$id'";
}else{
	$query = "SELECT * from fournisseur where cle = '$cle'";
}
$result = mysql_query( $query );

/* print out your own XML */
print "<fournisseurRead>\n";
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

	$date_creation = substr($row->date_creation,-2)."/".substr($row->date_creation,5,2)."/".substr($row->date_creation,0,4);
	$date_demande_attest = substr($row->date_demande_attestation,-2)."/".substr($row->date_demande_attestation,5,2)."/".substr($row->date_demande_attestation,0,4);
	$date_relance1 = substr($row->date_relance1,-2)."/".substr($row->date_relance1,5,2)."/".substr($row->date_relance1,0,4);
	$date_relance2 = substr($row->date_relance2,-2)."/".substr($row->date_relance2,5,2)."/".substr($row->date_relance2,0,4);
	$date_reception = substr($row->date_reception,-2)."/".substr($row->date_reception,5,2)."/".substr($row->date_reception,0,4);
	$date_document = substr($row->date_document,-2)."/".substr($row->date_document,5,2)."/".substr($row->date_document,0,4);
	$date_renouvellement = substr($row->date_renouvellement,-2)."/".substr($row->date_renouvellement,5,2)."/".substr($row->date_renouvellement,0,4);
	
   print "<item>
	<idfournisseur><![CDATA[".$row->idfournisseur."]]></idfournisseur>
	<cle><![CDATA[".$row->cle."]]></cle>
	<nom><![CDATA[".$row->nom."]]></nom>
	<tel><![CDATA[".$row->tel."]]></tel>
	<date_creation><![CDATA[".$date_creation."]]></date_creation>
	<creation_par><![CDATA[".$row->creation_par."]]></creation_par>
	<fax><![CDATA[".$row->fax."]]></fax>
	<adresse><![CDATA[".$row->adresse."]]></adresse>
	<heure_creation><![CDATA[".$row->heure_creation."]]></heure_creation>
	<email><![CDATA[".$row->email."]]></email>
	<adressesuite><![CDATA[".$row->adressesuite."]]></adressesuite>
	<modification_par><![CDATA[".$row->modification_par."]]></modification_par>
	<date_modification><![CDATA[".$row->date_modification."]]></date_modification>
	<cp><![CDATA[".$row->cp."]]></cp>
	<siret><![CDATA[".$row->siret."]]></siret>
	<heure_modification><![CDATA[".$row->heure_modification."]]></heure_modification>
	<ville><![CDATA[".$row->ville."]]></ville>
	<pays><![CDATA[".$connexion_pays."]]></pays>
	<pays_cle><![CDATA[".$row->pays."]]></pays_cle>
	<compte_tiers><![CDATA[".$row->compte_tiers."]]></compte_tiers>
	<annee><![CDATA[".$row->annee."]]></annee>
	<tva_intra><![CDATA[".$row->tva_intra."]]></tva_intra>
	<nouveau><![CDATA[".$row->nouveau."]]></nouveau>
	<date_demande_attestation><![CDATA[".$date_demande_attest."]]></date_demande_attestation>
	<date_relance1><![CDATA[".$date_relance1."]]></date_relance1>
	<date_relance2><![CDATA[".$date_relance2."]]></date_relance2>
	<date_reception><![CDATA[".$date_reception."]]></date_reception>
	<date_document><![CDATA[".$date_document."]]></date_document>
	<date_renouvellement><![CDATA[".$date_renouvellement."]]></date_renouvellement>
</item>\n";
}
print "</fournisseurRead>";

?>

