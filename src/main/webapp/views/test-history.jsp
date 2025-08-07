<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>История тестирования</title>
    <link rel="stylesheet" href="../../styles/main.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .history-card {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            transition: transform 0.3s ease;
        }

        .history-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
        }

        .result-progress {
            width: 100%;
            height: 10px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 5px;
            overflow: hidden;
            margin-top: 10px;
        }

        .result-progress-fill {
            height: 100%;
            background: var(--accent-color);
            width: ${result.percentage}%;
            transition: width 0.5s ease;
        }

        .result-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .result-meta strong {
            color: white;
        }

        .result-meta small {
            color: #ccc;
        }

        .result-score {
            font-size: 1.2rem;
            color: white;
        }
    </style>
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
                <h2>Ваша история тестирования</h2>
                <p>Ниже вы можете посмотреть все пройденные вами тесты</p>

                <c:if test="${empty history}">
                    <p>Вы ещё не проходили ни один тест.</p>
                </c:if>

                <c:forEach items="${history}" var="result">
                    <div class="history-card">
                        <div class="result-meta">
<%--                            <strong>${result.title}</strong>--%>
                            <small>${result.passedAtFormattedDate}</small>
                        </div>

                        <div class="result-score">
                                ${result.score} / ${result.totalQuestions} (${String.format("%.1f%%", result.percentage)})
                        </div>

                        <div class="result-progress">
                            <div class="progress-fill" style="width: ${result.percentage}%"></div>
                        </div>

                        <a href="/test/result?testId=${result.testId}" class="btn btn-login" style="margin-top: 15px;">
                            <i class="fas fa-eye"></i> Посмотреть результат
                        </a>
                    </div>
                </c:forEach>
            </div>
        </section>
    </main>

    <footer>
        <p>© 2025 Центр профессионального тестирования. Все права защищены.</p>
    </footer>
</div>
</body>
</html>