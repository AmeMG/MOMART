<?php
session_start();
// Destruye todas las variables de sesión
session_unset();
// Destruye la sesión físicamente en el servidor
session_destroy();

// Redirige al login o a la página principal de acceso
header("Location: Acceso.php"); 
exit();
?>