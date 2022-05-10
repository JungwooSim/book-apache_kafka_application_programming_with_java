package connect;

import org.apache.kafka.common.config.Config;
import org.apache.kafka.common.config.ConfigDef;
import org.apache.kafka.connect.connector.ConnectorContext;
import org.apache.kafka.connect.connector.Task;
import org.apache.kafka.connect.source.SourceConnector;

import java.util.List;
import java.util.Map;

public class TestSourceConnector extends SourceConnector {

    @Override
    public String version() {
        return null;
    }

    @Override
    public void initialize(ConnectorContext ctx) {
        super.initialize(ctx);
    }

    @Override
    public void initialize(ConnectorContext ctx, List<Map<String, String>> taskConfigs) {
        super.initialize(ctx, taskConfigs);
    }

    @Override
    public void reconfigure(Map<String, String> props) {
        super.reconfigure(props);
    }

    @Override
    public Config validate(Map<String, String> connectorConfigs) {
        return super.validate(connectorConfigs);
    }

    @Override
    public void start(Map<String, String> props) {

    }

    @Override
    public Class<? extends Task> taskClass() {
        return null;
    }

    @Override
    public List<Map<String, String>> taskConfigs(int maxTasks) {
        return null;
    }

    @Override
    public void stop() {

    }

    @Override
    public ConfigDef config() {
        return null;
    }
}
