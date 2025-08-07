<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Детали результата теста</title>
    <link rel="stylesheet" href="../../../styles/main.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href=" https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css ">
    <style>
        .result-card {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 30px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            border: none;
            backdrop-filter: blur(0px);
        }

        .result-card:hover {
            transform: translateY(0);
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);
        }

        .question-title {
            font-size: 1.2rem;
            color: #333; /* Чёрный цвет */
            margin-bottom: 10px;
            font-weight: 600;
        }

        .option-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 8px 12px;
            border-radius: 6px;
            transition: background 0.3s ease;
        }

        .option-item.correct span i {
            color: #4cc9f0;
        }

        .option-item.incorrect span i {
            color: #f72585;
        }

        .option-item.missing span i {
            color: #ffcc00;
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
                <h2>Детали прохождения теста</h2>

                <!-- Информация о пользователе -->
                <div class="summary">
                    <h3>Пользователь: <strong>${username}</strong></h3>
                    <h3>Результат: <strong>${result.score} / ${result.totalQuestions}</strong> →
                        <strong>${String.format("%.1f%%", result.percentage)}</strong>
                    </h3>
                    <div class="progress-bar">
                        <div class="progress-fill"></div>
                    </div>
                </div>

                <!-- Вопросы -->
<%--                <c:forEach items="${test.questions}" var="q" varStatus="questionLoop">--%>
<%--                    <div class="result-card" data-question-id="${q.id}">--%>
<%--                        <div class="question-title">--%>
<%--                            <strong>Вопрос ${questionLoop.index + 1}:</strong> ${q.text}--%>
<%--                        </div>--%>

<%--                        <ul class="option-list">--%>
<%--                            <c:forEach items="${q.options}" var="o" varStatus="optionLoop">--%>
<%--                                <li class="option-item--%>
<%--                                    <c:if test="${userAnswers[q.id][o.id]}"> correct</c:if>--%>
<%--                                    <c:if test="${not o.isCorrect() && userAnswers[q.id][o.id] != null && userAnswers[q.id][o.id]}"> incorrect</c:if>--%>
<%--                                ">--%>
<%--                                    <span>--%>
<%--                                        <c:choose>--%>
<%--                                            <c:when test="${userAnswers[q.id][o.id]}">--%>
<%--                                                <i class="fas fa-check-circle"></i>--%>
<%--                                            </c:when>--%>
<%--                                            <c:when test="${not o.isCorrect() && userAnswers[q.id][o.id] != null && userAnswers[q.id][o.id]}">--%>
<%--                                                <i class="fas fa-times-circle"></i>--%>
<%--                                            </c:when>--%>
<%--                                            <c:otherwise>&nbsp;</c:otherwise>--%>
<%--                                        </c:choose>--%>
<%--                                    </span>--%>
<%--                                        ${o.text}--%>
<%--                                </li>--%>
<%--                            </c:forEach>--%>
<%--                        </ul>--%>
<%--                    </div>--%>
<%--                </c:forEach>--%>
                <c:forEach items="${test.questions}" var="q" varStatus="questionLoop">
                    <c:set var="details" value="${answerDetails[q.id]}"/>

                    <div class="result-card" data-question-id="${q.id}">
                        <div class="question-title">
                            <strong>Вопрос ${questionLoop.index + 1}:</strong> ${q.text}
                        </div>

                        <ul class="option-list">
                            <c:forEach items="${details}" var="detail">
                                <li class="option-item
                    <c:if test="${detail.correctlySelected}"> correct</c:if>
                    <c:if test="${detail.incorrectlySelected}"> incorrect</c:if>
                    <c:if test="${detail.missedCorrect}"> missed-correct</c:if>
                ">
                    <span>
                        <c:choose>
                            <c:when test="${detail.correctlySelected}">
                                <i class="fas fa-check-circle" style="color: #4cc9f0;"></i>
                            </c:when>
                            <c:when test="${detail.incorrectlySelected}">
                                <i class="fas fa-times-circle" style="color: #f72585;" title="Неверный ответ"></i>
                            </c:when>
                            <c:when test="${detail.missedCorrect}">
                                <i class="fas fa-exclamation-triangle" style="color: #ffcc00;" title="Правильный ответ, но вы его не выбрали"></i>
                            </c:when>
                            <c:otherwise>&nbsp;</c:otherwise>
                        </c:choose>
                    </span>
                                        ${detail.text}
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:forEach>

                <a href="/admin/test/results?testId=${test.id}" class="btn btn-login">
                    <i class="fas fa-arrow-left"></i> Назад к статистике
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