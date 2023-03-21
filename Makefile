include .env
export $(shell sed 's/=.*//' .env)

kafka-client-install:
	@(./bin/kafka-client-install.sh)
	@echo "kafka client installed!"
consumer-group-describe:
	@(./bin/kafka-consumer-groups-describe.sh $(ENV) $(CONSUMER_GROUP))
consumer-group-delete:
	@(./bin/kafka-consumer-groups-delete.sh $(ENV) $(CONSUMER_GROUP))
edit-offset:
	@(./bin/kafka-consumer-groups-delete.sh $(ENV) $(CONSUMER_GROUP) $(TOPIC_NAME))