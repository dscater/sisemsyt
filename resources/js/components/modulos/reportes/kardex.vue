<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Reportes - Kardex de productos</h1>
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
                                <div class="ml-auto mr-auto col-md-5">
                                    <form>
                                        <div class="row">
                                            <div class="form-group col-md-12">
                                                <label
                                                    :class="{
                                                        'text-danger':
                                                            errors.filtro,
                                                    }"
                                                    >Seleccione*</label
                                                >
                                                <el-select
                                                    v-model="oReporte.filtro"
                                                    filterable
                                                    placeholder="Seleccione"
                                                    class="d-block"
                                                    :class="{
                                                        'is-invalid':
                                                            errors.filtro,
                                                    }"
                                                >
                                                    <el-option
                                                        v-for="item in listFiltro"
                                                        :key="item"
                                                        :label="item"
                                                        :value="item"
                                                    >
                                                    </el-option>
                                                </el-select>
                                                <span
                                                    class="error invalid-feedback"
                                                    v-if="errors.filtro"
                                                    v-text="errors.filtro[0]"
                                                ></span>
                                            </div>
                                            <div
                                                class="form-group col-md-12"
                                                v-if="
                                                    oReporte.filtro ==
                                                    'Producto'
                                                "
                                            >
                                                <label
                                                    :class="{
                                                        'text-danger':
                                                            errors.producto_id,
                                                    }"
                                                    >Seleccionar
                                                    Producto*</label
                                                >

                                                <el-select
                                                    class="w-100"
                                                    :class="{
                                                        'is-invalid':
                                                            errors.producto_id,
                                                    }"
                                                    v-model="
                                                        oReporte.producto_id
                                                    "
                                                    filterable
                                                    remote
                                                    reserve-keyword
                                                    placeholder="Buscar producto"
                                                    :remote-method="
                                                        buscarProducto
                                                    "
                                                    :loading="loading_buscador"
                                                >
                                                    <el-option
                                                        v-for="item in aux_lista_productos"
                                                        :key="item.id"
                                                        :label="item.nombre"
                                                        :value="item.id"
                                                    >
                                                    </el-option>
                                                </el-select>
                                                <span
                                                    class="error invalid-feedback"
                                                    v-if="errors.producto_id"
                                                    v-text="
                                                        errors.producto_id[0]
                                                    "
                                                ></span>
                                            </div>
                                            <div
                                                class="form-group col-md-12"
                                                v-if="
                                                    oReporte.filtro ==
                                                    'Rango de fechas'
                                                "
                                            >
                                                <label
                                                    :class="{
                                                        'text-danger':
                                                            errors.fecha_ini,
                                                        'text-danger':
                                                            errors.fecha_fin,
                                                    }"
                                                    >Indice un rango de
                                                    fechas*</label
                                                >
                                                <el-date-picker
                                                    class="w-full d-block"
                                                    :class="{
                                                        'is-invalid':
                                                            errors.fecha_ini,
                                                        'is-invalid':
                                                            errors.fecha_fin,
                                                    }"
                                                    v-model="aFechas"
                                                    type="daterange"
                                                    range-separator="a"
                                                    start-placeholder="Fecha Inicial"
                                                    end-placeholder="Fecha Final"
                                                    format="dd/MM/yyyy"
                                                    value-format="yyyy-MM-dd"
                                                    @change="obtieneFechas()"
                                                >
                                                </el-date-picker>
                                                <span
                                                    class="error invalid-feedback"
                                                    v-if="errors.fecha_ini"
                                                    v-text="errors.fecha_ini[0]"
                                                ></span>
                                                <span
                                                    class="error invalid-feedback"
                                                    v-if="errors.fecha_fin"
                                                    v-text="errors.fecha_fin[0]"
                                                ></span>
                                            </div>
                                        </div>
                                    </form>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <el-button
                                                type="primary"
                                                class="bg-primary w-full"
                                                :loading="enviando"
                                                @click="generaReporte()"
                                                >{{ textoBtn }}</el-button
                                            >
                                        </div>
                                        <div class="col-md-12">
                                            <el-button
                                                type="default"
                                                class="w-full mt-1"
                                                @click="limpiarFormulario()"
                                                >Reiniciar</el-button
                                            >
                                        </div>
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
export default {
    data() {
        return {
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            errors: [],
            oReporte: {
                filtro: "Todos",
                producto_id: "",
                fecha_ini: "",
                fecha_fin: "",
            },
            aFechas: [],
            enviando: false,
            textoBtn: "Generar Reporte",
            listFiltro: ["Todos", "Producto", "Rango de fechas"],
            listProductos: [],
            aux_lista_productos: [],
            loading_buscador: false,
            errors: [],
            sw_busqueda: "todos",
        };
    },
    mounted() {
        this.loadingWindow.close();
    },
    methods: {
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
        limpiarFormulario() {
            this.oReporte.filtro = "Todos";
        },
        generaReporte() {
            this.enviando = true;
            let config = {
                responseType: "blob",
            };
            axios
                .post("/admin/reportes/kardex", this.oReporte, config)
                .then((res) => {
                    this.errors = [];
                    this.enviando = false;
                    let pdfBlob = new Blob([res.data], {
                        type: "application/pdf",
                    });
                    let urlReporte = URL.createObjectURL(pdfBlob);
                    window.open(urlReporte);
                })
                .catch(async (error) => {
                    let responseObj = await error.response.data.text();
                    responseObj = JSON.parse(responseObj);
                    console.log(error);
                    this.enviando = false;
                    if (error.response) {
                        if (error.response.status === 422) {
                            this.errors = responseObj.errors;
                        }
                        if (
                            error.response.status === 420 ||
                            error.response.status === 419 ||
                            error.response.status === 401
                        ) {
                            Swal.fire({
                                icon: "error",
                                title: "Error",
                                html: responseObj.message,
                                showConfirmButton: false,
                                timer: 2000,
                            });
                            window.location = "/";
                        }

                        if (error.response.status === 500) {
                            Swal.fire({
                                icon: "error",
                                title: "Error",
                                html: responseObj.message,
                                showConfirmButton: false,
                                timer: 2000,
                            });
                        }
                    }
                });
        },
        obtieneFechas() {
            this.oReporte.fecha_ini = this.aFechas[0];
            this.oReporte.fecha_fin = this.aFechas[1];
        },
    },
};
</script>

<style></style>
