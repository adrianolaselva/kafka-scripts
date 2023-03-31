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

## Examples remove records

It is only possible to remove all offsets from one or N... partitions.

```sh
kcat -b $KAFKA_CLUSTERS_PROD_BOOTSTRAPSERVERS -t topic-example -o beginning -J -q -e | grep -e "DROP TABLE IF EXISTS request_logs_bkp2021-03-11" | jq -c 'del(.payload, .key, .broker, .ts, .tstype)' | jq -s '{partitions: ., version: 1}'
```
> filter events with `kcat` format and stop after receive

```json
{"topic":"topic-example","partition":0,"offset":11,"tstype":"create","ts":1646857416396,"broker":15,"key":null,"payload":"{\n  \"source\" : {\n    \"server\" : \"teste_database\"\n  },\n  \"position\" : {\n    \"ts_sec\" : 1646857416,\n    \"file\" : \"mysql-bin-changelog.034486\",\n    \"pos\" : 41177917,\n    \"snapshot\" : true\n  },\n  \"databaseName\" : \"teste_database\",\n  \"ddl\" : \"DROP TABLE IF EXISTS request_logs_bkp2021-03-11\",\n  \"tableChanges\" : [ ]\n}"}
```
> Example terminal output

```json
{
    "partitions":[
        {"topic":"topic-example","partition":0,"offset":11}
    ],
    "version":1
 }
```
> Create a file with the following information for the events to be removed

```sh
./bin/kafka-delete-records.sh "PROD" ".tmp/prod-offset-remove.json"
```
> Run command to remove events


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
