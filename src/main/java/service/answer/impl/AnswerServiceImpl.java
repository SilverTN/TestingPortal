package service.answer.impl;

import dao.TestDAO;
import dao.UserAnswerDAO;
import model.Question;
import model.Option;
import service.answer.AnswerService;
import service.answer.dto.AnswerDetail;
import java.util.*;

public class AnswerServiceImpl implements AnswerService {

    private final UserAnswerDAO userAnswerDAO = new UserAnswerDAO(); // ✅ Новый DAO
    private final TestDAO testDAO = new TestDAO();

    @Override
    public Map<Integer, List<AnswerDetail>> getAnswerDetails(int userId, int testId) {
        Map<Integer, List<AnswerDetail>> result = new LinkedHashMap<>(); // ✅ Сохраняет порядок вставки
        Map<Integer, Map<Integer, Boolean>> userAnswers = userAnswerDAO.getUserAnswers(userId, testId);
        List<Question> questions = testDAO.getQuestionsByTestId(testId);

        for (Question q : questions) {
            List<AnswerDetail> details = new ArrayList<>();
            Map<Integer, Boolean> selectedOptions = userAnswers.getOrDefault(q.getId(), Collections.emptyMap());

            for (Option o : q.getOptions()) {
                boolean isSelected = selectedOptions.getOrDefault(o.getId(), false);
                details.add(new AnswerDetail(o.getText(), isSelected, o.isCorrect()));
            }

            result.put(q.getId(), details); // ✅ Привязываем к ID вопроса
        }

        return result;
    }

    @Override
    public void saveUserAnswers(int userId, int testId, Map<String, String[]> answers) {
        List<Question> questions = testDAO.getQuestionsByTestId(testId);
        userAnswerDAO.saveUserAnswers(userId, testId, questions, answers);
    }

}