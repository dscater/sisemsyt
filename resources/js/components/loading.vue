<template>
    <div class="loading_saliendo" v-show="vloading">
        <div class="loading">
            <i class="fa fa-spinner fa-spin"></i> Saliendo...
        </div>
    </div>
</template>
<script>
export default {
    props: ["loading"],
    data() {
        return {
            vloading: this.loading,
        };
    },
    watch: {
        loading(newVal) {
            this.vloading = newVal;
        },
    },
    mounted() {},
    methods: {},
};
</script>
