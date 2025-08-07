package controller.admin;

import dao.TestDAO;
import model.Option;
import model.Question;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.QuestionParser;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;


@WebServlet("/admin/test/update-questions")
public class UpdateQuestionsServlet extends HttpServlet {
    private final TestDAO testDAO = new TestDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int testId = Integer.parseInt(request.getParameter("testId"));

        // Парсим вопросы из формы
        List<Question> questions = QuestionParser.parseQuestions(request);

        // Обновляем в БД
        testDAO.updateTestQuestions(testId, questions);

        // Перенаправляем обратно к списку тестов
        response.sendRedirect("/admin/test/list");
    }
}