<?php
$cle = $_REQUEST['cle'];

//Connexion à la base de données
include 'cnx.php';

// Requête
$query = "SELECT * from type_depense where cle = '$cle'";
$result = mysql_query( $query );

/* print out your own XML */
print "<type_depenseRead>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	
	</item>\n";
}
print "</type_depenseRead>";

?>

