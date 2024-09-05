<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Análisis - Ventas</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body">
                                <h4>Cantidad de productos vendidos</h4>
                                <div class="row">
                                    <div
                                        class="col-md-12"
                                        id="container1"
                                    ></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body">
                                <h4>Ingresos por venta de productos</h4>
                                <div class="row">
                                    <div
                                        class="col-md-12"
                                        id="container2"
                                    ></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body">
                                <h4>Cantidad de productos vendidos</h4>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row">
                                            <div class="col-md-3">
                                                <label>Fecha inicio</label>
                                                <input
                                                    type="date"
                                                    v-model="
                                                        oGrafico3.fecha_ini
                                                    "
                                                    class="form-control"
                                                />
                                            </div>
                                            <div class="col-md-3">
                                                <label>Fecha fin</label>
                                                <input
                                                    type="date"
                                                    v-model="
                                                        oGrafico3.fecha_fin
                                                    "
                                                    class="form-control"
                                                />
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
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body">
                                <h4>Ingresos por venta de productos</h4>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row">
                                            <div class="col-md-3">
                                                <label>Fecha inicio</label>
                                                <input
                                                    type="date"
                                                    v-model="
                                                        oGrafico4.fecha_ini
                                                    "
                                                    class="form-control"
                                                />
                                            </div>
                                            <div class="col-md-3">
                                                <label>Fecha fin</label>
                                                <input
                                                    type="date"
                                                    v-model="
                                                        oGrafico4.fecha_fin
                                                    "
                                                    class="form-control"
                                                />
                                            </div>
                                            <div class="col-md-3">
                                                <label>Seleccione</label>
                                                <el-select
                                                    class="d-block"
                                                    v-model="oGrafico4.filtro"
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
                                                    oGrafico4.filtro ==
                                                    'POR PRODUCTO'
                                                "
                                            >
                                                <label>Producto</label>
                                                <el-select
                                                    class="d-block"
                                                    v-model="oGrafico4.producto"
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
                                        id="container4"
                                    ></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body">
                                <h4>Predicción de cantidad de productos</h4>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row">
                                            <div class="col-md-3">
                                                <label>Año</label>
                                                <input
                                                    type="number"
                                                    v-model="oGrafico5.anio"
                                                    class="form-control"
                                                />
                                            </div>
                                            <div class="col-md-3">
                                                <label>Mes</label>
                                                <el-select
                                                    class="d-block"
                                                    v-model="oGrafico5.mes"
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
                                                    v-model="oGrafico5.filtro"
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
                                                    oGrafico5.filtro ==
                                                    'POR PRODUCTO'
                                                "
                                            >
                                                <label>Producto</label>
                                                <el-select
                                                    class="d-block"
                                                    v-model="oGrafico5.producto"
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
                                        id="container5"
                                    ></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body">
                                <h4>Predicción de ingresos por productos</h4>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row">
                                            <div class="col-md-3">
                                                <label>Año</label>
                                                <input
                                                    type="number"
                                                    v-model="oGrafico6.anio"
                                                    class="form-control"
                                                />
                                            </div>
                                            <div class="col-md-3">
                                                <label>Mes</label>
                                                <el-select
                                                    class="d-block"
                                                    v-model="oGrafico6.mes"
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
                                                    v-model="oGrafico6.filtro"
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
                                                    oGrafico6.filtro ==
                                                    'POR PRODUCTO'
                                                "
                                            >
                                                <label>Producto</label>
                                                <el-select
                                                    class="d-block"
                                                    v-model="oGrafico6.producto"
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
                                        id="container6"
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
            oGrafico3: {
                filtro: "TODOS",
                fecha_ini: "",
                fecha_fin: "",
                producto: "TODOS",
            },
            oGrafico4: {
                filtro: "TODOS",
                fecha_ini: "",
                fecha_fin: "",
                producto: "TODOS",
            },
            oGrafico5: {
                anio: "",
                mes: "",
                filtro: "TODOS",
                producto: "TODOS",
            },
            oGrafico6: {
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
        oGrafico3: {
            handler: function (newVal, oldVal) {
                this.grafico3();
            },
            deep: true,
        },
        oGrafico4: {
            handler: function (newVal, oldVal) {
                this.grafico4();
            },
            deep: true,
        },
        oGrafico5: {
            handler: function (newVal, oldVal) {
                this.grafico5();
            },
            deep: true,
        },
        oGrafico6: {
            handler: function (newVal, oldVal) {
                this.grafico6();
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
        this.grafico4();
        this.grafico5();
        this.grafico6();
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
                .get("/admin/analisis_bi/ventas1")
                .then((response) => {
                    this.errors = [];
                    Highcharts.chart("container1", {
                        chart: {
                            type: "bar",
                        },
                        title: {
                            text: "CANTIDAD VENDIDA POR PRODUCTOS",
                        },
                        subtitle: {
                            text: "",
                        },
                        xAxis: {
                            type: "category",
                            // crosshair: true,
                            labels: {
                                rotation: 0,
                                style: {
                                    fontSize: "10px",
                                    fontFamily: "Verdana, sans-serif",
                                },
                            },
                        },
                        yAxis: {
                            min: 0,
                            title: {
                                text: "TOTAL CANTIDAD",
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
                                name: "Total",
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
                .get("/admin/analisis_bi/ventas2")
                .then((response) => {
                    this.errors = [];
                    Highcharts.chart("container2", {
                        chart: {
                            type: "column",
                        },
                        title: {
                            text: "INGRESOS POR PRODUCTOS",
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
                                text: "TOTAL INGRESOS",
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
                                name: "Total",
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
                .get("/admin/analisis_bi/ventas3", {
                    params: this.oGrafico3,
                })
                .then((response) => {
                    this.errors = [];
                    let fecha_entero = new Date(
                        this.oGrafico3.fecha_ini
                    ).getTime();

                    Highcharts.chart("container3", {
                        chart: {
                            type: "bar",
                        },
                        title: {
                            text: "CANTIDAD VENDIDAD POR PRODUCTOS",
                        },
                        subtitle: {
                            text: "",
                        },
                        xAxis: {
                            type: "category",
                            // crosshair: true,
                            labels: {
                                rotation: 0,
                                style: {
                                    fontSize: "10px",
                                    fontFamily: "Verdana, sans-serif",
                                },
                            },
                        },
                        yAxis: {
                            min: 0,
                            title: {
                                text: "TOTAL CANTIDAD",
                            },
                        },
                        legend: {
                            // layout: "vertical",
                        },

                        plotOptions: {
                            series: {
                                borderWidth: 0,
                                dataLabels: {
                                    enabled: false,
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
                                name: "Total",
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
        grafico4() {
            this.enviando = true;
            axios
                .get("/admin/analisis_bi/ventas4", {
                    params: this.oGrafico4,
                })
                .then((response) => {
                    this.errors = [];
                    let fecha_entero = new Date(
                        this.oGrafico3.fecha_ini
                    ).getTime();

                    Highcharts.chart("container4", {
                        chart: {
                            type: "column",
                        },
                        title: {
                            text: "INGRESO POR PRODUCTOS",
                        },
                        subtitle: {
                            text: "",
                        },
                        xAxis: {
                            type: "category",
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
                                text: "TOTAL INGRESOS",
                            },
                        },
                        legend: {
                            // layout: "vertical",
                        },

                        plotOptions: {
                            series: {
                                borderWidth: 0,
                                dataLabels: {
                                    enabled: false,
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
                                name: "Total",
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
        grafico5() {
            this.enviando = true;
            axios
                .get("/admin/analisis_bi/ventas5", {
                    params: this.oGrafico5,
                })
                .then((response) => {
                    this.errors = [];
                    Highcharts.chart("container5", {
                        chart: {
                            type: "bar",
                        },
                        title: {
                            text:
                                "CANTIDAD VENDIDAD POR PRODUCTOS PARA " +
                                response.data.mes_anio,
                        },
                        subtitle: {
                            text: "",
                        },
                        xAxis: {
                            type: "category",
                            // crosshair: true,
                            labels: {
                                rotation: 0,
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
                                name: "Total",
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
        grafico6() {
            this.enviando = true;
            axios
                .get("/admin/analisis_bi/ventas6", {
                    params: this.oGrafico6,
                })
                .then((response) => {
                    this.errors = [];
                    Highcharts.chart("container6", {
                        chart: {
                            type: "column",
                        },
                        title: {
                            text:
                                "INGRESOS POR PRODUCTOS PARA " +
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
                                text: "TOTAL INGRESOS",
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
                                name: "Total",
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
            this.oGrafico5.mes = mes;
            this.oGrafico6.mes = mes;
            if (parseInt(mes) < 10) {
                fecha_completa = anio + "-0" + mes + "-" + dia;
                this.oGrafico5.mes = "0" + mes;
                this.oGrafico6.mes = "0" + mes;
            }
            this.oGrafico3.fecha_ini = fecha_completa;
            this.oGrafico3.fecha_fin = fecha_completa;
            this.oGrafico4.fecha_ini = fecha_completa;
            this.oGrafico4.fecha_fin = fecha_completa;
            this.oGrafico5.anio = parseInt(anio);
            this.oGrafico6.anio = parseInt(anio);
        },
    },
};
</script>

<style></style>
