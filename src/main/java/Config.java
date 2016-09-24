
import java.util.List;

/**
 * Created by haste on 23.09.16.
 */
public class Config {

    String dataFile;
    List templates;

    public String getDataFile() {
        return dataFile;
    }

    public List getTemplates() {
        return templates;
    }

    public void setDataFile(String dataFile) {
        this.dataFile = dataFile;
    }

    public void setTemplates(List templates) {
        this.templates = templates;
    }
}
