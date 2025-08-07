package controller.admin;

import dao.TestDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/test/statistics")
public class TestStatisticsServlet extends HttpServlet {

    private final TestDAO testDAO = TestDAO.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        List<Map<String, Object>> topUsers = testDAO.getTopUsersByScore();
        request.setAttribute("topUsers", topUsers);
        request.getRequestDispatcher("/views/admin/test-statistics.jsp").forward(request, response);
    }
}