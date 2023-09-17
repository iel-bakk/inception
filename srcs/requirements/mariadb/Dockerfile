FROM debian:bullseye

COPY ./tools/db.sh /tmp/db.sh

# ENTRYPOINT [ "sleep", "infinity" ]
RUN chmod 777 /tmp/db.sh


ENTRYPOINT [ "/tmp/db.sh" ]