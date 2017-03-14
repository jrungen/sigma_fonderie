<?php

//Connexion à la base de données
include 'cnx.php';


// Requête
$query = "SELECT * from facture_client_ligne where 1 and facture_client='".$_REQUEST['cle']."' order by idfacture_client_ligne";
$result = mysql_query( $query );

print "<facture_client_ligneList>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<designation>".$row->designation."</designation>
<qte>".$row->qte."</qte>
<puht>".$row->puht."</puht>
<total_montant_ht>".$row->total_montant_ht."</total_montant_ht>
<total_montant_ttc>".$row->total_montant_ttc."</total_montant_ttc>
<cle>".$row->cle."</cle>
<idfacture_client_ligne>".$row->idfacture_client_ligne."</idfacture_client_ligne>

   </item>\n";
}
print "</facture_client_ligneList>"; 
?>