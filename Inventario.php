<?php
session_start();
if (!isset($_SESSION['emp_id'])) {
    header("Location: login_empleado.php");
    exit();
}

include "ConexionBD.php";
include "Header.php";

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['realizar_pedido'])) {
    $sku = $_POST['sku'];
    $cantidad = intval($_POST['cantidad_nueva']);
    $fecha_actual = date('Y-m-d');

    $queryProv = $cn->prepare("SELECT id_proveedor, precio_unitario FROM surte_proveedor WHERE sku = ? ORDER BY fecha_entrega DESC LIMIT 1");
    $queryProv->bind_param("s", $sku);
    $queryProv->execute();
    $resProv = $queryProv->get_result()->fetch_assoc();

    if ($resProv) {
        $id_proveedor = $resProv['id_proveedor'];
        $precio_unitario = $resProv['precio_unitario'];
        $costo_total = $precio_unitario * $cantidad;

        $cn->begin_transaction();

        try {
            $stmtInsert = $cn->prepare("INSERT INTO surte_proveedor (id_proveedor, sku, fecha_entrega, precio_unitario, cantidad, costo_compra) VALUES (?, ?, ?, ?, ?, ?)");
            $stmtInsert->bind_param("isssid", $id_proveedor, $sku, $fecha_actual, $precio_unitario, $cantidad, $costo_total);
            $stmtInsert->execute();

            $stmtUpdate = $cn->prepare("UPDATE articulo SET stock_disponible = stock_disponible + ? WHERE sku = ?");
            $stmtUpdate->bind_param("is", $cantidad, $sku);
            $stmtUpdate->execute();

            $cn->commit();
            echo "<script>alert('Pedido realizado con éxito al proveedor. El stock ha sido actualizado.'); window.location='inventario.php';</script>";
        } catch (Exception $e) {
            $cn->rollback();
            echo "<script>alert('Error crítico: No se pudo procesar el pedido.');</script>";
        }
    } else {
        echo "<script>alert('Error: No hay un proveedor previo registrado para este SKU.');</script>";
    }
}

$articulosRs = $cn->query("SELECT sku, descripcion, stock_disponible, precio_venta FROM articulo ORDER BY descripcion");

$imagenes_productos = [
    'A1001' => 'https://images.unsplash.com/photo-1586201375761-83865001e31c?auto=format&fit=crop&w=400&q=80', // Aceite
    'A1002' => 'https://tse3.mm.bing.net/th/id/OIP.6Dln75hsLTbxS4-TZ7PE1wHaFj?rs=1&pid=ImgDetMain&o=7&rm=3', // Arroz
    'A1003' => 'https://images.pexels.com/photos/248412/pexels-photo-248412.jpeg?auto=compress&cs=tinysrgb&w=400', // Leche
    'A1004' => 'https://i5.walmartimages.com.mx/gr/images/product-images/img_large/00750102600460L.jpg', // Detergente
    'A1005' => 'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?auto=format&fit=crop&w=400&q=80', // Azúcar
    'A1006' => 'https://images.unsplash.com/photo-1604503468506-a8da13d82791?auto=format&fit=crop&w=400&q=80', // Café
    'A1007' => 'https://tse1.mm.bing.net/th/id/OIP.HfQFQpvgCus5JKxS42FLGgHaEC?rs=1&pid=ImgDetMain&o=7&rm=3', // Pan
    'A1008' => 'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?auto=format&fit=crop&w=400&q=80', // Refresco
    'A1009' => 'https://distribuidoramagdalena.cl/cdn/shop/products/jamon-100-pavo-250-g-aprox-gourmet-internacional-granja-magdalena-848102.jpg?v=1684301873&width=2040', // Jamón
    'A1010' => 'https://tse1.explicit.bing.net/th/id/OIP.7J3bWeAOE5pRfrUuPhNHKQHaEk?rs=1&pid=ImgDetMain&o=7&rm=3', // Queso
    'A1011' => 'https://images.unsplash.com/photo-1585325701165-351af916e581?auto=format&fit=crop&w=400&q=80', // Manzanas
    'A1012' => 'https://images.unsplash.com/photo-1535585209827-a15fcdbc4c2d?auto=format&fit=crop&w=400&q=80', // Shampoo
    'A1013' => 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=400&q=80', // Vitaminas
];
?>

<style>
    .card-inventario { border: none; border-radius: 15px; transition: 0.3s; background: #fff; }
    .card-inventario:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.1) !important; }
    .img-box { height: 160px; overflow: hidden; border-radius: 15px 15px 0 0; }
    .img-box img { width: 100%; height: 100%; object-fit: cover; }
    .alerta-baja { background: #ff3b30; color: white; font-weight: bold; text-align: center; font-size: 0.7rem; padding: 5px; animation: focus 1s infinite alternate; }
    @keyframes focus { from { opacity: 1; } to { opacity: 0.6; } }
    .btn-proveedor { background-color: #001e5f; color: white; font-size: 0.75rem; font-weight: bold; border-radius: 20px; }
    .btn-proveedor:hover { background-color: #0036ab; color: white; }
</style>

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold mb-0">Gestión de Existencias - MOMART</h3>
            <span class="badge bg-success">Empleado: <?= $_SESSION['emp_nom'] ?></span>
        </div>
        <div>
            <a href="logout.php" class="btn btn-danger btn-sm">Cerrar Sesión</a>
        </div>
    </div>

    <div class="row row-cols-1 row-cols-md-3 row-cols-lg-4 g-4">
        <?php while ($art = $articulosRs->fetch_assoc()): 
            $sku = $art['sku'];
            $stock = (int)$art['stock_disponible'];
            $img = $imagenes_productos[$sku] ?? 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=400&q=80';
        ?>
            <div class="col">
                <div class="card h-100 shadow-sm card-inventario">
                    <div class="img-box">
                        <img src="<?= $img ?>" alt="<?= $art['descripcion'] ?>">
                    </div>
                    <div class="card-body d-flex flex-column">
                        <?php if ($stock < 16): ?>
                            <div class="alerta-baja rounded mb-2">¡REABASTECER!</div>
                        <?php endif; ?>
                        
                        <h6 class="fw-bold mb-0"><?= $art['descripcion'] ?></h6>
                        <small class="text-muted">SKU: <?= $sku ?></small>
                        
                        <div class="d-flex justify-content-between mt-3 mb-3">
                            <span class="fw-bold text-success">$<?= number_format($art['precio_venta'], 2) ?></span>
                            <span class="badge <?= ($stock < 16) ? 'bg-danger' : 'bg-success' ?>">
                                <?= $stock ?> piezas
                            </span>
                        </div>

                        <form method="POST" class="mt-auto border-top pt-3">
                            <input type="hidden" name="sku" value="<?= $sku ?>">
                            <div class="mb-2">
                                <input type="number" name="cantidad_nueva" class="form-control form-control-sm text-center" placeholder="Cant. a pedir" required min="1">
                            </div>
                            <button type="submit" name="realizar_pedido" class="btn btn-proveedor w-100 py-2 shadow-sm">
                                <i class="bi bi-truck me-1"></i> PEDIDO A PROVEEDOR
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        <?php endwhile; ?>
    </div>
</div>

<?php include "Footer.php"; ?>