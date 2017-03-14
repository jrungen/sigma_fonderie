<?php
header("Content-Type:text/html; charset=iso-8859-15");
$textsearch = $_REQUEST['search'];
$field = $_REQUEST['field'];
$view = $_REQUEST['view'];
$s_categorie = $_REQUEST['categorie'];


$search="";
switch ($view) {
	case 'Par défaut':
	$search="";
	break;
	

}

if ($s_categorie!='') $search.="and categorie = '".$s_categorie."' ";


if ($field=='Tous'){
	if ($textsearch!='') $search.=" and (idmodele_lettre like '%$textsearch%' OR cle like '%$textsearch%' OR intitule like '%$textsearch%' OR categorie like '%$textsearch%' OR note like '%$textsearch%' OR fichier like '%$textsearch%' ) ";
}else{
	if ($textsearch!='') $search.=" and $field like '%$textsearch%' ";
}

//Connexion à la base de données
include 'cnx.php';


// Requête
$query = "SELECT idmodele_lettre, cle, intitule, categorie, note, fichier from modele_lettre where 1 ".$search;
$result = mysql_query( $query );

print "<modele_lettreList>\n";
while( $row = mysql_fetch_object( $result ) )
{
//---------------------------
// Gestion des connexions
//---------------------------


print "<item>
<idmodele_lettre><![CDATA[".$row->idmodele_lettre."]]></idmodele_lettre>
<cle><![CDATA[".$row->cle."]]></cle>
<intitule><![CDATA[".$row->intitule."]]></intitule>
<categorie><![CDATA[".$row->categorie."]]></categorie>
<note><![CDATA[".$row->note."]]></note>
<fichier><![CDATA[".$row->fichier."]]></fichier>

</item>\n";
}
print "</modele_lettreList>"; 
?>

