FROM klaemo/couchdb:2.0-single

WORKDIR /replication-couch
COPY replicate.sh /replication-couch/

#RUN chmod +x replicate.sh
RUN export NODE1="http://10.0.0.2:9000"
RUN export NODE2="http://10.0.0.2:9010"
RUN export DB_NAME="blinkbox_files"

CMD ["./replicate.sh"]