<?php
session_start();
require '../vendor/autoload.php';
$valoracion = $_GET['valoracion'];
$articulo_id = $_GET['articulo_id'];
$usuario_id = $_GET['usuario_id'];

var_dump($valoracion);
var_dump($articulo_id);
var_dump($usuario_id);

$pdo = conectar();
$sent = $pdo->prepare("INSERT INTO valoraciones (valoracion, usuario_id, articulo_id) VALUES (:valoracion, :usuario_id, :articulo_id)");
$sent->execute([$valoracion, $usuario_id, $articulo_id]);


$sent = $pdo->prepare("UPDATE articulos SET valoracion = :valoracion WHERE id = :id");
$sent->execute([$valoracion, $articulo_id]);
volver();

?>