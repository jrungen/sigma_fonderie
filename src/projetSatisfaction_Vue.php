<?php

//Connexion à la base de données
include 'cnx.php';


// Requête
$query = "SELECT fournisseur, date_preparation, eval_preparation, liste_preparation, date_realisation, liste_realisation, ca_ht, cle, idsatisfaction from satisfaction where 1  and ( fournisseur like '%".$_REQUEST['search']."%' OR date_preparation like '%".$_REQUEST['search']."%' OR eval_preparation like '%".$_REQUEST['search']."%' OR liste_preparation like '%".$_REQUEST['search']."%' OR date_realisation like '%".$_REQUEST['search']."%' OR liste_realisation like '%".$_REQUEST['search']."%' OR ca_ht like '%".$_REQUEST['search']."%' OR cle like '%".$_REQUEST['search']."%' OR idsatisfaction like '%".$_REQUEST['search']."%' ) and projet='".$_REQUEST['cle']."'";
$result = mysql_query( $query );

print "<satisfactionList>\n";
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

// Connexion_eval_preparation
//---------------------------
$query_connexion_eval_preparation = "SELECT cle from utilisateur where cle='".$row->eval_preparation."'";
$result_connexion_eval_preparation = mysql_query( $query_connexion_eval_preparation );
$row_connexion_eval_preparation = mysql_fetch_object( $result_connexion_eval_preparation );
$connexion_eval_preparation = '';
if (mysql_num_rows($result_connexion_eval_preparation)>0){
$connexion_eval_preparation = $row_connexion_eval_preparation->cle;
}
//---------------------------


   print "<item>
	<fournisseur><![CDATA[".$connexion_fournisseur."]]></fournisseur>
<date_preparation><![CDATA[".$row->date_preparation."]]></date_preparation>
<eval_preparation><![CDATA[".$connexion_eval_preparation."]]></eval_preparation>
<liste_preparation><![CDATA[".$row->liste_preparation."]]></liste_preparation>
<date_realisation><![CDATA[".$row->date_realisation."]]></date_realisation>
<liste_realisation><![CDATA[".$row->liste_realisation."]]></liste_realisation>
<ca_ht><![CDATA[".$row->ca_ht."]]></ca_ht>
<cle><![CDATA[".$row->cle."]]></cle>
<idsatisfaction><![CDATA[".$row->idsatisfaction."]]></idsatisfaction>

   </item>\n";
}
print "</satisfactionList>"; 
?>

