<?php

use App\Http\Controllers\AlgoritmoColaborativoController;
use App\Http\Controllers\ReporteAnalisisController;
use App\Http\Controllers\CategoriaController;
use App\Http\Controllers\ClienteController;
use App\Http\Controllers\ConfiguracionController;
use App\Http\Controllers\HistorialAccionController;
use App\Http\Controllers\IngresoProductoController;
use App\Http\Controllers\InicioController;
use App\Http\Controllers\LoginController;
use App\Http\Controllers\NotificacionController;
use App\Http\Controllers\NotificacionUserController;
use App\Http\Controllers\VentaController;
use App\Http\Controllers\ProductoController;
use App\Http\Controllers\ProveedorController;
use App\Http\Controllers\ReporteController;
use App\Http\Controllers\SalidaProductoController;
use App\Http\Controllers\StockMinimoController;
use App\Http\Controllers\SugerenciaController;
use App\Http\Controllers\TipoIngresoController;
use App\Http\Controllers\TipoSalidaController;
use App\Http\Controllers\UserController;
use Illuminate\Support\Facades\Route;

// LOGIN
Route::post('/login', [LoginController::class, 'login'])->middleware('login.attempts');;
Route::post('/logout', [LoginController::class, 'logout']);
Route::post('/genera2fa', [LoginController::class, 'genera2fa']);

Route::get("/verificaLogin", [LoginController::class, 'verificaLogin']);

Route::get("/updatePassword", [LoginController::class, 'updatePassword'])->name("updatePassword");

// CONFIGURACIÓN
Route::get('/configuracion/getConfiguracion', [ConfiguracionController::class, 'getConfiguracion']);

Route::middleware(['auth'])->group(function () {
    Route::post('/configuracion/update', [ConfiguracionController::class, 'update']);
    Route::post('/verificar2fa', [LoginController::class, 'verificar2fa']);

    Route::prefix('admin', '2fa')->group(function () {
        Route::get('stock_productos', [InicioController::class, 'stock_productos']);

        // Usuarios
        Route::post('usuarios/updatePassword', [UserController::class, 'updatePassword']);
        Route::get('usuarios/getUsuario/{usuario}', [UserController::class, 'getUsuario']);
        Route::get('usuarios/userActual', [UserController::class, 'userActual']);
        Route::get('usuarios/getInfoBox', [UserController::class, 'getInfoBox']);
        Route::get('usuarios/getPermisos/{usuario}', [UserController::class, 'getPermisos']);
        Route::get('usuarios/getEncargadosRepresentantes', [UserController::class, 'getEncargadosRepresentantes']);
        Route::post('usuarios/actualizaContrasenia/{usuario}', [UserController::class, 'actualizaContrasenia']);
        Route::post('usuarios/actualizaFoto/{usuario}', [UserController::class, 'actualizaFoto']);
        Route::post('usuarios/update2Fa/{usuario}', [UserController::class, 'update2Fa']);
        Route::resource('usuarios', UserController::class)->only([
            'index',
            'store',
            'update',
            'destroy',
            'show'
        ]);

        // Proveedores
        Route::resource('proveedors', ProveedorController::class)->only([
            'index',
            'store',
            'update',
            'destroy',
            'show'
        ]);

        // Productos
        Route::post("productos/excel", [ProductoController::class, 'excel']);
        Route::get("productos/paginado", [ProductoController::class, 'paginado']);
        Route::get("productos/verifica_ventas", [ProductoController::class, 'verifica_ventas']);
        Route::get("productos/valida_stock", [ProductoController::class, 'valida_stock']);
        Route::get("productos/productos_sucursal", [ProductoController::class, 'productos_sucursal']);
        Route::get("productos/getStock", [ProductoController::class, 'getStock']);
        Route::get("productos/buscar_producto", [ProductoController::class, 'buscar_producto']);
        Route::resource('productos', ProductoController::class)->only([
            'index',
            'store',
            'update',
            'destroy',
            'show'
        ]);

        // Categorias
        Route::resource('categorias', CategoriaController::class)->only([
            'index',
            'store',
            'update',
            'destroy',
            'show'
        ]);

        // Tipo Ingresos
        Route::resource('tipo_ingresos', TipoIngresoController::class)->only([
            'index',
            'store',
            'update',
            'destroy',
            'show'
        ]);

        // Ingreso productos
        Route::resource('ingreso_productos', IngresoProductoController::class)->only([
            'index',
            'store',
            'update',
            'destroy',
            'show'
        ]);

        // Tipo Salidas
        Route::resource('tipo_salidas', TipoSalidaController::class)->only([
            'index',
            'store',
            'update',
            'destroy',
            'show'
        ]);

        // Salida productos
        Route::resource('salida_productos', SalidaProductoController::class)->only([
            'index',
            'store',
            'update',
            'destroy',
            'show'
        ]);

        // Sugerencia
        Route::post("sugerencia_stocks/guardar", [SugerenciaController::class, 'guardar']);
        Route::resource('sugerencia_stocks', SugerenciaController::class)->only([
            'store',
        ]);

        // Stock mínimo
        Route::resource('stock_minimos', StockMinimoController::class)->only([
            'index',
            'destroy'
        ]);

        // Clientes
        Route::post("clientes/datos_factura/{cliente}", [ClienteController::class, 'datos_factura']);
        Route::resource('clientes', ClienteController::class)->only([
            'index',
            'store',
            'update',
            'destroy',
            'show'
        ]);

        // Ventas
        Route::post("ventas/pdf/{venta}", [VentaController::class, 'pdf']);
        Route::get("ventas/printTicket/{venta}", [VentaController::class, 'printTicket'])->name("ventas.ticket");
        Route::get("ventas/info/getLiteral", [VentaController::class, 'getLiteral']);
        Route::get("ventas/info/devolucions", [VentaController::class, 'getDevolucions']);
        Route::resource('ventas', VentaController::class)->only([
            'index',
            'store',
            'update',
            'destroy',
            'show'
        ]);

        // historial acciones
        Route::resource('historial_accions', HistorialAccionController::class)->only([
            'index',
            'show'
        ]);

        // notificacions
        Route::get("notificacions", [NotificacionController::class, "index"])->name("notificacions.index");

        // notificacion_users
        Route::resource('notificacion_users', NotificacionUserController::class)->only([
            'index',
            'show'
        ]);

        // REPORTE Analisis
        Route::get("reporte_analisis/stock_productos1", [ReporteAnalisisController::class, 'stock_productos1']);
        Route::get("reporte_analisis/stock_productos2", [ReporteAnalisisController::class, 'stock_productos2']);
        Route::get("reporte_analisis/stock_productos3", [ReporteAnalisisController::class, 'stock_productos3']);

        Route::get("reporte_analisis/proveedors1", [ReporteAnalisisController::class, 'proveedors1']);
        Route::get("reporte_analisis/proveedors2", [ReporteAnalisisController::class, 'proveedors2']);
        Route::get("reporte_analisis/proveedors3", [ReporteAnalisisController::class, 'proveedors3']);

        Route::get("reporte_analisis/ventas1", [ReporteAnalisisController::class, 'ventas1']);
        Route::get("reporte_analisis/ventas2", [ReporteAnalisisController::class, 'ventas2']);
        Route::get("reporte_analisis/ventas3", [ReporteAnalisisController::class, 'ventas3']);
        Route::get("reporte_analisis/ventas4", [ReporteAnalisisController::class, 'ventas4']);
        Route::get("reporte_analisis/ventas5", [ReporteAnalisisController::class, 'ventas5']);
        Route::get("reporte_analisis/ventas6", [ReporteAnalisisController::class, 'ventas6']);

        Route::get("reporte_analisis/clientes1", [ReporteAnalisisController::class, 'clientes1']);
        Route::get("reporte_analisis/clientes2", [ReporteAnalisisController::class, 'clientes2']);
        Route::get("reporte_analisis/clientes3", [ReporteAnalisisController::class, 'clientes3']);
        Route::get("reporte_analisis/clientes4", [ReporteAnalisisController::class, 'clientes4']);
        Route::get("reporte_analisis/clientes5", [ReporteAnalisisController::class, 'clientes5']);
        Route::get("reporte_analisis/clientes6", [ReporteAnalisisController::class, 'clientes6']);

        Route::get("reporte_analisis/analisis_suministro", [AlgoritmoColaborativoController::class, 'analisis_suministro']);

        Route::get("reporte_analisis/analisis_consumo", [AlgoritmoColaborativoController::class, 'analisis_consumo']);

        // REPORTES
        Route::post('reportes/usuarios', [ReporteController::class, 'usuarios']);
        Route::post('reportes/kardex', [ReporteController::class, 'kardex']);
        Route::post('reportes/ventas', [ReporteController::class, 'ventas']);
        Route::post('reportes/stock_productos', [ReporteController::class, 'stock_productos']);
        Route::post('reportes/historial_accion', [ReporteController::class, 'historial_accion']);
        Route::post('reportes/grafico_ingresos', [ReporteController::class, 'grafico_ingresos']);
        Route::post('reportes/grafico_orden', [ReporteController::class, 'grafico_orden']);
        Route::post('reportes/stock_minimos', [ReporteController::class, 'stock_minimos']);
    });
});


// ---------------------------------------
Route::get('/{optional?}', function () {
    return view('app');
})->name('base_path')->where('optional', '.*');
