import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()],
  base: './', // Importante para aplicaciones Electron

  build: {
    rollupOptions: {
      output: {
        // Divide las dependencias grandes en chunks separados
        manualChunks: {
          vendor: ['react', 'react-dom'], // Agrupa React y ReactDOM
        },
      },
    },
    chunkSizeWarningLimit: 10000, // Aumenta el límite de tamaño a 10000 kB si es necesario
  },
});
