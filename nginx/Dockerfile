FROM debian:bullseye
RUN apt-get update -y && apt-get upgrade -y \
        && apt-get install nginx openssl -y 
RUN openssl req -x509 -days 365 -newkey rsa:2048 -nodes \
    -keyout /etc/nginx/nginx-selfsigned.key \
    -subj "/C=MA/ST=KHOURIBGA/L=1337KH/O=42/OU=42/CN=iel-bakk" \
    -out /etc/nginx/nginx-selfsigned.crt


COPY /conf/nginx.conf /etc/nginx/conf.d/default.conf
COPY /conf/html/index.html /usr/share/nginx/html/index.html
EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]