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
$query = "SELECT * from type_operation where 1 ".$search;
$result = mysql_query( $query );

print "<type_operationList>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	
   </item>\n";
}
print "</type_operationList>"; 
?>

