<?php

namespace App\Http\Controllers;

use App\Models\DetalleVenta;
use App\Models\IngresoProducto;
use App\Models\Producto;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;

class AlgoritmoColaborativoController extends Controller
{
    /**
     * Entrenar el modelo de filtrado colaborativo Item-Based basado en las ventas de productos.
     */
    public function entrenarConsumo()
    {
        // Paso 1: Obtener todas las ventas
        $ventas = DetalleVenta::all();

        // Paso 2: Agrupar productos por transacción (venta)
        $transacciones = [];
        foreach ($ventas as $venta) {
            $transacciones[$venta->venta_id][] = $venta->producto_id;
        }

        // Paso 3: Construir vectores de ítems (cada ítem con las transacciones en las que aparece)
        $itemVector = [];
        foreach ($transacciones as $transaccion) {
            foreach ($transaccion as $productoId) {
                if (!isset($itemVector[$productoId])) {
                    $itemVector[$productoId] = [];
                }
                $itemVector[$productoId][] = $transaccion;
            }
        }

        // Paso 4: Calcular la similitud de coseno entre ítems
        $similaridadItems = [];
        $productos = array_keys($itemVector);
        $totalProductos = count($productos);

        for ($i = 0; $i < $totalProductos; $i++) {
            for ($j = $i + 1; $j < $totalProductos; $j++) {
                $productoA = $productos[$i];
                $productoB = $productos[$j];
                $similarity = $this->cosineSimilarity($itemVector[$productoA], $itemVector[$productoB]);

                if ($similarity > 0) {
                    $similaridadItems[$productoA][$productoB] = $similarity;
                    $similaridadItems[$productoB][$productoA] = $similarity;
                }
            }
        }

        // Paso 5: Guardar la matriz de similitud en almacenamiento
        Storage::put('models/consumo_similarity_matrix.json', json_encode($similaridadItems));

        return true;
    }

    /**
     * Predecir el consumo de un producto específico usando el modelo Item-Based.
     */
    public function predecirConsumo($productoId = null, $topN = 5)
    {
        // Verificar si el modelo existe
        if (!Storage::exists('models/consumo_similarity_matrix.json')) {
            throw new Exception("El modelo de consumo no ha sido entrenado aún", 400);
        }

        // Cargar la matriz de similitud
        $similaridadItems = json_decode(Storage::get('models/consumo_similarity_matrix.json'), true);

        if (!isset($similaridadItems[$productoId])) {
            throw new Exception("roducto consultado no encontrado en el modelo", 404);
        }

        // Obtener los productos similares y ordenarlos por similitud descendente
        $productosSimilares = $similaridadItems[$productoId];
        arsort($productosSimilares);

        // Seleccionar los top N productos
        $productosRecomendadosIds = array_slice(array_keys($productosSimilares), 0, $topN);
        $productosRecomendados = Producto::whereIn('id', $productosRecomendadosIds)->get();

        return $productosRecomendados;
    }

    /**
     * Entrenar el modelo de filtrado colaborativo Item-Based basado en los ingresos de productos.
     */
    public function entrenarSuministro()
    {
        // Paso 1: Obtener todos los ingresos de productos
        $ingresos = IngresoProducto::all();

        // Paso 2: Agrupar productos por transacción (ingreso)
        $transacciones = [];
        foreach ($ingresos as $ingreso) {
            $transacciones[$ingreso->ingreso_id][] = $ingreso->producto_id;
        }

        // Paso 3: Construir vectores de ítems
        $itemVector = [];
        foreach ($transacciones as $transaccion) {
            foreach ($transaccion as $productoId) {
                if (!isset($itemVector[$productoId])) {
                    $itemVector[$productoId] = [];
                }
                $itemVector[$productoId][] = $transaccion;
            }
        }

        // Paso 4: Calcular la similitud de coseno entre ítems
        $similaridadItems = [];
        $productos = array_keys($itemVector);
        $totalProductos = count($productos);

        for ($i = 0; $i < $totalProductos; $i++) {
            for ($j = $i + 1; $j < $totalProductos; $j++) {
                $productoA = $productos[$i];
                $productoB = $productos[$j];
                $similarity = $this->cosineSimilarity($itemVector[$productoA], $itemVector[$productoB]);

                if ($similarity > 0) {
                    $similaridadItems[$productoA][$productoB] = $similarity;
                    $similaridadItems[$productoB][$productoA] = $similarity;
                }
            }
        }

        // Paso 5: Guardar la matriz de similitud en almacenamiento
        Storage::put('models/suministro_similarity_matrix.json', json_encode($similaridadItems));

        return true;
    }

    /**
     * Predecir el suministro de un producto específico usando el modelo Item-Based.
     */
    public function predecirSuministro($productoId = null, $topN = 5)
    {
        // Verificar si el modelo existe
        if (!Storage::exists('models/suministro_similarity_matrix.json')) {
            throw new Exception("El modelo de consumo no ha sido entrenado aún", 400);
        }

        // Cargar la matriz de similitud
        $similaridadItems = json_decode(Storage::get('models/suministro_similarity_matrix.json'), true);

        if (!isset($similaridadItems[$productoId])) {
            throw new Exception("roducto consultado no encontrado en el modelo", 404);
        }

        // Obtener los productos similares y ordenarlos por similitud descendente
        $productosSimilares = $similaridadItems[$productoId];
        arsort($productosSimilares);

        // Seleccionar los top N productos
        $productosRecomendadosIds = array_slice(array_keys($productosSimilares), 0, $topN);
        $productosRecomendados = Producto::whereIn('id', $productosRecomendadosIds)->get();

        return $productosRecomendados;
    }

    /**
     * Función auxiliar para calcular la similitud de coseno entre dos vectores.
     * @param array $itemsA Transacciones en las que aparece el ítem A
     * @param array $itemsB Transacciones en las que aparece el ítem B
     * @return float Similitud de coseno
     */
    private function cosineSimilarity($itemsA, $itemsB)
    {
        // Convertir listas de transacciones a conjuntos para la intersección
        $setA = array_map('serialize', $itemsA);
        $setB = array_map('serialize', $itemsB);

        $common = count(array_intersect($setA, $setB));
        $countA = count($setA);
        $countB = count($setB);

        if ($countA == 0 || $countB == 0) {
            return 0;
        }

        // Calcular la similitud de coseno
        return $common / sqrt($countA * $countB);
    }

    public function analisis_suministro(Request $request)
    {
        // entrenar el modelo de suministro
        $this->entrenarSuministro();

        $c_meses = $request->c_meses;
        $filtro = $request->filtro;
        $meses_txt = [
            "01" => "ENERO",
            "02" => "FEBRERO",
            "03" => "MARZO",
            "04" => "ABRIL",
            "05" => "MAYO",
            "06" => "JUNIO",
            "07" => "JULIO",
            "08" => "AGOSTO",
            "09" => "SEPTIEMBRE",
            "10" => "OCTUBRE",
            "11" => "NOVIEMBRE",
            "12" => "DICIEMBRE",
        ];
        $fmd = [];
        if ($c_meses > 0) {
            $fecha = date("Y-m");
            $factual = date("Y-m-d", strtotime($fecha . "-01"));
            $actual = date("m");
            $fmd = [];

            $m1 = date("Y-m", strtotime($factual . '-1 month'));
            $m2 = date("Y-m", strtotime($factual . '-2 month'));
            $m3 = date("Y-m", strtotime($factual . '-3 month'));

            // preparar los meses de predicción
            $faumento = $factual;
            for ($i = 0; $i < $c_meses; $i++) {
                $faumento = date("Y-m-d", strtotime($faumento . "+1 month"));
                $sum_d = $faumento;
                $mes_index = date("m", strtotime($sum_d));
                $fmd[] = [
                    "id" => "c" . $i,
                    "title" => "SUMINISTROS PARA " . $meses_txt[$mes_index] . " - " . date("Y", strtotime($sum_d)),
                    "fecha" => $sum_d,
                    "datos" => [],
                ];
                $productos = Producto::all();

                if ($filtro == 'prediccion') {
                    // entrenar el modelo para el suministro
                    // obtener el producto con mayor ingresos para la predicción
                    $producto_id = DB::select("SELECT sum(cantidad) as tc, producto_id FROM ingreso_productos ORDER BY tc desc")[0];
                    // asignar el ID del producto
                    $producto_id = $producto_id->producto_id;
                    // obtener los productos
                    $contProdVendidos = DetalleVenta::select("detalle_ventas.producto_id")->distinct("producto_id")->count();
                    $productos = $this->predecirSuministro($producto_id, $contProdVendidos);

                    $datos = [];
                    foreach ($productos as $item) {
                        // obtener el producto
                        $producto = Producto::find($item);
                        // generar un promedio segun el ingreso de productos para mostrarlo en gráfica
                        // segun la cantidad de meses a predecir
                        $res = (float)self::getValueProd($producto->id);
                        if ($res > 0) {
                            $datos[] = [$item->nombre, $res];
                        } else {
                            // no se encontró ningun registro
                            $datos[] = [$item->nombre, 0];
                        }
                    }
                } else {
                    $datos = [];
                    foreach ($productos as $item) {
                        $total = 0;
                        $reg1 = IngresoProducto::where("fecha_registro", "LIKE", "%$m1")
                            ->where("producto_id", $item->id)
                            ->sum("cantidad");
                        if ($reg1) {
                            $total += (float)$reg1;
                        }
                        $reg2 = IngresoProducto::where("fecha_registro", "LIKE", "%$m2")
                            ->where("producto_id", $item->id)
                            ->sum("cantidad");
                        if ($reg2) {
                            $total += (float)$reg2;
                        }
                        $reg3 = IngresoProducto::where("fecha_registro", "LIKE", "%$m3")
                            ->where("producto_id", $item->id)
                            ->sum("cantidad");
                        if ($reg3) {
                            $total += (float)$reg3;
                        }

                        $total = round(($total / 3), 2);
                        if ($total == 0) {
                            $res = (float)self::getValueProd($item->id);
                            if ($res > 0)
                                $datos[] = [$item->nombre, $res];
                        } else {
                            if ($total > 0)
                                $datos[] = [$item->nombre, (float)$total];
                        }
                    }
                    $fmd[$i]["datos"] = $datos;
                }
            }
        }

        return response()->JSON([
            "fmd" => $fmd
        ]);
    }

    public function analisis_consumo(Request $request)
    {
        // entrenar el modelo de consumo
        $this->entrenarConsumo();
        $c_meses = $request->c_meses;
        $filtro = $request->filtro;
        $meses_txt = [
            "01" => "ENERO",
            "02" => "FEBRERO",
            "03" => "MARZO",
            "04" => "ABRIL",
            "05" => "MAYO",
            "06" => "JUNIO",
            "07" => "JULIO",
            "08" => "AGOSTO",
            "09" => "SEPTIEMBRE",
            "10" => "OCTUBRE",
            "11" => "NOVIEMBRE",
            "12" => "DICIEMBRE",
        ];
        $fmd = [];
        if ($c_meses > 0) {
            $fecha = date("Y-m");
            $factual = date("Y-m-d", strtotime($fecha . "-01"));
            $actual = date("m");
            $fmd = [];
            $m1 = date("Y-m", strtotime($factual . '-1 month'));
            $m2 = date("Y-m", strtotime($factual . '-2 month'));
            $m3 = date("Y-m", strtotime($factual . '-3 month'));

            // preparar los meses de predicción
            $faumento = $factual;
            for ($i = 0; $i < $c_meses; $i++) {
                $faumento = date("Y-m-d", strtotime($faumento . "+1 month"));
                $sum_d = $faumento;
                $mes_index = date("m", strtotime($sum_d));
                $fmd[] = [
                    "id" => "c" . $i,
                    "title" => "TENDENCIAS DE CONSUMO PARA " . $meses_txt[$mes_index] . " - " . date("Y", strtotime($sum_d)),
                    "fecha" => $sum_d,
                    "datos" => [],
                ];
                $productos = Producto::all();

                if ($filtro == 'prediccion') {
                    // entrenar el modelo para el suministro
                    // obtener el producto mas vendido para realizar la predicción
                    $producto_id = DetalleVenta::orderBy("cantidad", "desc")->get()->last();
                    $producto_id = $producto_id->id;
                    $contProdVendidos = DetalleVenta::select("detalle_ventas.producto_id")->distinct("producto_id")->count();
                    $productos = $this->predecirConsumo($producto_id, $contProdVendidos);

                    $datos = [];
                    foreach ($productos as $item) {
                        // obtener el producto
                        $producto = Producto::find($item);
                        // generar un promedio segun la cantidad total de ventas por producto para mostrarlo en gráfica
                        // segun la cantidad de meses a predecir
                        $res = (float)self::getValueProd($producto->id);
                        if ($res > 0) {
                            $datos[] = [$item->nombre, $res];
                        } else {
                            // no se encontró ningun registro
                            $datos[] = [$item->nombre, 0];
                        }
                    }
                } else {
                    $datos = [];
                    foreach ($productos as $item) {
                        $total = 0;
                        $reg1 = DetalleVenta::join("ventas", "ventas.id", "=", "detalle_ventas.venta_id")
                            ->where("ventas.fecha_registro", "LIKE", "%$m1")
                            ->where("producto_id", $item->id)
                            ->sum("detalle_ventas.cantidad");
                        if ($reg1) {
                            $total += (float)$reg1;
                        }
                        $reg2 = DetalleVenta::join("ventas", "ventas.id", "=", "detalle_ventas.venta_id")
                            ->where("ventas.fecha_registro", "LIKE", "%$m2")
                            ->where("producto_id", $item->id)
                            ->sum("detalle_ventas.cantidad");
                        if ($reg2) {
                            $total += (float)$reg2;
                        }
                        $reg3 = DetalleVenta::join("ventas", "ventas.id", "=", "detalle_ventas.venta_id")
                            ->where("ventas.fecha_registro", "LIKE", "%$m3")
                            ->where("producto_id", $item->id)
                            ->sum("detalle_ventas.cantidad");
                        if ($reg3) {
                            $total += (float)$reg3;
                        }
                        $total = round(($total / 3), 2);

                        if ($total == 0) {
                            $res = (float)self::getValueProd2($item->id);
                            if ($res > 0)
                                $datos[] = [$item->nombre, $res];
                        } else {
                            if ($total > 0)
                                $datos[] = [$item->nombre, (float)$total];
                        }
                    }
                    $fmd[$i]["datos"] = $datos;
                }
            }
        }

        return response()->JSON([
            "fmd" => $fmd
        ]);
    }


    // funcion para obtener promedio
    public static function getValueProd($id)
    {
        $var = mt_rand(50, 250) / 1000;
        $sum_v = IngresoProducto::where("producto_id", $id)->sum("cantidad");

        return round(($sum_v / 3) * (1 - $var), 2);
    }
    public static function getValueProd2($id)
    {
        $var = mt_rand(50, 250) / 1000;
        $sum_v = DetalleVenta::where("producto_id", $id)->sum("cantidad");
        return round(($sum_v / 3) * (1 - $var), 2);
    }
}
