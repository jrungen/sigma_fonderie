<?php
$id = addslashes($_REQUEST['idfournisseur_attestation']);
$cle = addslashes($_REQUEST['cle']);

//Connexion � la base de donn�es
include 'cnx.php';

// Requ�te
if($cle==''){
	$query = "SELECT * from fournisseur_attestation where idfournisseur_attestation = '$id'";
}else{
	$query = "SELECT * from fournisseur_attestation where cle = '$cle'";
}
$result = mysql_query( $query );

/* print out your own XML */
print "<fournisseur_attestationRead>\n";
while( $row = mysql_fetch_object( $result ) )
{
//---------------------------
// Gestion des connexions
//---------------------------

// Connexion_fournisseur
//---------------------------
$query_connexion_fournisseur = "SELECT cle from fournisseur where cle='".$row->fournisseur."'";
$result_connexion_fournisseur = mysql_query( $query_connexion_fournisseur );
$row_connexion_fournisseur = mysql_fetch_object( $result_connexion_fournisseur );
$connexion_fournisseur = '';
if (mysql_num_rows($result_connexion_fournisseur)>0){
$connexion_fournisseur = $row_connexion_fournisseur->cle;
}
//---------------------------

   print "<item>
	<fournisseur><![CDATA[".$connexion_fournisseur."]]></fournisseur>
<fournisseur_cle><![CDATA[".$row->fournisseur."]]></fournisseur_cle>
<cle><![CDATA[".$row->cle."]]></cle>
<date_attestation><![CDATA[".$row->date_attestation."]]></date_attestation>
<date_document><![CDATA[".$row->date_document."]]></date_document>
<idfournisseur_attestation><![CDATA[".$row->idfournisseur_attestation."]]></idfournisseur_attestation>
<note><![CDATA[".$row->note."]]></note>
<creation_par><![CDATA[".$row->creation_par."]]></creation_par>
<pj_kbis><![CDATA[".$row->pj_kbis."]]></pj_kbis>
<modification_par><![CDATA[".$row->modification_par."]]></modification_par>
<pj_urssaf_rsi><![CDATA[".$row->pj_urssaf_rsi."]]></pj_urssaf_rsi>
<date_creation><![CDATA[".$row->date_creation."]]></date_creation>
<pj_autre><![CDATA[".$row->pj_autre."]]></pj_autre>
<date_modification><![CDATA[".$row->date_modification."]]></date_modification>
<heure_creation><![CDATA[".$row->heure_creation."]]></heure_creation>
<heure_modification><![CDATA[".$row->heure_modification."]]></heure_modification>
<annee><![CDATA[".$row->annee."]]></annee>

	</item>\n";
}
print "</fournisseur_attestationRead>";

?>

