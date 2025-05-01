<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Ticket</title>
    <style>
        @page {
            margin: 0;
            width: 7cm;
        }

        body {
            width: 7cm !important;
        }

        #principal {
            width: 7cm !important;
        }

        #contenedor_imprimir {
            font-size: 0.94em;
            width: 7cm !important;
            padding-top: 15px;
            padding-bottom: 15px;
            font-family: 'Times New Roman', Times, serif;
        }

        .elemento {
            text-align: center;
        }

        .elemento.logo img {
            width: 60%;
        }

        .separador {
            padding: 0px;
            margin: 0px;
        }

        .fono,
        .lp {
            font-size: 0.75em;
        }

        .txt_fo {
            margin-top: 3px;
            border-top: solid 1px black;
        }

        .detalle {
            border-top: solid 1px black;
            border-bottom: solid 1px black;
        }

        .act_eco {
            font-size: 0.73em;
        }

        .info1 {
            text-align: center;
            font-weight: bold;
            font-size: 0.75em;
        }

        .info2 {
            text-align: center;
            font-weight: bold;
            font-size: 0.7em;
        }

        .izquierda {
            text-align: left;
            padding-left: 5px;
        }

        .derecha {
            text-align: right;
            padding-right: 5px;
        }

        .informacion {
            padding: 5px;
            width: 100%;
        }

        .bold {
            font-weight: bold;
        }

        .cobro {
            width: 100%;
            padding: 5px;
        }

        .cobro table {
            width: 100%;
        }

        .centreado {
            text-align: center;
        }

        .cobro table tr td {
            font-size: 0.9em;
        }

        .literal {
            font-size: 0.7em;
        }

        .cod_control,
        .fecha_emision {
            font-size: 0.9em;
        }

        .cobro table {
            border-collapse: collapse;
        }

        .cobro table tr.punteado td {
            border-top: solid 1px black;
            border-bottom: solid 1px black;
        }

        .total {
            font-size: 0.9em !important;
        }

        .contenedor_qr {
            display: block;
            width: 100%;
        }

        img.qr {
            width: 160px;
            height: 160px;
        }
    </style>
</head>

<body>
    <div class="contenedor_factura ml-auto mr-auto" id="contenedor_imprimir">
        {{-- <div class="elemento logo">
        <img
            src="{{ asset('imgs/' . $empresa->logo) }}"
            alt="Logo"
        />
    </div> --}}
        <div class="elemento nom_empresa">
            {{ $oConfiguracion->razon_social }}
        </div>
        <div class="elemento direccion">
            Dirección:
            {{ $oConfiguracion->dir }}
        </div>
        <div class="elemento direccion">
            Teléfonos:
            {{ $oConfiguracion->fono }}
        </div>
        <div class="elemento direccion">
            La Paz - Bolivia
        </div>
        <div class="elemento direccion">
            FACTURA<br />
        </div>
        <div class="elemento detalle centreado">
            NIT:
            {{ $oConfiguracion->nit }}
            <br />
            FACTURA NÚMERO:
            {{ $venta->nro_factura }}
            <br />
            AUTORIZACIÓN: 325545855547
            <br />
        </div>

        <div class="elemento centreado">
            VENTA AL POR MAYOR Y MENOR DE
            MAQUINARIA, EQUIPO Y MATERIALES
        </div>
        <div class="elemento detalle izquierda">
            Fecha:
            {{ $venta->fecha_formateado }}
            &nbsp;&nbsp; Hora:
            {{ $venta->hora }}
            <br />
            NOMBRE:
            {{ $venta->nom_fac ? $venta->nom_fac : '' }}
            <br />
            NIT/C.I.: {{ $venta->nit_fac }}
            <br />
            Usu.:
            {{ $venta->user ? $venta->user->usuario : '' }}
            <br />
        </div>
        <div class="elemento bold">DETALLE</div>
        <div class="cobro">
            <table>
                <tr class="punteado">
                    <td class="centreado">
                        CANTIDAD
                    </td>
                    <td class="centreado">
                        PRODUCTO
                    </td>
                    <td class="centreado">
                        P/U
                    </td>
                    <td class="centreado">
                        SUBTOTAL
                    </td>
                </tr>
                @foreach ($venta->detalle_ventas as $item)
                    <tr v-for="item in $venta->detalle_ventas">
                        <td class="centreado">
                            {{ $item->cantidad }}
                        </td>
                        <td class="izquierda">
                            {{ $item->producto->nombre }}
                        </td>
                        <td class="centreado">
                            {{ $item->precio }}
                        </td>
                        <td class="centreado">
                            {{ $item->subtotal }}
                        </td>
                    </tr>
                @endforeach
                <tr>
                    <td colspan="3" class="bold elemento detalle"
                        style="
                        text-align: right;
                        padding-right: 4px;
                    ">
                        TOTAL
                    </td>
                    <td class="centreado bold detalle" style="">
                        {{ $venta->total }}
                    </td>
                </tr>
                <tr>
                    <td colspan="3" class="bold elemento"
                        style="
                        text-align: right;
                        padding-right: 4px;
                    ">
                        DESCUENTO %
                    </td>
                    <td class="centreado bold">
                        {{ $venta->descuento }}
                    </td>
                </tr>
                <tr>
                    <td colspan="3" class="bold elemento detalle"
                        style="
                        text-align: right;
                        padding-right: 4px;
                    ">
                        TOTAL FINAL
                    </td>
                    <td class="centreado bold detalle">
                        {{ $venta->total_final }}
                    </td>
                </tr>
            </table>
        </div>
        <div class="centreado literal">
            Son: {{ $literal }}
        </div>
        <div class="elemento contenedor_qr">
            <img src="{{ $venta->qr }}" class="qr" alt="QR" />
        </div>
        <div class="elemento centreado">
            Ley N 453: El proveedor deberá
            entregar el producto en las
            modalidades y términos ofertados o
            convenidos.
        </div>
        <div class="elemento centreado">
            Este documento es la representación
            gráfico a un Documento Fiscal
            Digital emitido en una modalidad de
            facturación en línea.
        </div>
    </div>
    <script type="text/javascript">
        try {
            this.print();
        } catch (e) {
            window.onload = window.print;
        }
    </script>
</body>

</html>
