package service.answer.dto;

import lombok.*;

@Data
@AllArgsConstructor
/**
 * Этот DTO будет передаваться в JSP и содержать:
 * Текст варианта
 * Выбран ли пользователем
 * Правильный ли вариант
 */
public class AnswerDetail {
    private final String text;
    private final boolean selected;
    private final boolean correct;

    public boolean isCorrectlySelected() {
        return selected && correct;
    }

    public boolean isIncorrectlySelected() {
        return selected && !correct;
    }

    public boolean isMissedCorrect() {
        return !selected && correct;
    }

    public boolean isUnselected() {
        return !selected && !correct;
    }

}