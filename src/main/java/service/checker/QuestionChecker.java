package service.checker;

import model.Question;
import java.util.Map;

public interface QuestionChecker {
    boolean isAnswerCorrect(Question question, Map<String, String[]> answers);
}