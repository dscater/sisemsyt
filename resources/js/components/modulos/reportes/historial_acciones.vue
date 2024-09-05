<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Historial de Acciones del sistema</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <div class="row">
                                    <div class="col-md-3">
                                        <el-button
                                            type="primary"
                                            class="btn btn-primary bg-primary btn-flat btn-block"
                                            @click="generaReporte()"
                                            :loading="enviando"
                                        >
                                            Generar reporte
                                        </el-button>
                                    </div>
                                    <div class="form-group col-md-4">
                                        <el-date-picker
                                            class="w-full d-block"
                                            :class="{
                                                'is-invalid': errors.fecha_ini,
                                                'is-invalid': errors.fecha_fin,
                                            }"
                                            v-model="aFechas"
                                            type="daterange"
                                            range-separator="a"
                                            start-placeholder="Fecha Inicial"
                                            end-placeholder="Fecha Final"
                                            format="dd/MM/yyyy"
                                            value-format="yyyy-MM-dd"
                                            @change="obtieneFechas()"
                                        >
                                        </el-date-picker>
                                        <span
                                            class="error invalid-feedback"
                                            v-if="errors.fecha_ini"
                                            v-text="errors.fecha_ini[0]"
                                        ></span>
                                        <span
                                            class="error invalid-feedback"
                                            v-if="errors.fecha_fin"
                                            v-text="errors.fecha_fin[0]"
                                        ></span>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <b-col lg="10" class="my-1">
                                        <b-form-group
                                            label="Buscar"
                                            label-for="filter-input"
                                            label-cols-sm="3"
                                            label-align-sm="right"
                                            label-size="sm"
                                            class="mb-0"
                                        >
                                            <b-input-group size="sm">
                                                <b-form-input
                                                    id="filter-input"
                                                    v-model="filter"
                                                    type="search"
                                                    placeholder="Buscar"
                                                ></b-form-input>

                                                <b-input-group-append>
                                                    <b-button
                                                        class="bg-primary"
                                                        variant="primary"
                                                        :disabled="!filter"
                                                        @click="filter = ''"
                                                        >Borrar</b-button
                                                    >
                                                </b-input-group-append>
                                            </b-input-group>
                                        </b-form-group>
                                    </b-col>
                                    <div class="col-md-12">
                                        <b-overlay
                                            :show="showOverlay"
                                            rounded="sm"
                                        >
                                            <b-table
                                                :fields="fields"
                                                :items="listRegistros"
                                                show-empty
                                                stacked="md"
                                                responsive
                                                :current-page="currentPage"
                                                :per-page="perPage"
                                                @filtered="onFiltered"
                                                empty-text="Sin resultados"
                                                empty-filtered-text="Sin resultados"
                                                :filter="filter"
                                            >
                                                <template
                                                    #cell(datos_original)="row"
                                                >
                                                    <div
                                                        v-html="
                                                            row.item
                                                                .datos_original
                                                        "
                                                    ></div>
                                                </template>

                                                <template
                                                    #cell(datos_nuevo)="row"
                                                >
                                                    <div
                                                        v-html="
                                                            row.item.datos_nuevo
                                                        "
                                                    ></div>
                                                </template>

                                                <template #cell(fecha)="row">
                                                    {{
                                                        formatoFecha(
                                                            row.item.fecha
                                                        )
                                                    }}
                                                </template>
                                            </b-table>
                                        </b-overlay>
                                        <div class="row">
                                            <b-col
                                                sm="6"
                                                md="2"
                                                class="ml-auto my-1"
                                            >
                                                <b-form-select
                                                    align="right"
                                                    id="per-page-select"
                                                    v-model="perPage"
                                                    :options="pageOptions"
                                                    size="sm"
                                                ></b-form-select>
                                            </b-col>
                                            <b-col
                                                sm="6"
                                                md="2"
                                                class="my-1 mr-auto"
                                                v-if="perPage"
                                            >
                                                <b-pagination
                                                    v-model="currentPage"
                                                    :total-rows="totalRows"
                                                    :per-page="perPage"
                                                    align="left"
                                                ></b-pagination>
                                            </b-col>
                                        </div>
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
    data() {
        return {
            permisos: localStorage.getItem("permisos"),
            search: "",
            listRegistros: [],
            showOverlay: false,
            fields: [
                {
                    key: "user.usuario",
                    label: "Usuario",
                    sortable: true,
                },
                { key: "accion", label: "Acción", sortable: true },
                {
                    key: "modulo",
                    label: "Módulo",
                    sortable: true,
                },
                { key: "descripcion", label: "Descripción", sortable: true },
                {
                    key: "datos_original",
                    label: "Información original",
                    sortable: true,
                },
                {
                    key: "datos_nuevo",
                    label: "Cambios de información",
                    sortable: true,
                },
                {
                    key: "fecha",
                    label: "Fecha",
                    sortable: true,
                },
                {
                    key: "hora",
                    label: "Hora",
                    sortable: true,
                },
            ],
            loading: true,
            fullscreenLoading: true,
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            muestra_modal: false,
            modal_accion: "nuevo",
            oHistorialAccion: {
                id: 0,
                nombre: "",
                descripcion: "",
            },
            currentPage: 1,
            perPage: 5,
            pageOptions: [
                { value: 5, text: "Mostrar 5 Registros" },
                { value: 10, text: "Mostrar 10 Registros" },
                { value: 25, text: "Mostrar 25 Registros" },
                { value: 50, text: "Mostrar 50 Registros" },
                { value: 100, text: "Mostrar 100 Registros" },
                { value: this.totalRows, text: "Mostrar Todo" },
            ],
            totalRows: 10,
            filter: null,
            enviando: false,
            aFechas: [],
            errors: [],
            fecha_ini: "",
            fecha_fin: "",
        };
    },
    mounted() {
        this.loadingWindow.close();
        this.getHistorialAccions();
    },
    methods: {
        // Listar HistorialAccions
        getHistorialAccions() {
            this.showOverlay = true;
            this.muestra_modal = false;
            let url = "/admin/historial_accions";

            let params = {};
            if (this.fecha_ini != "" && this.fecha_fin != "") {
                params = {
                    params: {
                        fecha_ini: this.fecha_ini,
                        fecha_fin: this.fecha_fin,
                    },
                };
            }

            axios.get(url, params).then((res) => {
                this.showOverlay = false;
                this.listRegistros = res.data.historial_accions;
                this.totalRows = res.data.total;
            });
        },
        onFiltered(filteredItems) {
            // Trigger pagination to update the number of buttons/pages due to filtering
            this.totalRows = filteredItems.length;
            this.currentPage = 1;
        },
        limpiaHistorialAccion() {
            this.oHistorialAccion.nombre = "";
            this.oHistorialAccion.descripcion = "";
        },
        formatoFecha(date) {
            return this.$moment(String(date)).format("DD/MM/YYYY");
        },
        generaReporte() {
            this.enviando = true;
            let config = {
                responseType: "blob",
            };
            let oReporte = {};
            if (this.fecha_ini != "" && this.fecha_fin != "") {
                oReporte = {
                    fecha_ini: this.fecha_ini,
                    fecha_fin: this.fecha_fin,
                };
            }

            axios
                .post("/admin/reportes/historial_accion", oReporte, config)
                .then((res) => {
                    this.errors = [];
                    this.enviando = false;
                    let pdfBlob = new Blob([res.data], {
                        type: "application/pdf",
                    });
                    let urlReporte = URL.createObjectURL(pdfBlob);
                    window.open(urlReporte);
                })
                .catch(async (error) => {
                    let responseObj = await error.response.data.text();
                    responseObj = JSON.parse(responseObj);
                    console.log(error);
                    this.enviando = false;
                    if (error.response) {
                        if (error.response.status === 422) {
                            this.errors = responseObj.errors;
                        }
                        if (
                            error.response.status === 420 ||
                            error.response.status === 419 ||
                            error.response.status === 401
                        ) {
                            Swal.fire({
                                icon: "error",
                                title: "Error",
                                html: responseObj.message,
                                showConfirmButton: false,
                                timer: 2000,
                            });
                            window.location = "/";
                        }

                        if (error.response.status === 500) {
                            Swal.fire({
                                icon: "error",
                                title: "Error",
                                html: responseObj.message,
                                showConfirmButton: false,
                                timer: 2000,
                            });
                        }
                    }
                });
        },
        obtieneFechas() {
            if (this.aFechas) {
                console.log(this.aFechas);
                this.fecha_ini = this.aFechas[0];
                this.fecha_fin = this.aFechas[1];
            } else {
                this.fecha_ini = "";
                this.fecha_fin = "";
            }
            this.getHistorialAccions();
        },
    },
};
</script>

<style></style>
