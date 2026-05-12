<?php
include "ConexionBD.php";
session_start();
$error = "";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id_emp = $_POST['id_empleado'];

    $stmt = $cn->prepare("SELECT id_empleado, nombre_emp FROM empleado WHERE id_empleado = ?");
    $stmt->bind_param("i", $id_emp);
    $stmt->execute();
    $res = $stmt->get_result();

    if ($user = $res->fetch_assoc()) {
        $_SESSION['emp_id'] = $user['id_empleado'];
        $_SESSION['emp_nom'] = $user['nombre_emp'];
        header("Location: inventario.php");
        exit();
    } else {
        $error = "El ID de empleado no existe en el sistema.";
    }
}
include "Header.php";
?>

<div class="container d-flex align-items-center justify-content-center" style="min-height: 80vh;">
    <div class="card shadow-lg border-0" style="max-width: 400px; width: 100%; border-top: 10px solid #005f2e !important;">
        <div class="card-body p-5">
            <div class="text-center mb-4">
                <h3 class="fw-bold" style="color: #005f2e;">ACCESO EMPLEADOS</h3>
                <p class="text-muted small">Módulo de Inventario - MOMART</p>
            </div>
            
            <?php if($error): ?>
                <div class="alert alert-danger p-2 small"><?= $error ?></div>
            <?php endif; ?>

            <form method="POST">
                <div class="mb-4">
                    <label class="form-label small fw-bold text-uppercase text-muted">ID de Empleado</label>
                    <input type="number" name="id_empleado" class="form-control form-control-lg bg-light" placeholder="Ej. 4000" required>
                </div>
                <button type="submit" class="btn btn-success w-100 fw-bold rounded-pill py-2 mb-3" style="background: #005f2e;">
                    CONSULTAR STOCK
                </button>
            </form>

            <div class="pt-3 text-center border-top">
                <div class="d-flex flex-column gap-2">
                    <a href="Acceso.php" class="btn btn-light rounded-pill fw-bold btn-sm py-2 text-muted text-decoration-none shadow-sm">
                        <i class="bi bi-arrow-left me-1"></i> REGRESAR AL INICIO
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<?php include "Footer.php"; ?>