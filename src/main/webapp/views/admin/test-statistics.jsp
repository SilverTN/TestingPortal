    <%@ page contentType="text/html;charset=UTF-8" isELIgnored="false"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!DOCTYPE html>
    <html lang="ru">
    <head>
        <meta charset="UTF-8">
        <title>Статистика лидеров</title>
        <link rel="stylesheet" href="../../../styles/main.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js "></script>
        <style>
            .chart-container {
                width: 90%;
                max-width: 1000px;
                margin: 40px auto;
                background: white;
                padding: 30px;
                border-radius: 20px;
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            }

            h2 {
                text-align: center;
                color: #ffffff;
                margin-top: 40px;
            }
        </style>
    </head>
    <body>

    <div class="main-container">

        <header>
            <h1>Центр профессионального тестирования</h1>
            <p>Админка: Статистика лидеров</p>
        </header>

        <main>
            <section class="hero">
                <div class="hero-content">

                    <!-- Сообщение, если нет данных -->
                    <c:if test="${empty topUsers}">
                        <p style="color: red; text-align: center;">Нет данных для отображения графика.</p>
                    </c:if>

                    <!-- График -->
                    <c:if test="${not empty topUsers}">
                        <div class="chart-container">
                            <canvas id="userStatsChart"></canvas>
                        </div>
                    </c:if>

                    <!-- Таблица с данными (для проверки) -->
                    <c:if test="${not empty topUsers}">
                        <table class="test-table" style="width: 90%; margin: 40px auto;">
                            <thead>
                            <tr>
                                <th>Пользователь</th>
                                <th>Средний результат (%)</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${topUsers}" var="user">
                                <tr>
                                    <td>${user.username}</td>
                                    <td>${user.avgPercentage}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </c:if>

                    <a href="/admin/test/list" class="btn btn-login">
                        <i class="fas fa-arrow-left"></i> Назад к списку тестов
                    </a>

                </div>
            </section>
        </main>

        <footer>
            <p>&copy; 2025 Центр профессионального тестирования. Все права защищены.</p>
        </footer>

    </div>

    <!-- JavaScript для Chart.js -->
    <script>
        const ctx = document.getElementById('userStatsChart').getContext('2d');

        // Данные из JSP
        const dataLabels = [
            <c:forEach items="${topUsers}" var="user" varStatus="loop">
            "${user.username}"${!loop.last ? "," : ""}
            </c:forEach>
        ];

        const dataValues = [
            <c:forEach items="${topUsers}" var="user" varStatus="loop">
            ${user.avgPercentage}${!loop.last ? "," : ""}
            </c:forEach>
        ];

        // Создаём градиент
        const gradient = ctx.createLinearGradient(0, 0, 0, 400);
        gradient.addColorStop(0, '#4cc9f0');
        gradient.addColorStop(1, '#4361ee');

        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: dataLabels,

                datasets: [{
                    label: 'Средний результат (%)',
                    data: dataValues,
                    backgroundColor: gradient,
                    borderRadius: 5,
                    barPercentage: 0.7,
                    categoryPercentage: 0.5
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: { display: false },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                return context.parsed.y + '%';
                            }
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        max: 100,
                        ticks: {
                            callback: function(value) {
                                return value + '%';
                            }
                        },
                        title: {
                            display: true,
                            text: 'Процент успешности'
                        }
                    },
                    x: {
                        title: {
                            display: true,
                            text: 'Пользователи'
                        }
                    }
                }
            }
        });
    </script>

    </body>
    </html>