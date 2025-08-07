package service.test;

import model.TestResult;
import model.dto.TestResultDTO;

import java.util.List;
import java.util.Map;

public interface TestResultService {
    /**
     * Рассчитывает результат теста на основе ответов пользователя
     */
    TestResult calculateResult(int userId, int testId, Map<String, String[]> answers);

    /**
     * Сохраняет результат теста в БД
     */
    void saveResult(TestResult result);

    /**
     * Возвращает историю прохождения тестов пользователем
     */
    List<TestResult> getHistoryByUser(int userId);

    /**
     * Проверяет, пройден ли тест успешно
     */
    boolean isTestPassed(TestResult result);


    /**
     * Метод для расчёта процента успешности
     */
    double calculatePercentage(TestResult result);

    TestResultDTO convertToDTO(TestResult entity);
}