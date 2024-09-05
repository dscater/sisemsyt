<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Stock de productos</title>
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
            margin: auto;
            border-collapse: collapse;
            table-layout: fixed;
            margin-top: 20px;
            page-break-inside: avoid;
        }

        table thead tr th,
        tbody tr td {
            font-size: 0.63em;
            word-wrap: break-word;
        }

        tr {
            page-break-inside: avoid !important;
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

        table thead {
            background: rgb(236, 236, 236)
        }

        table thead tr th {
            padding: 3px;
            font-size: 0.7em;
        }

        table tbody tr td {
            padding: 3px;
            font-size: 0.75em;
        }

        table tbody tr td.franco {
            background: red;
            color: white;
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
            color: black;
        }

        .iquierda {
            text-align: left;
            padding-left: 4px;
        }

        .img_celda img {
            width: 45px;
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
        <h4 class="texto">HISTORIAL DE ACCIONES DEL SISTEMA</h4>
        <h4 class="fecha">Expedido: {{ date('d-m-Y') }}</h4>
    </div>
    <table border="1">

        <tbody>
            @php
                $cont = 1;
            @endphp
            <tr class="green">
                <th class="bold">USUARIO</th>
                <th class="bold">ACCIÓN</th>
                <th class="bold">MÓDULO</th>
                <th class="bold">DESCRIPCIÓN</th>
                <th class="bold">INFORMACIÓN ORIGINAL</th>
                <th class="bold">CAMBIOS DE INFORMACIÓN</th>
                <th class="bold">FECHA</th>
                <th class="bold">HORA</th>
            </tr>
            @foreach ($historial_accions as $value)
                <tr>
                    <td class="iquierda">{{ $value->user->usuario }}</td>
                    <td class="iquierda">{{ $value->accion }}</td>
                    <td class="iquierda">{{ $value->modulo }}</td>
                    <td class="iquierda">{{ $value->descripcion }}</td>
                    <td class="iquierda">{!! $value->datos_original !!}</td>
                    <td class="iquierda">{!! $value->datos_nuevo !!}</td>
                    <td class="iquierda">{{ date('d/m/Y', strtotime($value->fecha)) }}</td>
                    <td class="iquierda">{{ $value->hora }}</td>
                </tr>
            @endforeach
        </tbody>
    </table>
</body>

</html>
