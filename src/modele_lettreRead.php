<?php
$id = addslashes($_REQUEST['idmodele_lettre']);
$cle = addslashes($_REQUEST['cle']);

//Connexion à la base de données
include 'cnx.php';

// Requête
if($cle==''){
	$query = "SELECT * from modele_lettre where idmodele_lettre = '$id'";
}else{
	$query = "SELECT * from modele_lettre where cle = '$cle'";
}
$result = mysql_query( $query );

/* print out your own XML */
print "<modele_lettreRead>\n";
while( $row = mysql_fetch_object( $result ) )
{
//---------------------------
// Gestion des connexions
//---------------------------

   print "<item>
	<idmodele_lettre><![CDATA[".$row->idmodele_lettre."]]></idmodele_lettre>
<cle><![CDATA[".$row->cle."]]></cle>
<intitule><![CDATA[".$row->intitule."]]></intitule>
<date_creation><![CDATA[".$row->date_creation."]]></date_creation>
<creation_par><![CDATA[".$row->creation_par."]]></creation_par>
<categorie><![CDATA[".$row->categorie."]]></categorie>
<note><![CDATA[".$row->note."]]></note>
<date_modification><![CDATA[".$row->date_modification."]]></date_modification>
<heure_creation><![CDATA[".$row->heure_creation."]]></heure_creation>
<modification_par><![CDATA[".$row->modification_par."]]></modification_par>
<fichier><![CDATA[".$row->fichier."]]></fichier>
<heure_modification><![CDATA[".$row->heure_modification."]]></heure_modification>
<annee><![CDATA[".$row->annee."]]></annee>

	</item>\n";
}
print "</modele_lettreRead>";

?>

