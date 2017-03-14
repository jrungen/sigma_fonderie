<?php
header("Content-Type:text/html; charset=iso-8859-15");

//Connexion a la base de donn�es
include 'cnx.php';


// Requete
$query = "SELECT * from action where date_debut = curdate() and type like 'Demande%'";
$result = mysql_query( $query );
echo $query;
print "<actionList>\n";
while( $row = mysql_fetch_object( $result ) )
{

print "<item>
<idaction><![CDATA[".$row->idaction."]]></idaction>
<cle><![CDATA[".$row->cle."]]></cle>
<nom><![CDATA[".$row->nom."]]></nom>
<type><![CDATA[".$row->type."]]></type>
<statut><![CDATA[".$row->statut."]]></statut>
<date_fin><![CDATA[".$row->date_fin."]]></date_fin>
<fournisseur><![CDATA[".$row->fournisseur."]]></fournisseur>
<utilisateur><![CDATA[".$row->utilisateur."]]></utilisateur>
<date_debut><![CDATA[".$row->date_debut."]]></date_debut>
<duree><![CDATA[".$row->duree."]]></duree>
</item>\n";
}
print "</actionList>"; 
?>