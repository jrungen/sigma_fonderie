<?php

//Connexion à la base de données
include 'cnx.php';

// Requête
$query = "SELECT * from societe where nouveau='Oui'";
$result = mysql_query( $query );

print "<societeList>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<nom>".$row->nom."</nom>
<idsociete>".$row->idsociete."</idsociete>
<tel>".$row->tel."</tel>
<cle>".$row->cle."</cle>
<adresse>".$row->adresse."</adresse>
<adressesuite>".$row->adressesuite."</adressesuite>
<cp>".$row->cp."</cp>
<ville>".$row->ville."</ville>
<pays>".$row->pays."</pays>
<compte_tiers><![CDATA[".$row->compte_tiers."]]></compte_tiers>
<nouveau><![CDATA[".$row->nouveau."]]></nouveau>

   </item>\n";
}
print "</societeList>"; 
?>

