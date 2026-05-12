<?php
$host = 'localhost';
$user = 'root';
$password = '';
$dbname = 'sistema_supermercado';

$cn = new mysqli($host, $user, $password, $dbname);

if ($cn->connect_error) {
    die("Error de conexión: " . $cn->connect_error);
}

$cn->set_charset('utf8mb4');
date_default_timezone_set('America/Mexico_City');
?>
