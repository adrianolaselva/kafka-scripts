#!/usr/bin/env bash

set -e

# KAFKA CLIENT PATH
KAFKA_CLIENT_DIR="$PWD/kafka-cli"
if [ ! -d "$KAFKA_CLIENT_DIR" ]; then
    echo "=============================================================================================================================="
	echo "> kafka-cli was found at ${KAFKA_CLIENT_DIR} installing..."
    
    wget https://archive.apache.org/dist/kafka/3.2.1/kafka_2.13-3.2.1.tgz
    tar -xzf kafka_2.13-3.2.1.tgz
    mv kafka_2.13-3.2.1 kafka-cli
    rm -rf kafka_2.13-3.2.1.tgz

    echo "=============================================================================================================================="
fi
