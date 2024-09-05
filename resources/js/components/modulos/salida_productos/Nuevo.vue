<template>
    <div
        class="modal fade"
        :class="{ show: bModal }"
        id="modal-default"
        aria-modal="true"
        role="dialog"
    >
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <h4 class="modal-title" v-text="tituloModal"></h4>
                    <button
                        type="button"
                        class="close"
                        data-dismiss="modal"
                        aria-label="Close"
                        @click="cierraModal"
                    >
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="row">
                            <div
                                class="form-group col-md-12"
                                v-if="accion != 'edit'"
                            >
                                <label
                                    :class="{
                                        'text-danger': errors.producto_id,
                                    }"
                                    >Seleccionar Producto*</label
                                >

                                <el-select
                                    class="w-100"
                                    :class="{
                                        'is-invalid': errors.producto_id,
                                    }"
                                    v-model="salida_producto.producto_id"
                                    filterable
                                    remote
                                    reserve-keyword
                                    placeholder="Buscar producto"
                                    :remote-method="buscarProducto"
                                    :loading="loading_buscador"
                                    @change="muestraInfoProducto"
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
                            <div class="form-group col-md-12" v-else>
                                <label
                                    :class="{
                                        'text-danger': errors.producto_id,
                                    }"
                                    >Producto*</label
                                >
                                <input
                                    type="readonly"
                                    class="form-control"
                                    readonly
                                    v-model="
                                        salida_producto.nombre_producto
                                    "
                                />
                            </div>
                            <div
                                class="col-md-12"
                                v-if="oProducto && oProducto.codigo_almacen"
                            >
                                <table class="table table-bordered">
                                    <thead>
                                        <tr class="bg-primary">
                                            <th>Cód. Almacén</th>
                                            <th>Cód. Producto</th>
                                            <th>Nombre</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                {{ oProducto.codigo_almacen }}
                                            </td>
                                            <td>
                                                {{ oProducto.codigo_producto }}
                                            </td>
                                            <td>{{ oProducto.nombre }}</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.cantidad,
                                    }"
                                    >Cantidad*</label
                                >
                                <el-input
                                    type="number"
                                    min="0.01"
                                    placeholder="Cantidad"
                                    :class="{ 'is-invalid': errors.cantidad }"
                                    v-model="salida_producto.cantidad"
                                    clearable
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.cantidad"
                                    v-text="errors.cantidad[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.fecha_salida,
                                    }"
                                    >Fecha de salida*</label
                                >
                                <el-input
                                    type="date"
                                    placeholder="Fecha de salida"
                                    :class="{
                                        'is-invalid': errors.fecha_salida,
                                    }"
                                    v-model="salida_producto.fecha_salida"
                                    clearable
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.fecha_salida"
                                    v-text="errors.fecha_salida[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.tipo_salida_id,
                                    }"
                                    >Seleccionar Tipo de salida*</label
                                >
                                <el-select
                                    placeholder="Tipo de salida"
                                    class="w-100"
                                    :class="{
                                        'is-invalid': errors.tipo_salida_id,
                                    }"
                                    v-model="salida_producto.tipo_salida_id"
                                    filterable
                                >
                                    <el-option
                                        v-for="item in listTipoSalidas"
                                        :key="item.id"
                                        :label="item.nombre"
                                        :value="item.id"
                                    >
                                    </el-option>
                                </el-select>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.tipo_salida_id"
                                    v-text="errors.tipo_salida_id[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.descripcion,
                                    }"
                                    >Descripción</label
                                >
                                <el-input
                                    type="textarea"
                                    autosize
                                    placeholder="Descripción"
                                    :class="{
                                        'is-invalid': errors.descripcion,
                                    }"
                                    v-model="salida_producto.descripcion"
                                    clearable
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.descripcion"
                                    v-text="errors.descripcion[0]"
                                ></span>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer justify-content-between">
                    <button
                        type="button"
                        class="btn btn-default"
                        data-dismiss="modal"
                        @click="cierraModal"
                    >
                        Cerrar
                    </button>
                    <el-button
                        type="primary"
                        class="bg-primary"
                        :loading="enviando"
                        @click="setRegistroModal()"
                        >{{ textoBoton }}</el-button
                    >
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    props: {
        muestra_modal: {
            type: Boolean,
            default: false,
        },
        accion: {
            type: String,
            default: "nuevo",
        },
        salida_producto: {
            type: Object,
            default: {
                id: 0,
                lugar: "",
                producto_id: "",
                cantidad: "",
                tipo_salida_id: "",
                descripcion: "",
            },
        },
    },
    watch: {
        muestra_modal: function (newVal, oldVal) {
            this.errors = [];
            if (newVal) {
                this.bModal = true;
            } else {
                this.bModal = false;
            }
        },
    },
    computed: {
        tituloModal() {
            if (this.accion == "nuevo") {
                return "NUEVO REGISTRO";
            } else {
                return "MODIFICAR REGISTRO";
            }
        },
        textoBoton() {
            if (this.accion == "nuevo") {
                return "Registrar";
            } else {
                return "Actualizar";
            }
        },
    },
    data() {
        return {
            user: JSON.parse(localStorage.getItem("user")),
            bModal: this.muestra_modal,
            enviando: false,
            errors: [],
            listProductos: [],
            aux_lista_productos: [],
            listTipoSalidas: [],
            loading_buscador: false,
            timeOutProductos: null,
            sw_busqueda: "todos",
            oProducto: {
                codigo_almacen: "",
                codigo_producto: "",
                nombre: "",
            },
        };
    },
    mounted() {
        this.bModal = this.muestra_modal;
        this.getTipoSalidas();
    },
    methods: {
        getTipoSalidas() {
            axios.get("/admin/tipo_salidas").then((response) => {
                this.listTipoSalidas = response.data.tipo_salidas;
            });
        },
        setRegistroModal() {
            this.enviando = true;
            try {
                this.textoBtn = "Enviando...";
                let url = "/admin/salida_productos";
                let config = {
                    headers: {
                        "Content-Type": "multipart/form-data",
                    },
                };
                let formdata = new FormData();
                formdata.append(
                    "producto_id",
                    this.salida_producto.producto_id
                        ? this.salida_producto.producto_id
                        : ""
                );
                formdata.append(
                    "cantidad",
                    this.salida_producto.cantidad
                        ? this.salida_producto.cantidad
                        : ""
                );
                formdata.append(
                    "fecha_salida",
                    this.salida_producto.fecha_salida
                        ? this.salida_producto.fecha_salida
                        : ""
                );
                formdata.append(
                    "tipo_salida_id",
                    this.salida_producto.tipo_salida_id
                        ? this.salida_producto.tipo_salida_id
                        : ""
                );
                formdata.append(
                    "descripcion",
                    this.salida_producto.descripcion
                        ? this.salida_producto.descripcion
                        : ""
                );
                if (this.accion == "edit") {
                    url = "/admin/salida_productos/" + this.salida_producto.id;
                    formdata.append("_method", "PUT");
                }
                axios
                    .post(url, formdata, config)
                    .then((res) => {
                        this.enviando = false;
                        if (res.data.sw) {
                            Swal.fire({
                                icon: "success",
                                title: res.data.msj,
                                showConfirmButton: false,
                                timer: 1500,
                            });
                            this.limpiaSalidaProducto();
                            this.$emit("envioModal");
                            this.errors = [];
                            if (this.accion == "edit") {
                                this.textoBtn = "Actualizar";
                            } else {
                                this.textoBtn = "Registrar";
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
                            this.textoBtn = "Actualizar";
                        } else {
                            this.textoBtn = "Registrar";
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
        // Dialog/modal
        cierraModal() {
            this.bModal = false;
            this.$emit("close");
        },
        limpiaSalidaProducto() {
            this.errors = [];
            this.salida_producto.producto_id = "";
            this.salida_producto.cantidad = "";
            this.salida_producto.tipo_salida_id = "";
            this.salida_producto.fecha_salida = "";
            this.salida_producto.descripcion = "";
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
        muestraInfoProducto() {
            if (this.salida_producto.producto_id != "") {
                let elem = this.aux_lista_productos.filter(
                    (element) => element.id == this.salida_producto.producto_id
                );
                this.oProducto = elem[0];
            } else {
                this.oProducto = null;
            }
        },
    },
};
</script>

<style></style>
