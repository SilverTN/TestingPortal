<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false"%>
<%@ page import="model.User"%>
<%@ page import="model.UserRole" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Главная</title>
    <link rel="stylesheet" href="../styles/main.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<div class="main-container">
    <header>
        <h1>Центр профессионального тестирования</h1>
        <p>Оцените навыки сотрудников быстро и объективно</p>
    </header>

    <main>
        <section class="hero">
            <div class="hero-content">
                <h2>Добро пожаловать, ${fn:escapeXml(user.username)}!</h2>
                <p>Вы вошли как <%= UserRole.ADMIN == user.getRole() ? "Администратор" : "Пользователь" %>.</p>

                <div class="buttons">
                    <% if (UserRole.ADMIN == user.getRole()) { %>
                    <a href="/admin/test/list" class="btn-edit-tests">
                        <i class="fas fa-edit"></i> Список тестов
                    </a>
                    <% } %>

                    <a href="/test/select" class="btn btn-start-test">
                        <i class="fas fa-vial"></i> Пройти тест
                    </a>

                    <a href="/test/history" class="btn btn-login">
                        <i class="fas fa-history"></i> История тестов
                    </a>

                    <a href="/logout" class="btn btn-sign-out">
                        <i class="fas fa-sign-out-alt"></i> Выйти
                    </a>
                </div>
            </div>
        </section>
    </main>

    <footer>
        <p>© 2025 Центр профессионального тестирования. Все права защищены.</p>
    </footer>
</div>
</body>
</html>