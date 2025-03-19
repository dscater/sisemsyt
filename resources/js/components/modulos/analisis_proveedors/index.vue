<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Análisis - Proveedores</h1>
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
                                <h4>Cantidad actual proveída por proveedor</h4>
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
                                <h4>
                                    Predicción Cantidad proveída por proveedor
                                </h4>
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
                                                            'POR PROVEEDOR',
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
                                                    'POR PROVEEDOR'
                                                "
                                            >
                                                <label>Proveedor</label>
                                                <el-select
                                                    class="d-block"
                                                    v-model="
                                                        oGrafico3.proveedor
                                                    "
                                                >
                                                    <el-option
                                                        v-for="(
                                                            item, index
                                                        ) in listProveedors"
                                                        :key="index"
                                                        :value="item.id"
                                                        :label="
                                                            item.razon_social
                                                        "
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
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <h4>
                                    Cantidad proveída por proveedor en un rango
                                    de fechas
                                </h4>
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
                                                            'POR PROVEEDOR',
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
                                                    'POR PROVEEDOR'
                                                "
                                            >
                                                <label>Proveedor</label>
                                                <el-select
                                                    class="d-block"
                                                    v-model="
                                                        oGrafico2.proveedor
                                                    "
                                                >
                                                    <el-option
                                                        v-for="(
                                                            item, index
                                                        ) in listProveedors"
                                                        :key="index"
                                                        :value="item.id"
                                                        :label="
                                                            item.razon_social
                                                        "
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
                proveedor: "TODOS",
            },
            oGrafico3: {
                anio: "",
                mes: "",
                filtro: "TODOS",
                proveedor: "TODOS",
            },
            listProveedors: [],
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
        this.getProveedors();
        this.grafico1();
        this.grafico2();
        this.grafico3();
    },
    methods: {
        getProveedors() {
            let url = "/admin/proveedors";
            axios.get(url).then((res) => {
                this.listProveedors = res.data.proveedors;
                this.listProveedors.unshift({ id: "TODOS", nombre: "TODOS" });
            });
        },
        grafico1() {
            this.enviando = true;
            axios
                .get("/admin/reporte_analisis/proveedors1")
                .then((response) => {
                    this.errors = [];
                    Highcharts.chart("container1", {
                        chart: {
                            type: "column",
                        },
                        title: {
                            text: "CANTIDAD ACTUAL PROVEÍDA POR PROVEEDOR",
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
                                name: "Cantidad proveída",
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
                .get("/admin/reporte_analisis/proveedors2", {
                    params: this.oGrafico2,
                })
                .then((response) => {
                    this.errors = [];
                    let fecha_entero = new Date(
                        this.oGrafico2.fecha_ini
                    ).getTime();

                    Highcharts.chart("container2", {
                        chart: {
                            plotBackgroundColor: null,
                            plotBorderWidth: null,
                            plotShadow: false,
                            type: "pie",
                        },
                        title: {
                            text: "CANTIDAD PROVEÍDA POR PROVEEDORES",
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
                            pie: {
                                allowPointSelect: true,
                                cursor: "pointer",
                                dataLabels: {
                                    enabled: false,
                                },
                                showInLegend: true,
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
                                name: "Cantidad proveída",
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
        grafico3() {
            this.enviando = true;
            axios
                .get("/admin/reporte_analisis/proveedors3", {
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
                                "PREDICCIÓN CANTIDAD PROVEÍDA POR PROVEEDOR PARA " +
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
                                name: "Cantidad proveída",
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
