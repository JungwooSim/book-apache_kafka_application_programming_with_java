## 토픽 생성 및 조회

# 특정 서버의 카프카에 "hello" 라는 토픽 생성
bin/kafka-topics.sh --create --bootstrap-server {ip}:{port} --topic hello.kafka

#토픽 생성
# partitions : 파티션 개수를 지정할 수 있다. (최소는 1개) 만약, 옵션을 사용하지 않으면 config/server.properties)에 있는 num.partitions 옵션값을 따라 간다.
# replication-factor : 토픽의 파티션을 복제할 복제 개수 (1 은 복제를 사용하지 않는 것을 의미, 2 는 1개의 복제본을 사용하겠다는 의미), 설정하지 않으면 카프카 브로커 설정에 있는 deafult.replication.factor 옵션값을 따라 감
# config : kafka-topics.sh 명령에 포함되지 않는 추가적인 설정 가능. retention.ms 는 토픽의 데이터 유지기간이다. (172800000ms 는 2일을 ms 단위로 나타낸 것이다.) 해당 기간이 데이터는 지나면 삭제된다.
bin/kafka-topics.sh \
--create \
--bootstap-server hello.kafka:9092 \
--partitions 3 \
--replication-factor 1 \
--config retention.ms = 172800000 \
--topic hello.kafka.2

# 토픽 조회
bin/kafka-topics.sh --bootstrap-server {ip}:{port} --list

# 토픽 상태 조회
bin/kafka-topics.sh --bootstrap-server {ip}:{port} --describe --topic hello.kafka.2

#bigpenguin@MacBook-Pro-3 kafka_2.13-3.1.0 % ./bin/kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic hello.kafka.2
#Topic: hello.kafka.2	TopicId: 2whI3yDhS5yZq_znVANDVA	PartitionCount: 3	ReplicationFactor: 1	Configs: segment.bytes=1073741824,retention.ms=172800000
#	Topic: hello.kafka.2	Partition: 0	Leader: 1001	Replicas: 1001	Isr: 1001
#	Topic: hello.kafka.2	Partition: 1	Leader: 1001	Replicas: 1001	Isr: 1001
#	Topic: hello.kafka.2	Partition: 2	Leader: 1001	Replicas: 1001	Isr: 1001

# Leader : 1001 브로커에 위치한다는 것을 의미
# TIP : 리더 파티션이 일부 브로커에 몰려있는 경우 카프카 클러스터 부하가 특정 브로커들로 몰릴 수 있다.

## 토픽 옵션 수정

# alter 옵션과 partitions 옵션을 함께 사용하여 파티션 개수를 변경할 수 있다.
bin/kafka-topics.sh --bootstrap-server localhost:9092 \
--topic hello.kafka \
--alter \
--partitions 4

bin/kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic hello.kafka

# retention.ms 옵션 추가 및 수정
bin/kafka-configs.sh --bootstrap-server localhost:9092 \
--entity-type topics \
--entity-name hello.kafka \
--alter --add-config retention.ms=86400000

bin/kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic hello.kafka

## 프로듀서 명령어

# hello.kafka 토픽에 레코드 추가하기 위해 kafka-console-producer.sh 실행 (key 없이 value 추가)
bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic hello.kafka

hello # key 없이 레코드 추가

# hello.kafka 토픽에 레코드 추가하기 위해 kafka-console-producer.sh 실행 (key 포함 value 추가)
bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic hello.kafka \
--property "parse.key=true" \
--property "key.separator=:" # 메시지와 키 값을 구분하는 구분자 선언 (선언하지 않을시 기본은 Tab delimiter(\t) 이다.)

key1:no1 # key 를 설정하여 추가

## 컨슈머 명령어
bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 \
--topic hello.kafka \
--from-beginning

bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 \
--topic hello.kafka \
--property print.key=true \
--property key.separator="-" \
--group hello-group \
--from-beginning

# 컨슈머 상태와 오프셋 확인
./bin/kafka-consumer-groups.sh --bootstrap-server localhost:9092 --group console-consumer-54159 --describe

# 토픽 삭제
./bin/kafka-topics.sh --bootstrap-server localhost:9092 --delete --topic hello.kafka
