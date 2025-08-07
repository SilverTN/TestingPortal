package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import util.PasswordUtil;
import dao.UserDao;
import model.User;

import java.io.IOException;

@WebServlet(urlPatterns = "/login")
public class LoginServlet extends HttpServlet {

    // Отображение формы входа
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }

    // Обработка данных формы
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserDao userDao = new UserDao();
        User user = userDao.getUserByUsername(username);

        if (user != null && PasswordUtil.checkPassword(password, user.getPasswordHash())) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect("home");
        } else {
            request.setAttribute("error", "Неверное имя пользователя или пароль");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        }
    }
}
