<?php

namespace App\Http\Controllers;

use App\Models\Configuracion;
use App\Models\HistorialAccion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class ConfiguracionController extends Controller
{
    public function getConfiguracion()
    {
        $configuracion = Configuracion::first();
        if ($configuracion) {
            return response()->JSON([
                'sw' => true,
                'configuracion' => $configuracion
            ]);
        }
        return response()->JSON([
            'sw' => false,
            'msj' => 'No se encontró ninguna configuración'
        ], 200);
    }

    public function update(Request $request)
    {
        $validacion = [
            'nombre_sistema' => 'required|min:4|regex:/^[\pL\s\.\'\"\,áéíóúÁÉÍÓÚñÑ]+$/uu',
            'alias' => 'required|min:1|regex:/^[\pL\s\.\'\"\,áéíóúÁÉÍÓÚñÑ]+$/uu',
            'razon_social' => 'required|min:4|regex:/^[\pL\s\.\'\"\,áéíóúÁÉÍÓÚñÑ]+$/uu',
            'ciudad' => 'required|min:4|regex:/^[\pL\s\.\'\"\,áéíóúÁÉÍÓÚñÑ]+$/uu',
            'dir' => 'required|min:4|regex:/^[\pL\s\.\'\"\,0-9áéíóúÁÉÍÓÚñÑ]+$/u',
            'fono' => 'required|numeric|digits_between:7,20',
            'nit' => 'required|numeric|digits_between:7,20',
            'web' => 'required|regex:/^(https?:\/\/)?([a-zA-Z0-9\-]+\.)+[a-zA-Z]{2,}(\/[^\s]*)?$/',
            'correo' => 'required|email',
            'actividad' => 'required|regex:/^[\pL\s\.\'\"\,áéíóúÁÉÍÓÚñÑ]+$/uu',
        ];
        $mensajes =  [
            'nombre_sistema.required' => 'Este campo es obligatorio',
            'nombre_sistema.min' => 'Debes ingresar al menos 4 carácteres',
            'nombre_sistema.regex' => 'Debes ingresar solo texto',
            'alias.required' => 'Este campo es obligatorio',
            'alias.regex' => 'Debes ingresar solo texto',
            'razon_social.required' => 'Este campo es obligatorio',
            'razon_social.min' => 'Debes ingresar al menos 4 carácteres',
            'razon_social.regex' => 'Debes ingresar solo texto',
            'web.required' => 'Este campo es obligatorio',
            'web.regex' => 'El formato ingresado es invalido',
            'nit.required' => 'Este campo es obligatorio',
            'ciudad.required' => 'Este campo es obligatorio',
            'ciudad.min' => 'Debes ingresar al menos 4 carácteres',
            'ciudad.regex' => 'Debes ingresar solo texto',
            'dir.required' => 'Este campo es obligatorio',
            'dir.min' => 'Debes ingresar al menos 4 carácteres',
            'dir.regex' => 'El formato de texto es invalido',
            'nit.required' => 'Este campo es obligatorio',
            'nit.min' => 'Debes ingresar al menos 4 carácteres',
            'fono.required' => 'Este campo es obligatorio',
            'fono.min' => 'Debes ingresar al menos 4 carácteres',
            'correo.required' => 'Este campo es obligatorio',
            'correo.email' => 'Debes ingresar un correo valido',
            'actividad.required' => 'Este campo es obligatorio',
            'actividad.regex' => 'Debes ingresar solo texto',
        ];

        if ($request->hasFile('logo')) {
            $validacion['logo'] = 'image|mimes:jpeg,jpg,png,webp|max:4096';
        }
        $request->validate($validacion, $mensajes);

        $configuracion = Configuracion::first();
        if ($configuracion) {
            DB::beginTransaction();
            try {

                $datos_original = HistorialAccion::getDetalleRegistro($configuracion, "configuracions");

                $configuracion->update(array_map('mb_strtoupper', $request->except('logo')));
                if ($request->hasFile('logo')) {
                    $antiguo = $configuracion->logo;
                    \File::delete(public_path() . '/imgs/' . $antiguo);
                    $file = $request->logo;
                    $nombre = time() . '_logo.' . $file->getClientOriginalExtension();
                    $file->move(public_path() . '/imgs/', $nombre);
                    $configuracion->logo = $nombre;
                    $configuracion->save();
                }

                $datos_nuevo = HistorialAccion::getDetalleRegistro($configuracion, "configuracions");
                HistorialAccion::create([
                    'user_id' => Auth::user()->id,
                    'accion' => 'MODIFICACIÓN',
                    'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ LA CONFIGURACIÓN DEL SISTEMA',
                    'datos_original' => $datos_original,
                    'datos_nuevo' => $datos_nuevo,
                    'modulo' => 'CONFIGURACIÓN',
                    'fecha' => date('Y-m-d'),
                    'hora' => date('H:i:s')
                ]);

                DB::commit();
                return response()->JSON([
                    'sw' => true,
                    'msj' => 'Los datos se actualizarón de forma correcta',
                    'configuracion' => $configuracion
                ], 200);
            } catch (\Exception $e) {
                DB::rollBack();
                return response()->JSON([
                    'sw' => false,
                    'message' => $e->getMessage(),
                ], 500);
            }
        }
        return response()->JSON([
            'sw' => false,
            'msj' => 'No se encontró ninguna configuración'
        ], 200);
    }
}
