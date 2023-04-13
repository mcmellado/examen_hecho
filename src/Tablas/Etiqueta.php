<?php

namespace App\Tablas;

use PDO;

class Etiqueta extends Modelo
{
    protected static string $tabla = 'etiquetas';

    public $id;
    public $nombre;

    public function __construct(array $campos)
    {
        $this->id = $campos['id'];
        $this->nombre = $campos['nombre'];
    }

}
