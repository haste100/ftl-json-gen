package ru.nsk.gen;

import com.fasterxml.jackson.databind.ObjectMapper;
import freemarker.template.Configuration;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.core.io.Resource;

import java.io.FileWriter;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Slf4j
@SpringBootApplication
public class Application implements CommandLineRunner {

    private final Configuration cfg;
    private final String templates;
    private final Resource dataFile;
    private final ObjectMapper objectMapper;

    public Application(@Qualifier("myFtlConfig") Configuration cfg,
                       @Value("${ftlTemplates}") String templates,
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

        var model = new HashMap<String, Object>();

        try (var isData = dataFile.getInputStream()) {
            var objects = objectMapper.readerFor(List.class).readValue(isData);
            model.put("objects", objects);
        } catch (IOException e) {
            log.error("Error read file", e);
        }

        getTemplates().forEach(
                it -> generateTemplate(it, model)
        );

        log.info("Generation done.");
    }

    @SneakyThrows
    private void generateTemplate(String file, Map<String, Object> model) {
        var ftlName = getFileName(file) +".ftl";

        var template = cfg.getTemplate(ftlName);
        var out = new FileWriter(file);

        template.process(model, out);

        log.info("Generated source for "+ file);
    }

    private List<String> getTemplates() {
        return Arrays.stream(templates.split(","))
                .collect(Collectors.toList());
    }

    private String getFileName(String file) {
        int index = file.indexOf(".");

        return file.substring(0, index);
    }
}