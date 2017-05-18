FROM klaemo/couchdb:2.0-single

WORKDIR /replication-couch
COPY replicate.sh /replication-couch/

#RUN chmod +x replicate.sh
ENTRYPOINT ["./replicate.sh"]