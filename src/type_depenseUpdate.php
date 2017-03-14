<?php

$search=" where idtype_depense = '".$_REQUEST['id']."'";

//Connexion ˆ la base de donnees
include 'cnx.php';



// Requête
$query = "UPDATE type_depense set  $search";


$result = mysql_query( $query );

?>



