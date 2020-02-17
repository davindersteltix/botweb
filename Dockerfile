# FROM node:alpine as appshare
# WORKDIR /app
# RUN mkdir build
# COPY build /app/build

FROM nginx
COPY public /var/www
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
ENTRYPOINT ["nginx","-g","daemon off;"]
