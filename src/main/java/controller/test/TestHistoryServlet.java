package controller.test;

import dao.TestDAO;
import model.TestResult;
import model.User;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/test/history")
public class TestHistoryServlet extends HttpServlet {
    private final TestDAO testDAO = new TestDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("/login");
            return;
        }

        List<TestResult> history = testDAO.getTestResultsByUserId(user.getId());

        request.setAttribute("history", history);
        request.getRequestDispatcher("/views/test-history.jsp").forward(request, response);
    }
}