<template>
    <div class="row">
        <div class="col-md-6">
            <form>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div
                                class="card-header bg-primary text-md font-weight-bold"
                            >
                                <i class="fa fa-info-circle"></i> INFORMACIÓN DE
                                LA VENTA
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="form-group col-md-12">
                                        <label
                                            :class="{
                                                'text-danger':
                                                    errors.cliente_id,
                                            }"
                                            >Seleccionar cliente
                                            <button
                                                class="btn btn-xs btn-primary"
                                                @click.prevent="
                                                    abreModal('nuevo');
                                                    limpiaCliente();
                                                "
                                            >
                                                <i class="fa fa-plus"></i>
                                            </button>
                                        </label>
                                        <el-select
                                            class="w-full d-block"
                                            :class="{
                                                'is-invalid': errors.cliente_id,
                                            }"
                                            v-model="venta.cliente_id"
                                            clearable
                                            filterable
                                            @change="getCliente()"
                                        >
                                            <el-option
                                                v-for="item in listClientes"
                                                :key="item.id"
                                                :value="item.id"
                                                :label="item.nombre"
                                            >
                                            </el-option>
                                        </el-select>
                                        <span
                                            class="error invalid-feedback"
                                            v-if="errors.cliente_id"
                                            v-text="errors.cliente_id[0]"
                                        ></span>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <table
                                            class="table table-bordered tabla_responsive"
                                        >
                                            <thead>
                                                <tr>
                                                    <th>Nombre Completo</th>
                                                    <th>Número C.I. o Nit</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td
                                                        data-col="Nombre Completo: "
                                                        v-text
                                                    >
                                                        {{ oCliente.nombre }}
                                                    </td>
                                                    <td
                                                        data-col="Número C.I. o Nit: "
                                                    >
                                                        <select
                                                            class="form-control"
                                                            v-model="
                                                                venta.nit
                                                            "
                                                        >
                                                            <option value="0">
                                                                0
                                                            </option>
                                                            <option
                                                                :value="
                                                                    oCliente.nit
                                                                "
                                                            >
                                                                Nit:
                                                                {{
                                                                    oCliente.nit
                                                                }}
                                                            </option>
                                                            <option
                                                                :value="
                                                                    oCliente.ci
                                                                "
                                                            >
                                                                C.I.:
                                                                {{
                                                                    oCliente.ci
                                                                }}
                                                            </option>
                                                        </select>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div
                                class="card-header bg-primary text-md font-weight-bold"
                            >
                                <i class="fa fa-plus-circle"></i> AGREGAR
                                PRODUCTOS
                            </div>
                            <div class="card-body pt-0">
                                <div class="row">
                                    <div class="form-group col-md-12">
                                        <label
                                            :class="{
                                                'text-danger':
                                                    errors.producto_id,
                                            }"
                                            >Seleccionar producto</label
                                        >
                                        <el-select
                                            class="w-full d-block"
                                            :class="{
                                                'is-invalid':
                                                    errors.producto_id,
                                            }"
                                            v-model="producto_id"
                                            filterable
                                            remote
                                            reserve-keyword
                                            clearable
                                            placeholder="Buscar producto"
                                            :remote-method="buscarProducto"
                                            :loading="loading_buscador"
                                            @change="getProducto"
                                        >
                                            <el-option
                                                v-for="item in aux_lista_productos"
                                                :key="item.id"
                                                :value="item.id"
                                                :label="item.nombre"
                                            >
                                            </el-option>
                                        </el-select>
                                        <span
                                            class="error invalid-feedback"
                                            v-if="errors.producto_id"
                                            v-text="errors.producto_id[0]"
                                        ></span>
                                    </div>
                                    <div
                                        class="col-md-12"
                                        style="overflow: auto"
                                    >
                                        <table
                                            class="table table-bordered tabla_responsive"
                                        >
                                            <thead>
                                                <tr>
                                                    <th>Cód. Almacén</th>
                                                    <th>Cód. Producto</th>
                                                    <th>Nombre</th>
                                                    <th>Stock Disponible</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td
                                                        data-col="Cód. almacén: "
                                                        v-text="
                                                            oProducto?.codigo_almacen
                                                        "
                                                    ></td>
                                                    <td
                                                        data-col="Cód. producto: "
                                                        v-text="
                                                            oProducto?.codigo_producto
                                                        "
                                                    ></td>
                                                    <td
                                                        data-col="Nombre:"
                                                        v-text="
                                                            oProducto?.nombre
                                                        "
                                                    ></td>
                                                    <td
                                                        data-col="Stock actual: "
                                                        v-text="
                                                            oProducto?.stock_actual
                                                        "
                                                    ></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="form-group col-md-12">
                                        <label
                                            :class="{
                                                'text-danger': errors.cantidad,
                                            }"
                                            >Cantidad</label
                                        >
                                        <input
                                            type="number"
                                            class="form-control"
                                            :class="{
                                                'is-invalid': errors.cantidad,
                                            }"
                                            v-model="cantidad"
                                        />
                                        <span
                                            class="error invalid-feedback"
                                            v-if="errors.cantidad"
                                            v-text="errors.cantidad[0]"
                                        ></span>
                                    </div>
                                    <div class="col-md-12">
                                        <button
                                            class="btn btn-primary btn-flat btn-block"
                                            :disabled="
                                                cantidad <= 0 ||
                                                cantidad == '' ||
                                                producto_id == ''
                                            "
                                            @click.prevent="validaStock()"
                                        >
                                            <i class="fa fa-plus"></i> Agregar
                                            producto
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <div class="col-md-6">
            <div class="card">
                <div class="card-header bg-primary text-md font-weight-bold">
                    <i class="fa fa-list-alt"></i> DETALLE DE ORDEN DE VENTA
                </div>
                <div class="card-body p-0">
                    <div class="row">
                        <div class="col-md-12 contenedor_tabla">
                            <table
                                class="table table-striped tabla_responsive mb-0"
                            >
                                <thead>
                                    <tr>
                                        <th>Producto</th>
                                        <th>Precio Unitario</th>
                                        <th>Cantidad</th>
                                        <th>Subtotal</th>
                                        <th width="5px"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr
                                        v-if="
                                            venta.detalle_ventas.length >
                                            0
                                        "
                                        v-for="(
                                            item, index
                                        ) in venta.detalle_ventas"
                                    >
                                        <td data-col="Nombre: ">
                                            {{ item.producto.nombre }}
                                        </td>
                                        <td data-col="Precio Unitario: ">
                                            {{ item.precio }}
                                        </td>
                                        <td data-col="Cantidad: ">
                                            {{ item.cantidad }}
                                        </td>
                                        <td data-col="Subtotal: ">
                                            {{ item.subtotal }}
                                        </td>
                                        <td class="text-center">
                                            <button
                                                v-if="venta.editable"
                                                class="btn-sm btn-flat btn-danger"
                                                @click.prevent="
                                                    quitarDetalleVenta(
                                                        item.id,
                                                        index
                                                    )
                                                "
                                            >
                                                <i class="fa fa-times"></i>
                                            </button>
                                        </td>
                                    </tr>
                                    <tr
                                        v-if="
                                            venta.detalle_ventas.length ==
                                            0
                                        "
                                    >
                                        <td
                                            colspan="5"
                                            class="text-center text-gray font-weight-bold"
                                        >
                                            NO SE AGREGÓ NINGUN PRODUCTO
                                        </td>
                                    </tr>
                                </tbody>
                                <tfoot class="bg-blue">
                                    <tr>
                                        <td colspan="3" class="ocultar">
                                            TOTAL
                                        </td>
                                        <td
                                            data-col="TOTAL: "
                                            class="font-weight-bold text-lg"
                                        >
                                            {{ venta.total }}
                                        </td>
                                        <td class="ocultar"></td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-md-12">
                    <label
                        :class="{
                            'text-danger': errors.descuento,
                        }"
                        >Descuento %</label
                    >
                    <input
                        type="number"
                        class="form-control"
                        :class="{
                            'is-invalid': errors.descuento,
                        }"
                        max="100"
                        min="0"
                        step="0.01"
                        v-model="venta.descuento"
                        @keyup="sumaTotalVenta"
                        @change="sumaTotalVenta"
                    />
                    <span
                        class="error invalid-feedback"
                        v-if="errors.descuento"
                        v-text="errors.descuento[0]"
                    ></span>
                </div>
                <div class="form-group col-md-12">
                    <label
                        :class="{
                            'text-danger': errors.total_final,
                        }"
                        >Total final</label
                    >
                    <input
                        type="number"
                        class="form-control"
                        :class="{
                            'is-invalid': errors.total_final,
                        }"
                        v-model="venta.total_final"
                        readonly
                    />
                    <span
                        class="error invalid-feedback"
                        v-if="errors.total_final"
                        v-text="errors.total_final[0]"
                    ></span>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <el-button
                        type="primary"
                        class="btn-primary bg-primary btn-block"
                        :loading="enviando"
                        @click="enviarFormulario()"
                        v-html="textoBoton"
                        :disabled="venta.detalle_ventas.length <= 0"
                        v-if="venta.editable || accion == 'nuevo'"
                    ></el-button>
                    <el-button type="info" class="btn-block" v-else>
                        No editable, debido a que existe una
                        devolución</el-button
                    >
                    <router-link
                        v-if="this.venta.id != 0"
                        class="btn btn-success btn-lg btn-block"
                        :to="{ name: 'ventas.ticket' }"
                        ><i class="fa fa-print"></i> Imprimir
                        Ticket</router-link
                    >

                    <router-link
                        :to="{ name: 'ventas.create' }"
                        v-if="this.venta.id != 0"
                        class="btn btn-danger btn-lg btn-block"
                        ><i class="fa fa-plus"></i> Realizar nueva
                        orden</router-link
                    >

                    <router-link
                        :to="{ name: 'ventas.index' }"
                        class="btn btn-default btn-lg btn-block"
                        ><i class="fa fa-cash-register"></i> Volver a
                        ventas</router-link
                    >
                </div>
            </div>
        </div>
        <NuevoCliente
            :muestra_modal="muestra_modal"
            :accion="modal_accion"
            :cliente="oClienteModal"
            @close="muestra_modal = false"
            @envioModal="getClientes"
        ></NuevoCliente>
    </div>
</template>

<script>
import NuevoCliente from "./NuevoCliente.vue";
export default {
    components: {
        NuevoCliente,
    },
    props: {
        accion: {
            type: String,
            default: "nuevo",
        },
        venta: {
            type: Object,
            default() {
                return {
                    id: 0,
                    sucursal_id: "",
                    cliente_id: "",
                    nit: "",
                    total: "0.00",
                    descuento: "0",
                    total_final: "0.00",
                    detalle_ventas: [],
                    editable: true,
                };
            },
        },
    },
    watch: {
        venta(newVal, oldVal) {
            if (newVal.id != 0) {
                this.getClientes();
                this.getCliente();
                this.getCajas();
            }
        },
    },
    computed: {
        textoBoton() {
            if (this.accion == "nuevo") {
                return '<i class="fa fa-save"></i> Registrar venta';
            } else {
                return '<i class="fa fa-edit"></i> Actualizar venta';
            }
        },
    },
    data() {
        return {
            user: JSON.parse(localStorage.getItem("user")),
            enviando: false,
            producto_id: "",
            cantidad: 1,
            errors: [],
            listClientes: [],
            aux_lista_productos: [],
            listProductos: [],
            listTipos: ["AL CONTADO", "A CRÉDITO"],
            eliminados: [],
            muestra_modal: false,
            modal_accion: "nuevo",
            oCliente: {
                id: 0,
                nombre: "",
                ci: "",
                ci_exp: "",
                full_ci: "",
                nit: "",
                fono_array: [],
                fono: "",
                dir: "",
            },
            oClienteModal: {
                id: 0,
                nombre: "",
                ci: "",
                ci_exp: "",
                full_ci: "",
                nit: "",
                fono_array: [],
                fono: "",
                dir: "",
            },
            oProducto: null,
            sw_busqueda: "todos",
            loading_buscador: false,
            timeOutProductos: null,
        };
    },
    mounted() {
        if (this.venta.id == 0) {
            this.venta.fecha = this.fechaActual();
        }
        if (this.user.tipo == "CAJA") {
            this.venta.caja_id = this.user.caja_usuario.caja_id;
        }
        this.getClientes();
        this.iniciaSeleccionFilas();
    },
    methods: {
        // OBTENER LISTADOS E INFORMACIÓN
        getCliente() {
            if (this.venta.cliente_id != "") {
                axios
                    .get("/admin/clientes/" + this.venta.cliente_id)
                    .then((response) => {
                        this.oCliente = response.data.cliente;
                        if (this.accion != "edit") {
                            this.venta.nit = this.oCliente.ci;
                        }
                    });
            } else {
                this.oCliente = {
                    id: 0,
                    nombre: "",
                    ci: "",
                    ci_exp: "",
                    full_ci: "",
                    nit: "",
                    fono_array: [],
                    fono: "",
                    dir: "",
                };
            }
        },
        getClientes() {
            this.muestra_modal = false;
            axios.get("/admin/clientes").then((response) => {
                this.listClientes = response.data.clientes;
            });
        },
        getProducto() {
            if (this.producto_id != "") {
                axios
                    .get("/admin/productos/" + this.producto_id)
                    .then((response) => {
                        this.oProducto = response.data.producto;
                        this.oProducto["stock_actual"] =
                            response.data.stock_actual;
                    });
            } else {
                this.oProducto = null;
            }
        },
        // ENVIAR REGISTRO
        enviarFormulario() {
            this.enviando = true;
            try {
                this.textoBtn = "Enviando...";
                let url = "/admin/ventas";
                if (this.accion == "edit") {
                    url = "/admin/ventas/" + this.venta.id;
                    this.venta["_method"] = "PUT";
                    this.venta.eliminados = this.eliminados;
                }
                axios
                    .post(url, this.venta)
                    .then((res) => {
                        this.enviando = false;
                        if (res.data.sw) {
                            Swal.fire({
                                icon: "success",
                                title: res.data.msj,
                                showConfirmButton: false,
                                timer: 2000,
                            });
                            this.$emit("envioFormulario", res.data.id);
                            this.errors = [];
                            if (this.accion == "edit") {
                                this.textoBtn = "Actualizar venta";
                            } else {
                                this.textoBtn = "Registrar venta";
                            }
                        } else {
                            Swal.fire({
                                icon: "info",
                                title: "Atención",
                                html: res.data.msj,
                                showConfirmButton: false,
                                timer: 2000,
                            });
                        }
                    })
                    .catch((error) => {
                        this.enviando = false;
                        if (this.accion == "edit") {
                            this.textoBtn = "Actualizar venta";
                        } else {
                            this.textoBtn = "Registrar venta";
                        }
                        if (error.response) {
                            if (error.response.status === 422) {
                                this.errors = error.response.data.errors;
                            }
                            if (
                                error.response.status === 420 ||
                                error.response.status === 419 ||
                                error.response.status === 401
                            ) {
                                window.location = "/";
                            }
                            if (error.response.status === 500) {
                                Swal.fire({
                                    icon: "error",
                                    title: "Error",
                                    html: error.response.data.message,
                                    showConfirmButton: false,
                                    timer: 2000,
                                });
                            }
                        }
                    });
            } catch (e) {
                this.enviando = false;
                console.log(e);
            }
        },
        limpiaVenta() {
            this.errors = [];
        },
        fechaActual() {
            // crea un nuevo objeto `Date`
            var today = new Date();

            // `getDate()` devuelve el día del mes (del 1 al 31)
            var day = today.getDate();
            if (day < 10) {
                day = "0" + day;
            }
            // `getMonth()` devuelve el mes (de 0 a 11)
            var month = today.getMonth() + 1;
            if (month < 10) {
                month = "0" + month;
            }

            // `getFullYear()` devuelve el año completo
            var year = today.getFullYear();

            // muestra la fecha de hoy en formato `MM/DD/YYYY`
            return `${year}-${month}-${day}`;
        },
        iniciaSeleccionFilas() {
            $(".detalle_ventas").on("focusin", "input", function () {
                $(this).parents("tr").addClass("seleccionado");
            });
            $(".detalle_ventas").on("focusout", "input", function () {
                $(this).parents("tr").removeClass("seleccionado");
            });
        },
        buscarProducto(query) {
            this.aux_lista_productos = [];
            this.loading_buscador = true;
            clearTimeout(this.timeOutProductos);
            let self = this;
            this.timeOutProductos = setTimeout(() => {
                self.getProductosQuery(query);
            }, 1000);
        },
        getProductosQuery(query) {
            if (query !== "") {
                axios
                    .get("/admin/productos/buscar_producto", {
                        params: {
                            value: query,
                            sw_busqueda: this.sw_busqueda,
                        },
                    })
                    .then((response) => {
                        this.loading_buscador = false;
                        this.listProductos;
                        this.aux_lista_productos = response.data;
                    });
            } else {
                this.loading_buscador = false;
                this.aux_lista_productos = [];
            }
        },
        generaReporte() {
            this.enviando = true;
            let config = {
                responseType: "blob",
            };
            axios
                .post(
                    "/admin/ventas/pdf/" + this.venta.id,
                    null,
                    config
                )
                .then((res) => {
                    this.errors = [];
                    this.enviando = false;
                    let pdfBlob = new Blob([res.data], {
                        type: "application/pdf",
                    });
                    let urlReporte = URL.createObjectURL(pdfBlob);
                    window.open(urlReporte);
                    this.enviando = false;
                })
                .catch(async (error) => {
                    let responseObj = await error.response.data.text();
                    responseObj = JSON.parse(responseObj);
                    this.enviando = false;
                    if (error.response) {
                        if (error.response.status == 422)
                            this.errors = responseObj.errors;
                    }
                    this.enviando = false;
                });
        },
        validaStock() {
            axios
                .get("/admin/productos/valida_stock", {
                    params: {
                        id: this.producto_id,
                        cantidad: this.cantidad,
                    },
                })
                .then((response) => {
                    if (response.data.sw) {
                        let subtotal = 0;
                        let precio = 0;
                        precio = response.data.producto.precio;
                        subtotal =
                            parseFloat(this.cantidad) * parseFloat(precio);
                        this.venta.detalle_ventas.push({
                            id: 0,
                            venta_id: 0,
                            producto_id: response.data.producto.id,
                            cantidad: this.cantidad,
                            precio: precio,
                            subtotal: subtotal.toFixed(2),
                            producto: response.data.producto,
                        });
                        this.sumaTotalVenta();
                        this.producto_id = "";
                        this.oProducto = null;
                        this.cantidad = 1;
                    } else {
                        Swal.fire({
                            icon: "info",
                            title: "ATENCIÓN",
                            html: response.data.msj,
                            showConfirmButton: false,
                            timer: 2500,
                        });
                    }
                });
        },
        sumaTotalVenta() {
            let suma_total = 0;
            let precio = 0;
            let subtotal = 0;
            this.venta.detalle_ventas.forEach((elem) => {
                suma_total += parseFloat(elem.subtotal);
            });
            this.venta.total = suma_total.toFixed(2);

            // agrega descuento
            if (this.venta.descuento != "") {
                if (
                    parseFloat(this.venta.descuento) >= 0 &&
                    parseFloat(this.venta.descuento) <= 100
                ) {
                    let p_descuento =
                        parseFloat(
                            this.venta.descuento != ""
                                ? this.venta.descuento
                                : 0
                        ) / 100;
                    let descuento =
                        parseFloat(this.venta.total) * p_descuento;
                    this.venta.total_final = parseFloat(
                        parseFloat(this.venta.total) - descuento
                    ).toFixed(2);
                } else {
                    this.venta.descuento = 0;
                    this.venta.total_final = this.venta.total;
                    Swal.fire({
                        icon: "info",
                        title: "ATENCIÓN",
                        html: "Debes ingresar un descuento entre 0 y 100%",
                        showConfirmButton: false,
                        timer: 2500,
                    });
                }
            }
        },
        quitarDetalleVenta(id, index) {
            if (id) {
                this.eliminados.push(id);
            }
            this.venta.detalle_ventas.splice(index, 1);
            this.sumaTotalVenta();
        },
        abreModal(tipo_accion = "nuevo") {
            this.muestra_modal = true;
            this.modal_accion = tipo_accion;
        },
        limpiaCliente() {
            this.oClienteModal.nombre = "";
            this.oClienteModal.ci = "";
            this.oClienteModal.ci_exp = "";
            this.oClienteModal.nit = "";
            this.oClienteModal.fono_array = [];
            this.oClienteModal.fono = "";
            this.oClienteModal.dir = "";
        },
    },
};
</script>

<style>
.detalle_ventas tbody tr td {
    padding: 0px;
    vertical-align: middle;
}

.detalle_ventas tbody tr td:nth-child(1) {
    padding-left: 5px;
}

.contenedor_tabla {
    overflow: auto;
}

@media (max-width: 780px) {
    .tabla_responsive thead {
        display: none;
    }

    .tabla_responsive.table-striped tbody tr td,
    .tabla_responsive.table-bordered tbody tr td {
        display: block !important;
    }
    .tabla_responsive.table-striped tbody tr td:before,
    .tabla_responsive.table-bordered tbody tr td:before {
        content: attr(data-col);
        font-weight: bold;
    }

    .tabla_responsive.table-bordered tfoot tr td,
    .tabla_responsive.table-bordered tfoot tr th,
    .tabla_responsive.table-striped tfoot tr td,
    .tabla_responsive.table-striped tfoot tr th {
        display: block;
    }

    .tabla_responsive.table-bordered tfoot tr td.ocultar,
    .tabla_responsive.table-bordered tfoot tr th.ocultar,
    .tabla_responsive.table-striped tfoot tr td.ocultar,
    .tabla_responsive.table-striped tfoot tr th.ocultar {
        display: none !important;
    }

    .tabla_responsive.table-bordered tfoot tr td:before,
    .tabla_responsive.table-bordered tfoot tr th:before,
    .tabla_responsive.table-striped tfoot tr td:before,
    .tabla_responsive.table-striped tfoot tr th:before {
        content: attr(data-col);
        font-weight: bold;
    }
}
</style>
