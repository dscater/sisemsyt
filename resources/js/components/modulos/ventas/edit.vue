<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Ventas - <span>Editar</span></h1>
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
                                <FormVenta
                                    :venta="oVenta"
                                    :accion="'edit'"
                                    @envioFormulario="recargaFormulario"
                                ></FormVenta>
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
    props: ["id"],
    data() {
        return {
            fullscreenLoading: true,
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            oVenta: {
                id: 0,
                sucursal_id: "",
                cliente_id: "",
                nit: "",
                venta_mayor: "NO",
                total: "0.00",
                detalle_ventas: [],
            },
        };
    },
    mounted() {
        this.getVenta();
        this.loadingWindow.close();
    },
    methods: {
        recargaFormulario(id) {
            this.$router.push({
                name: "ventas.ticket",
                params: {
                    id: id,
                    imprime: true,
                },
            });
            // location.reload();
        },
        getVenta() {
            axios.get("/admin/ventas/" + this.id).then((response) => {
                this.oVenta = response.data;
            });
        },
    },
};
</script>
<style></style>
