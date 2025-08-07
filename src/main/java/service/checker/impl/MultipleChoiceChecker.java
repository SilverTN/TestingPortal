package service.checker.impl;

import model.Option;
import model.Question;
import jakarta.servlet.http.HttpServletRequest;
import service.checker.QuestionChecker;

import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

//public class MultipleChoiceChecker implements QuestionChecker {
//
//    @Override
//    public boolean isAnswerCorrect(Question q, Map<String, String[]> answers) {
//        // Все правильные варианты
//        List<Option> correctOptions = q.getOptions().stream()
//                .filter(Option::isCorrect)
//                .toList();
//
//        Set<Integer> selectedIds = new HashSet<>();
//        for (Option o : q.getOptions()) {
//            String key = "question_" + q.getId() + "_option_" + o.getId();
//            if (answers.containsKey(key)) {
//                selectedIds.add(o.getId());
//            }
//        }
//
//        // Пользователь должен выбрать ровно столько же вариантов, сколько правильных
//        return selectedIds.size() == correctOptions.size() &&
//                selectedIds.containsAll(correctOptions.stream().map(Option::getId).toList());
//    }
//
//}

public class MultipleChoiceChecker implements QuestionChecker {
    @Override
    public boolean isAnswerCorrect(Question question, Map<String, String[]> answers) {
        List<Option> correctOptions = question.getOptions().stream()
                .filter(Option::isCorrect)
                .toList();

        List<Option> incorrectOptions = question.getOptions().stream()
                .filter(opt -> !opt.isCorrect())
                .toList();

        // Проверяем, что все правильные выбраны
        boolean allCorrectSelected = correctOptions.stream()
                .allMatch(opt -> isOptionSelected(answers, question.getId(), opt.getId()));

        // Проверяем, что ни один неправильный не выбран
        boolean noIncorrectSelected = incorrectOptions.stream()
                .noneMatch(opt -> isOptionSelected(answers, question.getId(), opt.getId()));

        return allCorrectSelected && noIncorrectSelected;
    }

    private boolean isOptionSelected(Map<String, String[]> answers, int questionId, int optionId) {
        String key = "question_" + questionId + "_option_" + optionId;
        return answers.containsKey(key);
    }
}
