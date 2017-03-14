<?php
$table = $_REQUEST['categorie'];
$id = $_REQUEST['id'];

//Connexion à la base de données
include 'cnx.php';


// Requête
$query = "delete from $table where id$table = '$id'";
$result = mysql_query( $query );



?>


