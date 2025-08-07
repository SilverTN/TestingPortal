package model;

import lombok.*;
import util.formatter.DateFormatter;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class TestResult {

    private int id;
    private int userId;
    private int testId;
    private int score;
    private int totalQuestions;
    private Timestamp passedAt;
    private String username;
    private String title;

    public TestResult(int userId, int testId, int score, int totalQuestions, Timestamp passedAt) {
        this.userId = userId;
        this.testId = testId;
        this.score = score;
        this.totalQuestions = totalQuestions;
        this.passedAt = passedAt;
    }

    public double getPercentage() {
        return totalQuestions == 0 ? 0 : ((double) score / totalQuestions) * 100;
    }

    public String getPassedAtFormattedDate() {
        return DateFormatter.format(passedAt);
    }
}