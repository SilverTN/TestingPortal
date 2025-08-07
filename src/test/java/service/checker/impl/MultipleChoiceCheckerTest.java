package service.checker.impl;

import model.Option;
import model.Question;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import jakarta.servlet.http.HttpServletRequest;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@DisplayName("Тесты для MultipleChoiceChecker — проверка логики множественного выбора")
class MultipleChoiceCheckerTest {

    private Question question;
    private List<Option> options;

    @BeforeEach
    void setUp() {
        question = mock(Question.class);
        when(question.getId()).thenReturn(2); // ✅ Важно: ID должен быть 2

        options = Arrays.asList(
                createOption(201, true),
                createOption(202, true),
                createOption(203, false),
                createOption(204, true)
        );

        when(question.getOptions()).thenReturn(options);
    }

    private Option createOption(int id, boolean isCorrect) {
        Option option = mock(Option.class);
        when(option.getId()).thenReturn(id);
        when(option.isCorrect()).thenReturn(isCorrect);
        return option;
    }

    @Test
    @DisplayName("✅ Все правильные варианты выбраны, неправильных нет → ответ верный")
    void testAllCorrectAnswersSelected_returnsTrue() {
        // Убедимся, что question.getId() возвращает 2
        when(question.getId()).thenReturn(2);

        Map<String, String[]> answers = new HashMap<>();
        answers.put("question_2_option_201", new String[]{"on"});
        answers.put("question_2_option_202", new String[]{"on"});
        answers.put("question_2_option_204", new String[]{"on"});

        MultipleChoiceChecker checker = new MultipleChoiceChecker();
        assertTrue(checker.isAnswerCorrect(question, answers));
    }

    @Test
    @DisplayName("❌ Не все правильные варианты выбраны → ответ неверный")
    void testSomeCorrectNotSelected_returnsFalse() {
        Map<String, String[]> answers = new HashMap<>();
        answers.put("question_2_option_201", new String[]{"on"});
        answers.put("question_2_option_202", new String[]{"on"});
        MultipleChoiceChecker checker = new MultipleChoiceChecker();
        assertFalse(checker.isAnswerCorrect(question, answers));
    }

    @Test
    @DisplayName("❌ Выбран лишний неправильный вариант → ответ неверный")
    void testExtraIncorrectSelected_returnsFalse() {
        Map<String, String[]> answers = new HashMap<>();
        answers.put("question_2_option_201", new String[]{"on"});
        answers.put("question_2_option_202", new String[]{"on"});
        answers.put("question_2_option_203", new String[]{"on"}); // 203 — неправильный вариант
        answers.put("question_2_option_204", new String[]{"on"});

        MultipleChoiceChecker checker = new MultipleChoiceChecker();
        assertFalse(checker.isAnswerCorrect(question, answers));
    }

    @Test
    @DisplayName("✅ Только правильные варианты выбраны, неправильных нет → ответ верный")
    void testOnlyCorrectAndNoneIncorrect_returnsTrue() {
        Map<String, String[]> answers = new HashMap<>();
        answers.put("question_2_option_201", new String[]{"on"});
        answers.put("question_2_option_202", new String[]{"on"});
        answers.put("question_2_option_204", new String[]{"on"});

        MultipleChoiceChecker checker = new MultipleChoiceChecker();
        assertTrue(checker.isAnswerCorrect(question, answers));
    }
}