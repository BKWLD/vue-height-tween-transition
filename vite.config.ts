import { defineConfig } from "vite";
import vue from '@vitejs/plugin-vue';
import { resolve } from "node:path";

export default defineConfig({
    plugins: [vue()],
    build: {
        lib: {
            entry: resolve(__dirname, "src/index.vue"),
            name: "vue-height-tween-transition",
            fileName: (format) => `index.${format}.js`,
        },
        rollupOptions: {
            external: ["vue"],
            output: {
                globals: {
                    vue: "Vue",
                },
            },
        },
    }
})  