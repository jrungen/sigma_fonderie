<?php

//Connexion à la base de données
include 'cnx.php';


// Requête
$query = "SELECT * from projet where 1 and societe='".$_REQUEST['cle']."'";
$result = mysql_query( $query );

print "<projetList>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<numero_code>".$row->numero_code."</numero_code>
<nom>".$row->nom."</nom>
<numero>".$row->numero."</numero>
<societe>".$row->societe."</societe>
<lieu>".$row->lieu."</lieu>
<datedebut>".substr($row->datedebut,-2)."/".substr($row->datedebut,-5,2)."/".substr($row->datedebut,-10,4)."</datedebut>
<datefin>".substr($row->datefin,-2)."/".substr($row->datefin,-5,2)."/".substr($row->datefin,-10,4)."</datefin>
<utilisateur>".$row->utilisateur."</utilisateur>
<ca_ht>".$row->ca_ht."</ca_ht>
<total_marge>".$row->total_marge."</total_marge>
<cle>".$row->cle."</cle>
<idprojet>".$row->idprojet."</idprojet>
<taux_marge>".$row->taux_marge."</taux_marge>

   </item>\n";
}
print "</projetList>"; 
?>

