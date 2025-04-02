<template>
    <div class="login-page">
        <div class="login-box">
            <!-- /.login-logo -->
            <div class="card border border-primary">
                <div class="card-header text-center">
                    <img :src="logo" alt="Logo" />
                    <router-link :to="{ name: 'login' }" class="h1 text-white"
                        ><b v-text="empresa"></b
                    ></router-link>
                </div>
                <div class="card-body">
                    <p class="login-box-msg text-white font-weight-bold">
                        Ingresa tu usuario y contraseña para inicar sesión
                    </p>

                    <div>
                        <div class="input-group mb-3">
                            <input
                                type="text"
                                class="form-control"
                                placeholder="Usuario"
                                v-model="usuario"
                                @keypress.enter="login()"
                                autofocus
                            />
                            <div class="input-group-append">
                                <div class="input-group-text bg-primary">
                                    <span class="fas fa-user"></span>
                                </div>
                            </div>
                        </div>
                        <div class="input-group mb-3">
                            <input
                                :type="muestra_password ? 'text' : 'password'"
                                class="form-control"
                                placeholder="Contraseña"
                                v-model="password"
                                @keypress.enter="login()"
                            />
                            <div class="input-group-append">
                                <button
                                    class="btn btn-default"
                                    :class="[
                                        muestra_password ? 'bg-white' : '',
                                    ]"
                                    type="button"
                                    @click="
                                        muestra_password = !muestra_password
                                    "
                                >
                                    <i
                                        class="fa"
                                        :class="[
                                            muestra_password
                                                ? 'fa-eye'
                                                : 'fa-eye-slash',
                                        ]"
                                    ></i>
                                </button>
                            </div>
                            <div class="input-group-append">
                                <div class="input-group-text bg-primary">
                                    <span class="fas fa-lock"></span>
                                </div>
                            </div>
                        </div>
                        <div class="row" v-if="error">
                            <div class="col-12">
                                <div class="callout callout-danger">
                                    <h5>¡Error!</h5>
                                    <p>
                                        El usuario o contraseña son incorrectos
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="row" v-if="error_login">
                            <div class="col-12">
                                <div class="callout callout-danger">
                                    <h5>¡Atención!</h5>
                                    <p v-html="error_login"></p>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <!-- /.col -->
                            <div class="col-12">
                                <button
                                    type="button"
                                    class="btn btn-primary btn-block btn-flat font-weight-bold"
                                    @click.prevent="login()"
                                    v-loading.fullscreen.lock="
                                        fullscreenLoading
                                    "
                                >
                                    Acceder
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    props: {
        empresa: { String, default: "Nombre Empresa" },
        logo: {
            String,
            default:
                "https://www.logodesign.net/logo/eye-and-house-5806ld.png?size=2&industry=All",
        },
        configuracion: {
            String,
            default: "",
        },
    },
    data() {
        return {
            usuario: "",
            password: "",
            muestra_password: false,
            error: false,
            error_login: null,
            fullscreenLoading: false,
            user: null,
        };
    },
    created() {
        this.verificaLogin();
    },
    onMounted() {},
    methods: {
        verificaLogin() {
            axios
                .get("/verificaLogin")
                .then((response) => {
                    if (response.data) {
                        this.$router.push({ name: "inicio" });
                    }
                })
                .catch((error) => {
                    window.location.reload();
                });
        },
        login() {
            this.fullscreenLoading = true;
            axios
                .post("/login", {
                    usuario: this.usuario,
                    password: this.password,
                })
                .then((res) => {
                    // console.log(res);
                    if (!res.data.error) {
                        this.error_login = null;
                        this.user = res.data.user;
                        if (this.user.auth2fa == 1) {
                            this.verificacion2FA();
                        } else {
                            this.obtienePermisos();
                        }
                    } else {
                        this.fullscreenLoading = false;
                        this.error_login = res.data.error;
                    }
                })
                .catch((error) => {
                    this.user = null;
                    this.error = true;
                    this.password = "";
                    console.log(error);
                    this.fullscreenLoading = false;
                });
        },
        verificacion2FA() {
            axios
                .post("/genera2fa", { user_id: this.user.id })
                .then((response) => {
                    setTimeout(() => {
                        this.obtienePermisos();
                    }, 50);
                });
        },
        obtienePermisos() {
            axios
                .get("/admin/usuarios/getPermisos/" + this.user.id)
                .then((res) => {
                    this.error = false;
                    localStorage.setItem("configuracion", this.configuracion);
                    localStorage.setItem("permisos", JSON.stringify(res.data));
                    localStorage.setItem("user", JSON.stringify(this.user));
                    if (this.user.auth2fa == 1) {
                        this.$router.push({ name: "verificacion" });
                    } else {
                        this.$router.push({ name: "inicio" });
                    }
                    location.reload();
                });
        },
    },
};
</script>

<style>
.login-page {
    background: #000000bd;
}

.login-page .card {
    border-radius: 0px;
    box-shadow: 0px 0px 1px 1px var(--primary);
    background: var(--transparente);
}
.login-page .card-header {
    border-bottom: solid 1px var(--primary);
}
</style>
