package controller.test;

import model.Test;
import dao.TestDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/start-test")
public class StartTestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String testIdParam = request.getParameter("testId");

        if (testIdParam == null || testIdParam.isEmpty()) {
            response.sendRedirect("/test/select");
            return;
        }

        int testId = Integer.parseInt(testIdParam);
        Test test = TestDAO.getInstance().getTestById(testId);

        if (test == null) {
            request.setAttribute("error", "Тест не найден");
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
            return;
        }

        request.setAttribute("test", test);
        request.getRequestDispatcher("/views/pass-test.jsp").forward(request, response);
    }
}