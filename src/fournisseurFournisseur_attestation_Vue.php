<?php

//Connexion à la base de données
include 'cnx.php';


// Requête
$query = "SELECT cle, idfournisseur_attestation, fournisseur, date_attestation, date_document, note, pj_kbis, pj_urssaf_rsi, pj_autre from fournisseur_attestation where 1  and ( cle like '%".$_REQUEST['search']."%' OR idfournisseur_attestation like '%".$_REQUEST['search']."%' OR fournisseur like '%".$_REQUEST['search']."%' OR note like '%".$_REQUEST['search']."%' OR pj_kbis like '%".$_REQUEST['search']."%' OR pj_urssaf_rsi like '%".$_REQUEST['search']."%' OR pj_autre like '%".$_REQUEST['search']."%' ) and fournisseur='".$_REQUEST['cle']."'";
$result = mysql_query( $query );
echo $query;
print "<fournisseur_attestationList>\n";
while( $row = mysql_fetch_object( $result ) )
{
//---------------------------
// Gestion des connexions
//---------------------------
// Connexion_fournisseur
//---------------------------
$query_connexion_fournisseur = "SELECT * from fournisseur where cle='".$row->fournisseur."'";
$result_connexion_fournisseur = mysql_query( $query_connexion_fournisseur );
$row_connexion_fournisseur = mysql_fetch_object( $result_connexion_fournisseur );
$connexion_fournisseur = '';
if (mysql_num_rows($result_connexion_fournisseur)>0){
$connexion_fournisseur = $row_connexion_fournisseur->cle;
}
//---------------------------


   print "<item>
	<cle><![CDATA[".$row->cle."]]></cle>
<idfournisseur_attestation><![CDATA[".$row->idfournisseur_attestation."]]></idfournisseur_attestation>
<fournisseur><![CDATA[".$connexion_fournisseur."]]></fournisseur>
<date_document>".substr($row->date_attestation,-2)."/".substr($row->date_attestation,-5,2)."/".substr($row->date_attestation,-10,4)."</date_document>
<date_attestation>".substr($row->date_document,-2)."/".substr($row->date_document,-5,2)."/".substr($row->date_document,-10,4)."</date_attestation>
<note><![CDATA[".$row->note."]]></note>
<pj_kbis><![CDATA[".$row->pj_kbis."]]></pj_kbis>
<pj_urssaf_rsi><![CDATA[".$row->pj_urssaf_rsi."]]></pj_urssaf_rsi>
<pj_autre><![CDATA[".$row->pj_autre."]]></pj_autre>

   </item>\n";
}
print "</fournisseur_attestationList>"; 
?>