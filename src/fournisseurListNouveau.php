<?php
header("Content-Type:text/html; charset=iso-8859-15");

//Connexion à la base de données
include 'cnx.php';


// Requête
$query = "SELECT idfournisseur, cle, nom, tel, adresse, adressesuite, cp, ville, pays, compte_tiers, nouveau from fournisseur where nouveau='Oui'";
$result = mysql_query( $query );

print "<fournisseurList>\n";
while( $row = mysql_fetch_object( $result ) )
{
//---------------------------
// Gestion des connexions
//---------------------------
// Connexion_pays
//---------------------------
$query_connexion_pays = "SELECT cle from pays where cle='".$row->pays."'";
$result_connexion_pays = mysql_query( $query_connexion_pays );
$row_connexion_pays = mysql_fetch_object( $result_connexion_pays );
$connexion_pays = '';
if (mysql_num_rows($result_connexion_pays)>0){
$connexion_pays = $row_connexion_pays->cle;
}
//---------------------------



print "<item>
<idfournisseur><![CDATA[".$row->idfournisseur."]]></idfournisseur>
<cle><![CDATA[".$row->cle."]]></cle>
<nom><![CDATA[".$row->nom."]]></nom>
<tel><![CDATA[".$row->tel."]]></tel>
<adresse><![CDATA[".$row->adresse."]]></adresse>
<adressesuite><![CDATA[".$row->adressesuite."]]></adressesuite>
<cp><![CDATA[".$row->cp."]]></cp>
<ville><![CDATA[".$row->ville."]]></ville>
<pays><![CDATA[".$connexion_pays."]]></pays>
<compte_tiers><![CDATA[".$row->compte_tiers."]]></compte_tiers>
<nouveau><![CDATA[".$row->nouveau."]]></nouveau>

</item>\n";
}
print "</fournisseurList>"; 
?>

