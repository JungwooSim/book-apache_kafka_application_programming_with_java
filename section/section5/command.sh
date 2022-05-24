# 로컬 하둡, 엘라스틱서치, 키바나 설치
brew install hadoop elasticsearch kibana

# 토픽 생성
./bin/kafka-topics.sh --create \
--bootstrap-server localhost:9092 \
--replication-factor 2 \
--partitions 3 \
--topic select-color