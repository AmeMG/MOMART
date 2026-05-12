<!doctype html>
<html lang="es">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Sistema de Supermercado - Momart</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<style>
    :root {
        --unilever-blue: #00175a;
        --bright-blue: #12abdb;
        --light-bg: #f4f7fa;
    }
    body { 
        background-color: var(--light-bg); 
        font-family: 'Segoe UI', Arial, sans-serif;
    }
    .navbar-custom {
        background-color: var(--unilever-blue);
        padding: 1rem 0;
        border-bottom: 5px solid var(--bright-blue);
    }
    .navbar-brand {
        color: #ffffff !important;
        font-weight: 800;
        font-size: 1.5rem;
        text-transform: uppercase;
    }
    .card {
        border: none;
        border-radius: 4px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.08);
    }
    .btn-primary {
        background-color: var(--unilever-blue);
        border: none;
        border-radius: 50px; /* Estilo Unilever */
        padding: 12px 30px;
        font-weight: 600;
        transition: 0.3s;
    }
    .btn-primary:hover {
        background-color: var(--bright-blue);
        transform: translateY(-2px);
    }
    .section-title {
        color: var(--unilever-blue);
        border-left: 5px solid var(--bright-blue);
        padding-left: 15px;
        margin-bottom: 25px;
        font-weight: 700;
    }
    .table-custom thead {
        background-color: var(--unilever-blue);
        color: white;
    }
</style>
</head>
<body>

<nav class="navbar navbar-custom mb-5">
    <div class="container">
        <a class="navbar-brand" href="#">SISTEMA DE SUPERMERCADO MOMART</a>
    </div>
</nav>

<div class="container">
