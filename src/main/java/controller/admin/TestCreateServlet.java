package controller.admin;

import dao.TestDAO;
import model.Test;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/admin/test/create")
public class TestCreateServlet extends HttpServlet {

    private final TestDAO testDAO = new TestDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/admin/test-create.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String title = request.getParameter("title");
        String description = request.getParameter("description");

        Test test = new Test();
        test.setTitle(title);
        test.setDescription(description);

        testDAO.addTest(test);
        response.sendRedirect("/admin/test/list");
    }
}