<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Orden de Ventas - <span>Ticket</span></h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <div id="principal">
                                    <div
                                        class="contenedor_factura ml-auto mr-auto"
                                        id="contenedor_imprimir"
                                    >
                                        <div class="elemento logo">
                                            <!-- <img
                                                src="{{ asset('imgs/' . $empresa->logo) }}"
                                                alt="Logo"
                                            /> -->
                                        </div>
                                        <div class="elemento nom_empresa">
                                            {{ oConfiguracion.razon_social }}
                                        </div>
                                        <div class="elemento direccion">
                                            Dirección:
                                            {{ oConfiguracion.dir }}
                                        </div>
                                        <div class="elemento direccion">
                                            Teléfonos:
                                            {{ oConfiguracion.fono }}
                                        </div>
                                        <div class="elemento direccion">
                                            La Paz - Bolivia
                                        </div>
                                        <div class="elemento direccion">
                                            FACTURA<br />
                                        </div>
                                        <div class="elemento detalle centreado">
                                            NIT:
                                            {{ oConfiguracion.nit }}
                                            <br />
                                            FACTURA NÚMERO:
                                            {{ oVenta.nro_factura }}
                                            <br />
                                            AUTORIZACIÓN: 325545855547
                                            <br />
                                        </div>

                                        <div class="elemento centreado">
                                            VENTA AL POR MENOR DE PRODUCTOS
                                            FARMACÉUTICOS, MEDICINALES,
                                            COSMÉTICOS Y ARTÍCULOS DE TOCADOR
                                        </div>
                                        <div class="elemento detalle izquierda">
                                            Fecha:
                                            {{ oVenta.fecha_formateado }}
                                            &nbsp;&nbsp; Hora:
                                            {{ oVenta.hora }}
                                            <br />
                                            NOMBRE:
                                            {{ oVenta.cliente?.nombre }}
                                            <br />
                                            NIT/C.I.: {{ oVenta.nit }}
                                            <br />
                                            Usu.:
                                            {{ oVenta.user?.usuario }}
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
                                                <tr
                                                    v-for="item in oVenta.detalle_ventas"
                                                >
                                                    <td class="centreado">
                                                        {{ item.cantidad }}
                                                    </td>
                                                    <td class="izquierda">
                                                        {{
                                                            item.producto.nombre
                                                        }}
                                                    </td>
                                                    <td class="centreado">
                                                        {{ item.precio }}
                                                    </td>
                                                    <td class="centreado">
                                                        {{ item.subtotal }}
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td
                                                        colspan="3"
                                                        class="bold elemento detalle"
                                                        style="
                                                            text-align: right;
                                                            padding-right: 4px;
                                                        "
                                                    >
                                                        TOTAL
                                                    </td>
                                                    <td
                                                        class="centreado bold detalle"
                                                        style=""
                                                    >
                                                        {{ oVenta.total }}
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td
                                                        colspan="3"
                                                        class="bold elemento"
                                                        style="
                                                            text-align: right;
                                                            padding-right: 4px;
                                                        "
                                                    >
                                                        DESCUENTO %
                                                    </td>
                                                    <td class="centreado bold">
                                                        {{ oVenta.descuento }}
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td
                                                        colspan="3"
                                                        class="bold elemento detalle"
                                                        style="
                                                            text-align: right;
                                                            padding-right: 4px;
                                                        "
                                                    >
                                                        TOTAL FINAL
                                                    </td>
                                                    <td
                                                        class="centreado bold detalle"
                                                    >
                                                        {{ oVenta.total_final }}
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div class="centreado literal">
                                            Son: {{ literal }}
                                        </div>
                                        <div class="elemento">
                                            <img :src="oVenta.qr" alt="QR" />
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
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <button
                                            class="btn btn-primary btn-block btn-flat"
                                            id="btnImprimir"
                                            @click="imrpimirContenedor"
                                        >
                                            <i class="fa fa-print"></i> Imprimir
                                        </button>
                                    </div>
                                    <div class="col-md-12">
                                        <router-link
                                            class="btn btn-outline-primary mt-2 btn-flat mb-1 btn-block"
                                            :to="{
                                                name: 'ventas.edit',
                                                params: {
                                                    id: oVenta.id,
                                                },
                                            }"
                                        >
                                            Editar
                                        </router-link>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</template>
<script>
import FormVenta from "./FormVenta.vue";
export default {
    components: {
        FormVenta,
    },
    props: ["id", "imprime"],
    data() {
        return {
            fullscreenLoading: true,
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            oConfiguracion: {
                id: 0,
                nombre_sistema: "",
                alias: "",
                razon_social: "",
                nit: "",
                ciudad: "",
                dir: "",
                fono: "",
                web: "",
                actividad: "",
                correo: "",
                logo: "",
            },
            oVenta: {
                id: 0,
                sucursal_id: "",
                cliente_id: "",
                nit: "",
                venta_mayor: "NO",
                total: "0.00",
                detalle_ventas: [],
            },
            total_final: 0,
            literal: "",
            devolucion: null,
            total_cantidad_devolucion: 0,
        };
    },
    watch: {
        oVenta(newVal) {
            this.oVenta = newVal;
        },
    },
    mounted() {
        this.getVenta();
        this.getConfiguracion();
        this.loadingWindow.close();
    },
    methods: {
        getConfiguracion() {
            this.loading = true;
            let url = "/configuracion/getConfiguracion";
            axios.get(url).then((res) => {
                this.oConfiguracion = res.data.configuracion;
            });
        },
        getVenta() {
            axios.get("/admin/ventas/" + this.id).then((response) => {
                this.oVenta = response.data;
                this.total_final = this.oVenta.total_final;
                this.getLiteral();
            });
        },
        getLiteral() {
            axios
                .get("/admin/ventas/info/getLiteral", {
                    params: {
                        total: this.total_final,
                    },
                })
                .then((response) => {
                    this.literal = response.data;
                    if (this.imprime) {
                        let self = this;
                        setTimeout(function () {
                            self.imrpimirContenedor();
                        }, 300);
                    }
                });
        },
        imrpimirContenedor() {
            var divContents = document.getElementById("principal").innerHTML;
            var a = window.open("", "");
            a.document.write("<html>");
            a.document.write("<head>");
            a.document.write(
                `
                <style>
                    @page { margin: 0;}
                    body { width: 7cm !important;}

                    #principal{
                        width: 7cm !important;
                    }

                    #contenedor_imprimir {
                        font-size: 0.95em;
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

                    .qr img {
                        width: 160px;
                        height: 160px;
                    }

                    .total {
                        font-size: 0.9em !important;
                    }
                </style>
                `
            );
            a.document.write("</head>");
            a.document.write("<body >");
            a.document.write(divContents);
            a.document.write("</body></html>");
            a.document.close();
            a.print();
        },
    },
};
</script>
<style>
/* FACURA */
.contenedor_factura {
    font-size: 0.95em;
    width: 7cm !important;
    padding-top: 15px;
    padding-bottom: 15px;
    font-family: "Times New Roman", Times, serif;
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

.qr img {
    width: 160px;
    height: 160px;
}

.total {
    font-size: 0.9em !important;
}
</style>
