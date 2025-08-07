package controller.admin;

import dao.TestDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/admin/test/delete")
public class TestDeleteServlet extends HttpServlet {
    private final TestDAO testDAO = new TestDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int testId = Integer.parseInt(request.getParameter("id"));
        testDAO.deleteTest(testId);
        response.sendRedirect("/admin/test/list");
    }
}
