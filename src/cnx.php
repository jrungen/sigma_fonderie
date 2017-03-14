<?php
//connect to mysql
$mysql_host='bdd.nids.fr';
$mysql_bdd= 'lafonderie_test';
$mysql_login = 'root';
$mysql_password ='MgH1412';

//Connexion
$mysqlconnexion = mysql_connect( $mysql_host, $mysql_login, $mysql_password );

//load the database
mysql_select_db( $mysql_bdd );

?>

