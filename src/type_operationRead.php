<?php
$cle = $_REQUEST['cle'];

//Connexion � la base de donn�es
include 'cnx.php';

// Requ�te
$query = "SELECT * from type_operation where cle = '$cle'";
$result = mysql_query( $query );

/* print out your own XML */
print "<type_operationRead>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	
	</item>\n";
}
print "</type_operationRead>";

?>

