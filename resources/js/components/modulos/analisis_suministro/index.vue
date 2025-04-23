<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Análisis - Recomendaciones de suministro</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-4 mb-2">
                        <label class="text-white"
                            >Cantidad de meses a predecir a partir del
                            actual</label
                        >
                        <div class="input-group">
                            <input
                                type="number"
                                class="form-control"
                                v-model="c_meses"
                                @change="generarGraficos"
                                @keyup="generarGraficos"
                            />
                            <div class="input-group-append">
                                <button
                                    class="btn btn-primary"
                                    @click="generarGraficos"
                                >
                                    <i class="fa fa-sync"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row" v-if="c_meses && c_meses > 0">
                    <div class="col-md-12">
                        <div class="card">
                            <div
                                class="card-body contenedor_grafico"
                                :class="{ loading: loading }"
                            >
                                <div class="cargando" v-show="loading">
                                    <i class="fa fa-spinner fa-spin mr-1"></i>
                                    Cargando...
                                </div>
                                <div
                                    class="row"
                                    id="cont_grafs"
                                    v-show="!loading"
                                ></div>
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
            listProductos: [],
            c_meses: 1,
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
            listGraficos: [],
            loading: false,
        };
    },
    watch: {
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
        this.generarGraficos();
    },
    methods: {
        getProductos() {
            let url = "/admin/productos";
            axios.get(url).then((res) => {
                this.listProductos = res.data.productos;
                this.listProductos.unshift({ id: "TODOS", nombre: "TODOS" });
            });
        },
        generarGraficos() {
            this.loading = true;
            axios
                .get("/admin/reporte_analisis/analisis_suministro", {
                    params: {
                        c_meses: this.c_meses,
                    },
                })
                .then((response) => {
                    const cont_grafs = document.getElementById("cont_grafs");
                    cont_grafs.innerHTML = ""; // Corregido innerHtml a innerHTML

                    response.data.fmd.forEach((item) => {
                        var div = document.createElement("div");
                        div.classList.add("col-md-12");
                        div.classList.add("mt-2");
                        div.id = item.id; // Asignar el id al div
                        cont_grafs.appendChild(div);

                        Highcharts.chart(item.id, {
                            chart: {
                                type: "column",
                            },
                            title: {
                                text: item.title, // Asegúrate de que item.title existe
                            },
                            subtitle: {
                                text: "",
                            },
                            xAxis: {
                                type: "category",
                                labels: {
                                    rotation: 0,
                                    style: {
                                        fontSize: "14px",
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
                                    '<span style="font-size:14px"><b>{point.key}</b></span><table>',
                                pointFormat:
                                    '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                                    '<td style="padding:0"><b>{point.y:.2f}</b></td></tr>',
                                footerFormat: "</table>",
                                shared: true,
                                useHTML: true,
                                style: {
                                    fontSize: "14px",
                                    fontFamily: "Arial, sans-serif",
                                },
                            },
                            series: [
                                {
                                    name: "Total",
                                    colorByPoint: true,
                                    data: item.datos, // Asegúrate de que item.datos existe
                                    dataLabels: {
                                        rotation: 0,
                                        color: "#FFFFFF",
                                        format: "{point.y:.2f}", // one decimal
                                        y: 0, // 10 pixels down from the top
                                        style: {
                                            fontSize: "14px",
                                            fontFamily: "Verdana, sans-serif",
                                        },
                                    },
                                },
                            ],
                        });
                    });

                    this.errors = [];
                    let timing = this.c_meses * 500;
                    setTimeout(() => {
                        this.loading = false;
                    }, timing);
                })
                .catch(async (error) => {
                    this.loading = false;
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
            if (parseInt(mes) < 10) {
                fecha_completa = anio + "-0" + mes + "-" + dia;
            }
        },
    },
};
</script>

<style>
#cont_grafs {
    width: 100%;
}
</style>
