FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y

COPY ./tools/script.sh /tmp/script.sh

ENTRYPOINT ["/bin/script.sh", "tmp/script.sh"]