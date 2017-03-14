<?php
$cle = $_REQUEST['cle'];

//Connexion à la base de données
include 'cnx.php';

// Requête
$query = "SELECT * from pays where cle = '$cle'";
$result = mysql_query( $query );

/* print out your own XML */
print "<paysRead>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<cle>".$row->cle."</cle>
<idpays>".$row->idpays."</idpays>
<taux_tva_normal>".$row->taux_tva_normal."</taux_tva_normal>
<taux_tva_reduit>".$row->taux_tva_reduit."</taux_tva_reduit>

	</item>\n";
}
print "</paysRead>";

?>

