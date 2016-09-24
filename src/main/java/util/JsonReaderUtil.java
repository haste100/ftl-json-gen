package util;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectReader;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import static com.fasterxml.jackson.core.JsonParser.Feature.ALLOW_COMMENTS;

/**
 * Created by haste on 16.09.16.
 */
public class JsonReaderUtil {

    static Logger LOG = Logger.getLogger(JsonReaderUtil.class.getName());

    static final ObjectMapper mapper = new ObjectMapper();

    static {
        mapper.configure(ALLOW_COMMENTS, true);
    }

    public static Object getJsonObject(String fileName, Class aClass) {
        InputStream isData = getResourceAsStream(fileName);
        ObjectReader reader = mapper.readerFor(aClass);
        try {
            return reader.readValue(isData);
        } catch (IOException e) {
            LOG.log(Level.WARNING, "Error read file", e);
        }
        return null;
    }

    static InputStream getResourceAsStream(String fileName) {
        return JsonReaderUtil.class.getClassLoader().getResourceAsStream(fileName);
    }

}
