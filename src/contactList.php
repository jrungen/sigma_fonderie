<?php
$textsearch = $_REQUEST['search'];
$field = $_REQUEST['field'];
$view = $_REQUEST['view'];


$search="";
switch ($view) {
	case 'Par d�faut':
	$search="";
	break;
	

}




if ($field=='Tous'){
	if ($textsearch!='') $search.=" and (idcontact like '%$textsearch%' OR cle like '%$textsearch%' OR nom like '%$textsearch%' ) ";
}else{
	if ($textsearch!='') $search.=" and $field like '%$textsearch%' ";
}

//Connexion � la base de donn�es
include 'cnx.php';


// Requ�te
$query = "SELECT * from contact where 1 ".$search;
$result = mysql_query( $query );

print "<contactList>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<idcontact>".$row->idcontact."</idcontact>
<cle>".$row->cle."</cle>
<nom>".$row->nom."</nom>

   </item>\n";
}
print "</contactList>"; 
?>

