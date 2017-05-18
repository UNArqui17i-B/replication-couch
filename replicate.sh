#!/usr/bin/env bash

echo "--------------------------------edghddgh----------------------------------"
export TARGET_URL="localhost"
export TARGET_PORT="9000"
export HOST_URL="localhost"
export HOST_PORT="9001"
export DB_NAME="blinkbox_files"
curl -X PUT "http://$HOST_URL:$HOST_PORT/$DB_NAME"
curl -X PUT "http://$HOST_URL:$HOST_PORT/_replicator"
curl -H "Content-Type: application/json" -X POST \\
    -d '{"_id":"'"$HOST_URL-to-$TARGET_URL"'", "source":"'"$HOST_URL:$HOST_PORT/$DB_NAME"'", "target":"'"$TARGET_URL:$TARGET_PORT/$DB_NAME"'", "create_target": true, "continuous":true}' \\
    "$HOST_URL:$HOST_PORT/_replicator"