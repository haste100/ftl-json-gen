import freemarker.template.Configuration;
import freemarker.template.Template;

import java.io.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import static util.ConfigurationUtil.getConfiguration;
import static util.JsonReaderUtil.getJsonObject;

/**
 * Created by haste on 06.09.16.
 */
public class FtlGenerator {

    static Logger LOG = Logger.getLogger(FtlGenerator.class.getName());

    static Config config;

    public static void main(String[] args) throws Exception {

        String configFile=null;
        for (String arg:args) {
            LOG.info(arg);
            if (arg.startsWith("-h")) {
                showHelp();
                return;
            } else if (arg.startsWith("-c")) {
                configFile = arg.substring(2, arg.length());
                LOG.info("objectsFile is "+configFile);
            }
        }

        config = (Config) getJsonObject(configFile, Config.class);

        List<String> files = config.getTemplates();

        List objects = (List) getJsonObject(config.getDataFile(), List.class);

        Map model = new HashMap();
        model.put("objects", objects);

        Configuration cfg = getConfiguration();
        for(String file:files) {

            String ftlName = getFileName(file) +".ftl";

            Template template = cfg.getTemplate(ftlName);
            Writer out = new FileWriter(new File(file));

            template.process(model, out);

            LOG.info("Generated source for "+ file);
        }

        LOG.info("Generation done.");
    }

    private static void showHelp() {
        LOG.info("Usage main -o<objects> -t<templates>\n"+
                "\t-c<json/config.json>\n" +
                "\t-h this help");
    }

    private static String getFileName(String file) {
        int index = file.indexOf(".");

        return file.substring(0, index);
    }

}
