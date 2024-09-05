<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row" v-if="configuracion">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <h2
                                    style="
                                        font-weight: bold;
                                        text-align: center;
                                    "
                                >
                                    SISTEMA {{ configuracion.nombre_sistema }}
                                </h2>
                                <h3 style="text-align: center">
                                    ¡BIENVENID@ {{ user.full_name }}!
                                </h3>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div
                        class="col-12 col-sm-6 col-md-3"
                        v-for="(item, index) in listInfoBox"
                        :key="index"
                    >
                        <div class="info-box">
                            <span
                                class="info-box-icon elevation-1"
                                :class="item.color"
                                ><i :class="item.icon"></i
                            ></span>
                            <div class="info-box-content">
                                <span class="info-box-text">{{
                                    item.label
                                }}</span>
                                <span class="info-box-number">{{
                                    item.cantidad
                                }}</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-10 mx-auto">
                        <div id="container"></div>
                    </div>
                </div>
            </div>
            <!-- /.container-fluid -->
        </section>
    </div>
</template>

<script>
export default {
    data() {
        return {
            fullscreenLoading: true,
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            usuarios: 10,
            configuracion: JSON.parse(localStorage.getItem("configuracion")),
            user: JSON.parse(localStorage.getItem("user")),
            listInfoBox: [],
            htmlMision: "",
            htmlVision: "",
            htmlObjetivos: "",
        };
    },
    mounted() {
        this.loadingWindow.close();
        this.getInfoBox();
        this.grafico();
    },
    methods: {
        getInfoBox() {
            axios.get("/admin/usuarios/getInfoBox").then((res) => {
                this.listInfoBox = res.data;
            });
        },
        grafico() {
            Highcharts.chart("container", {
                chart: {
                    type: "cylinder",
                    options3d: {
                        enabled: true,
                        alpha: 20,
                        beta: 12,
                        depth: 40,
                        viewDistance: 0,
                    },
                },
                title: {
                    text: "STOCK DE PRODUCTOS",
                },
                subtitle: {
                    text:"",
                },
                xAxis: {
                    categories: [
                        "PRODUCTO 1",
                        "PRODUCTO 2",
                        "PRODUCTO 3",
                        "PRODUCTO 4",
                        "PRODUCTO 5",
                        "PRODUCTO 6",
                        "PRODUCTO 7",
                        "PRODUCTO 8",
                        "PRODUCTO 9",
                        "PRODUCTO 10",
                    ],
                    title: {
                        text: "STOCK DE PRODUCTOS",
                    },
                    labels: {
                        skew3d: true,
                        rotation: -65,
                        style: {
                            fontSize: "11px",
                            fontFamily: "Verdana, sans-serif",
                        },
                    },
                },
                yAxis: {
                    title: {
                        margin: 20,
                        text: "TOTAL",
                    },
                    labels: {
                        skew3d: true,
                    },
                },
                tooltip: {
                    headerFormat: "<b>Stock: {point.x}</b><br>",
                },
                plotOptions: {
                    series: {
                        depth: 45,
                        colorByPoint: true,
                        // pointWidth: 45
                    },
                },
                series: [
                    {
                        data: [
                            95321, 169339, 121105, 136046, 106800, 58041, 26766,
                            14291, 7065, 3283,
                        ],
                        name: "TOTAL",
                        showInLegend: false,
                    },
                ],
            });
        },
    },
};
</script>

<style></style>
