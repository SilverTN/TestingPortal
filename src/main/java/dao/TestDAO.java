package dao;

import model.*;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import java.sql.*;
import java.util.*;

public class TestDAO {

    private final JdbcTemplate jdbcTemplate = DataSourceConfig.getJdbcTemplate();
    private static final TestDAO INSTANCE = new TestDAO();

    public static TestDAO getInstance() {
        return INSTANCE;
    }

    RowMapper<Test> testRowMapper = new BeanPropertyRowMapper<>(Test.class);
    RowMapper<Question> questionRowMapper = new BeanPropertyRowMapper<>(Question.class);
    RowMapper<Option> optionRowMapper = new BeanPropertyRowMapper<>(Option.class);
    RowMapper<TestResult> testResultWithUserRowMapper = new BeanPropertyRowMapper<>(TestResult.class);


    /**
     * Получить все тесты
     */
    public List<Test> getAllTests() {
        String sql = "SELECT * FROM tests";
        return jdbcTemplate.query(sql, testRowMapper);
    }


    /**
     * Получить тест по ID вместе с вопросами и вариантами
     */
    public Test getTestById(int testId) {
        String sqlTest = "SELECT * FROM tests WHERE id = ?";
        String sqlQuestions = "SELECT * FROM questions WHERE test_id = ?";
        String sqlOptions = "SELECT * FROM options WHERE question_id = ?";

        try {
            Test test = jdbcTemplate.queryForObject(sqlTest, testRowMapper, testId);

            if (test == null) return null;

            List<Question> questions = jdbcTemplate.query(
                    sqlQuestions,
                    (rs, rowNum) -> {
                        Question q = questionRowMapper.mapRow(rs, rowNum);
                        List<Option> options = getOptionsByQuestionId(q.getId());
                        q.setOptions(options);
                        return q;
                    },
                    testId
            );

            test.setQuestions(questions);
            return test;

        } catch (Exception e) {
            return null;
        }
    }


    /**
     * Добавить новый тест
     */
    public void addTest(Test test) {
        String sqlTest = "INSERT INTO tests(title, description) VALUES (?, ?)";
        String sqlQuestion = "INSERT INTO questions(test_id, text, question_type) VALUES (?, ?, ?)";
        String sqlOption = "INSERT INTO options(question_id, text, is_correct) VALUES (?, ?, ?)";

        try {
            // Вставляем тест
            jdbcTemplate.update(sqlTest, test.getTitle(), test.getDescription());

            Integer testId = jdbcTemplate.queryForObject(
                    "SELECT currval(pg_get_serial_sequence('tests', 'id'))", Integer.class);

            // Вставляем вопросы и варианты ответов
            for (Question q : test.getQuestions()) {
                jdbcTemplate.update(sqlQuestion, testId, q.getText(), q.getQuestionType());

                Integer questionId = jdbcTemplate.queryForObject(
                        "SELECT currval(pg_get_serial_sequence('questions', 'id'))", Integer.class);

                for (Option o : q.getOptions()) {
                    jdbcTemplate.update(sqlOption, questionId, o.getText(), o.isCorrect());
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    /**
     * Обновить тест
     */
    public void updateTest(Test test) {
        String sql = "UPDATE tests SET title = ?, description = ? WHERE id = ?";
        jdbcTemplate.update(sql, test.getTitle(), test.getDescription(), test.getId());
    }


    /**
     * Удалить тест
     */
    public void deleteTest(int testId) {
        String sql = "DELETE FROM tests WHERE id = ?";
        jdbcTemplate.update(sql, testId);
    }


    /**
     * Обновить вопросы и варианты теста
     */
    public void updateTestQuestions(int testId, List<Question> questions) {
        String deleteOptions = "DELETE FROM options WHERE question_id IN (SELECT id FROM questions WHERE test_id = ?)";
        String deleteQuestions = "DELETE FROM questions WHERE test_id = ?";
        String insertQuestion = "INSERT INTO questions(test_id, text, question_type) VALUES (?, ?, ?)";
        String insertOption = "INSERT INTO options(question_id, text, is_correct) VALUES (?, ?, ?)";

        try {
            // Удаляем старые данные
            jdbcTemplate.update(deleteOptions, testId);
            jdbcTemplate.update(deleteQuestions, testId);

            // Вставляем новые вопросы
            for (Question q : questions) {
                jdbcTemplate.update(insertQuestion, testId, q.getText(), q.getQuestionType());

                Integer questionId = jdbcTemplate.queryForObject(
                        "SELECT currval(pg_get_serial_sequence('questions', 'id'))", Integer.class);

                // Вставляем варианты
                for (Option o : q.getOptions()) {
                    jdbcTemplate.update(insertOption, questionId, o.getText(), o.isCorrect());
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }



    /**
     * Сохранить результат прохождения теста
     */
    public void saveTestResult(int userId, int testId, int score, int totalQuestions) {
        String sql = "INSERT INTO test_results (user_id, test_id, score, total_questions, passed_at) " +
                "VALUES (?, ?, ?, ?, NOW()) " +
                "ON CONFLICT (user_id, test_id) DO UPDATE SET " +
                "score = EXCLUDED.score, " +
                "total_questions = EXCLUDED.total_questions, " +
                "passed_at = EXCLUDED.passed_at";

        jdbcTemplate.update(sql, userId, testId, score, totalQuestions);
    }


    /**
     * Получить результаты теста по testId
     */
    public List<TestResult> getTestResultsByTestId(int testId) {
        String sql = "SELECT tr.id, tr.user_id, tr.test_id, tr.score, tr.total_questions, tr.passed_at, u.username, t.title " +
                "FROM test_results tr " +
                "JOIN users u ON tr.user_id = u.id " +
                "JOIN tests t ON tr.test_id = t.id " +
                "WHERE tr.test_id = ? " +
                "ORDER BY tr.passed_at DESC";

        return jdbcTemplate.query(sql, testResultWithUserRowMapper, testId);
    }


    /**
     * Получить заголовок теста по ID
     */
    public String getTestTitleById(int testId) {
        String sql = "SELECT title FROM tests WHERE id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, String.class, testId);
        } catch (Exception e) {
            return "Тест #" + testId;
        }
    }


    /**
     * Построить карту ответов пользователя
     */
    public Map<Integer, List<Boolean>> buildUserAnswersMap(int userId, int testId, Map<Integer, List<UserAnswer>> answersMap) {
        Map<Integer, List<Boolean>> result = new HashMap<>();
        List<Question> questions = getQuestionsByTestId(testId);

        for (Question q : questions) {
            List<Boolean> answerResults = new ArrayList<>();
            List<UserAnswer> userAnswers = answersMap.getOrDefault(q.getId(), Collections.emptyList());

            Map<Integer, Boolean> userAnswerMap = new HashMap<>();
            for (UserAnswer ans : userAnswers) {
                userAnswerMap.put(ans.getOptionId(), ans.isSelected());
            }

            for (Option o : q.getOptions()) {
                answerResults.add(userAnswerMap.getOrDefault(o.getId(), false));
            }

            result.put(q.getId(), answerResults);
        }

        return result;
    }

    public List<Question> getQuestionsByTestId(int testId) {
        List<Question> questions = new ArrayList<>();
        String sql = "SELECT * FROM questions WHERE test_id = ?";
        String sqlOptions = "SELECT * FROM options WHERE question_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, testId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Question q = new Question();
                q.setId(rs.getInt("id"));
                q.setTestId(testId);
                q.setText(rs.getString("text"));
                q.setQuestionType(rs.getInt("question_type"));

                // Загрузка вариантов ответов
                List<Option> options = getOptionsByQuestionId(q.getId());
                q.setOptions(options);

                questions.add(q);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return questions;
    }


    public List<Option> getOptionsByQuestionId(int questionId) {
        List<Option> options = new ArrayList<>();
        String sql = "SELECT * FROM options WHERE question_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, questionId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Option o = new Option();
                o.setId(rs.getInt("id"));
                o.setQuestionId(questionId);
                o.setText(rs.getString("text"));
                o.setCorrect(rs.getBoolean("is_correct"));
                options.add(o);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return options;
    }


    /**
     * Получить результат теста пользователя
     */
    public TestResult getTestResult(int userId, int testId) {
        String sql = "SELECT tr.*, u.username, t.title " +
                "FROM test_results tr " +
                "JOIN users u ON tr.user_id = u.id " +
                "JOIN tests t ON tr.test_id = t.id " +
                "WHERE tr.user_id = ? AND tr.test_id = ?";

        try {
            return jdbcTemplate.queryForObject(sql, testResultWithUserRowMapper, userId, testId);
        } catch (Exception e) {
            return null;
        }
    }


    /**
     * Получить историю прохождения тестов пользователем
     */
    public List<TestResult> getTestResultsByUserId(int userId) {
        String sql = "SELECT tr.test_id, tr.score, tr.total_questions, tr.passed_at, u.username, t.title " +
                "FROM test_results tr " +
                "JOIN tests t ON tr.test_id = t.id " +
                "JOIN users u ON tr.user_id = u.id " +
                "WHERE tr.user_id = ? " +
                "ORDER BY tr.passed_at DESC";

        return jdbcTemplate.query(sql, testResultWithUserRowMapper, userId);
    }


    /**
     * Получить все результаты тестов
     */
    public List<TestResult> getAllTestResults() {
        String sql = "SELECT tr.id, tr.user_id, tr.test_id, tr.score, tr.total_questions, tr.passed_at, u.username, t.title " +
                "FROM test_results tr " +
                "JOIN users u ON tr.user_id = u.id " +
                "JOIN tests t ON tr.test_id = t.id";

        return jdbcTemplate.query(sql, testResultWithUserRowMapper);
    }

    public TestResult getUserTestResult(int userId, int testId) {
        String sql = "SELECT * FROM test_results WHERE user_id = ? AND test_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userId);
            pstmt.setInt(2, testId);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                TestResult result = new TestResult();
                result.setId(rs.getInt("id"));
                result.setUserId(rs.getInt("user_id"));
                result.setTestId(rs.getInt("test_id"));
                result.setScore(rs.getInt("score"));
                result.setTotalQuestions(rs.getInt("total_questions"));
                result.setPassedAt(rs.getTimestamp("passed_at"));

                return result;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public List<Map<String, Object>> getTopUsersByScore() {
        String sql = "SELECT u.username, AVG(tr.score * 100 / tr.total_questions) AS avg_percentage " +
                     "FROM test_results tr " +
                     "JOIN users u ON tr.user_id = u.id " +
                     "GROUP BY u.id, u.username " +
                     "ORDER BY avg_percentage DESC LIMIT 5";

        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            Map<String, Object> row = new HashMap<>();
            row.put("username", rs.getString("username"));
            row.put("avgPercentage", rs.getDouble("avg_percentage"));
            return row;
        });
    }

}
