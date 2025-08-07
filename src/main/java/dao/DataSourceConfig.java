package dao;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.springframework.jdbc.core.JdbcTemplate;

import java.io.InputStream;
import java.util.Properties;

public class DataSourceConfig {
    private static final String PROPERTIES_FILE = "db.properties";
    private static HikariDataSource dataSource;
    private static JdbcTemplate jdbcTemplate;

    public static JdbcTemplate getJdbcTemplate() {
        if (jdbcTemplate == null) {
            jdbcTemplate = new JdbcTemplate(getDataSource());
        }
        return jdbcTemplate;
    }

    public static HikariDataSource getDataSource() {
        if (dataSource == null || dataSource.isClosed()) {
            Properties props = loadProperties();
            HikariConfig config = new HikariConfig();

            // 1. Определяем URL
            String url = System.getenv("DB_URL");
            config.setJdbcUrl(url);
            if (url == null || url.isEmpty()) {
                config.setJdbcUrl(props.getProperty("db.url"));
            }

            config.setUsername(props.getProperty("db.user"));
            config.setPassword(props.getProperty("db.password"));
            config.setDriverClassName("org.postgresql.Driver");
            config.setMaximumPoolSize(Integer.parseInt(
                    props.getProperty("db.pool.size", "10")));

            dataSource = new HikariDataSource(config);
        }
        return dataSource;
    }

    private static Properties loadProperties() {
        try (InputStream input = DataSourceConfig.class.getClassLoader()
                .getResourceAsStream(PROPERTIES_FILE)) {
            if (input == null) {
                throw new RuntimeException("File " + PROPERTIES_FILE + " not found in classpath");
            }
            Properties props = new Properties();
            props.load(input);
            return props;
        } catch (Exception e) {
            throw new RuntimeException("Error loading database properties", e);
        }
    }

    public static void closeDataSource() {
        if (dataSource != null && !dataSource.isClosed()) {
            dataSource.close();
        }
    }
}