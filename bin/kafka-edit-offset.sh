#!/usr/bin/env bash

set -e

# Example: ./bin/kafka-edit-offset.sh "QA" "consumer-group-name" "topic-name" "2023-03-08T12:48:00.000-0300""

source $PWD/bin/kafka-load-environments.sh "$1"

func_kafka_change_offset()
{
    bootstrap_servers="$1"
    topic_name="$2"
    worker_group="$3"
    offset_datetime="$4"

    echo "=============================================================================================================================="
    echo "> START EDIT OFFSET TOPIC '$topic_name' AND WORKER GROUP '$worker_group' TO DATETIME '$offset_datetime'"

    (
        cd $KAFKA_CLIENT_DIR && 
        ./bin/kafka-consumer-groups.sh --bootstrap-server $bootstrap_servers --group $worker_group --reset-offsets --to-datetime $offset_datetime --topic $topic_name --execute && 
        ./bin/kafka-consumer-groups.sh --bootstrap-server $bootstrap_servers --describe --group $worker_group
    )

    echo "> END EDIT OFFSET TOPIC '$topic_name' AND WORKER GROUP '$worker_group' TO '$offset_datetime'"

    echo "=============================================================================================================================="
}

if [ -z "$2" ]; then
    echo "parameter 3 worker group name not found"
    exit 0
fi

if [ -z "$3" ]; then
    echo "parameter 4 topic name not found"
    exit 0
fi

if [ -z "$4" ]; then
    echo "parameter 2 datetime offset not found (ex: \"2023-03-03T13:29:00.000-0300\")"
    exit 0
fi

KAFKA_CONSUMER_GROUP_OFFSET_TO_DATETIME="$2"
KAFKA_TOPIC_NAMES[0]="$4"
KAFKA_CONSUMER_GROUPS[0]="$3"

func_kafka_change_offset $KAFKA_BROKERS_TMP "$2" "$3" "$4"