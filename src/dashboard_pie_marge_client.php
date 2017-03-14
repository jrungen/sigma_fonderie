<?php

//Connexion à la base de données
include 'cnx.php';


// Requête
$query = "SELECT sum(total_marge) as marge, societe as societe FROM projet where datedebut >= '20110101' group by societe order by marge desc limit 0,10";
$result = mysql_query( $query );
echo $query;
print "<dashboard>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<societe>".$row->societe."</societe>
	<marge>".$row->marge."</marge>
	</item>\n";
}
print "</dashboard>"; 
?>

