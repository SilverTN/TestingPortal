package service.answer;

import service.answer.dto.AnswerDetail;

import java.util.Map;
import java.util.List;

public interface AnswerService {
    /**
     * Возвращает Map<questionId, List<AnswerDetail>>
     */
    Map<Integer, List<AnswerDetail>> getAnswerDetails(int userId, int testId);

    /**
     * Сохраняет все ответы пользователя
     */
    void saveUserAnswers(int userId, int testId, Map<String, String[]> answers);
}