<?php
$cle = $_REQUEST['cle'];

//Connexion � la base de donn�es
include 'cnx.php';

// Requ�te
$query = "SELECT * from bon_commande where cle = '$cle'";
$result = mysql_query( $query );

/* print out your own XML */
print "<bon_commandeRead>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	
	</item>\n";
}
print "</bon_commandeRead>";

?>

