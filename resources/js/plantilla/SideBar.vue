<template>
    <!-- Main Sidebar Container -->
    <aside class="main-sidebar sidebar-dark-primary bg-navy elevation-4">
        <!-- Brand Logo -->
        <router-link
            exact
            :to="{ name: 'inicio' }"
            class="brand-link bg-primary"
        >
            <img
                :src="configuracion.path_image"
                alt="Logo"
                class="brand-image img-circle elevation-3"
                style="opacity: 0.8"
            />
            <span
                class="brand-text font-weight-light"
                v-text="configuracion.alias"
            ></span>
        </router-link>

        <!-- Sidebar -->
        <div class="sidebar">
            <!-- Sidebar user (optional) -->
            <div class="user-panel mt-3 pb-3 mb-3 d-flex">
                <div class="image">
                    <img
                        :src="user_sidebar.path_image"
                        class="img-circle elevation-2"
                        alt="User Image"
                    />
                </div>
                <div class="info">
                    <router-link
                        exact
                        :to="{
                            name: 'usuarios.perfil',
                            params: { id: user_sidebar.id },
                        }"
                        class="d-block"
                        v-text="user_sidebar.full_name"
                    ></router-link>
                </div>
            </div>

            <!-- SidebarSearch Form -->
            <div class="form-inline">
                <div class="input-group" data-widget="sidebar-search">
                    <input
                        class="form-control form-control-sidebar bg-white"
                        type="search"
                        placeholder="Buscar Modulo"
                        aria-label="Search"
                    />
                    <div class="input-group-append">
                        <button class="btn btn-sidebar bg-white">
                            <i class="fas fa-search fa-fw"></i>
                        </button>
                    </div>
                </div>
            </div>

            <!-- Sidebar Menu -->
            <nav class="mt-2">
                <ul
                    class="nav nav-pills nav-sidebar flex-column text-xs nav-flat"
                    data-widget="treeview"
                    role="menu"
                    data-accordion="false"
                >
                    <!-- Add icons to the links using the .nav-icon class with font-awesome or any other icon font library -->
                    <li class="nav-item">
                        <router-link
                            exact
                            :to="{ name: 'inicio' }"
                            class="nav-link"
                        >
                            <i class="nav-icon fas fa-home"></i>
                            <p>Inicio</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-header"
                        v-if="
                            permisos.includes('analisis_inventarios') ||
                            permisos.includes('analisis_proveedores') ||
                            permisos.includes('analisis_ventas') ||
                            permisos.includes('analisis_clientes')
                        "
                    >
                        REPORTES DE ANÁLISIS
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('analisis_inventarios')"
                    >
                        <router-link
                            :to="{ name: 'analisis_inventarios.index' }"
                            class="nav-link"
                        >
                            <i class="nav-icon fas fa-chart-pie"></i>
                            <p>Inventario</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('analisis_proveedores')"
                    >
                        <router-link
                            :to="{ name: 'analisis_proveedors.index' }"
                            class="nav-link"
                        >
                            <i class="nav-icon fas fa-chart-pie"></i>
                            <p>Proveedores</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('analisis_ventas')"
                    >
                        <router-link
                            :to="{ name: 'analisis_ventas.index' }"
                            class="nav-link"
                        >
                            <i class="nav-icon fas fa-chart-pie"></i>
                            <p>Ventas</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('analisis_clientes')"
                    >
                        <router-link
                            :to="{ name: 'analisis_clientes.index' }"
                            class="nav-link"
                        >
                            <i class="nav-icon fas fa-chart-pie"></i>
                            <p>Clientes</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('analisis_suministro')"
                    >
                        <router-link
                            :to="{ name: 'analisis_suministro.index' }"
                            class="nav-link"
                        >
                            <i class="nav-icon fas fa-chart-pie"></i>
                            <p>Recomendaciones de suministro</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('analisis_consumo')"
                    >
                        <router-link
                            :to="{ name: 'analisis_consumo.index' }"
                            class="nav-link"
                        >
                            <i class="nav-icon fas fa-chart-pie"></i>
                            <p>Tendencias de consumo</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-header"
                        v-if="
                            permisos.includes('ventas.index') ||
                            permisos.includes('ingreso_productos.index') ||
                            permisos.includes('salida_productos.index')
                        "
                    >
                        OPERACIONES
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('ventas.index')"
                    >
                        <router-link
                            :to="{ name: 'ventas.index' }"
                            class="nav-link"
                        >
                            <i class="nav-icon fas fa-clipboard-list"></i>
                            <p>Ventas</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('ingreso_productos.index')"
                    >
                        <router-link
                            :to="{ name: 'ingreso_productos.index' }"
                            class="nav-link"
                        >
                            <i class="nav-icon fas fa-sign-in-alt"></i>
                            <p>Ingreso de Productos</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('salida_productos.index')"
                    >
                        <router-link
                            :to="{ name: 'salida_productos.index' }"
                            class="nav-link"
                        >
                            <i class="nav-icon fas fa-sign-out-alt"></i>
                            <p>Salida de Productos</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-header"
                        v-if="
                            permisos.includes('users.index') ||
                            permisos.includes('proveedors.index') ||
                            permisos.includes('productos.index') ||
                            permisos.includes('clientes.index') ||
                            permisos.includes('configuracion.index')
                        "
                    >
                        ADMINISTRACIÓN
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('notificacion_users.index')"
                    >
                        <router-link
                            :to="{ name: 'notificacion_users.index' }"
                            class="nav-link"
                            v-loading.fullscreen.lock="fullscreenLoading"
                        >
                            <i class="nav-icon fas fa-bell"></i>
                            <p>Notificaciones</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('clientes.index')"
                    >
                        <router-link
                            exact
                            :to="{ name: 'clientes.index' }"
                            class="nav-link"
                            v-loading.fullscreen.lock="fullscreenLoading"
                        >
                            <i class="nav-icon fas fa-user-friends"></i>
                            <p>Clientes</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('proveedors.index')"
                    >
                        <router-link
                            exact
                            :to="{ name: 'proveedors.index' }"
                            class="nav-link"
                            v-loading.fullscreen.lock="fullscreenLoading"
                        >
                            <i class="nav-icon fas fa-list"></i>
                            <p>Proveedores</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('productos.index')"
                    >
                        <router-link
                            exact
                            :to="{ name: 'productos.index' }"
                            class="nav-link"
                            v-loading.fullscreen.lock="fullscreenLoading"
                        >
                            <i class="nav-icon fas fa-box"></i>
                            <p>Productos</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('usuarios.index')"
                    >
                        <router-link
                            exact
                            :to="{ name: 'usuarios.index' }"
                            class="nav-link"
                            v-loading.fullscreen.lock="fullscreenLoading"
                        >
                            <i class="nav-icon fas fa-users"></i>
                            <p>Usuarios</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-header"
                        v-if="
                            permisos.includes('reportes.usuarios') ||
                            permisos.includes('reportes.kardex') ||
                            permisos.includes('reportes.ventas') ||
                            permisos.includes('reportes.stock_productos') ||
                            permisos.includes('reportes.historial_acciones') ||
                            permisos.includes('reportes.grafico_ingresos') ||
                            permisos.includes('reportes.grafico_orden')
                        "
                    >
                        REPORTES
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('reportes.usuarios')"
                    >
                        <router-link
                            :to="{ name: 'reportes.usuarios' }"
                            class="nav-link"
                        >
                            <i class="fas fa-file-pdf nav-icon"></i>
                            <p>Lista de Usuarios</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('reportes.stock_productos')"
                    >
                        <router-link
                            :to="{ name: 'reportes.stock_productos' }"
                            class="nav-link"
                        >
                            <i class="fas fa-file-pdf nav-icon"></i>
                            <p>Stock de productos</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('reportes.kardex')"
                    >
                        <router-link
                            :to="{ name: 'reportes.kardex' }"
                            class="nav-link"
                        >
                            <i class="fas fa-file-pdf nav-icon"></i>
                            <p>Kardex de productos</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('reportes.ventas')"
                    >
                        <router-link
                            :to="{ name: 'reportes.ventas' }"
                            class="nav-link"
                        >
                            <i class="fas fa-file-pdf nav-icon"></i>
                            <p>Ventas</p>
                        </router-link>
                    </li>
                    <!-- <li
                        class="nav-item"
                        v-if="permisos.includes('reportes.historial_acciones')"
                    >
                        <router-link
                            :to="{ name: 'reportes.historial_acciones' }"
                            class="nav-link"
                        >
                            <i class="fas fa-file-pdf nav-icon"></i>
                            <p>Historial de acciones</p>
                        </router-link>
                    </li> -->
                    <li class="nav-header">OTRAS OPCIONES</li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('categorias.index')"
                    >
                        <router-link
                            :to="{ name: 'categorias.index' }"
                            class="nav-link"
                        >
                            <i class="nav-icon fas fa-list"></i>
                            <p>Categorías</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('tipo_ingresos.index')"
                    >
                        <router-link
                            :to="{ name: 'tipo_ingresos.index' }"
                            class="nav-link"
                        >
                            <i class="nav-icon fas fa-list"></i>
                            <p>Tipo de Ingresos</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('tipo_salidas.index')"
                    >
                        <router-link
                            :to="{ name: 'tipo_salidas.index' }"
                            class="nav-link"
                        >
                            <i class="nav-icon fas fa-list"></i>
                            <p>Tipo de Salidas</p>
                        </router-link>
                    </li>
                    <li
                        class="nav-item"
                        v-if="permisos.includes('configuracion.index')"
                    >
                        <router-link
                            :to="{ name: 'configuracion' }"
                            class="nav-link"
                        >
                            <i class="nav-icon fas fa-cog"></i>
                            <p>Configuración</p>
                        </router-link>
                    </li>
                    <li class="nav-item">
                        <router-link
                            exact
                            :to="{
                                name: 'usuarios.perfil',
                                params: { id: user_sidebar.id },
                            }"
                            class="nav-link"
                        >
                            <i class="nav-icon fas fa-user"></i>
                            <p>Perfil</p>
                        </router-link>
                    </li>
                    <li class="nav-item">
                        <a
                            href="#"
                            class="nav-link"
                            @click.prevent="logout()"
                            v-loading.fullscreen.lock="fullscreenLoading"
                        >
                            <i class="fas fa-power-off nav-icon"></i>
                            <p>Salir</p>
                        </a>
                    </li>
                </ul>
            </nav>
            <!-- /.sidebar-menu -->
        </div>
        <!-- /.sidebar -->
        <loading :loading="loadingSalir"></loading>
    </aside>
</template>

<script>
import loading from "../components/loading.vue";
export default {
    components: {
        loading,
    },
    props: ["user_sidebar", "configuracion"],
    data() {
        return {
            user: JSON.parse(localStorage.getItem("user")),
            fullscreenLoading: false,
            permisos: localStorage.getItem("permisos"),
            loadingSalir: false,
        };
    },
    methods: {
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
.user-panel .info {
    display: flex;
    height: 100%;
    align-items: center;
}
.user-panel .info a {
    font-size: 0.8em;
}
</style>
