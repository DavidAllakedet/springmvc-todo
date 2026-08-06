package com.todo.app.config;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class PropertiesReader {

    private final Properties properties;

    public PropertiesReader(String fileName) {
        properties = new Properties();
        try (InputStream inputStream = getClass().getClassLoader().getResourceAsStream(fileName)) {
            if (inputStream != null) {
                properties.load(inputStream);
            } else {
                throw new RuntimeException("Fichier " + fileName + " non trouvé dans le classpath");
            }
        } catch (IOException e) {
            throw new RuntimeException("Erreur de lecture du fichier " + fileName, e);
        }
    }

    public String getProperty(String key) {
        return properties.getProperty(key);
    }
}
