<?php

namespace App\Http\Controllers;

use App\Models\Producto;
use Illuminate\Http\Request;

class InicioController extends Controller
{
    public function stock_productos()
    {
        $categories = [];
        $data = [];
        $productos = Producto::all();
        foreach ($productos as $item) {
            $categories[] = $item->nombre;
            $data[] = $item->stock_actual;
        }

        return response()->JSON([
            "categories" => $categories,
            "data" => $data,
        ]);
    }
}
