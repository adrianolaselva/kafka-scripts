#!/usr/bin/env bash

set -e

# Example: kafka-delete-records.sh "QA" "./tmp/prod-offset-remove.json""

source $PWD/bin/kafka-load-environments.sh "$1"

func_kafka_delete_records()
{
    bootstrap_servers=$1
    offset_json_file=$2

    echo "=============================================================================================================================="
    echo "> REMOVE RECORDS '$consumer_group'"

    #cat "$PWD/$offset_json_file" | jq 'del(.partitions[].payload)'

    (
        cd $KAFKA_CLIENT_DIR && 
        ./bin/kafka-delete-records.sh --bootstrap-server $bootstrap_servers --offset-json-file "$PWD/../$offset_json_file"
    )

    echo "=============================================================================================================================="
}

func_kafka_delete_records $KAFKA_BROKERS_TMP "$2"