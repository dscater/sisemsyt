<template>
    <div>
        <!-- Navbar -->
        <nav class="main-header navbar navbar-expand navbar-primary">
            <!-- Left navbar links -->
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a
                        href="#"
                        class="nav-link text-white"
                        data-widget="pushmenu"
                        role="button"
                        ><i class="fas fa-bars"></i
                    ></a>
                </li>
                <li class="nav-item d-none d-sm-inline-block">
                    <router-link
                        :to="{ name: 'inicio' }"
                        class="nav-link text-white"
                        >Inicio</router-link
                    >
                </li>
                <li
                    class="nav-item d-none d-sm-inline-block"
                    v-if="permisos.includes('ventas.create')"
                >
                    <router-link
                        exact
                        :to="{ name: 'ventas.create' }"
                        class="nav-link text-white"
                        >Nueva venta</router-link
                    >
                </li>
            </ul>

            <!-- Right navbar links -->
            <ul class="navbar-nav ml-auto">
                <li
                    class="nav-item dropdown"
                    v-if="permisos.includes('notificacion_users.index')"
                >
                    <a class="nav-link" data-toggle="dropdown" href="#">
                        <i class="far fa-bell text-white text-md"></i>
                        <span
                            class="badge badge-warning navbar-badge"
                            v-if="sin_ver > 0"
                            v-text="sin_ver"
                        ></span>
                    </a>
                    <div
                        class="dropdown-menu dropdown-menu-lg dropdown-menu-right"
                    >
                        <span class="dropdown-item dropdown-header"
                            ><span v-text="sin_ver"></span> Notificaciones</span
                        >
                        <div class="dropdown-divider"></div>
                        <div class="contenedor_notificacions">
                            <router-link
                                v-for="(item, index) in listNotificacionUsers"
                                :key="item.id"
                                v-if="item && item.id"
                                class="dropdown-item notificacion"
                                :class="{
                                    sin_ver: item.visto == 0,
                                }"
                                :to="{
                                    name: 'notificacion_users.show',
                                    params: {
                                        id: item.id,
                                    },
                                }"
                            >
                                <i class="fas fa-info-circle mr-2"></i>
                                <p class="desc_notificacion">
                                    {{ item.notificacion?.descripcion }}
                                </p>
                                <span class="float-right text-muted text-sm">{{
                                    item.notificacion?.hace
                                }}</span>
                            </router-link>
                            <div class="dropdown-divider"></div>
                        </div>
                        <router-link
                            :to="{
                                name: 'notificacion_users.index',
                            }"
                            class="dropdown-item dropdown-footer"
                            >Ver todas las notificaciones</router-link
                        >
                    </div>
                </li>
                <li class="nav-item">
                    <a
                        class="nav-link text-white"
                        href="#"
                        role="button"
                        @click.prevent="logout()"
                        v-loading.fullscreen.lock="fullscreenLoading"
                    >
                        <i class="fas fa-power-off"></i>
                    </a>
                </li>
                <li class="nav-item">
                    <a
                        class="nav-link text-white"
                        data-widget="fullscreen"
                        href="#"
                        role="button"
                    >
                        <i class="fas fa-expand-arrows-alt"></i>
                    </a>
                </li>
            </ul>
        </nav>
        <!-- /.navbar -->
        <loading :loading="loadingSalir"></loading>
    </div>
</template>

<script>
import loading from "../components/loading.vue";
export default {
    components: {
        loading,
    },
    data() {
        return {
            fullscreenLoading: false,
            permisos: localStorage.getItem("permisos"),
            ultimo: 0,
            sin_ver: 0,
            listNotificacionUsers: [],
            intervaloNotificacions: null,
            loadingSalir: false,
        };
    },
    mounted() {
        if (!this.permisos) {
            this.$router.push({ name: "login" });
        }

        this.intervalNotificaciones = setInterval(() => {
            this.getNotificacions();
        }, 1500);
    },
    unmounted() {
        clearInterval(this.intervaloNotificacions);
    },
    methods: {
        getNotificacions() {
            axios
                .get("/admin/notificacion_users", {
                    params: {
                        ultimo: this.ultimo,
                    },
                })
                .then((response) => {
                    let res = [
                        ...response.data.notificacion_users,
                        ...this.listNotificacionUsers,
                    ];
                    this.ultimo = response.data.ultimo;
                    this.sin_ver = response.data.sin_ver;
                    this.listNotificacionUsers = res;
                });
        },
        logout() {
            // this.fullscreenLoading = true;
            this.loadingSalir = true;
            axios.post("/logout").then((res) => {
                localStorage.clear();
                this.$router.push({ name: "login" });
                setTimeout(function () {
                    this.loadingSalir = false;
                    location.reload();
                }, 500);
            });
        },
    },
};
</script>

<style>
/* .contenedor_notificacions {
    width: 100%;
    max-height: 40vh;
    overflow: auto;
} */
</style>
