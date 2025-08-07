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

@DisplayName("Тесты для SingleChoiceChecker — проверка одиночного выбора")
class SingleChoiceCheckerTest {

    private Question question;
    private List<Option> options;

    @BeforeEach
    void setUp() {
        question = mock(Question.class);
        when(question.getId()).thenReturn(1);
        options = Arrays.asList(
                createOption(101, false),
                createOption(102, true), // правильный
                createOption(103, false)
        );

        when(question.getOptions()).thenReturn(options);
    }

    private Option createOption(int id, boolean correct) {
        Option o = mock(Option.class);
        when(o.getId()).thenReturn(id);
        when(o.isCorrect()).thenReturn(correct);
        return o;
    }

    @Test
    @DisplayName("✅ Правильный вариант выбран → ответ верный")
    void testCorrectAnswerSelected_returnsTrue() {
        // Подготавливаем ответ пользователя
        Map<String, String[]> answers = new HashMap<>();
        answers.put("question_1", new String[]{"102"});

        SingleChoiceChecker checker = new SingleChoiceChecker();
        assertTrue(checker.isAnswerCorrect(question, answers));
    }

    @Test
    @DisplayName("❌ Неправильный вариант выбран → ответ неверный")
    void testIncorrectAnswerSelected_returnsFalse() {
        Map<String, String[]> answers = new HashMap<>();
        answers.put("question_1", new String[]{"101"});

        SingleChoiceChecker checker = new SingleChoiceChecker();
        assertFalse(checker.isAnswerCorrect(question, answers));
    }

    @Test
    @DisplayName("❌ Ответ не предоставлен → ответ неверный")
    void testNoAnswerSelected_returnsFalse() {
        Map<String, String[]> answers = new HashMap<>();

        SingleChoiceChecker checker = new SingleChoiceChecker();
        assertFalse(checker.isAnswerCorrect(question, answers));
    }
}