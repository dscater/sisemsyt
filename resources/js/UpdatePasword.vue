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
                        Primer inicio de sesión detectado<br />
                        Debes ingresar una nueva contraseña de inicio de sesión
                        <br />
                        <small
                            >La contraseña debe tener al menos 8 carácteres con
                            al menos una letra mayuscula, minuscula, un número y
                            carácter especial($#/.)</small
                        >
                    </p>
                    <div class="input-group mb-3">
                        <input
                            :type="muestra_password ? 'text' : 'password'"
                            class="form-control"
                            placeholder="Contraseña"
                            v-model="password"
                            @keypress.enter="actualizarPassword()"
                            autofocus
                        />
                        <div class="input-group-append">
                            <button
                                class="btn btn-default"
                                :class="[muestra_password ? 'bg-white' : '']"
                                type="button"
                                @click="muestra_password = !muestra_password"
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
                                <span class="fas fa-key"></span>
                            </div>
                        </div>
                    </div>
                    <div class="input-group mb-3">
                        <input
                            :type="muestra_password2 ? 'text' : 'password'"
                            class="form-control"
                            placeholder="Confirmar contraseña"
                            v-model="password_confirmation"
                            @keypress.enter="actualizarPassword()"
                            autofocus
                        />

                        <div class="input-group-append">
                            <button
                                class="btn btn-default"
                                :class="[muestra_password2 ? 'bg-white' : '']"
                                type="button"
                                @click="muestra_password2 = !muestra_password2"
                            >
                                <i
                                    class="fa"
                                    :class="[
                                        muestra_password2
                                            ? 'fa-eye'
                                            : 'fa-eye-slash',
                                    ]"
                                ></i>
                            </button>
                        </div>
                        <div class="input-group-append">
                            <div class="input-group-text bg-primary">
                                <span class="fas fa-key"></span>
                            </div>
                        </div>
                    </div>
                    <div class="row" v-if="errors && errors.password">
                        <div class="col-12">
                            <div class="callout callout-danger">
                                <h5>¡Error!</h5>
                                <p>{{ errors.password[0] }}</p>
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
                                @click.prevent="actualizarPassword()"
                                v-loading.fullscreen.lock="fullscreenLoading"
                            >
                                Guardar cambios
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
            password: "",
            password_confirmation: "",
            muestra_password: false,
            muestra_password2: false,
            error: false,
            errors: null,
            fullscreenLoading: false,
            user: null,
            qr2fa: "",
        };
    },
    created() {
        this.verificaLogin();
    },
    mounted() {
        window.addEventListener("popstate", this.handleBackButton);
        // Swal.fire({
        //     icon: "info",
        //     title: `Te envíamos un código de verificación a tu correo`,
        //     showConfirmButton: false,
        //     timer: 1500,
        // });
    },
    beforeDestroy() {
        window.removeEventListener("popstate", this.handleBackButton);
    },
    methods: {
        handleBackButton(event) {
            console.log("Se ha detectado un retroceso");
        },
        verificaLogin() {
            axios
                .get("/verificaLogin", {
                    params: {
                        updatePassword: true,
                    },
                })
                .then((response) => {
                    if (!response.data) {
                        window.location = "/login";
                    }
                })
                .catch((error) => {
                    window.location.reload();
                });
        },
        actualizarPassword() {
            axios
                .post("/admin/usuarios/updatePassword", {
                    password: this.password,
                    password_confirmation: this.password_confirmation,
                })
                .then((response) => {
                    Swal.fire({
                        icon: "info",
                        title: `Contraseña actualizada`,
                        showConfirmButton: false,
                        timer: 1500,
                    });
                    this.$router.push({ name: "inicio" });
                    window.location.reload();
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
