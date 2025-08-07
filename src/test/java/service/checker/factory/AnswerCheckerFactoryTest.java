package service.checker.factory;

import model.Question;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;
import static service.checker.factory.AnswerCheckerFactory.getChecker;

class AnswerCheckerFactoryTest {

    @Test
    void testGetSingleChoiceChecker() {
        Question q = new Question();
        q.setQuestionType(0);

        var checker = getChecker(q.getQuestionType());

        assertNotNull(checker);
        assertTrue(checker instanceof service.checker.impl.SingleChoiceChecker);
    }

    @Test
    void testGetMultipleChoiceChecker() {
        Question q = new Question();
        q.setQuestionType(1);

        var checker = getChecker(q.getQuestionType());

        assertNotNull(checker);
        assertTrue(checker instanceof service.checker.impl.MultipleChoiceChecker);
    }

    @Test
    void testUnsupportedTypeThrowsException() {
        Question q = new Question();
        q.setQuestionType(2); // Не поддерживаемый тип

        assertThrows(IllegalArgumentException.class, () -> getChecker(q.getQuestionType()));
    }

    @Test
    void testNullCheckerForInvalidType() {
        Question q = new Question();
        q.setQuestionType(-1);

        Exception exception = assertThrows(IllegalArgumentException.class, () -> getChecker(q.getQuestionType()));

        String expectedMessage = "Неизвестный тип вопроса";
        String actualMessage = exception.getMessage();

        assertTrue(actualMessage.contains(expectedMessage));
    }
}