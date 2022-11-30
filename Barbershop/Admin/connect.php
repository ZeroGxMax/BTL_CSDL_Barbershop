<?php
    $dsn = 'mysql:host=sql6.freesqldatabase.com;dbname=sql6582109';
	$user = 'sql6582109';
	$pass = 'VlX7gkPJrK';
	$option = array(
		PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8'
	);
	try
	{
		$con = new PDO($dsn,$user,$pass,$option);
		$con->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
		//echo 'Good Very Good !';
	}
	catch(PDOException $ex)
	{
		echo "Failed to connect with database ! ".$ex->getMessage();
		die();
	}
?>