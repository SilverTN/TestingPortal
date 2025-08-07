package service.checker.impl;

import model.Option;
import model.Question;
import jakarta.servlet.http.HttpServletRequest;
import service.checker.QuestionChecker;

import java.util.Map;

public class SingleChoiceChecker implements QuestionChecker {

    @Override
    public boolean isAnswerCorrect(Question q, Map<String, String[]> answers) {
        String key = "question_" + q.getId();

        if (!answers.containsKey(key)) {
            return false;
        }

        int selectedId = Integer.parseInt(answers.get(key)[0]);

        for (Option o : q.getOptions()) {
            if (o.isCorrect() && o.getId() == selectedId) {
                return true;
            }
        }

        return false;
    }
}