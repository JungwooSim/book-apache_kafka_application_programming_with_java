# 2. 카프카 빠르게 시작해보기

카프카 다운로드</br>
[https://kafka.apache.org/downloads](https://kafka.apache.org/downloads)

카프카 바이너리 패키지에는 카프카 브로커에 대한 정보를 가져올 수 있는 [kafka-broker-api-version.sh](http://kafka-broker-api-version.sh) 명령어를 제공한다

```bash
./bin/kafka-broker-api-versions.sh --bootstrap-server 0.0.0.0:9092
```
### Kafka-topics.sh

kafka-topics 커맨드를 통해 topic 과 관련된 명령을 실행할 수 있다.</br>
topic 이란 카프카에서 데이터를 구분하는 가장 기본적인 개념이다. (RDBMS 에서 사용하는 테이블과 유사하다고 볼 수 있다)</br>
topic 에는 partition 이 존재하는데 partition 의 개수는 최소 1개부터 시작한다.</br>
partition 은 토픽을 구성하는데 중요한 요소이다. partition 을 통해 한 번에 처리할 수 잇는 데이터양을 늘릴 수 있고 topic 내부에서도 파티션을 통해 데이터의 종류를 나누어 처리할 수 있기 때문이다.</br>

> **토픽을 생성하는 2가지 방법**
1. 컨슈머 또는 프로듀서가 카프카 브로커에 생성되지 않은 토픽에대해 데이터를 요청할 경우</br>
2. 커맨드 라인 툴을 통해 명시적으로 토픽을 생성</br></br>

토픽을 효과적으로 유지보수 하기 위해서는 2번 방법으로 토픽을 생성하는 것을 권장한다.</br>
토픽은 데이터의 특성에 따라 옵션을 다르게 설정할 수 있다.</br>
동시 처리량이 많다면 파티션의 개수를 높게 설정하여 동시 처리량을 높일 수 있고,</br>
단기간 데이터 처리만 필요한 경우에는 데이터의 보관 기간을 짧게 설정할 수 있다.
>

**토픽 생성 및 수정**

```bash
# 토픽 생성, 조회

# 특정 서버의 카프카에 "hello" 라는 토픽 생성
bin/kafka-topics.sh --create --bootstrap-server {ip}:{port} --topic hello.kafka

bin/kafka-topics.sh \
--create \
--bootstap-server hello.kafka:9092 \
--partitions 3 \
--replication-factor 1 \
--config retention.ms = 172800000 \
--topic hello.kafka.2

# partitions : 파티션 개수를 지정할 수 있다. (최소는 1개) 만약, 옵션을 사용하지 않으면 config/server.properties)에 있는 num.partitions 옵션값을 따라 간다.
# replication-factor : 토픽의 파티션을 복제할 복제 개수 (1 은 복제를 사용하지 않는 것을 의미, 2 는 1개의 복제본을 사용하겠다는 의미), 설정하지 않으면 카프카 브로커 설정에 있는 deafult.replication.factor 옵션값을 따라 감
# config : kafka-topics.sh 명령에 포함되지 않는 추가적인 설정 가능. retention.ms 는 토픽의 데이터 유지기간이다. (172800000ms 는 2일을 ms 단위로 나타낸 것이다.) 해당 기간이 데이터는 지나면 삭제된다.

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

```

**토픽 옵션 수정**

옵션을 변경하기 위해서는 [kafka-topics.sh](http://kafka-topics.sh) 또는 [kafka-configs.sh](http://kafka-configs.sh) 두개를 사용해야 한다.
