package controller;

import dao.UserDao;
import jakarta.servlet.annotation.WebServlet;
import util.PasswordUtil;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;


@WebServlet(urlPatterns = "/registration")
public class RegistrationServlet extends HttpServlet {

    // Отображение формы регистрации
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("/views/registration.jsp").forward(request, response);
    }

    // Обработка данных формы
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
        String email = request.getParameter("email");

        if (password == null || !password.equals(confirmPassword)) {
            request.setAttribute("error", "Пароли не совпадают");
            request.getRequestDispatcher("/views/registration.jsp").forward(request, response);
            return;
        }

        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("error", "Логин не может быть пустым");
            request.getRequestDispatcher("/views/registration.jsp").forward(request, response);
            return;
        }

        if (!isValidUsername(username)) {
            request.setAttribute("error", "Недопустимый логин");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }

        if (!isValidEmail(email)) {
            request.setAttribute("error", "Некорректный email");
            request.getRequestDispatcher("/views/registration.jsp").forward(request, response);
            return;
        }

        if (!isValidPassword(password)) {
            request.setAttribute("error", "Пароль должен содержать минимум 6 символов");
            request.getRequestDispatcher("/views/registration.jsp").forward(request, response);
            return;
        }

        String hashedPassword = PasswordUtil.hashPassword(password);


        UserDao userDao = new UserDao();
        // Регистрация пользователя
        boolean success = userDao.registerUser(username, hashedPassword, email);

        if (success) {
            response.sendRedirect("login");
        } else {
            request.setAttribute("error", "Пользователь с таким логином уже существует");
            request.getRequestDispatcher("/views/registration.jsp").forward(request, response);
        }

    }

    public boolean isValidUsername(String username) {
        return username != null && username.matches("[a-zA-Z0-9_\\s]+");
    }

    private boolean isValidEmail(String email) {
        // Простая проверка email
        return email != null && email.matches("^[\\w-.]+@([\\w-]+\\.)+[\\w-]{2,4}$");
    }

    private boolean isValidPassword(String password) {
        // Пароль должен быть минимум 6 символов
        return password != null && password.length() >= 6;
    }
}
