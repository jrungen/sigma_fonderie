<?php
header("Content-Type:text/html; charset=iso-8859-15");
$s_categorie = $_REQUEST['categorie'];


$search="";

if ($s_categorie!='') $search.="and categorie = '".$s_categorie."' ";



//Connexion � la base de donn�es
include 'cnx.php';


// Requ�te
$query = "SELECT cle, champs, clause, categorie from vue where 1 ".$search;
$result = mysql_query( $query );

print "<vueList>\n";
print "<item>
<intitule><![CDATA[Par d�faut]]></intitule>
</item>\n";

while( $row = mysql_fetch_object( $result ) )
{
//---------------------------
// Gestion des connexions
//---------------------------


print "<item>
<intitule><![CDATA[".$row->cle."]]></intitule>
</item>\n";
}
print "</vueList>"; 
?>

