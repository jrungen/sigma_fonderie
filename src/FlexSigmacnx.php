<?php
//connect to mysql
$mysql_host='';
$mysql_bdd= '';
$mysql_login = '';
$mysql_password ='';

//Connexion
$mysqlconnexion = mysql_connect( $mysql_host, $mysql_login, $mysql_password );

//load the database
mysql_select_db( $mysql_bdd );

?>

