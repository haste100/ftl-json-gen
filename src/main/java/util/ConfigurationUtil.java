package util;

import freemarker.cache.ClassTemplateLoader;
import freemarker.template.Configuration;
import freemarker.template.TemplateExceptionHandler;

public class ConfigurationUtil {

    private static Configuration configuration;

    public static final String BASE_PACKAGE_PATH = "/ftl";

    static {
        ClassTemplateLoader loader = new ClassTemplateLoader(
                new ConfigurationUtil().getClass(), BASE_PACKAGE_PATH);
        configuration = new Configuration(Configuration.VERSION_2_3_23);
        configuration.setTemplateLoader(loader);
        configuration.setDefaultEncoding("UTF-8");
        configuration.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
    }
    public static Configuration getConfiguration() {
        return configuration;
    }
} 