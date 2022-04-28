bin/kafka-topics.sh --bootstrap-server localhost:9092 --create \
--topic test \
--partitions 3

# test 토픽의 모든 레코드 확인
bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 \
--topic test \
--from-beginning testMessage
