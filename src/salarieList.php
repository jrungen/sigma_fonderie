<?php
$textsearch = $_REQUEST['search'];
$field = $_REQUEST['field'];
$view = $_REQUEST['view'];

switch ($view) {
	case 'Par d�faut':
	$search="";
	break;
	

}

if ($field=='Tous'){
	if ($textsearch!='') $search.=" and nom like '%$textsearch%'";
}else{
	if ($textsearch!='') $search.=" and $field like '%$textsearch%'";
}

//Connexion � la base de donn�es
include 'cnx.php';


// Requ�te
$query = "SELECT * from salarie where 1 ".$search;
$result = mysql_query( $query );

print "<salarieList>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<nom>".$row->nom."</nom>
<nom>".$row->nom."</nom>
<siteappartenance>".$row->siteappartenance."</siteappartenance>
<cle>".$row->cle."</cle>
<idsalarie>".$row->idsalarie."</idsalarie>

   </item>\n";
}
print "</salarieList>"; 
?>

