import freemarker.template.Configuration;
import freemarker.template.Template;

import java.io.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import static util.ConfigurationUtil.getConfiguration;
import static util.JsonReaderUtil.getJsonObjects;

/**
 * Created by haste on 06.09.16.
 */
public class FtlGenerator {

    static Logger LOG = Logger.getLogger(FtlGenerator.class.getName());

    static final String OBJECT_PROPERTIES_JSON = "json/object_properties.json";
    static final String FILES_JSON = "json/files.json";

    public static void main(String[] args) throws Exception {

        Configuration cfg = getConfiguration();

        List<Map> files = getJsonObjects(FILES_JSON);

        List<Map> objects = getJsonObjects(OBJECT_PROPERTIES_JSON);

        for(Map<String, String> file:files) {

            String name = file.get("name");
            String extension = file.get("ext");

            String ftlName = name+".ftl";
            String outName = name+'.'+ extension;

            Template template = cfg.getTemplate(ftlName);
            Writer out = new FileWriter(new File(outName));

            Map model = new HashMap();
            model.put("objects", objects);

            template.process(model, out);

            LOG.info("Generated source for "+outName);
        }

        LOG.info("Generation done.");
    }

}
