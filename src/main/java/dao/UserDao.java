package dao;

import model.User;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import java.util.List;

public class UserDao {

    private final JdbcTemplate jdbcTemplate = DataSourceConfig.getJdbcTemplate();

    // BeanPropertyRowMapper (если названия колонок = названиям полей)
    RowMapper<User> userRowMapper = new BeanPropertyRowMapper<>(User.class);


    // RowMapper для User
    //    private final RowMapper<User> userRowMapper = new RowMapper<>() {
    //        @Override
    //        public User mapRow(ResultSet rs, int rowNum) throws SQLException {
    //            User user = new User();
    //            user.setId(rs.getInt("id"));
    //            user.setUsername(rs.getString("username"));
    //            user.setPasswordHash(rs.getString("password_hash"));
    //            user.setEmail(rs.getString("email"));
    //            user.setRole(rs.getInt("role"));
    //            return user;
    //        }
    //    };

    /**
     * Получить пользователя по имени
     */
    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        try {
            return jdbcTemplate.queryForObject(sql, userRowMapper, username);
        } catch (Exception e) {
            return null;
        }
    }

    /**
     * Регистрация нового пользователя
     */
    public boolean registerUser(String username, String passwordHash, String email) {
        if (isUsernameExists(username)) {
            return false;
        }

        String sql = "INSERT INTO users(username, password_hash, email) VALUES (?, ?, ?)";
        try {
            jdbcTemplate.update(sql, username, passwordHash, email);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Получить список всех пользователей
     */
    public List<User> getAllUsers() {
        String sql = "SELECT id, username FROM users";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            User user = new User();
            user.setId(rs.getInt("id"));
            user.setUsername(rs.getString("username"));
            return user;
        });
    }

    /**
     * Проверить, существует ли пользователь
     */
    public boolean isUsernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM users WHERE username = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, username);
        return count != null && count > 0;
    }


    /**
     * Обновить роль пользователя
     */
    public void updateUserRole(int userId, int role) {
        String sql = "UPDATE users SET role = ? WHERE id = ?";
        jdbcTemplate.update(sql, role, userId);
    }

    /**
     * Получить пользователя по ID
     */
    public User getUserById(int userId) {
        String sql = "SELECT * FROM users WHERE id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, userRowMapper, userId);
        } catch (Exception e) {
            return null;
        }
    }
}
