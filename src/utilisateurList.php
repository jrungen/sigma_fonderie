<?php
header("Content-Type:text/html; charset=iso-8859-15");
$textsearch = addslashes($_REQUEST['search']);
$field = addslashes($_REQUEST['field']);
$view = addslashes($_REQUEST['view']);
$group = addslashes($_REQUEST['group']);

$s_profil = $_REQUEST['profil'];


$search="";

if ($s_profil!='') $search.="and profil = '".$s_profil."' ";


if ($field=='Tous'){
	if ($textsearch!='') $search.=" and (idutilisateur like '%$textsearch%' OR login like '%$textsearch%' OR profil like '%$textsearch%' OR password like '%$textsearch%' OR cle like '%$textsearch%' ) ";
}else{
	if ($textsearch!='') $search.=" and $field like '%$textsearch%' ";
}

//Connexion à la base de données
include 'cnx.php';

// Requête
$query = "SELECT idutilisateur, login, profil, password, cle, subordonnes from utilisateur where 1 ".$search;
$result = mysql_query( $query );
echo $query;
print "<utilisateurList>\n";
while( $row = mysql_fetch_object( $result ) )
{
print "<item>
<idutilisateur><![CDATA[".$row->idutilisateur."]]></idutilisateur>
<login><![CDATA[".$row->login."]]></login>
<profil><![CDATA[".$row->profil."]]></profil>
<password><![CDATA[".$row->password."]]></password>
<cle><![CDATA[".$row->cle."]]></cle>
<subordonnes><![CDATA[".$row->subordonnes."]]></subordonnes>
</item>\n";
}
print "</utilisateurList>"; 
?>

