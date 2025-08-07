package controller.admin;

import dao.TestDAO;
import model.Test;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/admin/test/edit-questions")
public class QuestionEditServlet extends HttpServlet {
    private final TestDAO testDAO = new TestDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int testId = Integer.parseInt(request.getParameter("id"));
        Test test = testDAO.getTestById(testId);

        if (test == null) {
            request.setAttribute("error", "Тест не найден");
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
            return;
        }

        request.setAttribute("test", test);
        request.getRequestDispatcher("/views/admin/test-edit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int testId = Integer.parseInt(request.getParameter("testId"));
        response.sendRedirect("/admin/test/list");
    }
}