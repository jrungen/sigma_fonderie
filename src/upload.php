<?php
header('Content-type: text/html; charset=UTF-8'); 

$tempFile = $_FILES['Filedata']['tmp_name'];
$fileName =  utf8_decode($_FILES['Filedata']['name']);
$fileSize = $_FILES['Filedata']['size'];

move_uploaded_file($tempFile, "./files/" . $fileName);

?>