<?php
$id = addslashes($_REQUEST['idtiers']);
$cle = addslashes($_REQUEST['cle']);

//Connexion à la base de données
include 'cnx.php';

// Requête
if($cle==''){
	$query = "SELECT * from tiers where idtiers = '$id'";
}else{
	$query = "SELECT * from tiers where cle = '$cle'";
}
$result = mysql_query( $query );
//echo $query;
/* print out your own XML */
print "<tiersRead>\n";
while( $row = mysql_fetch_object( $result ) )
{

$connexion_pays = $row->pays;

   print "<item>
	<cle><![CDATA[".$row->cle."]]></cle>
<idtiers><![CDATA[".$row->idtiers."]]></idtiers>
<civilite><![CDATA[".$row->civilite."]]></civilite>
<creation_par><![CDATA[".$row->creation_par."]]></creation_par>
<date_creation><![CDATA[".$row->date_creation."]]></date_creation>
<nom><![CDATA[".$row->nom."]]></nom>
<date_modification><![CDATA[".$row->date_modification."]]></date_modification>
<heure_creation><![CDATA[".$row->heure_creation."]]></heure_creation>
<modification_par><![CDATA[".$row->modification_par."]]></modification_par>
<prenom><![CDATA[".$row->prenom."]]></prenom>
<heure_modification><![CDATA[".$row->heure_modification."]]></heure_modification>
<societe><![CDATA[".$row->societe."]]></societe>
<service><![CDATA[".$row->service."]]></service>
<annee><![CDATA[".$row->annee."]]></annee>
<adresse><![CDATA[".$row->adresse."]]></adresse>
<adresse2><![CDATA[".$row->adresse2."]]></adresse2>
<cp><![CDATA[".$row->cp."]]></cp>
<ville><![CDATA[".$row->ville."]]></ville>
<tel><![CDATA[".$row->tel."]]></tel>
<compte_tiers><![CDATA[".$row->compte_tiers."]]></compte_tiers>
<fax><![CDATA[".$row->fax."]]></fax>
<tva_intra><![CDATA[".$row->tva_intra."]]></tva_intra>
<email><![CDATA[".$row->email."]]></email>
<siret><![CDATA[".$row->siret."]]></siret>
<pays><![CDATA[".$connexion_pays."]]></pays>
<pays_cle><![CDATA[".$row->pays."]]></pays_cle>
<nouveau><![CDATA[".$row->nouveau."]]></nouveau>

	</item>\n";
}
print "</tiersRead>";

?>

