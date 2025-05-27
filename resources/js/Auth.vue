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
                        <div class="input-group mt-3">
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
                        <span
                            class="error invalid-feedback d-block"
                            v-if="errors && errors.usuario"
                            v-text="errors.usuario[0]"
                        ></span>
                        <div class="input-group mt-3">
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
                        <span
                            class="error invalid-feedback d-block"
                            v-if="errors && errors.password"
                            v-text="errors.password[0]"
                        ></span>
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
                        <div class="row mt-3" v-if="error_login">
                            <div class="col-12">
                                <div class="callout callout-danger">
                                    <h5>¡Atención!</h5>
                                    <p v-html="error_login"></p>
                                </div>
                            </div>
                        </div>

                        <div class="row mt-3">
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
            errors: null,
        };
    },
    created() {
        this.verificaLogin();
    },
    onMounted() {
        this.fullscreenLoading = false;
    },
    methods: {
        verificaLogin() {
            this.fullscreenLoading = false;
            axios
                .get("/verificaLogin")
                .then((response) => {
                    if (response.data) {
                        console.log(response.data);
                        this.$router.push({ name: "inicio" });
                    }
                })
                .catch((error) => {
                    window.location.reload();
                });
        },
        login() {
            this.errors = null;
            this.error = false;
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
                        const up = res.data.up;
                        const url_up = res.data.url_up;
                        if (up) {
                            window.location = url_up;
                        } else {
                            if (this.user.auth2fa == 1) {
                                this.verificacion2FA();
                            } else {
                                this.obtienePermisos();
                            }
                        }
                    } else {
                        this.error_login = res.data.error;
                    }
                    this.fullscreenLoading = false;
                })
                .catch((error) => {
                    console.log(error.response);
                    if (error.response.data.errors) {
                        this.errors = error.response.data.errors;
                    } else {
                        this.user = null;
                        this.error = true;
                        this.password = "";
                        // console.log(error);
                    }
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
