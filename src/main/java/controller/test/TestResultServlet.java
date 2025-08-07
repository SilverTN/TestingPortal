package controller.test;

import controller.base.BaseTestResultServlet;
import model.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import service.answer.AnswerService;
import service.answer.dto.AnswerDetail;
import service.test.TestResultService;
import service.test.impl.TestResultServiceImpl;
import util.RequestUtil;

import java.io.IOException;
import java.util.*;

@WebServlet("/test/result")
public class TestResultServlet extends BaseTestResultServlet {

    private final TestResultService testResultService = new TestResultServiceImpl();
    private final AnswerService answerService = new service.answer.impl.AnswerServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("/login");
            return;
        }

        int testId = Integer.parseInt(request.getParameter("testId"));
        prepareCommonData(request, user.getId(), testId);

        request.getRequestDispatcher("/views/test-result.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("/login");
            return;
        }

        int testId = Integer.parseInt(request.getParameter("testId"));

        // Получаем ответы из формы
        Map<String, String[]> answers = RequestUtil.getAnswersFromRequest(request);

        Test test = testDAO.getTestById(testId);

        // Получаем результат теста
        TestResult result = testResultService.calculateResult(user.getId(), testId, answers);
        testResultService.saveResult(result);
        // Сохраняем ответы через AnswerService
        answerService.saveUserAnswers(user.getId(), testId, answers);

        // Детали по каждому ответу для JSP
        Map<Integer, List<AnswerDetail>> answerDetails = answerService.getAnswerDetails(user.getId(), testId);
        request.setAttribute("answerDetails", answerDetails);

        // Передача данных в JSP
        request.setAttribute("test", test);
        request.setAttribute("score", result.getScore());
        request.setAttribute("total", result.getTotalQuestions());
        request.setAttribute("percentage", testResultService.calculatePercentage(result));

        request.getRequestDispatcher("/views/test-result.jsp").forward(request, response);
    }

}

//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
//        HttpSession session = request.getSession(false);
//        User user = (User) session.getAttribute("user");
//
//        if (user == null) {
//            response.sendRedirect("/login");
//            return;
//        }
//
//        String testIdParam = request.getParameter("testId");
//        if (testIdParam == null || testIdParam.isEmpty()) {
//            request.setAttribute("error", "Не указан ID теста");
//            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
//            return;
//        }
//
//        int testId = Integer.parseInt(testIdParam);
//
//        Test test = TestDAO.getInstance().getTestById(testId);
//        TestResult testResult = testDAO.getTestResult(user.getId(), testId);
//        TestResultDTO dto = testResultService.convertToDTO(testResult);
//
//        if (test == null || dto== null) {
//            request.setAttribute("error", "Результат не найден");
//            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
//            return;
//        }
//
//        //Map<Integer, Map<Integer, Boolean>> userAnswers = testDAO.getUserAnswers(user.getId(), testId);
//        Map<Integer, List<AnswerDetail>> answerDetails = answerService.getAnswerDetails(user.getId(), testId);
//        request.setAttribute("answerDetails", answerDetails);
//      //  request.setAttribute("userAnswers", userAnswers);
//        request.setAttribute("test", test);
//        request.setAttribute("score", dto.getScore());
//        request.setAttribute("total", dto.getTotalQuestions());
//        request.setAttribute("passedAtFormattedPassedAt", dto.getPassedAt());
//        request.setAttribute("percentage", dto.getPercentage());
//
//        request.getRequestDispatcher("/views/test-result.jsp").forward(request, response);
//
//    }