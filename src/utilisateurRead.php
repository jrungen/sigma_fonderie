<?php
$id = addslashes($_REQUEST['idutilisateur']);
$cle = addslashes($_REQUEST['cle']);

//Connexion à la base de données
include 'cnx.php';

// Requête
if($cle==''){
	$query = "SELECT * from utilisateur where idutilisateur = '$id'";
}else{
	$query = "SELECT * from utilisateur where cle = '$cle'";
}
$result = mysql_query( $query );

/* print out your own XML */
print "<utilisateurRead>\n";
while( $row = mysql_fetch_object( $result ) )
{
//---------------------------
// Gestion des connexions
//---------------------------

   print "<item>
	<idutilisateur><![CDATA[".$row->idutilisateur."]]></idutilisateur>
<creation_par><![CDATA[".$row->creation_par."]]></creation_par>
<login><![CDATA[".$row->login."]]></login>
<date_creation><![CDATA[".$row->date_creation."]]></date_creation>
<heure_creation><![CDATA[".$row->heure_creation."]]></heure_creation>
<password><![CDATA[".$row->password."]]></password>
<modification_par><![CDATA[".$row->modification_par."]]></modification_par>
<date_modification><![CDATA[".$row->date_modification."]]></date_modification>
<cle><![CDATA[".$row->cle."]]></cle>
<heure_modification><![CDATA[".$row->heure_modification."]]></heure_modification>
<profil><![CDATA[".$row->profil."]]></profil>
<annee><![CDATA[".$row->annee."]]></annee>
<subordonnes><![CDATA[".$row->subordonnes."]]></subordonnes>

	</item>\n";
}
print "</utilisateurRead>";

?>

