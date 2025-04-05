<?php

namespace App\Http\Controllers;

use App\Models\StockMinimo;
use App\Services\HistorialAccionService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class StockMinimoController extends Controller
{
    private $modulo = "STOCK MÍNIMO";

    public function __construct(private HistorialAccionService $historialAccionService) {}

    public function index(Request $request)
    {
        $stock_minimos = StockMinimo::with(["producto"])->where("status", 1)->get();
        return response()->JSON(['stock_minimos' => $stock_minimos, 'total' => count($stock_minimos)], 200);
    }

    public function destroy(StockMinimo $stock_minimo)
    {
        DB::beginTransaction();
        try {
            $old_stock_minimo = clone $stock_minimo;
            $stock_minimo->status = 0;
            $stock_minimo->save();
            // registrar accion
            $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UNA SUGERENCIA DE STOCK MÍNIMO", $old_stock_minimo);
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
