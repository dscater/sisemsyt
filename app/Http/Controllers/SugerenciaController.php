<?php

namespace App\Http\Controllers;

use App\Models\DetalleVenta;
use App\Models\Producto;
use App\Models\StockMinimo;
use Illuminate\Http\Request;

class SugerenciaController extends Controller
{

    protected $model;

    /**
     * Entrenar el modelo con datos de ventas para predecir el stock mínimo necesario
     * 
     */
    private function entrenarModelo()
    {
        //Algoritmo usado descubrir patrones de productos frecuentemente comprados
        $ventas = DetalleVenta::all()->groupBy('venta_id');
        $data = [];

        foreach ($ventas as $venta) {
            $productos = $venta->pluck('producto_id')->toArray();
            $nombresProductos = Producto::whereIn('id', $productos)->pluck('nombre')->toArray();
            $data[] = $nombresProductos;
        }

        $this->model = new KNearestNeighbors($data);
    }

    /**
     * Predecir el stock mínimo recomendado para un producto basándose en las cantidad de ventas
     */
    private function predecirStockMinimo($productoId)
    {
        $productoNombre = Producto::where('id', $productoId)->value('nombre');
        $recomendaciones = $this->model->predict([$productoNombre]);

        if (!empty($recomendaciones)) {
            return Producto::whereIn('nombre', $recomendaciones[0])->pluck('id');
        }

        return collect();
    }

    /**
     * Predice el stok minimo de un producto
     *
     */
    private function predecirStock($productoId)
    {
        $stockMinimo = $this->predecirStockMinimo($productoId);
        return response()->json(['productos_recomendados' => $stockMinimo]);
    }

    /**
     * Funcion que generar el stock minimo por cada producto de la base de datos
     *
     */
    public function generarStockMinimo()
    {
        // entrenar
        $this->entrenarModelo();

        // obtener el stock min. de cada producto
        $productos = Producto::where("status", 1)->get()->map(function ($producto) {
            $stock_minimo = $this->predecirStock($producto->id);
            $producto->stock_minimo = $stock_minimo;
            return $producto;
        });

        return response()->JSON([
            "productos" => $productos
        ]);
    }


    /**
     * Guardar los nuevos stock minimos de cada producto en la base de datos
     *
     */
    public function guardar(Request $request)
    {
        $productos = $request->productos;
        foreach ($productos as $item) {
            $producto = Producto::find($item["id"]);
            if ($producto) {
                $producto->stock_min = $item["total_vendido"];
                $producto->save();
            }
        }

        return response()->JSON([
            "message" => "Registro éxitoso"
        ]);
    }

    public function store(Request $request)
    {
        $productos = Producto::where("status", 1)->get()->map(function ($producto) {
            $fecha_actual = date("Y-m-d");
            $fecha_mes_actual = date("Y-m");
            $mes_anterior = date("Y-m", strtotime($fecha_actual . "-1 month"));

            $ultimo_dia_mes_anterior = date("t", strtotime($mes_anterior . "-01"));
            $ultimo_dia_mes_actual = date("t", strtotime($fecha_mes_actual . "-01"));

            $total_ventas = DetalleVenta::select("detalle_ventas.*")
                ->join("ventas", "ventas.id", "=", "detalle_ventas.venta_id")
                ->where("ventas.status", 1)
                ->whereBetween("ventas.fecha_registro", ["$mes_anterior-01", "$mes_anterior-$ultimo_dia_mes_anterior"])
                ->where("producto_id", $producto->id)
                ->sum("cantidad");

            if ($total_ventas == 0) {
                $total_ventas = DetalleVenta::select("detalle_ventas.*")
                    ->join("ventas", "ventas.id", "=", "detalle_ventas.venta_id")
                    ->where("ventas.status", 1)
                    ->whereBetween("ventas.fecha_registro", ["$fecha_mes_actual-01", "$fecha_mes_actual-$ultimo_dia_mes_actual"])
                    ->where("producto_id", $producto->id)
                    ->sum("cantidad");
            }

            // Agregar el total vendido al producto
            $total = $total_ventas * 1.25;
            $total = round($total, 0);
            $producto->total_vendido = $total;

            return $producto;
        });


        $productos->each(function ($producto) {
            StockMinimo::create([
                'producto_id' => $producto->id,
                'fecha' => date("Y-m-d"),
                'stock_min' => $producto->total_vendido,
                'status' => 1,
            ]);
        });

        return response()->JSON([
            "productos" => $productos
        ]);
    }
}
