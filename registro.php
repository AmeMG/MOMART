<?php
include "ConexionBD.php";
$msg = "";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $sql = "INSERT INTO cliente (nombre, apellido_paterno, apellido_materno, rfc, domicilio, telefono, email, saldo) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    $stmt = $cn->prepare($sql);
    
    $stmt->bind_param("sssssssd", 
        $_POST['nom'], 
        $_POST['ap'], 
        $_POST['am'], 
        $_POST['rfc'], 
        $_POST['dom'], 
        $_POST['tel'], 
        $_POST['email'],
        $_POST['saldo']
    );
    
    if ($stmt->execute()) {
        header("Location: login.php?reg=success");
        exit();
    } else {
        $msg = "Error al registrar: " . $cn->error;
    }
}

include "Header.php"; 
?>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-lg border-0" style="border-top: 10px solid #001e5f !important;">
                <div class="card-body p-5">
                    <div class="text-center mb-4">
                        <h2 class="fw-bold text-primary">MOMART</h2>
                        <p class="text-muted small text-uppercase fw-bold">Registro de Nuevo Cliente</p>
                    </div>

                    <?php if($msg): ?>
                        <div class="alert alert-danger border-0 shadow-sm small mb-4">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i> <?= $msg ?>
                        </div>
                    <?php endif; ?>

                    <form method="POST">
                        <div class="row mb-3">
                            <div class="col-md-12">
                                <label class="form-label small fw-bold text-muted text-uppercase">Nombre(s)</label>
                                <input type="text" name="nom" class="form-control bg-light" required>
                            </div>
                        </div>
                        
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label small fw-bold text-muted text-uppercase">Apellido Paterno</label>
                                <input type="text" name="ap" class="form-control bg-light" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label small fw-bold text-muted text-uppercase">Apellido Materno</label>
                                <input type="text" name="am" class="form-control bg-light" required>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label small fw-bold text-muted text-uppercase">RFC</label>
                                <input type="text" name="rfc" class="form-control bg-light" maxlength="13" required style="text-transform: uppercase;">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label small fw-bold text-muted text-uppercase">Saldo Inicial</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-white border-end-0">$</span>
                                    <input type="number" step="0.01" name="saldo" class="form-control bg-light border-start-0" placeholder="0.00" required>
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label small fw-bold text-muted text-uppercase">Domicilio Fiscal</label>
                            <textarea name="dom" class="form-control bg-light" rows="2" required></textarea>
                        </div>

                        <div class="row mb-4">
                            <div class="col-md-6">
                                <label class="form-label small fw-bold text-muted text-uppercase">Teléfono</label>
                                <input type="tel" name="tel" class="form-control bg-light" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label small fw-bold text-muted text-uppercase">Correo Electrónico</label>
                                <input type="email" name="email" class="form-control bg-light" required>
                            </div>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary py-3 fw-bold rounded-pill shadow-sm">FINALIZAR REGISTRO</button>
                            <a href="Acceso.php" class="btn btn-light rounded-pill fw-bold btn-sm py-2 text-muted text-decoration-none text-center">
                                <i class="bi bi-arrow-left me-1"></i> REGRESAR AL INICIO
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<?php include "Footer.php"; ?>