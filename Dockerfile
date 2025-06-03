# Etapa 1: Build con pnpm
FROM node:20-alpine AS builder

RUN npm install -g pnpm

WORKDIR /app

COPY . .

RUN pnpm install
RUN pnpm run build

# Etapa 2: Servir con NGINX
FROM nginx:alpine

# Elimina la página por defecto
RUN rm -rf /usr/share/nginx/html/*

# Copia la build al directorio de NGINX
COPY --from=builder /app/dist /usr/share/nginx/html

# Copia configuración básica de NGINX (opcional)
# COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
