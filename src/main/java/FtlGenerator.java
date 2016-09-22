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

    public static void main(String[] args) throws Exception {

        String objectsFile="", templatesFile = "";

        for (String arg:args) {
            LOG.info(arg);
            if (arg.startsWith("-h")) {
                showHelp();
                return;
            } else if (arg.startsWith("-o")) {
                objectsFile = arg.substring(2, arg.length());
                LOG.info("objectsFile is "+objectsFile);
            } else if (arg.startsWith("-t")) {
                templatesFile = arg.substring(2, arg.length());
                LOG.info("templatesFile is "+templatesFile);
            }
        }

        if ((templatesFile == null) || (templatesFile.length()==0)) {
            LOG.info("No templates file!");
            return;
        }
        if ((objectsFile == null) || (objectsFile.length()==0)) {
            LOG.info("No objects file!");
            return;
        }
        List<String> files = getJsonObjects(templatesFile);

        List<Map> objects = getJsonObjects(objectsFile);

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
                "\t-o<objects>\n" +
                "\t-t<templates>\n" +
                "\t-h this help");
    }

    private static String getFileName(String file) {
        int index = file.indexOf(".");

        return file.substring(0, index);
    }

}
