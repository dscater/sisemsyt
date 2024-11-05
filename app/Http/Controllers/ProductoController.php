<?php

namespace App\Http\Controllers;

use App\Models\Almacen;
use App\Models\Configuracion;
use App\Models\DetalleVenta;
use App\Models\HistorialAccion;
use App\Models\IngresoProducto;
use App\Models\KardexProducto;
use App\Models\Producto;
use App\Models\SalidaProducto;
use App\Models\SucursalStock;
use App\Models\TransferenciaProducto;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use PhpOffice\PhpSpreadsheet\IOFactory;
use PhpOffice\PhpSpreadsheet\Spreadsheet;

class ProductoController extends Controller
{
    public $validacion = [
        'nombre' => 'required|regex:/^[\pL\s\.\'\"\,áéíóúÁÉÍÓÚñÑ]+$/uu',
        'precio' => 'required|numeric|min:1',
        'descripcion' => 'required|regex:/^[\pL\s\.\'\"\,áéíóúÁÉÍÓÚñÑ]+$/uu',
        'stock_min' => 'required|integer|min:0',
        'categoria_id' => 'required',
    ];

    public $mensajes = [
        "nombre.required" => "Este campo es obligatorio",
        "nombre.regex" => "Debes ingresar solo texto",
        "precio.required" => "Este campo es obligatorio",
        "precio.numeric" => "Debes ingresar un valor númerico",
        "precio.min" => "Debes ingresar al menos :min",
        "descripcion.required" => "Este campo es obligatorio",
        "descripcion.regex" => "Debes ingresar solo texto",
        "stock_min.required" => "Este campo es obligatorio",
        "stock_min.integer" => "Este campo debe ser un valor entero",
        "stock_min.min" => "Debes ingresar un valor mayor o igual a :min",
        "categoria_id.required" => "Este campo es obligatorio",
    ];

    public function index(Request $request)
    {
        $productos = Producto::with("categoria")->orderBy("productos.codigo_producto", "ASC")
            ->orderBy("productos.codigo_producto", "ASC")
            ->orderBy("productos.nombre", "ASC")
            ->get();
        return response()->JSON(['productos' => $productos, 'total' => count($productos)], 200);
    }

    public function excel(Request $request)
    {
        $spreadsheet = new Spreadsheet();
        $spreadsheet->getProperties()
            ->setCreator("ADMIN")
            ->setLastModifiedBy('Administración')
            ->setTitle('ListaProductos')
            ->setSubject('ListaProductos')
            ->setDescription('ListaProductos')
            ->setKeywords('PHPSpreadsheet')
            ->setCategory('Listado');

        $sheet = $spreadsheet->getActiveSheet();

        $spreadsheet->getDefaultStyle()->getFont()->setName('Arial');

        $styleTexto = [
            'font' => [
                'bold' => true,
                'size' => 12,
            ],
            'borders' => [
                'allBorders' => [
                    'borderStyle' => \PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN,
                ],
            ],
        ];

        $styleArray2 = [
            'font' => [
                'bold' => true,
                'size' => 9,
                'color' => ['argb' => 'ffffff'],
            ],
            'alignment' => [
                'horizontal' => \PhpOffice\PhpSpreadsheet\Style\Alignment::HORIZONTAL_CENTER,
                'vertical' => \PhpOffice\PhpSpreadsheet\Style\Alignment::VERTICAL_CENTER,
            ],
            'borders' => [
                'allBorders' => [
                    'borderStyle' => \PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN,
                ],
            ],
            'fill' => [
                'fillType' => \PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID,
                'color' => ['rgb' => '0062A5']
            ],
        ];

        $estilo_conenido = [
            'font' => [
                'size' => 8,
            ],
            'alignment' => [
                'vertical' => \PhpOffice\PhpSpreadsheet\Style\Alignment::VERTICAL_CENTER,
                // 'horizontal' => \PhpOffice\PhpSpreadsheet\Style\Alignment::HORIZONTAL_CENTER,
            ],
            'borders' => [
                'allBorders' => [
                    'borderStyle' => \PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN,
                ],
            ],
        ];


        $fila = 1;
        $drawing = new \PhpOffice\PhpSpreadsheet\Worksheet\Drawing();
        $drawing->setName('logo');
        $drawing->setDescription('logo');
        $drawing->setPath(public_path() . '/imgs/' . Configuracion::first()->logo); // put your path and image here
        $drawing->setCoordinates('A' . $fila);
        $drawing->setOffsetX(5);
        $drawing->setOffsetY(0);
        $drawing->setHeight(60);
        $drawing->setWorksheet($sheet);
        $sheet->setCellValue('A' . $fila, "LISTA DE PRODUCTOS");
        $sheet->mergeCells("A" . $fila . ":H" . $fila);  //COMBINAR CELDAS
        $sheet->getStyle('A' . $fila . ':H' . $fila)->getAlignment()->setHorizontal('center');
        $sheet->getStyle('A' . $fila . ':H' . $fila)->applyFromArray($styleTexto);
        $fila++;
        $fila++;
        $fila++;
        $fila++;

        $sheet->setCellValue('A' . $fila, 'GRUPO');
        $sheet->setCellValue('B' . $fila, 'CÓDIGO');
        $sheet->setCellValue('C' . $fila, 'MEDIDA');
        $sheet->setCellValue('D' . $fila, 'NOMBRE');
        $sheet->setCellValue('E' . $fila, 'PRECIO DE VENTA');
        $sheet->setCellValue('F' . $fila, 'STOCK ALMACÉN');
        $sheet->setCellValue('G' . $fila, 'STOCK SUCURSAL');
        $sheet->setCellValue('H' . $fila, 'TOTAL STOCK');
        $sheet->getStyle('A' . $fila . ':H' . $fila)->applyFromArray($styleArray2);
        $fila++;

        $sw_busqueda = $request->sw_busqueda;
        if (isset($request->value) && $request->value != "") {
            $value = $request->value;
            if ($sw_busqueda == 'todos') {
                $productos = Producto::select("productos.*")->with("grupo")
                    ->with("stock_almacen")
                    ->with("stock_sucursal")
                    ->join("grupos", "grupos.id", "=", "productos.grupo_id")
                    ->orWhere("productos.id", "LIKE", "%$value%")
                    ->orWhere("productos.codigo", "LIKE", "%$value%")
                    ->orWhere("productos.nombre", "LIKE", "%$value%")
                    ->orWhere("productos.medida", "LIKE", "%$value%")
                    ->orWhere("productos.precio", "LIKE", "%$value%")
                    ->orWhere("productos.precio_mayor", "LIKE", "%$value%")
                    ->orWhere("productos.fecha_registro", "LIKE", "%$value%")
                    ->orWhere("grupos.nombre", "LIKE", "%$value%");
            } else {
                $productos = Producto::select("productos.*")->with("grupo")
                    ->with("stock_almacen")
                    ->with("stock_sucursal")
                    ->join("grupos", "grupos.id", "=", "productos.grupo_id")
                    ->where("productos." . $sw_busqueda, $value);
            }
        } else {
            $productos = Producto::select("productos.*")->with("grupo")->join("grupos", "grupos.id", "=", "productos.grupo_id");
        }

        $productos = $productos
            ->orderBy("grupos.nombre", "ASC")
            ->orderBy("productos.codigo", "ASC")
            ->orderBy("productos.medida", "ASC")->get();
        // ->sortBy("grupos.nombre", SORT_NATURAL)
        // ->sortBy("productos.codigo", SORT_NATURAL)
        // ->sortBy("productos.medida", SORT_NATURAL);
        foreach ($productos as $producto) {
            $sheet->setCellValue('A' . $fila, $producto->grupo->nombre);
            $sheet->setCellValue('B' . $fila, $producto->codigo);
            $sheet->setCellValue('C' . $fila, $producto->medida);
            $sheet->setCellValue('D' . $fila, $producto->nombre);
            $sheet->setCellValue('E' . $fila, $producto->precio);
            $sheet->setCellValue('F' . $fila, $producto->stock_almacen ? $producto->stock_almacen->stock_actual : 0);
            $sheet->setCellValue('G' . $fila, $producto->stock_sucursal ? $producto->stock_sucursal->stock_actual : 0);
            $sheet->setCellValue('H' . $fila, $producto->total_stock);
            $sheet->getStyle('A' . $fila . ':H' . $fila)->applyFromArray($estilo_conenido);
            $fila++;
        }

        $sheet->getColumnDimension('A')->setWidth(20);
        $sheet->getColumnDimension('B')->setWidth(15);
        $sheet->getColumnDimension('C')->setWidth(20);
        $sheet->getColumnDimension('D')->setWidth(20);
        $sheet->getColumnDimension('E')->setWidth(15);
        $sheet->getColumnDimension('F')->setWidth(15);
        $sheet->getColumnDimension('G')->setWidth(15);
        $sheet->getColumnDimension('H')->setWidth(15);

        foreach (range('A', 'H') as $columnID) {
            $sheet->getStyle($columnID)->getAlignment()->setWrapText(true);
        }

        // DESCARGA DEL ARCHIVO
        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        header('Content-Disposition: attachment;filename="ListaProductos.xlsx"');
        header('Cache-Control: max-age=0');
        $writer = IOFactory::createWriter($spreadsheet, 'Xlsx');
        $writer->save('php://output');
    }

    public function buscar_producto(Request $request)
    {
        $value = $request->value;
        $sw_busqueda = $request->sw_busqueda;

        $productos = Producto::select("productos.*");
        if ($sw_busqueda == 'todos') {
            if (trim($value) != '') {
                $productos->where("codigo_producto", "LIKE", "%$value%")
                    ->orWhere("nombre", "LIKE", "%$value%");
            }
            $productos = $productos->orderBy("codigo_producto", "ASC")
                ->orderBy("nombre", "ASC")
                ->get()->take(100);
        } else {
            $productos = $productos->where("productos." . $sw_busqueda, $value)
                ->get()->take(100);
        }

        return response()->JSON($productos);
    }

    public function store(Request $request)
    {
        $this->validacion['imagen'] = "image|mimes:jpeg,jpg,png,webp|max:4096";
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            // crear Producto
            $codigog = Producto::getNuevoCodigoProducto();
            $request["codigo_producto"] = $codigog[0];
            $request["nro_codigo"] = $codigog[1];
            $request["fecha_registro"] = date("Y-m-d");
            $request["stock_actual"] = 0;
            $nuevo_producto = Producto::create(array_map('mb_strtoupper', $request->all()));

            if ($request->hasFile('imagen')) {
                $file = $request->imagen;
                $nom_file = time() . '_' . $nuevo_producto->id . '.' . $file->getClientOriginalExtension();
                $nuevo_producto->imagen = $nom_file;
                $file->move(public_path() . '/imgs/productos/', $nom_file);
            }
            $nuevo_producto->save();

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_producto, "productos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN PRODUCTO',
                'datos_original' => $datos_original,
                'modulo' => 'PRODUCTOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'producto' => $nuevo_producto,
                'msj' => 'El registro se realizó de forma correcta',
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function update(Request $request, Producto $producto)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($producto, "productos");
            $producto->update(array_map('mb_strtoupper', $request->all()));

            if ($request->hasFile('imagen')) {
                $antiguo = $producto->imagen;
                if ($antiguo && trim($antiguo) && $antiguo != 'default.png') {
                    \File::delete(public_path() . "/imgs/productos/" . $antiguo);
                }

                $file = $request->imagen;
                $nom_file = time() . '_' . $producto->id . '.' . $file->getClientOriginalExtension();
                $producto->imagen = $nom_file;
                $file->move(public_path() . '/imgs/productos/', $nom_file);
            }
            $producto->save();

            $datos_nuevo = HistorialAccion::getDetalleRegistro($producto, "productos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN PRODUCTO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'PRODUCTOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'producto' => $producto,
                'msj' => 'El registro se actualizó de forma correcta'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function show(Producto $producto)
    {
        return response()->JSON([
            'sw' => true,
            'producto' => $producto,
            "stock_actual" => $producto->stock_actual
        ], 200);
    }

    public function destroy(Producto $producto)
    {
        DB::beginTransaction();
        try {
            // validar que no exista en orden de ventas
            $orden_ventas = DetalleVenta::where("producto_id", $producto->id)->get();
            if (count($orden_ventas) > 0) {
                throw new Exception('No es posible eliminar el registro debido a que se realizaron ventas con este producto');
            }

            $producto->ingreso_productos()->delete();
            $producto->salida_productos()->delete();
            $producto->kardex_productos()->delete();

            $datos_original = HistorialAccion::getDetalleRegistro($producto, "productos");

            $antiguo = $producto->imagen;
            if ($antiguo && trim($antiguo) && $antiguo != 'default.png') {
                \File::delete(public_path() . "/imgs/productos/" . $antiguo);
            }

            $producto->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINO UN PRODUCTO',
                'datos_original' => $datos_original,
                'modulo' => 'PRODUCTOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'msj' => 'El registro se eliminó correctamente'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function getStock(Request $request)
    {
        $lugar = $request->lugar;
        $producto_id = $request->producto_id;

        $producto = Producto::find($producto_id);
        if ($lugar == 'SUCURSAL') {
            $producto_stock = SucursalStock::where("producto_id", $producto_id)->get()->first();
            if (!$producto_stock) {
                $producto_stock = SucursalStock::create([
                    "producto_id" => $producto_id,
                    "stock_actual" => 0,
                ]);
            }
        } else {
            $producto_stock = Almacen::where("producto_id", $producto_id)->get()->first();
            if (!$producto_stock) {
                $producto_stock = Almacen::create([
                    "producto_id" => $producto_id,
                    "stock_actual" => 0,
                ]);
            }
        }

        return response()->JSON([
            "producto" => $producto,
            "stock_actual" => $producto_stock->stock_actual
        ]);
    }

    public function productos_sucursal(Request $request)
    {
        $sw_busqueda = $request->sw_busqueda;
        $productos = [];
        if (isset($request->value)) {
            $value = $request->value;
            $productos = [];
            if ($sw_busqueda == 'todos') {
                $productos = SucursalStock::select("sucursal_stocks.*")
                    ->with("producto.grupo")
                    ->join("productos", "productos.id", "=", "sucursal_stocks.producto_id")
                    ->join("grupos", "grupos.id", "=", "productos.grupo_id")
                    ->where(function ($query) use ($value) {
                        $query->where('productos.id', "%$value%")
                            ->orWhere('productos.id', "LIKE", "%$value%")
                            ->orWhere("productos.codigo", "LIKE", "%$value%")
                            ->orWhere("productos.nombre", "LIKE", "%$value%")
                            ->orWhere("productos.medida", "LIKE", "%$value%")
                            ->orWhere("productos.precio", "LIKE", "%$value%")
                            ->orWhere("productos.precio_mayor", "LIKE", "%$value%")
                            ->orWhere("productos.fecha_registro", "LIKE", "%$value%")
                            ->orWhere("grupos.nombre", "LIKE", "%$value%");
                    })
                    ->orderBy("grupos.nombre", "ASC")
                    ->orderBy("productos.codigo", "ASC")
                    ->orderBy("productos.medida", "ASC")
                    ->get()->take(100);
            } else {
                $productos = SucursalStock::select("sucursal_stocks.*")
                    ->with("producto.grupo")
                    ->join("productos", "productos.id", "=", "sucursal_stocks.producto_id")
                    ->join("grupos", "grupos.id", "=", "productos.grupo_id")
                    ->where(function ($query) use ($value, $sw_busqueda) {
                        $query->where('productos.' . $sw_busqueda, $value);
                    })
                    ->orderBy("grupos.nombre", "ASC")
                    ->orderBy("productos.codigo", "ASC")
                    ->orderBy("productos.medida", "ASC")
                    ->get()->take(100);
            }
        } else {
            $productos = SucursalStock::with("sucursal")->with("producto.grupo")->where("sucursal_id", $request->id)->get();
        }
        return response()->JSON($productos);
    }

    public function valida_stock(Request $request)
    {
        $cantidad = $request->cantidad;
        $producto_id = $request->id;
        $producto = Producto::findOrFail($producto_id);

        if ($producto->stock_actual >= $cantidad) {
            return response()->JSON(
                [
                    "sw" => true,
                    "producto" => $producto,
                ]
            );
        }
        return response()->JSON(
            [
                "sw" => false,
                "msj" => "La cantidad que desea ingresar supera al stock disponible del producto.<br/> Stock actual: <b>" . $producto->stock_actual . " unidades</b>"
            ]
        );
    }

    public function verifica_ventas(Request $request)
    {
        $id = $request->id;
        $lugar = $request->lugar;


        $producto = Producto::find($id);
        $ingresos = IngresoProducto::where("lugar", $lugar)
            ->where("producto_id", $producto->id)
            ->get();

        $salidas = SalidaProducto::where("lugar", $lugar)
            ->where("producto_id", $producto->id)
            ->get();

        $transferencia_origen = TransferenciaProducto::where("origen", $lugar)
            ->where("producto_id", $producto->id)
            ->get();

        $transferencia_destino = TransferenciaProducto::where("origen", $lugar)
            ->where("producto_id", $producto->id)
            ->get();

        if ($lugar == 'SUCURSAL') {
            $existe = DetalleVenta::where("producto_id", $producto->id)->get();
            if (count($existe) > 0 || count($transferencia_origen) > 0 || count($transferencia_destino) > 0 || count($ingresos) > 0 || count($salidas) > 0) {
                return response()->JSON(true);
            }
        } else {
            if (count($transferencia_origen) > 0 || count($transferencia_destino) > 0 || count($ingresos) > 0 || count($salidas) > 0) {
                return response()->JSON(true);
            }
        }
        return response()->JSON(false);
    }
}
