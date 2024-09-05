<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Reportes - Cantidad de ordendes de ventas</h1>
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
                                                <div
                                                    class="text-center form-group clearfix mb-0 mt-0"
                                                >
                                                    <label
                                                        >Ajustar busqueda
                                                        <br /><small
                                                            ><i
                                                                >Realizará la
                                                                busqueda
                                                                exactamente por
                                                                la columna
                                                                seleccionada</i
                                                            ></small
                                                        ></label
                                                    >
                                                </div>
                                                <div
                                                    class="text-center form-group clearfix mb-1"
                                                >
                                                    <div
                                                        class="icheck-primary d-inline"
                                                    >
                                                        <input
                                                            type="radio"
                                                            id="radioPrimary5"
                                                            name="sw_busqueda"
                                                            value="todos"
                                                            v-model="
                                                                sw_busqueda
                                                            "
                                                            @change="
                                                                aux_lista_productos =
                                                                    [];
                                                                oReporte.producto_id =
                                                                    '';
                                                            "
                                                            checked=""
                                                        />
                                                        <label
                                                            for="radioPrimary5"
                                                        >
                                                            Todos
                                                        </label>
                                                    </div>
                                                    <div
                                                        class="icheck-primary d-inline"
                                                    >
                                                        <input
                                                            type="radio"
                                                            id="radioPrimary6"
                                                            name="sw_busqueda"
                                                            value="codigo"
                                                            v-model="
                                                                sw_busqueda
                                                            "
                                                            @change="
                                                                aux_lista_productos =
                                                                    [];
                                                                oReporte.producto_id =
                                                                    '';
                                                            "
                                                        />
                                                        <label
                                                            for="radioPrimary6"
                                                        >
                                                            Código
                                                        </label>
                                                    </div>
                                                    <div
                                                        class="icheck-primary d-inline"
                                                    >
                                                        <input
                                                            type="radio"
                                                            id="radioPrimary7"
                                                            name="sw_busqueda"
                                                            value="medida"
                                                            v-model="
                                                                sw_busqueda
                                                            "
                                                            @change="
                                                                aux_lista_productos =
                                                                    [];
                                                                oReporte.producto_id =
                                                                    '';
                                                            "
                                                        />
                                                        <label
                                                            for="radioPrimary7"
                                                        >
                                                            Medida
                                                        </label>
                                                    </div>
                                                    <div
                                                        class="icheck-primary d-inline"
                                                    >
                                                        <input
                                                            type="radio"
                                                            id="radioPrimary8"
                                                            name="sw_busqueda"
                                                            value="nombre"
                                                            v-model="
                                                                sw_busqueda
                                                            "
                                                            @change="
                                                                aux_lista_productos =
                                                                    [];
                                                                oReporte.producto_id =
                                                                    '';
                                                            "
                                                        />
                                                        <label
                                                            for="radioPrimary8"
                                                        >
                                                            Nombre
                                                        </label>
                                                    </div>
                                                </div>
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
                                                        :label="
                                                            item.codigo +
                                                            ' | ' +
                                                            item.nombre +
                                                            ' | ' +
                                                            item.medida
                                                        "
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
                                <div class="row">
                                    <div class="col-md-12" id="container"></div>
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
            user: JSON.parse(localStorage.getItem("user")),
            fullscreenLoading: true,
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
            axios
                .post("/admin/reportes/grafico_orden", this.oReporte)
                .then((response) => {
                    this.errors = [];
                    Highcharts.chart("container", {
                        chart: {
                            type: "column",
                        },
                        title: {
                            text: "CANTIDAD DE ORDENDES DE VENTAS",
                        },
                        subtitle: {
                            text: "",
                        },
                        xAxis: {
                            type: "category",
                            // crosshair: true,
                            labels: {
                                rotation: -45,
                                style: {
                                    fontSize: "13px",
                                    fontFamily: "Verdana, sans-serif",
                                },
                            },
                        },
                        yAxis: {
                            min: 0,
                            title: {
                                text: "CANTIDAD",
                            },
                        },
                        legend: {
                            enabled: true,
                        },
                        plotOptions: {
                            series: {
                                borderWidth: 0,
                                dataLabels: {
                                    enabled: true,
                                    format: "{point.y:.0f}",
                                },
                            },
                        },
                        tooltip: {
                            headerFormat:
                                '<span style="font-size:10px"><b>{point.key}</b></span><table>',
                            pointFormat:
                                '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                                '<td style="padding:0"><b>{point.y}</b></td></tr>',
                            footerFormat: "</table>",
                            shared: true,
                            useHTML: true,
                        },
                        series: [
                            {
                                name: "Cantidad",
                                colorByPoint: true,
                                data: response.data.datos,
                                dataLabels: {
                                    rotation: 0,
                                    color: "#000000",
                                    format: "{point.y:.0f}", // one decimal
                                    y: 0, // 10 pixels down from the top
                                    style: {
                                        fontSize: "13px",
                                        fontFamily: "Verdana, sans-serif",
                                    },
                                },
                            },
                        ],
                    });
                    this.enviando = false;
                })
                .catch(async (error) => {
                    this.enviando = false;
                    if (error.response) {
                        if (error.response.status === 422) {
                            this.errors = error.response.data.errors;
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
