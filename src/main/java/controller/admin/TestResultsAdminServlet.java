package controller.admin;

import dao.TestDAO;
import dao.UserDao;
import model.TestResult;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/test/results")
public class TestResultsAdminServlet extends HttpServlet {
    private final TestDAO testDAO = new TestDAO();
    private final UserDao userDAO = new UserDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String userIdParam = request.getParameter("userId");
        int userId = 0;

        if (userIdParam != null && !userIdParam.isEmpty()) {
            userId = Integer.parseInt(userIdParam);
        }

        // Получаем список пользователей для select
        List<User> allUsers = userDAO.getAllUsers();
        request.setAttribute("users", allUsers);
        request.setAttribute("selectedUserId", userId);

        // Если userId задан — загружаем только его результаты
        List<TestResult> results = userId > 0 ? testDAO.getTestResultsByUserId(userId) : testDAO.getAllTestResults();
        request.setAttribute("results", results);
        request.setAttribute("testTitle", "Все тесты");

        request.getRequestDispatcher("/views/admin/test-results.jsp").forward(request, response);
    }
}