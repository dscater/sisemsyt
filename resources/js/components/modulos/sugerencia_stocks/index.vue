<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Sugerencia de stock mínimo</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12 text-center">
                        <button
                            class="btn btn-lg btn-outline-info"
                            @click="generarSugerencia"
                            :disabled="generando"
                        >
                            <i class="fa fa-sync"></i> Generar sugerencia
                        </button>
                    </div>
                    <div
                        class="col-12 text-center mt-2"
                        v-if="listSugerencias.length > 0"
                    >
                        <button
                            class="btn btn-primary"
                            @click="guardarSugerencia"
                            :disabled="guardando"
                        >
                            <i class="fa fa-save"></i> Guardar
                        </button>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-md-12 contenedor_loading">
                        <div class="loading" v-if="generando">
                            <p class="text-body-1 text-white">Generando...</p>
                            <div class="loader">
                                <div class="book-wrapper">
                                    <svg
                                        xmlns="http://www.w3.org/2000/svg"
                                        fill="white"
                                        viewBox="0 0 126 75"
                                        class="book"
                                    >
                                        <rect
                                            stroke-width="5"
                                            stroke="#a1d1fd"
                                            rx="7.5"
                                            height="70"
                                            width="121"
                                            y="2.5"
                                            x="2.5"
                                        ></rect>
                                        <line
                                            stroke-width="5"
                                            stroke="#a1d1fd"
                                            y2="75"
                                            x2="63.5"
                                            x1="63.5"
                                        ></line>
                                        <path
                                            stroke-linecap="round"
                                            stroke-width="4"
                                            stroke="#c18949"
                                            d="M25 20H50"
                                        ></path>
                                        <path
                                            stroke-linecap="round"
                                            stroke-width="4"
                                            stroke="#c18949"
                                            d="M101 20H76"
                                        ></path>
                                        <path
                                            stroke-linecap="round"
                                            stroke-width="4"
                                            stroke="#c18949"
                                            d="M16 30L50 30"
                                        ></path>
                                        <path
                                            stroke-linecap="round"
                                            stroke-width="4"
                                            stroke="#c18949"
                                            d="M110 30L76 30"
                                        ></path>
                                    </svg>

                                    <svg
                                        xmlns="http://www.w3.org/2000/svg"
                                        fill="#ffffff"
                                        viewBox="0 0 65 75"
                                        class="book-page"
                                    >
                                        <path
                                            stroke-linecap="round"
                                            stroke-width="4"
                                            stroke="#c18949"
                                            d="M40 20H15"
                                        ></path>
                                        <path
                                            stroke-linecap="round"
                                            stroke-width="4"
                                            stroke="#c18949"
                                            d="M49 30L15 30"
                                        ></path>
                                        <path
                                            stroke-width="5"
                                            stroke="#a1d1fd"
                                            d="M2.5 2.5H55C59.1421 2.5 62.5 5.85786 62.5 10V65C62.5 69.1421 59.1421 72.5 55 72.5H2.5V2.5Z"
                                        ></path>
                                    </svg>
                                </div>
                            </div>
                            <p class="text-body-1 text-white">
                                ¡Espere por favor!
                            </p>
                        </div>
                        <div class="loading_guardar" v-if="guardando">
                            <p>Guardando</p>
                            <i class="fa fa-spinner fa-spin fa-4x"></i>
                        </div>
                        <table
                            class="table table-striped bg-white"
                            v-if="!generando"
                        >
                            <thead>
                                <tr class="bg-primary">
                                    <th>Código</th>
                                    <th>Producto</th>
                                    <th>Imagen</th>
                                    <th>Stock mínimo recomendado</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="item in listSugerencias">
                                    <td>{{ item.codigo_producto }}</td>
                                    <td>{{ item.nombre }}</td>
                                    <td>
                                        <img
                                            :src="item.url_imagen"
                                            alt="Imagen"
                                            height="57px"
                                        />
                                    </td>
                                    <td>{{ item.total_vendido }}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </section>
    </div>
</template>

<script>
export default {
    components: {},
    data() {
        return {
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            permisos: localStorage.getItem("permisos"),
            generando: false,
            guardando: false,
            listSugerencias: [],
        };
    },
    watch: {},
    mounted() {
        this.loadingWindow.close();
    },
    methods: {
        generarSugerencia() {
            this.generando = true;
            axios
                .post("/admin/sugerencia_stocks")
                .then((response) => {
                    this.listSugerencias = response.data.productos;
                })
                .catch((error) => {
                    console.log(error);
                })
                .finally(() => {
                    setTimeout(() => {
                        this.generando = false;
                    }, 1200);
                });
        },
        guardarSugerencia() {
            this.guardando = true;
            axios
                .post("/admin/sugerencia_stocks/guardar", {
                    productos: this.listSugerencias,
                })
                .then((response) => {
                    Swal.fire({
                        icon: "success",
                        title: `Registros actualizados correctamente`,
                        showConfirmButton: false,
                        timer: 1500,
                    });
                    this.listSugerencias = [];
                })
                .catch((error) => {
                    console.log(error);
                })
                .finally(() => {
                    setTimeout(() => {
                        this.guardando = false;
                    }, 900);
                });
        },
    },
};
</script>

<style>
.contenedor_loading .loading {
    padding: 80px 0px;
    display: flex;
    flex-direction: column;
    color: #47494b;
    font-size: 1.2em;
    font-weight: bold;
    justify-content: center;
    align-items: center;
    height: 100%;
    min-height: 40vh;
    width: 100%;
    background: var(--principal);
    z-index: 300;
    position: absolute;
}

.loading_guardar {
    padding: 80px 0px;
    display: flex;
    flex-direction: column;
    color: #f0f0f0;
    font-size: 1.2em;
    font-weight: bold;
    justify-content: center;
    align-items: center;
    height: 100%;
    min-height: 40vh;
    width: 100%;
    background: var(--principal);
    z-index: 300;
    position: absolute;
}

.contenedor_loading .loading {
    padding: 80px 0px;
    display: flex;
    flex-direction: column;
    color: #f0f0f0;
    font-size: 1.2em;
    font-weight: bold;
    justify-content: center;
    align-items: center;
    height: 100%;
    width: 100%;
    z-index: 300;
    position: absolute;
}

.loader {
    display: flex;
    align-items: center;
    justify-content: center;
}

.book-wrapper {
    width: 150px;
    height: fit-content;
    display: flex;
    align-items: center;
    justify-content: flex-end;
    position: relative;
}

.book {
    width: 100%;
    height: auto;
    filter: drop-shadow(10px 10px 5px rgba(0, 0, 0, 0.137));
}

.book-wrapper .book-page {
    width: 50%;
    height: auto;
    position: absolute;
    animation: paging 0.35s linear infinite;
    transform-origin: left;
}

@keyframes paging {
    0% {
        transform: rotateY(0deg) skewY(0deg);
    }

    50% {
        transform: rotateY(90deg) skewY(-20deg);
    }

    100% {
        transform: rotateY(180deg) skewY(0deg);
    }
}
</style>
