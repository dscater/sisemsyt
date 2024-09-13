<?php

namespace App\Http\Controllers;

use App\Models\DetalleVenta;
use App\Models\IngresoProducto;
use App\Models\Producto;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Phpml\Association\Apriori; //importación de la libreria a utlizar

class AlgoritmoColaborativoController extends Controller
{
    /**
     * Entrenar el modelo basado en las ventas de productos.
     */
    public function entrenarConsumo()
    {
        // Obtener todos los detalles de ventas
        $ventas = DetalleVenta::all();

        // Agrupar por venta producto
        $transacciones = [];
        foreach ($ventas as $venta) {
            $transacciones[$venta->id][] = $venta->producto_id;
        }

        // Configurar el algoritmo Apriori
        $soporteMinimo = 0.2;  // El 20% de las ventas
        $confianzaMinima = 0.5; // El 50% de confianza

        // Crear el modelo de Apriori
        $apriori = new Apriori($soporteMinimo, $confianzaMinima);

        // Entrenar el modelo con las transacciones
        $apriori->train(array_values($transacciones), []);

        // devolver el modelo entrenado
        return $apriori;
    }

    /**
     * Predecir el consumo de un producto específico o de todos los productos.
     */
    public function predecirConsumo($model, $productoId = null)
    {
        // Hacer predicción
        $productoRecomendado = $model->predict([[$productoId]]);
        // Obtener información de los productos recomendados
        $productos = Producto::whereIn('id', $productoRecomendado[0])->get();

        return [
            'producto_consultado' => Producto::find($productoId),
            'listado_productos' => $productos
        ];
    }

    /**
     * Entrenar el modelo basado en los ingresos de productos
     */
    public function entrenarSuministro()
    {
        // Obtener todos los ingresos de productos
        $ingresos = IngresoProducto::all();

        // Agrupar por transacciones de suministro
        $transacciones = [];
        foreach ($ingresos as $ingreso) {
            $transacciones[$ingreso->id][] = $ingreso->producto_id;
        }

        // Configurar el algoritmo Apriori
        $soporteMinimo = 0.2;  // El 20% de las transacciones
        $confianzaMinima = 0.5; // El 50% de confianza

        // Crear el modelo Apriori
        $apriori = new Apriori($soporteMinimo, $confianzaMinima);

        // Entrenar el modelo
        $apriori->train(array_values($transacciones), []);

        return $apriori;
    }

    /**
     * Predecir el suministro de un producto específico o de todos los productos usando el modelo guardado.
     */
    public function predecirSuministro($productoId = null)
    {
        // Cargar el modelo desde el archivo
        if (!Storage::exists('models/suministro_model.txt')) {
            return response()->json(['error' => 'El modelo de suministro no ha sido entrenado aún'], 400);
        }
        $model = unserialize(Storage::get('models/suministro_model.txt'));

        // Hacer predicción
        $productoRecomendado = $model->predict([[$productoId]]);

        // Obtener información de los productos recomendados
        $productos = Producto::whereIn('id', $productoRecomendado[0])->get();

        return response()->json([
            'producto_consultado' => Producto::find($productoId),
            'productos_recomendados' => $productos
        ]);
    }


    public function analisis_suministro(Request $request)
    {
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
                    // entrenar y obtener el modelo
                    $modelo = $this->entrenarSuministro();
                    // obtener los productos
                    $productos = $this->predecirSuministro($producto_id, $modelo);

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
                    $modelo = $this->entrenarSuministro();
                    $productos = $this->predecirSuministro($producto_id, $modelo);

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
