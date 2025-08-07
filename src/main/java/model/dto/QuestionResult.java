package model.dto;

import java.util.List;

public class QuestionResult {
    private String questionText;
    private List<OptionResult> options;

    public QuestionResult(String questionText, List<OptionResult> options) {
        this.questionText = questionText;
        this.options = options;
    }

    public String getQuestionText() { return questionText; }
    public List<OptionResult> getOptions() { return options; }
}