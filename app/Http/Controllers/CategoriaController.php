<?php

namespace App\Http\Controllers;

use App\Models\Categoria;
use App\Models\HistorialAccion;
use App\Models\Producto;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class CategoriaController extends Controller
{
    public $validacion = [
        'nombre' => 'required|min:2',
    ];

    public $mensajes = [];

    public function index(Request $request)
    {
        $categorias = Categoria::all();
        return response()->JSON(['categorias' => $categorias, 'total' => count($categorias)], 200);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            // crear Categoria
            $nuevo_categoria = Categoria::create(array_map('mb_strtoupper', $request->all()));

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_categoria, "categorias");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UNA CATEGORIA',
                'datos_original' => $datos_original,
                'modulo' => 'CATEGORIAS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

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
            $datos_original = HistorialAccion::getDetalleRegistro($categoria, "categorias");
            $categoria->update(array_map('mb_strtoupper', $request->all()));

            $datos_nuevo = HistorialAccion::getDetalleRegistro($categoria, "categorias");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UNA CATEGORIA',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'CATEGORIAS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

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

            $datos_original = HistorialAccion::getDetalleRegistro($categoria, "categorias");
            $categoria->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UNA CATEGORIA',
                'datos_original' => $datos_original,
                'modulo' => 'CATEGORIAS',
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
}
