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
                        Escanea la imagen QR con
                        <a
                            href="https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2&hl=es"
                            target="_blank"
                            >Google Authenticator</a
                        >
                        e ingresa el código de verificación
                    </p>
                    <div class="row mb-2">
                        <div class="col-12" v-if="qr2fa">
                            <div
                                class="contenedor_qr text-center"
                                v-html="qr2fa"
                            ></div>
                        </div>
                    </div>
                    <div class="input-group mb-3">
                        <input
                            type="text"
                            class="form-control"
                            placeholder="Código de verificación"
                            v-model="codigo"
                            @keypress.enter="verificar2FA()"
                            autofocus
                        />
                        <div class="input-group-append">
                            <div class="input-group-text bg-primary">
                                <span class="fas fa-key"></span>
                            </div>
                        </div>
                    </div>
                    <div class="row" v-if="errors && errors.code">
                        <div class="col-12">
                            <div class="callout callout-danger">
                                <h5>¡Error!</h5>
                                <p>{{ errors.code[0] }}</p>
                            </div>
                        </div>
                    </div>
                    <div class="row" v-if="error">
                        <div class="col-12">
                            <div class="callout callout-danger">
                                <h5>¡Error!</h5>
                                <p>{{ error }}</p>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <!-- /.col -->
                        <div class="col-12">
                            <button
                                type="button"
                                class="btn btn-primary btn-block btn-flat font-weight-bold"
                                @click.prevent="verificar2FA()"
                                v-loading.fullscreen.lock="fullscreenLoading"
                            >
                                Acceder
                            </button>
                        </div>
                        <div class="col-12 mt-3">
                            <button
                                type="button"
                                class="btn btn-outline-info btn-block btn-flat font-weight-bold"
                                @click.prevent="logout()"
                            >
                                Cancelar
                            </button>
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
            codigo: "",
            error: false,
            errors: null,
            fullscreenLoading: false,
            user: null,
            qr2fa: "",
        };
    },
    mounted() {
        // Swal.fire({
        //     icon: "info",
        //     title: `Te envíamos un código de verificación a tu correo`,
        //     showConfirmButton: false,
        //     timer: 1500,
        // });
        this.getQR2FA();
    },
    methods: {
        getQR2FA() {
            axios.post("/genera2fa").then((response) => {
                this.qr2fa = response.data.qr_code;
            });
        },
        verificar2FA() {
            axios
                .post("/verificar2fa", {
                    code: this.codigo,
                })
                .then((response) => {
                    this.user = response.data.user;
                    setTimeout(() => {
                        this.obtienePermisos();
                    }, 100);
                })
                .catch((error) => {
                    if (error.response.data.errors) {
                        this.errors = error.response.data.errors;
                    }
                    if (error.response.data.error) {
                        this.error = error.response.data.error;
                    }
                });
        },
        obtienePermisos() {
            axios
                .get("/admin/usuarios/getPermisos/" + this.user.id)
                .then((res) => {
                    this.error = false;
                    this.$router.push({ name: "inicio" });
                    localStorage.setItem("configuracion", this.configuracion);
                    localStorage.setItem("permisos", JSON.stringify(res.data));
                    localStorage.setItem("user", JSON.stringify(this.user));
                    location.reload();
                });
        },
        logout() {
            axios.post("/logout").then((res) => {
                localStorage.clear();
                this.$router.push({ name: "login" });
                setTimeout(function () {
                    location.reload();
                }, 500);
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
