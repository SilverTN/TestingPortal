package model.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class TestResultDTO {
    private final int testId;
    private final int userId;
    private final String username;
    private final String testName;
    private final int score;
    private final int totalQuestions;
    private final double percentage;
    private final String passedAt;

    public TestResultDTO(int testId, int userId, String username, String testName, int score, int totalQuestions, String passedAt) {
        this.testId = testId;
        this.userId = userId;
        this.username = username;
        this.testName = testName;
        this.score = score;
        this.totalQuestions = totalQuestions;
        this.percentage = ((double) score / totalQuestions) * 100;
        this.passedAt = passedAt;
    }
}
