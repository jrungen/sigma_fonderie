<?php
$id = addslashes($_REQUEST['idaction_type']);
$cle = addslashes($_REQUEST['cle']);

//Connexion à la base de données
include 'cnx.php';

// Requête
if($cle==''){
	$query = "SELECT * from action_type where idaction_type = '$id'";
}else{
	$query = "SELECT * from action_type where cle = '$cle'";
}
$result = mysql_query( $query );

/* print out your own XML */
print "<action_typeRead>\n";
while( $row = mysql_fetch_object( $result ) )
{
//---------------------------
// Gestion des connexions
//---------------------------

   print "<item>
	<cle><![CDATA[".$row->cle."]]></cle>
<idaction_type><![CDATA[".$row->idaction_type."]]></idaction_type>
<intitule><![CDATA[".$row->intitule."]]></intitule>
<creation_par><![CDATA[".$row->creation_par."]]></creation_par>
<date_creation><![CDATA[".$row->date_creation."]]></date_creation>
<modification_par><![CDATA[".$row->modification_par."]]></modification_par>
<heure_creation><![CDATA[".$row->heure_creation."]]></heure_creation>
<date_modification><![CDATA[".$row->date_modification."]]></date_modification>
<heure_modification><![CDATA[".$row->heure_modification."]]></heure_modification>
<annee><![CDATA[".$row->annee."]]></annee>

	</item>\n";
}
print "</action_typeRead>";

?>

