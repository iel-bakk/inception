FROM debian:bullseye

CMD ["mkdir tmp"]

COPY /tools/script.sh /tmp/script.sh
RUN chmod +x /tmp/script.sh
CMD ["/tmp/script.sh"]
