<?php
include "ConexionBD.php";
session_start();

$error = "";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'];
    
    $stmt = $cn->prepare("SELECT id_cliente, nombre, apellido_paterno, rfc, domicilio FROM cliente WHERE email = ?");
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $res = $stmt->get_result();

    if ($user = $res->fetch_assoc()) {
        $_SESSION['cliente_id'] = $user['id_cliente'];
        $_SESSION['cliente_nom'] = $user['nombre'] . " " . $user['apellido_paterno'];
        $_SESSION['cliente_rfc'] = $user['rfc'];
        $_SESSION['cliente_dom'] = $user['domicilio'];
        header("Location: index.php");
        exit();
    } else {
        $error = "El correo electrónico ingresado no está registrado.";
    }
}

include "Header.php"; 
?>

<div class="container d-flex align-items-center justify-content-center" style="min-height: 80vh;">
    <div class="card shadow-lg border-0" style="max-width: 450px; width: 100%; border-top: 10px solid #001e5f !important;">
        <div class="card-body p-5">
            <div class="text-center mb-4">
                <h2 class="fw-bold text-primary">MOMART</h2>
                <p class="text-muted small text-uppercase fw-bold">Acceso a Clientes</p>
            </div>
            
            <?php if($error): ?>
                <div class="alert alert-danger border-0 shadow-sm p-3 small mb-4">
                    <i class="bi bi-exclamation-circle-fill me-2"></i> <?= $error ?>
                </div>
            <?php endif; ?>

            <?php if(isset($_GET['reg']) && $_GET['reg'] == 'success'): ?>
                <div class="alert alert-success border-0 shadow-sm p-3 small mb-4">
                    <i class="bi bi-check-circle-fill me-2"></i> ¡Registro exitoso! Ya puedes ingresar.
                </div>
            <?php endif; ?>

            <form method="POST">
                <div class="mb-4">
                    <label class="form-label small fw-bold text-muted text-uppercase">Correo Electrónico</label>
                    <div class="input-group">
                        <span class="input-group-text bg-light border-end-0"><i class="bi bi-envelope"></i></span>
                        <input type="email" name="email" class="form-control border-start-0 bg-light" required placeholder="ejemplo@correo.com">
                    </div>
                </div>

                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary py-3 fw-bold rounded-pill shadow-sm">INGRESAR AL SISTEMA</button>
                </div>
            </form>
            
            <div class="mt-4 pt-3 text-center border-top">
                <p class="small text-muted mb-4">¿Aún no tienes una cuenta con nosotros?</p>
                <div class="d-flex flex-column gap-2">
                    <a href="registro.php" class="btn btn-outline-primary rounded-pill fw-bold btn-sm py-2 text-decoration-none">
                        CREAR UNA CUENTA NUEVA
                    </a>
                    
                    <a href="Acceso.php" class="btn btn-light rounded-pill fw-bold btn-sm py-2 text-muted text-decoration-none">
                        <i class="bi bi-arrow-left me-1"></i> REGRESAR AL INICIO
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<?php include "Footer.php"; ?>