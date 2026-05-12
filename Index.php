<?php
session_start();
include "ConexionBD.php";
include "Header.php";

if (!isset($_SESSION['cliente_id'])) {
    header("Location: login.php");
    exit();
}

$messages = [];
$facturaHTML = ""; 

$resFolio = $cn->query("SELECT MAX(id_pedido) as ultimo FROM pedido WHERE id_pedido BETWEEN 7000 AND 7999");
$rowF = $resFolio->fetch_assoc();
$nuevoFolio = ($rowF['ultimo']) ? $rowF['ultimo'] + 1 : 7001; 

$articulosRs = $cn->query("SELECT sku, descripcion, precio_venta FROM articulo ORDER BY descripcion");
$articulosArr = $articulosRs->fetch_all(MYSQLI_ASSOC);

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['guardar_pedido'])) {
    $folio = intval($_POST['folio_final']); 
    $idCliente = $_SESSION['cliente_id'];
    $fecha = date('Y-m-d'); 
   
    $skus = $_POST['sku'] ?? [];
    $cantidades = $_POST['cantidad'] ?? [];
    $precios = $_POST['precio'] ?? [];

    $cn->begin_transaction();
    $ok = true;

    $subtotal = 0;
    foreach ($skus as $i => $sku) {
        if (!$sku) continue;
        $subtotal += (floatval($cantidades[$i]) * floatval($precios[$i]));
    }
    $iva = round($subtotal * 0.16, 2);
    $total = round($subtotal + $iva, 2);

    $stmtHead = $cn->prepare("INSERT INTO pedido (id_pedido, id_cliente, fecha_pedido, total_neto) VALUES (?, ?, ?, ?)");
    $stmtHead->bind_param("iisd", $folio, $idCliente, $fecha, $total);
    if (!$stmtHead->execute()) $ok = false;

    if ($ok) {
        $stmtDetail = $cn->prepare("INSERT INTO detalle_pedido (id_pedido, sku, cantidad, precio_unitario, importe) VALUES (?, ?, ?, ?, ?)");
        foreach ($skus as $i => $sku) {
            if (!$sku) continue;
            $c = intval($cantidades[$i]);
            $p = floatval($precios[$i]);
            $imp = round($c * $p, 2);
            $stmtDetail->bind_param("isidd", $folio, $sku, $c, $p, $imp);
            if (!$stmtDetail->execute()) { $ok = false; break; }
        }
    }

    if ($ok) {
        $cn->commit();
        $facturaHTML = "
        <div class='modal d-block' style='background: rgba(0,0,0,0.8); z-index: 1050;'>
            <div class='modal-dialog modal-lg'>
                <div class='modal-content border-0 shadow-lg' style='border-top: 15px solid #001e5f !important;'>
                    <div class='modal-body p-5'>
                        <div class='row mb-4'>
                            <div class='col-6'>
                                <h2 class='fw-bold text-primary'>MOMART</h2>
                                <p class='small'>Sucursal FES Cuautitlán<br>Estado de México, MX.</p>
                            </div>
                            <div class='col-6 text-end'>
                                <h4 class='fw-bold text-uppercase'>Ticket de Venta</h4>
                                <p class='mb-0 font-monospace'><strong>#ID.Pedido:</strong> $folio</p> 
                                <p class='small'><strong>Fecha:</strong> $fecha</p>
                            </div>
                        </div>
                        <div class='row mb-4 p-3 bg-light rounded'>
                            <div class='col-12'>
                                <h6 class='fw-bold text-muted small mb-2 text-uppercase'>Datos del Cliente</h6>
                                <p class='mb-1'><strong>Nombre:</strong> {$_SESSION['cliente_nom']}</p>
                                <p class='mb-1'><strong>RFC:</strong> {$_SESSION['cliente_rfc']}</p>
                                <p class='mb-0'><strong>Domicilio:</strong> {$_SESSION['cliente_dom']}</p>
                            </div>
                        </div>
                        <table class='table table-sm align-middle'>
                            <thead class='bg-primary text-white'>
                                <tr><th>Descripción</th><th class='text-center'>Cant.</th><th class='text-end'>Precio</th><th class='text-end'>Importe</th></tr>
                            </thead>
                            <tbody>";
        foreach ($skus as $i => $sku) {
            if (!$sku) continue;
            $nombreArt = "";
            foreach($articulosArr as $a) if($a['sku'] == $sku) $nombreArt = $a['descripcion'];
            $facturaHTML .= "<tr><td>$nombreArt</td><td class='text-center'>{$cantidades[$i]}</td><td class='text-end'>$".number_format($precios[$i],2)."</td><td class='text-end'>$".number_format($cantidades[$i]*$precios[$i],2)."</td></tr>";
        }
        $facturaHTML .= "</tbody></table>
                        <div class='row mt-4 justify-content-end text-end'>
                            <div class='col-5'>
                                <p class='mb-1 small'>Subtotal: <strong>$".number_format($subtotal,2)."</strong></p>
                                <p class='mb-1 small'>IVA (16%): <strong>$".number_format($iva,2)."</strong></p>
                                <hr>
                                <h3 class='text-primary fw-bold'>TOTAL: $".number_format($total,2)."</h3>
                            </div>
                        </div>
                        <div class='text-center mt-5'>
                            <button onclick='window.print()' class='btn btn-outline-dark me-2 px-4'>Imprimir</button>
                            <a href='index.php' class='btn btn-primary px-5'>Cerrar</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>";
    } else {
        $cn->rollback();
    }
}
?>

<div class="container-fluid py-4">
    <div class="row mb-3">
        <div class="col-12 text-end">
            <a href="logout.php" class="btn btn-danger btn-sm px-3 shadow-sm fw-bold">
                <i class="bi bi-box-arrow-left me-1"></i> CERRAR SESIÓN
            </a>
        </div>
    </div>

    <form method="post" id="formVenta">
        <input type="hidden" name="folio_final" value="<?= $nuevoFolio ?>">
        
        <div class="row">
            <div class="col-md-4">
                <div class="card p-4 mb-4 border-0 shadow-sm text-white" style="background: #001e5f;">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="m-0 fw-bold text-uppercase">Nueva Venta</h5>
                        <span class="badge bg-white text-primary px-3 py-2" style="font-size: 0.9rem;">#ID: <?= $nuevoFolio ?></span>
                    </div>
                    
                    <div class="p-3 rounded" style="background: rgba(255,255,255,0.1);">
                        <p class="small text-info fw-bold mb-1 text-uppercase">Cliente Activo</p>
                        <h6 class="fw-bold mb-2"><?= $_SESSION['cliente_nom'] ?></h6>
                        <p class="mb-0 small opacity-75"><strong>RFC:</strong> <?= $_SESSION['cliente_rfc'] ?></p>
                        <p class="mb-0 small opacity-75 text-truncate"><strong>Dir:</strong> <?= $_SESSION['cliente_dom'] ?></p>
                    </div>
                </div>

                <div class="card p-4 border-0 shadow-sm">
                    <h6 class="text-muted fw-bold mb-3 small text-uppercase">Resumen de Cuenta</h6>
                    <div class="d-flex justify-content-between mb-2"><span>Subtotal:</span> <strong id="res-subtotal">$0.00</strong></div>
                    <div class="d-flex justify-content-between mb-2"><span>IVA (16%):</span> <strong id="res-iva">$0.00</strong></div>
                    <hr>
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <span class="fw-bold fs-5">TOTAL:</span>
                        <h2 class="fw-bold mb-0 text-primary" id="res-total">$0.00</h2>
                    </div>
                    <button type="submit" name="guardar_pedido" class="btn btn-primary w-100 py-3 fw-bold rounded-pill shadow">FINALIZAR COMPRA</button>
                </div>
            </div>

            <div class="col-md-8">
                <div class="card p-4 border-0 shadow-sm" style="min-height: 600px;">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h5 class="fw-bold m-0 text-dark text-uppercase">Productos Seleccionados</h5>
                        <button type="button" class="btn btn-sm btn-outline-primary px-4 rounded-pill fw-bold" onclick="addRow()">
                            + Agregar Artículo
                        </button>
                    </div>
                    
                    <div class="table-responsive">
                        <table class="table align-middle" id="detalle">
                            <thead class="bg-light text-muted small text-uppercase">
                                <tr>
                                    <th>Artículo</th>
                                    <th width="130">Precio</th>
                                    <th width="100">Cant.</th>
                                    <th width="130">Importe</th>
                                    <th width="40"></th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<?= $facturaHTML ?>

<script>
const articulos = <?= json_encode($articulosArr) ?>;

function addRow(){
    let tbody = document.querySelector('#detalle tbody');
    let tr = document.createElement('tr');
    tr.innerHTML = `
        <td>
            <select name="sku[]" class="form-select border-0 bg-light" onchange="updatePrice(this)" required>
                <option value="">-- Seleccionar --</option>
                ${articulos.map(a => `<option value="${a.sku}" data-precio="${a.precio_venta}">${a.descripcion}</option>`).join('')}
            </select>
        </td>
        <td><div class="input-group input-group-sm">
            <span class="input-group-text border-0 bg-transparent">$</span>
            <input name="precio[]" class="form-control-plaintext precio ps-1" readonly value="0.00">
        </div></td>
        <td><input type="number" name="cantidad[]" class="form-control form-control-sm text-center" value="1" min="1" oninput="calcImporte(this)"></td>
        <td><div class="input-group input-group-sm">
            <span class="input-group-text border-0 bg-transparent fw-bold">$</span>
            <input name="importe[]" class="form-control-plaintext importe ps-1 fw-bold" readonly value="0.00">
        </div></td>
        <td><button type="button" class="btn btn-link text-danger p-0 text-decoration-none" onclick="this.closest('tr').remove(); actualizarTotales();">✕</button></td>
    `;
    tbody.appendChild(tr);
}

function updatePrice(sel){
    let precio = sel.options[sel.selectedIndex].dataset.precio || 0;
    let tr = sel.closest('tr');
    tr.querySelector('.precio').value = parseFloat(precio).toFixed(2);
    calcImporte(tr.querySelector('input[name="cantidad[]"]'));
}

function calcImporte(input){
    let tr = input.closest('tr');
    let c = parseFloat(input.value) || 0;
    let p = parseFloat(tr.querySelector('.precio').value) || 0;
    tr.querySelector('.importe').value = (c * p).toFixed(2);
    actualizarTotales();
}

function actualizarTotales() {
    let subtotal = 0;
    document.querySelectorAll('.importe').forEach(i => subtotal += parseFloat(i.value) || 0);
    let iva = subtotal * 0.16;
    let total = subtotal + iva;

    document.getElementById('res-subtotal').innerText = '$' + subtotal.toLocaleString('en-US', {minimumFractionDigits: 2});
    document.getElementById('res-iva').innerText = '$' + iva.toLocaleString('en-US', {minimumFractionDigits: 2});
    document.getElementById('res-total').innerText = '$' + total.toLocaleString('en-US', {minimumFractionDigits: 2});
}

window.onload = () => { addRow(); };
</script>

<?php include "Footer.php"; ?>