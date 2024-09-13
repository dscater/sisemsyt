<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Notificaciones - <span>Ver</span></h1>
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
                                <div class="row">
                                    <div class="col-12">
                                        <p>
                                            <strong>Descripción:</strong>
                                            {{
                                                oNotificacionUser?.notificacion
                                                    ?.descripcion
                                            }}
                                        </p>
                                        <p>
                                            <strong>Fecha:</strong>
                                            {{
                                                oNotificacionUser?.notificacion
                                                    ?.fecha_t
                                            }}
                                        </p>
                                        <p>
                                            <strong>Hora:</strong>
                                            {{
                                                oNotificacionUser?.notificacion
                                                    ?.hora
                                            }}
                                        </p>
                                    </div>
                                    <div class="col-md-4">
                                        <router-link :to="{name:'notificacion_users.index'}" class="btn btn-default"><i class="fa fa-arrow-left"></i> Volver</router-link>
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
    props: ["id"],
    data() {
        return {
            fullscreenLoading: true,
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            oNotificacionUser: {
                id: 0,
                notificacion_id: 0,
                user_id: 0,
                visto: 0,
                notificacion: {
                    descripcion: "",
                    fecha: "",
                    hora: "",
                },
            },
        };
    },
    mounted() {
        this.getNotificacionUser();
        this.loadingWindow.close();
    },
    methods: {
        getNotificacionUser() {
            axios
                .get("/admin/notificacion_users/" + this.id)
                .then((response) => {
                    console.log(response.data);
                    this.oNotificacionUser = response.data.notificacion_user;
                    console.log(this.oNotificacionUser);
                });
        },
    },
};
</script>
<style></style>
