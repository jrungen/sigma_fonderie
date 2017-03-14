<?php

//Connexion à la base de données
include 'cnx.php';


// Requête
$query = "SELECT * from depenses_annexes where 1 AND projet='".$_REQUEST['cle']."' AND objet <>'Prestation tourisme d\'affaires'";
$result = mysql_query( $query );

print "<depenses_annexesList>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<iddepenses_annexes>".$row->iddepenses_annexes."</iddepenses_annexes>
<cle>".$row->cle."</cle>
<pays>".$row->pays."</pays>
<date>".substr($row->date,-2)."/".substr($row->date,-5,2)."/".substr($row->date,-10,4)."</date>
<type_depense>".$row->type_depense."</type_depense>
<montant_reglement_ttc>".$row->montant_reglement_ttc."</montant_reglement_ttc>
<montant_ttc>".$row->montant_ttc."</montant_ttc>
<regle_le>".substr($row->regle_le,-2)."/".substr($row->regle_le,-5,2)."/".substr($row->regle_le,-10,4)."</regle_le>
<montant_ht>".$row->montant_ht."</montant_ht>

   </item>\n";
}
print "</depenses_annexesList>"; 
?>

