package util;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectReader;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;

import static com.fasterxml.jackson.core.JsonParser.Feature.ALLOW_COMMENTS;

/**
 * Created by haste on 16.09.16.
 */
public class JsonReaderUtil {

    static final ObjectMapper mapper = new ObjectMapper();

    static {
        mapper.configure(ALLOW_COMMENTS, true);
    }

    public static List getJsonObjects(String fileName) throws IOException {
        InputStream isData = getResourceAsStream(fileName);
        ObjectReader reader = mapper.readerFor(List.class);
        return reader.readValue(isData);
    }

    static InputStream getResourceAsStream(String fileName) {
        return JsonReaderUtil.class.getClassLoader().getResourceAsStream(fileName);
    }

}
