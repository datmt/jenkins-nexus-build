FROM nginx:1.23.1-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY /dist/pipeline-demo /usr/share/nginx/html