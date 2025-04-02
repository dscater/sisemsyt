<?php

namespace App\Http\Controllers;

use App\Models\Categoria;
use App\Models\HistorialAccion;
use App\Models\Producto;
use App\Services\HistorialAccionService;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class CategoriaController extends Controller
{
    public $validacion = [
        'nombre' => 'required|min:2|regex:/^[\pL\s\.\'\"\,áéíóúÁÉÍÓÚñÑ]+$/uu',
    ];

    public $mensajes = [
        "nombre.required" => "Este campo es obligatorio",
        "nombre.min" => "Debes ingresar al menos :min caracteres",
        "nombre.regex" => "Debes ingresar solo texto",
    ];
    private $modulo = "CATEGORÍAS";

    public function __construct(private HistorialAccionService $historialAccionService) {}

    public function index(Request $request)
    {
        $categorias = Categoria::where("status", 1)->get();
        return response()->JSON(['categorias' => $categorias, 'total' => count($categorias)], 200);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            // crear Categoria
            $nuevo_categoria = Categoria::create(array_map('mb_strtoupper', $request->all()));

            // registrar accion
            $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UNA CATEGORÍA", $nuevo_categoria);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'categoria' => $nuevo_categoria,
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

    public function update(Request $request, Categoria $categoria)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            $old_categoria = clone $categoria;

            $categoria->update(array_map('mb_strtoupper', $request->all()));

            // registrar accion
            $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UNA CATEGORÍA", $old_categoria, $categoria);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'categoria' => $categoria,
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

    public function show(Categoria $categoria)
    {
        return response()->JSON([
            'sw' => true,
            'categoria' => $categoria
        ], 200);
    }

    public function destroy(Categoria $categoria)
    {
        DB::beginTransaction();
        try {
            $existe = Producto::where("categoria_id", $categoria->id)->get();
            if (count($existe) > 0) {
                throw new Exception('No es posible eliminar el registro debido a que existen registros que lo utilizan');
            }

            $old_categoria = clone $categoria;
            $categoria->status = 0;
            $categoria->save();
            // registrar accion
            $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UNA CATEGORÍA", $old_categoria);
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
}
