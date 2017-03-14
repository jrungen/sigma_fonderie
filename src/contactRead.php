<?php
$cle = $_REQUEST['cle'];

//Connexion à la base de données
include 'cnx.php';

// Requête
$query = "SELECT * from contact where cle = '$cle'";
$result = mysql_query( $query );

/* print out your own XML */
print "<contactRead>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<idcontact>".$row->idcontact."</idcontact>
<cle>".$row->cle."</cle>
<tel>".$row->tel."</tel>
<nom>".$row->nom."</nom>
<prenom>".$row->prenom."</prenom>
<mobile>".$row->mobile."</mobile>
<date_creation>".substr($row->date_creation,-2)."/".substr($row->date_creation,-5,2)."/".substr($row->date_creation,-10,4)."</date_creation>
<creation_par>".$row->creation_par."</creation_par>
<fonction>".$row->fonction."</fonction>
<fax>".$row->fax."</fax>
<heure_creation>".$row->heure_creation."</heure_creation>
<societe>".$row->societe."</societe>
<email>".$row->email."</email>
<date_modification>".substr($row->date_modification,-2)."/".substr($row->date_modification,-5,2)."/".substr($row->date_modification,-10,4)."</date_modification>
<modification_par>".$row->modification_par."</modification_par>
<heure_modification>".$row->heure_modification."</heure_modification>
<annee>".$row->annee."</annee>

	</item>\n";
}
print "</contactRead>";

?>

