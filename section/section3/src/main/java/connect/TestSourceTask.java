package connect;

import org.apache.kafka.clients.producer.RecordMetadata;
import org.apache.kafka.connect.source.SourceRecord;
import org.apache.kafka.connect.source.SourceTask;
import org.apache.kafka.connect.source.SourceTaskContext;

import java.util.List;
import java.util.Map;

public class TestSourceTask extends SourceTask {

    @Override
    public String version() {
        return null;
    }

    public TestSourceTask() {
        super();
    }

    @Override
    public void initialize(SourceTaskContext context) {
        super.initialize(context);
    }

    @Override
    public void commit() throws InterruptedException {
        super.commit();
    }

    @Override
    public void commitRecord(SourceRecord record, RecordMetadata metadata) throws InterruptedException {
        super.commitRecord(record, metadata);
    }

    @Override
    public void start(Map<String, String> props) {

    }

    @Override
    public List<SourceRecord> poll() throws InterruptedException {
        return null;
    }

    @Override
    public void stop() {

    }
}
