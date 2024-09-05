<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Ventas - <span>Nuevo</span></h1>
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
                                    @envioFormulario="enviaEdit"
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
    data() {
        return {};
    },
    mounted() {},
    methods: {
        enviaEdit(id) {
            this.$router.push({
                name: "ventas.ticket",
                params: {
                    id: id,
                    imprime: true,
                },
            });
        },
    },
};
</script>
<style></style>
