<?php

$search=" where idtype_operation = '".$_REQUEST['id']."'";

//Connexion ˆ la base de donnees
include 'cnx.php';



// Requête
$query = "UPDATE type_operation set  $search";


$result = mysql_query( $query );

?>



