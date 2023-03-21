#!/usr/bin/env bash

set -e

# Example: ./bin/kafka-load-environments.sh "QA""

if [ ! -f ../.env ]
then
  export $(cat .env | xargs)
fi

KAFKA_BROKERS_ENV_NAME="KAFKA_BROKERS_$1"

if [[ ! -z "${!KAFKA_BROKERS_ENV_NAME}" ]]; then
	echo "Environment $1 defined"
    export KAFKA_BROKERS_TMP="${!KAFKA_BROKERS_ENV_NAME}"
else
    echo "parameter 1 environment not found or is invalid, received $1"
    echo "examples defined in '.env' file: \"KAFKA_BROKERS_LOCAL\", \"KAFKA_BROKERS_QA\", \"KAFKA_BROKERS_PROD\", and use suffix for environment parameter, examples: \"LOCAL\", \"QA\", \"PROD\""
    
    if [ ! -f ../.env ]
    then
        echo "Parameters defined in .env file"
        echo "$(cat .env)"
    else
        echo ".env not defined .env"
    fi

    exit 0
fi

source $PWD/bin/kafka-client-install.sh
