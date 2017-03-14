<?php

//Connexion à la base de données
include 'cnx.php';


// Requête
$query = "SELECT * from action where 1 AND societe='".$_REQUEST['cle']."'";
$result = mysql_query( $query );

print "<actionList>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<idaction>".$row->idaction."</idaction>
	<cle>".$row->cle."</cle>
	<date_debut>".substr($row->date_debut,-2)."/".substr($row->date_debut,-5,2)."/".substr($row->date_debut,-10,4)."</date_debut>
	<date_fin>".substr($row->date_fin,-2)."/".substr($row->date_fin,-5,2)."/".substr($row->date_fin,-10,4)."</date_fin>
	<societe>".$row->societe."</societe>
	<nom>".$row->nom."</nom>
	<type>".$row->type."</type>
	<statut>".$row->statut."</statut>
	<utilisateur>".$row->utilisateur."</utilisateur>
	<duree>".$row->duree."</duree>
   </item>\n";
}
print "</actionList>"; 
?>

