package controller.admin;

import controller.base.BaseTestResultServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/test/result-details")
public class TestResultDetailsServlet extends BaseTestResultServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String userIdParam = request.getParameter("userId");
        String testIdParam = request.getParameter("testId");

        if (userIdParam == null || testIdParam == null) {
            request.setAttribute("error", "Не указан ID пользователя или теста");
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
            return;
        }

        int userId = Integer.parseInt(userIdParam);
        int testId = Integer.parseInt(testIdParam);

        prepareCommonData(request, userId, testId);
        // Можно добавить дополнительные данные только для админа
        request.setAttribute("isAdmin", true);

        request.getRequestDispatcher("/views/admin/test-result-details.jsp").forward(request, response);
    }
}


