package dao;

import model.Option;
import model.Question;
import model.TestResult;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import service.checker.QuestionChecker;
import service.checker.factory.AnswerCheckerFactory;
import service.checker.impl.MultipleChoiceChecker;
import service.checker.impl.SingleChoiceChecker;
import java.util.*;

public class UserAnswerDAO {

    private final JdbcTemplate jdbcTemplate = DataSourceConfig.getJdbcTemplate();

    // BeanPropertyRowMapper (если названия колонок = названиям полей)
    RowMapper<Option> userRowMapper = new BeanPropertyRowMapper<>(Option.class);

    /**
     * Получить все ответы пользователя по тесту
     */
    public Map<Integer, Map<Integer, Boolean>> getUserAnswers(int userId, int testId) {
        String sql = "SELECT question_id, option_id, is_selected FROM test_results_answers WHERE user_id = ? AND test_id = ?";
        Map<Integer, Map<Integer, Boolean>> answers = new HashMap<>();

        List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql, userId, testId);

        for (Map<String, Object> row : rows) {
            Integer questionId = (Integer) row.get("question_id");
            Integer optionId = (Integer) row.get("option_id");
            Boolean isSelected = (Boolean) row.get("is_selected");

            answers.computeIfAbsent(questionId, k -> new HashMap<>()).put(optionId, isSelected);
        }

        return answers;
    }


    /**
     * Удалить старые ответы пользователя
     */
    public void deleteUserAnswers(int userId, int testId) {
        String sql = "DELETE FROM test_results_answers WHERE user_id = ? AND test_id = ?";
        jdbcTemplate.update(sql, userId, testId);
    }

    /**
     * Сохранить новые ответы пользователя
     */
    public void saveUserAnswers(int userId, int testId, List<Question> questions, Map<String, String[]> answers) {
        String insertSql = "INSERT INTO test_results_answers (user_id, test_id, question_id, option_id, is_selected) VALUES (?, ?, ?, ?, ?)";

        try {
            // 1. Удалить старые ответы
            deleteUserAnswers(userId, testId);

            List<Object[]> batchArgs = new ArrayList<>();
            // 2. Вставить новые ответы
            for (Question q : questions) {
                QuestionChecker checker = AnswerCheckerFactory.getChecker(q.getQuestionType());

                if (checker instanceof SingleChoiceChecker) {
                    String key = "question_" + q.getId();
                    if (answers.containsKey(key) && answers.get(key).length > 0) {
                        int selectedOptionId = Integer.parseInt(answers.get(key)[0]);

                        for (Option o : q.getOptions()) {
                            boolean isSelected = o.getId() == selectedOptionId;
                            batchArgs.add(new Object[]{userId, testId, q.getId(), o.getId(), isSelected});
                        }
                    }

                } else if (checker instanceof MultipleChoiceChecker) {
                    for (Option o : q.getOptions()) {
                        String key = "question_" + q.getId() + "_option_" + o.getId();
                        boolean isSelected = answers.containsKey(key);
                        batchArgs.add(new Object[]{userId, testId, q.getId(), o.getId(), isSelected});
                    }
                }
            }
            // Выполнить одним запросом
            jdbcTemplate.batchUpdate(insertSql, batchArgs);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /** Пока не используемые методы */

    /**
     * Получить результаты теста пользователя (score, total_questions и т.д.)
     */
    public TestResult getTestResult(int userId, int testId) {
        String sql = "SELECT tr.* FROM test_results tr WHERE tr.user_id = ? AND tr.test_id = ?";
        return jdbcTemplate.queryForObject(sql, (rs, rowNum) -> {
            TestResult result = new TestResult();
            result.setId(rs.getInt("id"));
            result.setUserId(rs.getInt("user_id"));
            result.setTestId(rs.getInt("test_id"));
            result.setScore(rs.getInt("score"));
            result.setTotalQuestions(rs.getInt("total_questions"));
            result.setPassedAt(rs.getTimestamp("passed_at"));
            return result;
        }, userId, testId);
    }

    /**
     * Получить список всех вопросов с ответами пользователя
     */
    public Map<Integer, Map<Integer, Boolean>> getAllUserAnswers(int userId, int testId) {
        String sql = "SELECT question_id, option_id, is_selected FROM test_results_answers WHERE user_id = ? AND test_id = ?";
        Map<Integer, Map<Integer, Boolean>> answers = new HashMap<>();

        jdbcTemplate.query(sql, rs -> {
            int questionId = rs.getInt("question_id");
            int optionId = rs.getInt("option_id");
            boolean isSelected = rs.getBoolean("is_selected");

            answers.computeIfAbsent(questionId, k -> new HashMap<>()).put(optionId, isSelected);
        }, userId, testId);

        return answers;
    }
}