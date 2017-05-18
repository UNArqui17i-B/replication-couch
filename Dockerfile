FROM klaemo/couchdb:2.0-single

WORKDIR /replication-couch
COPY replicate.py /replication-couch/

ENTRYPOINT ["python", "replicate.py"]