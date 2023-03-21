#!/usr/bin/env bash

set -e

# Example: ./bin/kafka-consumer-groups-describe.sh "QA" "consumer-group-name""

source $PWD/bin/kafka-load-environments.sh "$1"

func_kafka_describe_consumer_group()
{
    bootstrap_servers=$1
    consumer_group=$2

    echo "=============================================================================================================================="
    echo "> DESCRIBE CONSUMER GROUP '$consumer_group'"

    (
        cd $KAFKA_CLIENT_DIR && 
        ./bin/kafka-consumer-groups.sh --bootstrap-server $bootstrap_servers --describe --group $consumer_group
    )

    echo "=============================================================================================================================="
}

if [ -z "$2" ]; then
    echo "parameter 2 consumer group name not found"
    exit 0
fi

func_kafka_describe_consumer_group $KAFKA_BROKERS_TMP "$2"
