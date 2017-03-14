<?php
$cle = $_REQUEST['cle'];

//Connexion à la base de données
include 'cnx.php';

// Requête
$query = "SELECT * from societe where cle = '$cle'";
$result = mysql_query( $query );

/* print out your own XML */
print "<societeRead>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<nom>".$row->nom."</nom>
<idsociete>".$row->idsociete."</idsociete>
<tel>".$row->tel."</tel>
<cle>".$row->cle."</cle>
<caht>".$row->caht."</caht>
<fax>".$row->fax."</fax>
<adresse>".$row->adresse."</adresse>
<date_creation>".substr($row->date_creation,-2)."/".substr($row->date_creation,-5,2)."/".substr($row->date_creation,-10,4)."</date_creation>
<creation_par>".$row->creation_par."</creation_par>
<margeht>".$row->margeht."</margeht>
<email>".$row->email."</email>
<adressesuite>".$row->adressesuite."</adressesuite>
<heure_creation>".$row->heure_creation."</heure_creation>
<cp>".$row->cp."</cp>
<siret>".$row->siret."</siret>
<date_modification>".substr($row->date_modification,-2)."/".substr($row->date_modification,-5,2)."/".substr($row->date_modification,-10,4)."</date_modification>
<modification_par>".$row->modification_par."</modification_par>
<ville>".$row->ville."</ville>
<pays>".$row->pays."</pays>
<heure_modification>".$row->heure_modification."</heure_modification>
<type>".$row->type."</type>
<tva_intra>".$row->tva_intra."</tva_intra>
<annee>".$row->annee."</annee>
<profil>".$row->profil."</profil>
<compte_tiers><![CDATA[".$row->compte_tiers."]]></compte_tiers>
<nouveau><![CDATA[".$row->nouveau."]]></nouveau>


	</item>\n";
}
print "</societeRead>";

?>

