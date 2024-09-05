<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Análisis - Inventario</h1>
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
                                <h4>Stock actual de cada producto</h4>
                                <div class="row">
                                    <div
                                        class="col-md-12"
                                        id="container1"
                                    ></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <h4>Stock de producto por fechas</h4>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row">
                                            <div class="col-md-3">
                                                <label>Fecha inicio</label>
                                                <input
                                                    type="date"
                                                    v-model="
                                                        oGrafico2.fecha_ini
                                                    "
                                                    class="form-control"
                                                />
                                            </div>
                                            <div class="col-md-3">
                                                <label>Fecha fin</label>
                                                <input
                                                    type="date"
                                                    v-model="
                                                        oGrafico2.fecha_fin
                                                    "
                                                    class="form-control"
                                                />
                                            </div>
                                            <div class="col-md-3">
                                                <label>Seleccione</label>
                                                <el-select
                                                    class="d-block"
                                                    v-model="oGrafico2.filtro"
                                                >
                                                    <el-option
                                                        v-for="(
                                                            item, index
                                                        ) in [
                                                            'TODOS',
                                                            'POR PRODUCTO',
                                                        ]"
                                                        :key="index"
                                                        :value="item"
                                                        :label="item"
                                                    ></el-option>
                                                </el-select>
                                            </div>
                                            <div
                                                class="col-md-3"
                                                v-if="
                                                    oGrafico2.filtro ==
                                                    'POR PRODUCTO'
                                                "
                                            >
                                                <label>Producto</label>
                                                <el-select
                                                    class="d-block"
                                                    v-model="oGrafico2.producto"
                                                >
                                                    <el-option
                                                        v-for="(
                                                            item, index
                                                        ) in listProductos"
                                                        :key="index"
                                                        :value="item.id"
                                                        :label="item.nombre"
                                                    ></el-option>
                                                </el-select>
                                            </div>
                                        </div>
                                    </div>
                                    <div
                                        class="col-md-12"
                                        id="container2"
                                    ></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <h4>Predicción de stock</h4>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row">
                                            <div class="col-md-3">
                                                <label>Año</label>
                                                <input
                                                    type="number"
                                                    v-model="oGrafico3.anio"
                                                    class="form-control"
                                                />
                                            </div>
                                            <div class="col-md-3">
                                                <label>Mes</label>
                                                <el-select
                                                    class="d-block"
                                                    v-model="oGrafico3.mes"
                                                >
                                                    <el-option
                                                        v-for="(
                                                            item, index
                                                        ) in listMeses"
                                                        :key="index"
                                                        :value="item.key"
                                                        :label="item.label"
                                                    ></el-option>
                                                </el-select>
                                            </div>
                                            <div class="col-md-3">
                                                <label>Seleccione</label>
                                                <el-select
                                                    class="d-block"
                                                    v-model="oGrafico3.filtro"
                                                >
                                                    <el-option
                                                        v-for="(
                                                            item, index
                                                        ) in [
                                                            'TODOS',
                                                            'POR PRODUCTO',
                                                        ]"
                                                        :key="index"
                                                        :value="item"
                                                        :label="item"
                                                    ></el-option>
                                                </el-select>
                                            </div>
                                            <div
                                                class="col-md-3"
                                                v-if="
                                                    oGrafico3.filtro ==
                                                    'POR PRODUCTO'
                                                "
                                            >
                                                <label>Producto</label>
                                                <el-select
                                                    class="d-block"
                                                    v-model="oGrafico3.producto"
                                                >
                                                    <el-option
                                                        v-for="(
                                                            item, index
                                                        ) in listProductos"
                                                        :key="index"
                                                        :value="item.id"
                                                        :label="item.nombre"
                                                    ></el-option>
                                                </el-select>
                                            </div>
                                        </div>
                                    </div>
                                    <div
                                        class="col-md-12"
                                        id="container3"
                                    ></div>
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
            aFechas: [],
            enviando: false,
            errors: [],
            oGrafico2: {
                filtro: "TODOS",
                fecha_ini: "",
                fecha_fin: "",
                producto: "TODOS",
            },
            oGrafico3: {
                anio: "",
                mes: "",
                filtro: "TODOS",
                producto: "TODOS",
            },
            listProductos: [],
            listMeses: [
                {
                    key: "01",
                    label: "Enero",
                },
                {
                    key: "02",
                    label: "Febrero",
                },
                {
                    key: "03",
                    label: "Marzo",
                },
                {
                    key: "04",
                    label: "Abril",
                },
                {
                    key: "05",
                    label: "Mayo",
                },
                {
                    key: "06",
                    label: "Junio",
                },
                {
                    key: "07",
                    label: "Julio",
                },
                {
                    key: "08",
                    label: "Agosto",
                },
                {
                    key: "09",
                    label: "Septiembre",
                },
                {
                    key: "10",
                    label: "Octubre",
                },
                {
                    key: "11",
                    label: "Noviembre",
                },
                {
                    key: "12",
                    label: "Diciembre",
                },
            ],
        };
    },
    watch: {
        oGrafico2: {
            handler: function (newVal, oldVal) {
                this.grafico2();
            },
            deep: true,
        },
        oGrafico3: {
            handler: function (newVal, oldVal) {
                this.grafico3();
            },
            deep: true,
        },
    },
    mounted() {
        this.loadingWindow.close();
        this.asignaFechas();
        this.getProductos();
        this.grafico1();
        this.grafico2();
        this.grafico3();
    },
    methods: {
        getProductos() {
            let url = "/admin/productos";
            axios.get(url).then((res) => {
                this.listProductos = res.data.productos;
                this.listProductos.unshift({ id: "TODOS", nombre: "TODOS" });
            });
        },
        grafico1() {
            this.enviando = true;
            axios
                .get("/admin/analisis_bi/stock_productos1")
                .then((response) => {
                    this.errors = [];
                    Highcharts.chart("container1", {
                        chart: {
                            type: "column",
                        },
                        title: {
                            text: "STOCK ACTUAL DE PRODUCTOS",
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
                                    fontSize: "10px",
                                    fontFamily: "Verdana, sans-serif",
                                },
                            },
                        },
                        yAxis: {
                            min: 0,
                            title: {
                                text: "TOTAL",
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
                                    format: "{point.y:.2f}",
                                },
                            },
                        },
                        tooltip: {
                            headerFormat:
                                '<span style="font-size:10px"><b>{point.key}</b></span><table>',
                            pointFormat:
                                '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                                '<td style="padding:0"><b>{point.y:.2f}</b></td></tr>',
                            footerFormat: "</table>",
                            shared: true,
                            useHTML: true,
                        },

                        series: [
                            {
                                name: "Stock actual",
                                colorByPoint: true,
                                data: response.data.datos,
                                dataLabels: {
                                    rotation: 0,
                                    color: "#000000",
                                    format: "{point.y:.2f}", // one decimal
                                    y: 0, // 10 pixels down from the top
                                    style: {
                                        fontSize: "10px",
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
        grafico2() {
            this.enviando = true;
            axios
                .get("/admin/analisis_bi/stock_productos2", {
                    params: this.oGrafico2,
                })
                .then((response) => {
                    this.errors = [];
                    let fecha_entero = new Date(
                        this.oGrafico2.fecha_ini
                    ).getTime();

                    Highcharts.chart("container2", {
                        title: {
                            text: "STOCK DE PRODUCTOS POR FECHAS",
                        },
                        subtitle: {
                            text: "",
                        },
                        xAxis: {
                            type: "datetime",
                            // crosshair: true,
                            labels: {
                                rotation: -75,
                                style: {
                                    fontSize: "10px",
                                    fontFamily: "Verdana, sans-serif",
                                },
                            },
                        },
                        yAxis: {
                            min: 0,
                            title: {
                                text: "TOTAL",
                            },
                        },
                        legend: {
                            layout: "vertical",
                            align: "right",
                            verticalAlign: "middle",
                        },

                        plotOptions: {
                            series: {
                                borderWidth: 0,
                                dataLabels: {
                                    enabled: false,
                                    format: "{point.y:.2f}",
                                },
                                pointStart: fecha_entero,
                                pointInterval: 24 * 3600 * 1000,
                            },
                        },
                        tooltip: {
                            headerFormat:
                                '<span style="font-size:10px"><b>{point.key}</b></span><table>',
                            pointFormat:
                                '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                                '<td style="padding:0"><b>{point.y:.2f}</b></td></tr>',
                            footerFormat: "</table>",
                            shared: true,
                            useHTML: true,
                        },

                        series: response.data.datos,
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
        grafico3() {
            this.enviando = true;
            axios
                .get("/admin/analisis_bi/stock_productos3", {
                    params: this.oGrafico3,
                })
                .then((response) => {
                    this.errors = [];
                    Highcharts.chart("container3", {
                        chart: {
                            type: "column",
                        },
                        title: {
                            text:
                                "PREDICCIÓN DE STOCK PRODUCTOS PARA " +
                                response.data.mes_anio,
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
                                    fontSize: "10px",
                                    fontFamily: "Verdana, sans-serif",
                                },
                            },
                        },
                        yAxis: {
                            min: 0,
                            title: {
                                text: "TOTAL",
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
                                    format: "{point.y:.2f}",
                                },
                            },
                        },
                        tooltip: {
                            headerFormat:
                                '<span style="font-size:10px"><b>{point.key}</b></span><table>',
                            pointFormat:
                                '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                                '<td style="padding:0"><b>{point.y:.2f}</b></td></tr>',
                            footerFormat: "</table>",
                            shared: true,
                            useHTML: true,
                        },

                        series: [
                            {
                                name: "Stock actual",
                                colorByPoint: true,
                                data: response.data.datos,
                                dataLabels: {
                                    rotation: 0,
                                    color: "#000000",
                                    format: "{point.y:.2f}", // one decimal
                                    y: 0, // 10 pixels down from the top
                                    style: {
                                        fontSize: "10px",
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
        asignaFechas() {
            let fecha = new Date();
            let fecha_completa = "";
            let anio = fecha.getFullYear();
            let mes = fecha.getMonth();
            let dia = fecha.getDate();
            mes = parseInt(mes + 1);
            fecha_completa = anio + "-" + mes + "-" + dia;
            this.oGrafico3.mes = mes;
            if (parseInt(mes) < 10) {
                fecha_completa = anio + "-0" + mes + "-" + dia;
                this.oGrafico3.mes = "0" + mes;
            }
            this.oGrafico2.fecha_ini = fecha_completa;
            this.oGrafico2.fecha_fin = fecha_completa;
            this.oGrafico3.anio = parseInt(anio);
        },
    },
};
</script>

<style></style>
