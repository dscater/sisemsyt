<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Perfil</h1>
                    </div>
                </div>
            </div>
        </section>

        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-3">
                        <div class="card card-primary card-outline">
                            <div class="card-body box-profile">
                                <div class="text-center">
                                    <b-skeleton-wrapper :loading="loading_foto">
                                        <template #loading>
                                            <b-skeleton
                                                class="ml-auto mr-auto"
                                                size="100px"
                                                type="avatar"
                                            ></b-skeleton>
                                        </template>
                                        <img
                                            class="profile-user-img img-fluid img-circle"
                                            :src="oUsuario?.path_image"
                                            alt="User profile picture"
                                            id="img_perfil"
                                        />
                                    </b-skeleton-wrapper>
                                </div>
                                <h3 class="profile-username text-center">
                                    {{ oUsuario?.full_name }}
                                </h3>
                                <p class="text-primary text-center">
                                    {{ oUsuario?.tipo }}
                                </p>
                                <label
                                    v-if="!imagen_cargada"
                                    class="btn btn-primary bg-primary btn-block"
                                    for="file_foto"
                                    ><b>Cambiar foto</b
                                    ><input
                                        type="file"
                                        id="file_foto"
                                        accept="image/png, image/gif, image/jpeg"
                                        hidden
                                        @change="cargaImagen"
                                /></label>
                                <template v-else>
                                    <el-button
                                        type="primary"
                                        class="bg-primary w-full btn-flat mb-1"
                                        :loading="enviandoFoto"
                                        @click="setFoto"
                                        >Enviar cambios</el-button
                                    >
                                    <button
                                        class="btn btn-flat btn-outline-light btn-block"
                                        @click="cancelarCarga"
                                    >
                                        Cancelar
                                    </button>
                                </template>
                            </div>
                        </div>
                        <div class="card card-primary" v-if="oUsuario?.id != 1">
                            <div class="card-header bg-primary">
                                <h3 class="card-title">Información</h3>
                            </div>

                            <div class="card-body">
                                <strong
                                    ><i
                                        class="fas fa-envelope-open-text mr-1"
                                    ></i>
                                    Correo</strong
                                >
                                <p
                                    class="text-primary"
                                    v-text="oUsuario?.correo"
                                ></p>
                                <hr />
                                <strong
                                    ><i class="fas fa-id-card mr-1"></i>
                                    C.I:</strong
                                >
                                <p
                                    class="text-primary"
                                    v-text="oUsuario?.full_ci"
                                ></p>
                                <hr />
                                <strong
                                    ><i class="fas fa-phone mr-1"></i
                                    >Teléfono/Celular:</strong
                                >
                                <p
                                    class="text-primary"
                                    v-text="`${oUsuario ? oUsuario.fono : ''}`"
                                ></p>
                                <hr />
                                <strong
                                    ><i class="fa fa-map-marker mr-1"></i>
                                    Dirección:</strong
                                >
                                <p
                                    class="text-primary"
                                    v-text="oUsuario?.dir"
                                ></p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-9">
                        <div class="card">
                            <div class="card-header p-2 bg-primary">
                                <div class="col-md-12">
                                    <h4>Actualizar contraseña</h4>
                                </div>
                                <!-- <ul class="nav nav-pills">
                                    <li class="nav-item">
                                        <a
                                            class="nav-link active"
                                            href="#settings"
                                            data-toggle="tab"
                                            >Cambiar Contraseña</a
                                        >
                                    </li>
                                </ul> -->
                            </div>
                            <div class="card-body">
                                <div class="tab-content">
                                    <div class="tab-pane active" id="settings">
                                        <form class="form-horizontal">
                                            <div class="form-group row">
                                                <label
                                                    for="inputName"
                                                    class="col-sm-2 col-form-label"
                                                    :class="{
                                                        'text-danger':
                                                            errors.password,
                                                    }"
                                                    >Contraseña actual</label
                                                >
                                                <div class="col-sm-10">
                                                    <input
                                                        type="password"
                                                        class="form-control"
                                                        :class="{
                                                            'is-invalid':
                                                                errors.password_actual,
                                                        }"
                                                        v-model="
                                                            formPassword.password_actual
                                                        "
                                                        @keypress.enter="
                                                            setPassword
                                                        "
                                                        autocomplete=""
                                                    />
                                                    <span
                                                        class="error invalid-feedback"
                                                        v-if="
                                                            errors.password_actual
                                                        "
                                                        v-text="
                                                            errors
                                                                .password_actual[0]
                                                        "
                                                    ></span>
                                                </div>
                                            </div>

                                            <div class="form-group row">
                                                <label
                                                    for="inputName"
                                                    class="col-sm-2 col-form-label"
                                                    :class="{
                                                        'text-danger':
                                                            errors.password,
                                                    }"
                                                    >Nueva Contraseña</label
                                                >
                                                <div class="col-sm-10">
                                                    <input
                                                        type="password"
                                                        class="form-control"
                                                        :class="{
                                                            'is-invalid':
                                                                errors.password,
                                                        }"
                                                        v-model="
                                                            formPassword.password
                                                        "
                                                        @keypress.enter="
                                                            setPassword
                                                        "
                                                        autocomplete=""
                                                    />
                                                    <span
                                                        class="error invalid-feedback"
                                                        v-if="errors.password"
                                                        v-text="
                                                            errors.password[0]
                                                        "
                                                    ></span>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label
                                                    for="inputName"
                                                    class="col-sm-2 col-form-label"
                                                    :class="{
                                                        'text-danger':
                                                            errors.password_confirmation,
                                                    }"
                                                    >Confirmar Contraseña</label
                                                >
                                                <div class="col-sm-10">
                                                    <input
                                                        type="password"
                                                        class="form-control"
                                                        :class="{
                                                            'is-invalid':
                                                                errors.password_confirmation,
                                                        }"
                                                        v-model="
                                                            formPassword.password_confirmation
                                                        "
                                                        @keypress.enter="
                                                            setPassword
                                                        "
                                                        autocomplete=""
                                                    />
                                                    <span
                                                        class="error invalid-feedback"
                                                        v-if="
                                                            errors.password_confirmation
                                                        "
                                                        v-text="
                                                            errors
                                                                .password_confirmation[0]
                                                        "
                                                    ></span>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <div class="col-sm-12">
                                                    <el-button
                                                        type="success"
                                                        class="bg-primary w-full"
                                                        :loading="enviando"
                                                        @click="setPassword"
                                                        >Enviar
                                                        cambios</el-button
                                                    >
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-header p-2 bg-primary">
                                <div class="col-md-12">
                                    <h4>Autenticación de dos pasos</h4>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="tab-content">
                                    <div class="tab-pane active" id="settings">
                                        <div class="row">
                                            <div class="col-12">
                                                <p>
                                                    Activa esta opción y
                                                    descarga
                                                    <a
                                                        href="https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2&hl=es"
                                                        target="_blank"
                                                        >Google Authenticator</a
                                                    >
                                                    en tu dispositivo movíl el
                                                    cual generara un código
                                                    númerico que debes ingresar
                                                    despues de acceder con tus
                                                    credenciales en el Login
                                                </p>
                                            </div>
                                        </div>
                                        <form class="form-horizontal">
                                            <div
                                                class="bootstrap-switch bootstrap-switch-wrapper bootstrap-switch-animate"
                                                :class="{
                                                    'bootstrap-switch-on':
                                                        oUsuario?.auth2fa == 1,
                                                    'bootstrap-switch-off':
                                                        oUsuario?.auth2fa != 1,
                                                }"
                                                style="width: 170px"
                                                @click="cambiaAuth2"
                                            >
                                                <div
                                                    class="bootstrap-switch-container"
                                                    :style="{
                                                        marginLeft:
                                                            oUsuario?.auth2fa !=
                                                            1
                                                                ? '-153px'
                                                                : '0px',
                                                    }"
                                                >
                                                    <span
                                                        class="bootstrap-switch-handle-on bootstrap-switch-primary"
                                                        style="width: 65px"
                                                        >HABILITADO</span
                                                    ><span
                                                        class="bootstrap-switch-label"
                                                        style="width: 65px"
                                                        >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span
                                                    ><span
                                                        class="bootstrap-switch-handle-off bootstrap-switch-default"
                                                        style="width: 65px"
                                                        >DESHABILITADO</span
                                                    >
                                                    <input
                                                        type="checkbox"
                                                        name="my-checkbox"
                                                        data-bootstrap-switch=""
                                                    />
                                                </div>
                                            </div>
                                        </form>
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
            enviando: false,
            enviandoFoto: false,
            loading_foto: true,
            oUsuario: {},
            formPassword: {
                password_actual: "",
                password: "",
                password_confirmation: "",
            },
            errors: [],
            fullscreenLoading: true,
            imagen_cargada: false,
            src_perfil: null,
            foto: null,
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
        };
    },
    mounted() {
        this.loadingWindow.close();
        this.getUsuario();
    },
    methods: {
        cargaImagen(e) {
            this.foto = e.target.files[0];
            document.getElementById("img_perfil").src = URL.createObjectURL(
                this.foto
            );
            this.imagen_cargada = true;
        },
        cancelarCarga() {
            this.imagen_cargada = false;
            document.getElementById("img_perfil").src = this.src_perfil;
        },

        getUsuario() {
            axios.get("/admin/usuarios/" + this.id).then((res) => {
                this.oUsuario = res.data.usuario;
                setTimeout(() => {
                    this.loading_foto = false;
                }, 500);
                this.src_perfil = this.oUsuario.path_image;
            });
        },
        setPassword() {
            this.enviando = true;
            try {
                axios
                    .post(
                        "/admin/usuarios/actualizaContrasenia/" +
                            this.oUsuario?.id,
                        this.formPassword
                    )
                    .then((res) => {
                        this.limpiaCampos();
                        this.enviando = false;
                        Swal.fire({
                            icon: "success",
                            title: res.data.msj,
                            showConfirmButton: false,
                            timer: 1500,
                        });
                    })
                    .catch((error) => {
                        this.enviando = false;
                        if (error.response) {
                            if (error.response.status === 422) {
                                this.errors = error.response.data.errors;
                            }
                            if (
                                error.response.status === 420 ||
                                error.response.status === 419 ||
                                error.response.status === 401
                            ) {
                                window.location = "/";
                            }
                            if (error.response.status === 500) {
                                Swal.fire({
                                    icon: "error",
                                    title: "Error",
                                    html: error.response.data.message,
                                    showConfirmButton: false,
                                    timer: 2000,
                                });
                            }
                        }
                    });
            } catch (e) {}
        },
        setFoto() {
            this.enviandoFoto = true;
            let config = {
                headers: {
                    "Content-Type": "multipart/form-data",
                },
            };
            let formData = new FormData();
            formData.append("foto", this.foto);
            try {
                axios
                    .post(
                        "/admin/usuarios/actualizaFoto/" + this.oUsuario.id,
                        formData,
                        config
                    )
                    .then((res) => {
                        EventBus.$emit("usuario_actualizado", res.data.usuario);
                        this.enviandoFoto = false;
                        this.imagen_cargada = false;
                        Swal.fire({
                            icon: "success",
                            title: res.data.msj,
                            showConfirmButton: false,
                            timer: 1500,
                        });
                    })
                    .catch((error) => {
                        this.enviando = false;
                        if (error.response) {
                            if (error.response.status === 422) {
                                this.errors = error.response.data.errors;
                            }
                            if (
                                error.response.status === 420 ||
                                error.response.status === 419 ||
                                error.response.status === 401
                            ) {
                                window.location = "/";
                            }
                            if (error.response.status === 500) {
                                Swal.fire({
                                    icon: "error",
                                    title: res.data.msj,
                                    showConfirmButton: false,
                                    timer: 2000,
                                });
                            }
                        }
                    });
            } catch (e) {}
        },
        limpiaCampos() {
            this.formPassword.password_actual = "";
            this.formPassword.password = "";
            this.formPassword.password_confirmation = "";
            this.errors = [];
        },
        cambiaAuth2() {
            const value = this.oUsuario.auth2fa == 1 ? 0 : 1;
            axios
                .post("/admin/usuarios/update2Fa/" + this.oUsuario.id, {
                    auth2fa: value,
                })
                .then((response) => {
                    this.oUsuario = response.data.user;
                    Swal.fire({
                        icon: "success",
                        title: response.data.msj,
                        showConfirmButton: false,
                        timer: 1500,
                    });
                    const self = this;
                    setTimeout(() => {
                        self.obtienePermisos();
                    }, 100);
                });
        },
        obtienePermisos() {
            axios
                .get("/admin/usuarios/getPermisos/" + this.oUsuario.id)
                .then((res) => {
                    localStorage.setItem("permisos", JSON.stringify(res.data));
                    localStorage.setItem("user", JSON.stringify(this.oUsuario));
                });
        },
    },
};
</script>

<style>
#img_perfil {
    min-height: 100px;
    height: 100px;
}
</style>
