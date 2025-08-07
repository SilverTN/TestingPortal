package service.checker.factory;

import service.checker.QuestionChecker;
import service.checker.impl.SingleChoiceChecker;
import service.checker.impl.MultipleChoiceChecker;

public class AnswerCheckerFactory {
    public static QuestionChecker getChecker(int questionType) {
        switch (questionType) {
            case 0: return new SingleChoiceChecker();
            case 1: return new MultipleChoiceChecker();
            default: throw new IllegalArgumentException("Неизвестный тип вопроса" + questionType);
        }
    }
}