<?php
$search="";

//Connexion à la base de données
include 'cnx.php';
$search = "AND nouveau='Oui'";
//echo $search;

// Requête
$query = "SELECT * from projet where 1 ".$search;
//echo $query;

$result = mysql_query( $query );

print "<projetList>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<societe>".$row->societe."</societe>
<cle>".$row->cle."</cle>
<idprojet>".$row->idprojet."</idprojet>
<lieu>".$row->lieu."</lieu>
<nom>".$row->nom."</nom>
<datedebut>".substr($row->datedebut,-2)."/".substr($row->datedebut,-5,2)."/".substr($row->datedebut,-10,4)."</datedebut>
<datefin>".substr($row->datefin,-2)."/".substr($row->datefin,-5,2)."/".substr($row->datefin,-10,4)."</datefin>
<numero>".$row->numero."</numero>
<numero_code>".$row->numero_code."</numero_code>
<utilisateur>".$row->utilisateur."</utilisateur>
<ca_ht>".$row->ca_ht."</ca_ht>
<total_marge>".$row->total_marge."</total_marge>
<taux_marge>".$row->taux_marge."</taux_marge>
<libelle>".$row->libelle."</libelle>

   </item>\n";
}
print "</projetList>"; 
?>

