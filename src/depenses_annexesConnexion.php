<?php

//Connexion à la base de données
include 'cnx.php';

$textsearch = $_REQUEST['search'];
$textfiltre = explode("-", $_REQUEST['filtre']);
$filtre1 = $textfiltre[0];
$valeur1 = $textfiltre[1];
$filtre2 = $textfiltre[2];
$valeur2 = $textfiltre[3];

$search = "";
if ($textsearch!='') $search.=" and (cle like '%$textsearch%' OR date like '%$textsearch%' OR iddepenses_annexes like '%$textsearch%' OR type_depense like '%$textsearch%' OR num_comptable like '%$textsearch%' OR montant_ttc like '%$textsearch%' OR regle_le like '%$textsearch%' ) ";
if ($valeur1!='') $search.=" and $filtre1='$valeur1' ";
if ($valeur2!='') $search.=" and $filtre2='$valeur2' ";


// Requête
$query = "SELECT * from depenses_annexes where 1 ".$search." order by cle";
$result = mysql_query( $query );

print "<items>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<cle><![CDATA[".$row->cle."]]></cle>
<date><![CDATA[".substr($row->date,-2)."/".substr($row->date,-5,2)."/".substr($row->date,-10,4)."]]></date>
<iddepenses_annexes><![CDATA[".$row->iddepenses_annexes."]]></iddepenses_annexes>
<type_depense><![CDATA[".$row->type_depense."]]></type_depense>
<num_comptable><![CDATA[".$row->num_comptable."]]></num_comptable>
<montant_ttc><![CDATA[".$row->montant_ttc."]]></montant_ttc>
<regle_le><![CDATA[".substr($row->regle_le,-2)."/".substr($row->regle_le,-5,2)."/".substr($row->regle_le,-10,4)."]]></regle_le>

   </item>\n";
}
print "</items>"; 
?>

