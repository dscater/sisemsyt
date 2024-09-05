<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>ventas</title>
    <style type="text/css">
        * {
            font-family: sans-serif;
        }

        @page {
            margin-top: 2cm;
            margin-bottom: 1cm;
            margin-left: 1.5cm;
            margin-right: 1cm;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
            margin-top: 20px;
            page-break-before: avoid;
        }

        table thead tr th,
        tbody tr td {
            font-size: 0.63em;
            word-wrap: break-word;
        }

        .encabezado {
            width: 100%;
        }

        .logo img {
            position: absolute;
            width: 200px;
            height: 90px;
            top: -20px;
            left: -20px;
        }

        h2.titulo {
            width: 450px;
            margin: auto;
            margin-top: 15px;
            margin-bottom: 15px;
            text-align: center;
            font-size: 14pt;
        }

        .texto {
            width: 250px;
            text-align: center;
            margin: auto;
            margin-top: 15px;
            font-weight: bold;
            font-size: 1.1em;
        }

        .fecha {
            width: 250px;
            text-align: center;
            margin: auto;
            margin-top: 15px;
            font-weight: normal;
            font-size: 0.85em;
        }

        .total {
            text-align: right;
            padding-right: 15px;
            font-weight: bold;
        }

        table {
            width: 100%;
        }

        table thead {
            background: rgb(236, 236, 236)
        }

        table thead tr th {
            padding: 3px;
            font-size: 0.85em;
        }

        table tbody tr td {
            padding: 3px;
            font-size: 0.75em;
        }

        table tbody tr td.franco {
            background: red;
            color: white;
        }

        tr {
            page-break-inside: avoid !important;
        }

        .centreado {
            padding-left: 0px;
            text-align: center;
        }

        .datos {
            margin-left: 15px;
            border-top: solid 1px;
            border-collapse: collapse;
            width: 250px;
        }

        .txt {
            font-weight: bold;
            text-align: right;
            padding-right: 5px;
        }

        .txt_center {
            font-weight: bold;
            text-align: center;
        }

        .cumplimiento {
            position: absolute;
            width: 150px;
            right: 0px;
            top: 86px;
        }

        .p_cump {
            color: red;
            font-size: 1.2em;
        }

        .b_top {
            border-top: solid 1px black;
        }

        .gray {
            background: rgb(202, 202, 202);
        }

        .green {
            background: #149FDA;
            color: white;
        }

        .derecha {
            text-align: right;
            padding-right: 3px;
        }

        .izquierda {
            text-align: left;
            padding-left: 3px;
        }

        .img_celda img {
            width: 45px;
        }

        .bold {
            font-weight: bold;
        }
    </style>
</head>

<body>
    @inject('configuracion', 'App\Models\Configuracion')
    <div class="encabezado">
        <div class="logo">
            <img src="{{ asset('imgs/' . $configuracion->first()->logo) }}">
        </div>
        <h2 class="titulo">
            {{ $configuracion->first()->razon_social }}
        </h2>
        <h4 class="texto">VENTAS</h4>
        <h4 class="fecha">Expedido: {{ date('d-m-Y') }}</h4>
    </div>
    @foreach ($ventas as $venta)
        <table border="1">
            <thead class="green">
                <tr>
                    <th class="izquierda" width="15%">Fecha y hora:</th>
                    <th class="izquierda" colspan="3">{{ date('d/m/Y H:i', strtotime($venta->created_at)) }}</th>
                </tr>
                <tr>
                    <th class="izquierda">Cliente:</th>
                    <th class="izquierda" colspan="3">{{ $venta->cliente->nombre }}</th>
                </tr>
                <tr>
                    <th class="izquierda">Nit:</th>
                    <th class="izquierda" colspan="3">{{ $venta->nit }}</th>
                </tr>
                <tr>
                    <th class="izquierda">
                        Usuario:
                    </th>
                    <th class="izquierda" colspan="3">{{ $venta->user->usuario }}</th>
                </tr>
                <tr>
                    <th colspan="4">DETALLE DE ORDEN</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="bold centreado">Producto</td>
                    <td class="bold centreado">Cantidad</td>
                    <td class="bold centreado">P/U</td>
                    <td class="bold centreado">Subtotal</td>
                </tr>
                @foreach ($venta->detalle_ventas as $detalle)
                    <tr>
                        <td>{{ $detalle->producto->nombre }}</td>
                        <td class="centreado">{{ $detalle->cantidad }}</td>
                        <td class="centreado">{{ $detalle->precio }}</td>
                        <td class="centreado">{{ $detalle->subtotal }}</td>
                    </tr>
                @endforeach
                <tr>
                    <td class="derecha bold" colspan="3">TOTAL</td>
                    <td class="bold centreado">{{ $venta->total }}</td>
                </tr>
            </tbody>
        </table>
    @endforeach
</body>

</html>
