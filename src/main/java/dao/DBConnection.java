package dao;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import lombok.SneakyThrows;
import java.io.InputStream;
import java.sql.Connection;
import java.util.Properties;

/**
 * Устаревший способ подключения к БД напрямую через DriverManager.
 *
 * <p>Этот класс оставлен для образовательных и исторических целей:
 * <ul>
 *   <li>Показывает, как работать с JDBC без Spring и пулов соединений</li>
 *   <li>Помогает понять основы: Connection, PreparedStatement, ResultSet</li>
 *   <li>Может использоваться для быстрого понимания "ручного" доступа к БД</li>
 * </ul>
 *
 * <p>⚠️ <strong>Внимание:</strong> В текущем проекте <strong>не используйте этот класс</strong> для основной логики.
 * Вместо этого используйте:
 * <ul>
 *   <li>{@link DataSourceConfig} — для получения пула соединений через HikariCP</li>
 *   <li>{@link org.springframework.jdbc.core.JdbcTemplate} — для безопасной и чистой работы с БД</li>
 * </ul>
 *
 * <p>Этот класс может быть удалён в будущем, если не будет использоваться.
 */

public class DBConnection {

    private static final String PROPERTIES_FILE = "db.properties";
    private static HikariDataSource dataSource;

    // Инициализация пула соединений
    static {
        try {

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
            config.setMaximumPoolSize(Integer.parseInt(
            props.getProperty("db.pool.size", "10")));
            config.setDriverClassName(props.getProperty("db.driver","org.postgresql.Driver"));
            config.addDataSourceProperty("db.cachePrepStmts","true");
            config.addDataSourceProperty("db.prepStmtCacheSize","250");
            config.addDataSourceProperty("db.prepStmtCacheSqlLimit","2048");

            dataSource = new HikariDataSource(config);

        } catch (Exception e) {
            throw new ExceptionInInitializerError("Ошибка инициализации HikariDataSource: " + e.getMessage());
        }
    }

    // Получение Connection
    @SneakyThrows
    public static Connection getConnection() {
        return dataSource.getConnection();
    }


    // Закрытие пула
    public static void closeConnection() {
        if (dataSource != null && !dataSource.isClosed()) {
            dataSource.close();
        }
    }

    // Загрузка свойств из db.properties
    private static Properties loadProperties() throws Exception {
        try (InputStream input = DBConnection.class.getClassLoader().getResourceAsStream(PROPERTIES_FILE)) {
            if (input == null) {
                throw new RuntimeException("File " + PROPERTIES_FILE + " not found in classpath");
            }
            Properties props = new Properties();
            props.load(input);
            return props;
        }
    }
}

