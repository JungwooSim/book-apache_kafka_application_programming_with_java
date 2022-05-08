bin/kafka-topics.sh --bootstrap-server localhost:9092 --create \
--topic test \
--partitions 3

# test 토픽의 모든 레코드 확인
bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 \
--topic test \
--from-beginning testMessage

bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic test

bin/kafka-topics.sh --create \
--bootstrap-server localhost:9092 \
--partitions 3 \
--topic stream_log

bin/kafka-console-producer.sh --bootstrap-server localhost:9092 \
--topic stream_log

bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 \
--topic stream_log_copy --from-beginning

bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 \
--topic stream_log_filter --from-beginning

# create topic
bin/kafka-topics.sh --create \
--bootstrap-server localhost:9092 \
--partitions 3 \
--topic address

# create topic
bin/kafka-topics.sh --create \
--bootstrap-server localhost:9092 \
--partitions 3 \
--topic order

bin/kafka-topics.sh --create \
--bootstrap-server localhost:9092 \
--partitions 3 \
--topic order_join

bin/kafka-console-producer.sh --bootstrap-server localhost:9092 \
--topic address \
--property "parse.key=true" \
--property "key.separator=:"

bin/kafka-console-producer.sh --bootstrap-server localhost:9092 \
--topic order \
--property "parse.key=true" \
--property "key.separator=:"

bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 \
--topic order_join \
--property print.key=true \
--property key.separator=":" \
--from-beginning

bin/kafka-topics.sh --create \
--bootstrap-server localhost:9092 \
--partitions 2 \
--topic address_v2
