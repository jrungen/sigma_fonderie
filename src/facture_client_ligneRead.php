<?php
$cle = $_REQUEST['cle'];

//Connexion � la base de donn�es
include 'cnx.php';

// Requ�te
$query = "SELECT * from facture_client_ligne where cle = '$cle'";
$result = mysql_query( $query );

/* print out your own XML */
print "<facture_client_ligneRead>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<cle>".$row->cle."</cle>
<facture_client>".$row->facture_client."</facture_client>
<idfacture_client_ligne>".$row->idfacture_client_ligne."</idfacture_client_ligne>
<date_creation>".substr($row->date_creation,-2)."/".substr($row->date_creation,-5,2)."/".substr($row->date_creation,-10,4)."</date_creation>
<creation_par>".$row->creation_par."</creation_par>
<heure_creation>".$row->heure_creation."</heure_creation>
<taux_tva>".$row->taux_tva."</taux_tva>
<designation>".$row->designation."</designation>
<date_modification>".substr($row->date_modification,-2)."/".substr($row->date_modification,-5,2)."/".substr($row->date_modification,-10,4)."</date_modification>
<modification_par>".$row->modification_par."</modification_par>
<qte>".$row->qte."</qte>
<heure_modification>".$row->heure_modification."</heure_modification>
<puht>".$row->puht."</puht>
<annee>".$row->annee."</annee>
<cas>".$row->cas."</cas>
<puttc>".$row->puttc."</puttc>
<total_montant_ht>".$row->total_montant_ht."</total_montant_ht>
<total_montant_ttc>".$row->total_montant_ttc."</total_montant_ttc>
<objet_parent>".$row->objet_parent."</objet_parent>
<type>".$row->type."</type>
	</item>\n";
}
print "</facture_client_ligneRead>";

?>

