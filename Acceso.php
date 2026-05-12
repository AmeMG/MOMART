<?php
include "Header.php"; 
?>

<div class="container d-flex align-items-center justify-content-center" style="min-height: 80vh;">
    <div class="card shadow-lg border-0" style="max-width: 500px; width: 100%; border-top: 10px solid var(--unilever-blue) !important;">
        <div class="card-body p-5 text-center">
            <h2 class="fw-bold mb-2">MOMART</h2>
            <p class="text-muted mb-5">Sistema de Gestión de Supermercado</p>
            
            <div class="d-grid gap-3">
                <a href="index.php" class="btn btn-primary py-3 fw-bold shadow-sm">
                    <i class="bi bi-cart-fill me-2"></i> MÓDULO DE VENTAS (CLIENTES)
                </a>
                
                <hr class="my-4">
                
                <a href="inventario.php" class="btn btn-outline-dark py-3 fw-bold">
    <i class="bi bi-box-seam me-2"></i> MODULO PARA EMPLEADOS (STOCK)
</a>
            </div>
            
            <p class="small text-muted mt-5">FES Cuautitlán - Campo 4</p>
        </div>
    </div>
</div>

<?php include "Footer.php"; ?>