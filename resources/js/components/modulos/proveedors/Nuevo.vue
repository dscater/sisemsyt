<template>
    <div
        class="modal fade"
        :class="{ show: bModal }"
        id="modal-default"
        aria-modal="true"
        role="dialog"
    >
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <h4 class="modal-title" v-text="tituloModal"></h4>
                    <button
                        type="button"
                        class="close"
                        data-dismiss="modal"
                        aria-label="Close"
                        @click="cierraModal"
                    >
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="row">
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.razon_social,
                                    }"
                                    >Razón social*</label
                                >
                                <el-input
                                    placeholder="Razón social"
                                    :class="{ 'is-invalid': errors.razon_social }"
                                    v-model="proveedor.razon_social"
                                    clearable
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.razon_social"
                                    v-text="errors.razon_social[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.nit,
                                    }"
                                    >Nit</label
                                >
                                <el-input
                                    placeholder="Nit"
                                    :class="{ 'is-invalid': errors.nit }"
                                    v-model="proveedor.nit"
                                    clearable
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.nit"
                                    v-text="errors.nit[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.dir,
                                    }"
                                    >Dirección</label
                                >
                                <el-input
                                    placeholder="Dirección"
                                    :class="{ 'is-invalid': errors.dir }"
                                    v-model="proveedor.dir"
                                    clearable
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.dir"
                                    v-text="errors.dir[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.fono,
                                    }"
                                    >Teléfono/Celular*</label
                                >
                                <b-form-tags
                                    input-id="tags-basic"
                                    placeholder="Teléfono/Celular"
                                    :class="{ 'is-invalid': errors.fono }"
                                    v-model="proveedor.fono"
                                    addButtonText="Añadir"
                                    separator=" ,;"
                                    remove-on-delete
                                ></b-form-tags>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.fono"
                                    v-text="errors.fono[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.nombre_contacto,
                                    }"
                                    >Nombre Contacto</label
                                >
                                <el-input
                                    placeholder="Nombre Contacto"
                                    :class="{
                                        'is-invalid': errors.nombre_contacto,
                                    }"
                                    v-model="proveedor.nombre_contacto"
                                    clearable
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.nombre_contacto"
                                    v-text="errors.nombre_contacto[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.descripcion,
                                    }"
                                    >Descripción</label
                                >
                                <el-input
                                    type="textarea"
                                    autosize
                                    placeholder="Descripción"
                                    :class="{
                                        'is-invalid': errors.descripcion,
                                    }"
                                    v-model="proveedor.descripcion"
                                    clearable
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.descripcion"
                                    v-text="errors.descripcion[0]"
                                ></span>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer justify-content-between">
                    <button
                        type="button"
                        class="btn btn-default"
                        data-dismiss="modal"
                        @click="cierraModal"
                    >
                        Cerrar
                    </button>
                    <el-button
                        type="primary"
                        class="bg-primary"
                        :loading="enviando"
                        @click="setRegistroModal()"
                        >{{ textoBoton }}</el-button
                    >
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    props: {
        muestra_modal: {
            type: Boolean,
            default: false,
        },
        accion: {
            type: String,
            default: "nuevo",
        },
        proveedor: {
            type: Object,
            default: {
                id: 0,
                razon_social: "",
                nit: "",
                dir: "",
                fono: [],
                nombre_contacto: "",
                descripcion: "",
            },
        },
    },
    watch: {
        muestra_modal: function (newVal, oldVal) {
            this.errors = [];
            if (newVal) {
                this.bModal = true;
            } else {
                this.bModal = false;
            }
        },
    },
    computed: {
        tituloModal() {
            if (this.accion == "nuevo") {
                return "NUEVO REGISTRO";
            } else {
                return "MODIFICAR REGISTRO";
            }
        },
        textoBoton() {
            if (this.accion == "nuevo") {
                return "Registrar";
            } else {
                return "Actualizar";
            }
        },
    },
    data() {
        return {
            user: JSON.parse(localStorage.getItem("user")),
            bModal: this.muestra_modal,
            enviando: false,
            errors: [],
        };
    },
    mounted() {
        this.bModal = this.muestra_modal;
    },
    methods: {
        setRegistroModal() {
            this.enviando = true;
            try {
                this.textoBtn = "Enviando...";
                let url = "/admin/proveedors";
                let config = {
                    headers: {
                        "Content-Type": "multipart/form-data",
                    },
                };
                let formdata = new FormData();
                formdata.append(
                    "razon_social",
                    this.proveedor.razon_social ? this.proveedor.razon_social : ""
                );
                formdata.append(
                    "nit",
                    this.proveedor.nit ? this.proveedor.nit : ""
                );
                formdata.append(
                    "dir",
                    this.proveedor.dir ? this.proveedor.dir : ""
                );
                formdata.append(
                    "fono",
                    this.proveedor.fono ? this.proveedor.fono.join("; ") : ""
                );
                formdata.append(
                    "nombre_contacto",
                    this.proveedor.nombre_contacto
                        ? this.proveedor.nombre_contacto
                        : ""
                );
                formdata.append(
                    "descripcion",
                    this.proveedor.descripcion ? this.proveedor.descripcion : ""
                );

                if (this.accion == "edit") {
                    url = "/admin/proveedors/" + this.proveedor.id;
                    formdata.append("_method", "PUT");
                }
                axios
                    .post(url, formdata, config)
                    .then((res) => {
                        this.enviando = false;
                        if (res.data.sw) {
                            Swal.fire({
                                icon: "success",
                                title: res.data.msj,
                                showConfirmButton: false,
                                timer: 1500,
                            });
                            this.limpiaProveedor();
                            this.$emit("envioModal");
                            this.errors = [];
                            if (this.accion == "edit") {
                                this.textoBtn = "Actualizar";
                            } else {
                                this.textoBtn = "Registrar";
                            }
                        } else {
                            Swal.fire({
                                icon: "info",
                                title: "Atención",
                                html: res.data.msj,
                                showConfirmButton: false,
                                timer: 2000,
                            });
                        }
                    })
                    .catch((error) => {
                        this.enviando = false;
                        if (this.accion == "edit") {
                            this.textoBtn = "Actualizar";
                        } else {
                            this.textoBtn = "Registrar";
                        }
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
            } catch (e) {
                this.enviando = false;
                console.log(e);
            }
        },
        // Dialog/modal
        cierraModal() {
            this.bModal = false;
            this.$emit("close");
        },
        limpiaProveedor() {
            this.errors = [];
            this.proveedor.razon_social = "";
            this.proveedor.nit = "";
            this.proveedor.dir = "";
            this.proveedor.fono = [];
            this.proveedor.nombre_contacto = "";
            this.proveedor.descripcion = "";
        },
    },
};
</script>

<style></style>
