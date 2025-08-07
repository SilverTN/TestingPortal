<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Список тестов</title>
    <link rel="stylesheet" href="../../styles/main.css">
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
            <div class="test-table-container">
                <table class="test-table">
                    <thead>
                    <tr>
                        <th>№</th>
                        <th>Название теста</th>
                        <th>Описание</th>
                        <th>Действия</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${tests}" var="test" varStatus="loop">
                        <tr>
                            <td>${loop.index + 1}</td>
                            <td>${test.title}</td>
                            <td>${test.description}</td>
                            <td style="display: flex; gap: 10px; align-items: center;">
                                <a href="/admin/test/edit-questions?id=${test.id}" class="table-btn btn-questions">
                                    <i class="fas fa-question-circle"></i> Редактировать
                                </a>
                                <a href="/admin/test/delete?id=${test.id}" class="table-btn btn-delete"
                                   onclick="return confirm('Удалить тест?')">
                                    <i class="fas fa-trash"></i> Удалить
                                </a>
                                <a href="/admin/test/results?testId=${test.id}" class="table-btn btn-questions">
                                    <i class="fas fa-chart-bar"></i> Статистика
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </section>
    </main>
    <div class="action-buttons">
        <a href="/home" class="btn btn-login">
            <i class="fas fa-arrow-left"></i> На главную
        </a>
        <a href="/admin/test/create?id=${test.id}" class="btn btn-login">
            <i class="fas fa-plus-circle"></i> Добавить
        </a>
    </div>
    <footer>
        <p>© 2025 Центр профессионального тестирования. Все права защищены.</p>
    </footer>
</div>
</body>
</html>