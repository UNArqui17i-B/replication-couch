#!/usr/bin/env bash

echo "--------------------------------edghddgh----------------------------------"
curl -X PUT ${NODE1}/_replicator
curl -X PUT ${NODE2}/_replicator

curl -H "Content-Type: application/json" -X POST -d '{"_id":"node1_to_node2", "source":"'"${NODE1}/${DB_NAME}"'", "target":"'"${NODE2}/${DB_NAME}"'", "create_target": true, "continuous":true}' ${NODE1}/_replicator
curl -H "Content-Type: application/json" -X POST -d '{"_id":"node2_to_node1", "source":"'"${NODE2}/${DB_NAME}"'", "target":"'"${NODE1}/${DB_NAME}"'", "create_target": true, "continuous":true}' ${NODE2}/_replicator
