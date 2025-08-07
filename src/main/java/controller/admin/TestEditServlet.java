package controller.admin;

import dao.TestDAO;
import model.Test;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/admin/test/edit")
public class TestEditServlet extends HttpServlet {
    private final TestDAO testDAO = new TestDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int testId = Integer.parseInt(request.getParameter("id"));
        Test test = testDAO.getTestById(testId);
        request.setAttribute("test", test);
        request.getRequestDispatcher("/views/admin/old_test-edit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String description = request.getParameter("description");

        Test test = new Test();
        test.setId(id);
        test.setTitle(title);
        test.setDescription(description);

        testDAO.updateTest(test);
        response.sendRedirect("/admin/test/list");
    }
}
