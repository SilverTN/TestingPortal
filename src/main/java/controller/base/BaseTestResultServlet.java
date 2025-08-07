package controller.base;

import dao.TestDAO;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import model.Test;
import model.TestResult;
import model.dto.TestResultDTO;
import service.answer.AnswerService;
import service.answer.dto.AnswerDetail;
import service.test.TestResultService;
import service.test.impl.TestResultServiceImpl;

import java.util.List;
import java.util.Map;

public abstract class BaseTestResultServlet extends HttpServlet {
    protected final TestDAO testDAO = new TestDAO();
    protected final AnswerService answerService = new service.answer.impl.AnswerServiceImpl();
    private final TestResultService testResultService = new TestResultServiceImpl();

    /**
     * Подготавливает все необходимые данные для отображения результатов теста
     */
    protected void prepareCommonData(HttpServletRequest request, int userId, int testId) {
        // Получаем тест
        Test test = testDAO.getTestById(testId);
        if (test == null) {
            request.setAttribute("test", null);
            return;
        }

        // Получаем результат теста
        TestResult testResult = testDAO.getTestResult(userId, testId);
        TestResultDTO dto = testResult != null ? testResultService.convertToDTO(testResult) : null;

        // Детализация ответов
        Map<Integer, List<AnswerDetail>> answerDetails = answerService.getAnswerDetails(userId, testId);

        // Передача данных в JSP
        request.setAttribute("test", test);
        request.setAttribute("answerDetails", answerDetails);
        request.setAttribute("userId", userId); // если нужно
        request.setAttribute("testId", testId); // если нужно

        if (dto != null) {
            request.setAttribute("result", dto);
            request.setAttribute("score", dto.getScore());
            request.setAttribute("total", dto.getTotalQuestions());
            request.setAttribute("percentage", dto.getPercentage());
            request.setAttribute("passedAt", dto.getPassedAt());
            request.setAttribute("username", dto.getUsername());
        } else {
            request.setAttribute("score", 0);
            request.setAttribute("total", 0);
            request.setAttribute("percentage", 0.0);
            request.setAttribute("passedAt", "Неизвестно");
        }
    }
}