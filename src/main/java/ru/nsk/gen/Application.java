package ru.nsk.gen;

import com.fasterxml.jackson.databind.ObjectMapper;
import freemarker.template.Configuration;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import lombok.val;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.core.io.Resource;

import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Slf4j
@SpringBootApplication
public class Application implements CommandLineRunner {

    private final Configuration cfg;
    private final Set<String> templates;
    private final Resource dataFile;
    private final ObjectMapper objectMapper;

    public Application(@Qualifier("myFtlConfig") Configuration cfg,
                       @Value("${ftlTemplates}") Set<String> templates,
                       @Value("${dataFile}") Resource dataFile,
                       ObjectMapper objectMapper) {
        this.cfg = cfg;
        this.templates = templates;
        this.dataFile = dataFile;
        this.objectMapper = objectMapper;
    }

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

    @Override
    public void run(String... args) throws Exception {

        val model = new HashMap<String, Object>();

        try (val isData = dataFile.getInputStream()) {
            val objects = objectMapper.readerFor(List.class).readValue(isData);
            model.put("objects", objects);
        } catch (IOException e) {
            log.error("Error read file", e);
        }

        templates.forEach(
                it -> generateTemplate(it, model)
        );

        log.info("Generation done.");
    }

    @SneakyThrows
    private void generateTemplate(String file, Map<String, Object> model) {
        val ftlName = getFileName(file) +".ftl";

        val template = cfg.getTemplate(ftlName);
        val out = new FileWriter(file);

        template.process(model, out);

        log.info("Generated source for {}", file);
    }

    private String getFileName(String file) {
        val index = file.indexOf(".");

        return file.substring(0, index);
    }
}