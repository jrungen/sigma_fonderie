<?php

$search=" where idtype_operation = '".$_REQUEST['id']."'";

//Connexion � la base de donnees
include 'cnx.php';



// Requ�te
$query = "UPDATE type_operation set  $search";


$result = mysql_query( $query );

?>



