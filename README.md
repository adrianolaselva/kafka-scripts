# Kafka Scripts

Scripts created to facilitate routine maintenance activities in kafka, such as listing, loading details, creating consumer groups, editing consumer groups and editing offset of a given consumer group and topic.

If you don't have `kafka-cli` installed locally it will be installed before running the scripts.

**Obs: scripts must be called from the root of the project**

## Settings

Create and edit the `.env` file in the root to define the environment variables with the suffix being the environment to be used, for example "KAFKA_BROKERS_`LOCAL`", so when executing the script pass only the `LOCAL` env (ex: `./bin/kafka-consumer-groups-describe.sh "LOCAL" "consumer-group-name"`).

```shell
KAFKA_BROKERS_LOCAL="localhost:9092"
```
> Add a variable with hosts

```shell
KAFKA_BROKERS_LOCAL="localhost:9092"
```
> Just below the conditions add one for the environment you need to use

## Examples using shell scripts

- Remove consumer groups
```sh
./bin/kafka-consumer-groups-delete.sh "QA" "consumer-group-name"
```
> Delete consumer group

- Describe consumer groups
```sh
./bin/kafka-consumer-groups-describe.sh "QA" "consumer-group-name"
```
> Describe consumer group

- Edit consumer group offset

```sh
./bin/kafka-edit-offset.sh "QA" "consumer-group-name" "topic-name" "2023-03-08T12:48:00.000-0300"
```
> Edit offset by topic and consumer group


## Examples using Makefile

- Install kafka client
```sh
make kafka-client-install
```
> Installing kafka client

- Remove consumer groups
```sh
make consumer-group-delete ENV=QA CONSUMER_GROUP=consumer-group-name
```
> Delete consumer group

- Describe consumer groups
```sh
make consumer-group-describe ENV=QA CONSUMER_GROUP=consumer-group-name
```
> Describe consumer group

- Edit consumer group offset
```sh
make edit-offset ENV=QA CONSUMER_GROUP=consumer-group-name TOPIC_NAME=topic-name OFFSET_TIME="2023-03-08T12:48:00.000-0300"
```
> Edit offset by topic and consumer group
