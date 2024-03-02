package ru.nsk.gen.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import freemarker.cache.ClassTemplateLoader;
import freemarker.template.TemplateExceptionHandler;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AppConfig {

    @Bean
    ClassTemplateLoader loader(@Value("${ftl.base.package.path}") String basePackagePath) {
        return new ClassTemplateLoader(this.getClass(), basePackagePath);
    }

    @Bean
    freemarker.template.Configuration myFtlConfig(ClassTemplateLoader loader) {
        var configuration = new freemarker.template.Configuration(freemarker.template.Configuration.VERSION_2_3_31);
        configuration.setTemplateLoader(loader);
        configuration.setDefaultEncoding("UTF-8");
        configuration.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
        return configuration;
    }

    @Bean
    ObjectMapper objectMapper() {
        return new ObjectMapper();
    }
}