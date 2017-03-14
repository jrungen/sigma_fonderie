<?php

//Connexion à la base de données
include 'cnx.php';


// Requête
$query = "SELECT * from contact where 1 and societe='".$_REQUEST['cle']."'";
$result = mysql_query( $query );

print "<contactList>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<idcontact>".$row->idcontact."</idcontact>
<cle>".$row->cle."</cle>
<nom>".$row->nom."</nom>
<prenom>".$row->prenom."</prenom>
<tel>".$row->tel."</tel>
<email>".$row->email."</email>

   </item>\n";
}
print "</contactList>"; 
?>

