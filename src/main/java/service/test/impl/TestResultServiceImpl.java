package service.test.impl;

import dao.TestDAO;
import model.Question;
import model.Test;
import model.TestResult;
import model.dto.TestResultDTO;
import service.test.TestResultService;
import service.checker.QuestionChecker;
import service.checker.factory.AnswerCheckerFactory;
import java.sql.Timestamp;
import java.util.*;

public class TestResultServiceImpl implements TestResultService {

    private final TestDAO testDAO = new TestDAO();

    @Override
    public TestResult calculateResult(int userId, int testId, Map<String, String[]> answers) {
        Test test = testDAO.getTestById(testId);
        if (test == null || test.getQuestions() == null) return null;

        int score = 0;
        for (Question q : test.getQuestions()) {
            QuestionChecker checker = AnswerCheckerFactory.getChecker(q.getQuestionType());
            if (checker != null && checker.isAnswerCorrect(q, answers)) {
                score++;
            }
        }

        Timestamp passedAt = new Timestamp(System.currentTimeMillis());

        return TestResult.builder()
                .userId(userId)
                .testId(testId)
                .score(score)
                .totalQuestions(test.getQuestions().size())
                .passedAt(passedAt)
                .build();
    }

    @Override
    public void saveResult(TestResult result) {
        if (result == null) return;

        testDAO.saveTestResult(result.getUserId(), result.getTestId(), result.getScore(), result.getTotalQuestions());
    }

    @Override
    public List<TestResult> getHistoryByUser(int userId) {
        return testDAO.getTestResultsByUserId(userId);
    }

    @Override
    public boolean isTestPassed(TestResult result) {
        if (result.getTotalQuestions() == 0) return false;
        double percentage = ((double) result.getScore() / result.getTotalQuestions()) * 100;
        return percentage >= 75;
    }

    @Override
    public double calculatePercentage(TestResult result) {
        if (result.getTotalQuestions() == 0) return 0;
        return ((double) result.getScore() / result.getTotalQuestions()) * 100;
    }

    @Override
    public TestResultDTO convertToDTO(TestResult entity) {
        return new TestResultDTO(
                entity.getTestId(),
                entity.getUserId(),
                entity.getUsername(),
                entity.getTitle(),
                entity.getScore(),
                entity.getTotalQuestions(),
                entity.getPassedAtFormattedDate()
        );
    }
}