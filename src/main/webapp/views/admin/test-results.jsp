<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Результаты тестов</title>
    <link rel="stylesheet" href="../../../styles/main.css">
</head>
<body>

<div class="main-container">
    <header>
        <h1>Центр профессионального тестирования</h1>
        <p>Админка: Список результатов тестов</p>
    </header>

    <main>
        <section class="hero">
            <div class="hero-content">

                <!-- Фильтр по пользователю -->
                <div class="filter-container">
                    <form method="get" action="/admin/test/results" class="filter-form">
                        <label class="filter-label" for="userId">Фильтр по пользователю:</label>
                        <select class="form-select" name="userId" id="userId" class="form-select" onchange="this.form.submit()">
                            <option value="">Все пользователи</option>
                            <c:forEach items="${users}" var="user">
                                <option value="${user.id}" ${user.id == selectedUserId ? 'selected' : ''}>
                                        ${user.username}
                                </option>
                            </c:forEach>
                        </select>
                    </form>
                </div>

                <!-- Таблица результатов -->
                <div class="test-table-container">
                    <table class="test-table">
                        <thead>
                        <tr>
                            <th>Пользователь</th>
                            <th>Правильно</th>
                            <th>Всего</th>
                            <th>Процент</th>
                            <th>Дата прохождения</th>
                            <th>Действия</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${results}" var="result">
                            <tr>
                                <td>${fn:escapeXml(user.username)}</td>
                                <td>${result.score}</td>
                                <td>${result.totalQuestions}</td>
                                <td>${String.format("%.1f%%", result.percentage)}</td>
                                <td>${result.passedAtFormattedDate}</td>
                                <td>
                                    <a href="/admin/test/result-details?userId=${result.userId}&testId=${result.testId}"
                                       class="table-btn btn-questions">
                                        <i class="fas fa-eye"></i> Посмотреть
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>

                <a href="/admin/test/list" class="btn btn-login">
                    <i class="fas fa-arrow-left"></i> Назад к списку тестов
                </a>
                <a href="/admin/test/statistics" class="btn btn-login">
                    <i class="bi bi-bar-chart-line"></i> График
                </a>
            </div>
        </section>
    </main>

    <footer>
        <p>© 2025 Центр профессионального тестирования. Все права защищены.</p>
    </footer>
</div>

</body>
</html>