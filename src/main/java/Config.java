import util.JsonReaderUtil;

import java.util.List;
import java.util.Map;

/**
 * Created by haste on 23.09.16.
 */
public class Config {

    Map config;

    public Config(Map jsonMap) {
        this.config=jsonMap;
    }

    public static Config create(String fileName) {
        if (fileName == null) {
            throw new IllegalStateException("Config file required");
        }
        Map jsonMap = JsonReaderUtil.getJsonObject(fileName);
        if (jsonMap == null) {
            throw new IllegalStateException("Config required");
        }
        return new Config(jsonMap);
    }

    public String getDataFile() {
        return (String) config.get("dataFile");
    }

    public List getTemplates() {
        return (List) config.get("templates");
    }

}
