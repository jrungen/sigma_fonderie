<?php

//Connexion � la base de donn�es
include 'cnx.php';
$textsearch = $_REQUEST['search'];

if ($textsearch!='') $search.=" and cle like '%$textsearch%'";


// Requ�te
$query = "SELECT * from ".$_REQUEST['table']." where 1 ".$search;
$result = mysql_query( $query );

print "<items>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>".$row->cle."</item>\n";
}
print "</items>"; 
?>

