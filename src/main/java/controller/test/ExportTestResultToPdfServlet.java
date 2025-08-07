package controller.test;

import com.lowagie.text.DocumentException;
import dao.TestDAO;
import dao.UserAnswerDAO;
import model.*;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.dto.OptionResult;
import model.dto.QuestionResult;
import service.exports.PdfGenerator;
import util.TemplateUtil;

import java.io.IOException;
import java.util.*;

@WebServlet("/test/export")
public class ExportTestResultToPdfServlet extends HttpServlet {

    private final TestDAO testDAO = new TestDAO();
    private final UserAnswerDAO userAnswerDAO = new UserAnswerDAO(); // ✅ Новый DAO

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        // Загружаем тест и ответы пользователя
        Map<Integer, Map<Integer, Boolean>> rawUserAnswers = userAnswerDAO.getUserAnswers(user.getId(), Integer.parseInt(request.getParameter("testId")));
        // Преобразуем в список с понятными DTO
        List<QuestionResult> questionResults = new ArrayList<>();

        if (user == null) {
            response.sendRedirect("/login");
            return;
        }

        int testId = Integer.parseInt(request.getParameter("testId"));
        Test test = testDAO.getTestById(testId);

        if (test == null) {
            request.setAttribute("error", "Тест не найден");
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
            return;
        }

        // Загрузка данных
        List<Question> questions = testDAO.getQuestionsByTestId(testId);
        Map<Integer, Map<Integer, Boolean>> userAnswers = userAnswerDAO.getUserAnswers(user.getId(), testId);
        TestResult result = testDAO.getTestResult(user.getId(), testId);

        for (Question q : test.getQuestions()) {
            List<OptionResult> optionResults = new ArrayList<>();
            for (Option o : q.getOptions()) {
                boolean isSelected = false;
                boolean isCorrect = o.isCorrect();

                if (rawUserAnswers.containsKey(q.getId())) {
                    Map<Integer, Boolean> answersForQ = rawUserAnswers.get(q.getId());
                    isSelected = answersForQ.getOrDefault(o.getId(), false);
                }

                optionResults.add(new OptionResult(o.getText(), isSelected, isCorrect));
            }

            questionResults.add(new QuestionResult(q.getText(), optionResults));
        }

        // Подсчёт процента прохождения
        double percentage = ((double) result.getScore() / questions.size()) * 100;
        String formattedPercentage = String.format(Locale.US, "%.1f%%", percentage);

        // Передача данных в шаблонизатор
        Map<String, Object> model = new HashMap<>();
        model.put("test", test);
       // model.put("questions", questions);
        model.put("questions", questionResults);
        model.put("userAnswers", userAnswers);
        model.put("username", user.getUsername());
        model.put("score", result.getScore());
        model.put("total", questions.size());
        model.put("percentage", percentage);  // double значение
        model.put("formattedPercentage", formattedPercentage);
        model.put("passedAt", new java.util.Date());

        // Генерация HTML
        String html = TemplateUtil.process("test-result-pdf", model);

        // Генерация PDF
        byte[] pdfBytes = null;
        try {
            pdfBytes = new PdfGenerator().generateFromHtml(html);
        } catch (DocumentException e) {
            throw new RuntimeException(e);
        }

        // Настройка ответа
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=test_result_" + testId + ".pdf");
        response.setContentLength(pdfBytes.length);
        response.getOutputStream().write(pdfBytes);
    }
}