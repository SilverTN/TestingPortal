package controller.admin;

import dao.TestDAO;
import model.Test;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/test/list")
public class TestListServlet extends HttpServlet {
    private final TestDAO testDAO = new TestDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Test> tests = testDAO.getAllTests();

        request.setAttribute("tests", tests);
        request.getRequestDispatcher("/views/admin/test-list.jsp").forward(request, response);
    }
}