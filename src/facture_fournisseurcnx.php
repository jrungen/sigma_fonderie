<?php
//connect to mysql
$mysql_host='localhost';
$mysql_bdd= 'flexsigma';
$mysql_login = 'root';
$mysql_password ='';

//Connexion
$mysqlconnexion = mysql_connect( $mysql_host, $mysql_login, $mysql_password );

//load the database
mysql_select_db( $mysql_bdd );

?>

