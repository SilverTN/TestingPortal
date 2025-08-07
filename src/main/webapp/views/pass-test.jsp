<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Прохождение теста</title>
    <link rel="stylesheet" href="../../styles/main.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.7.0/styles/github.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.7.0/highlight.min.js"></script>
    <script>hljs.highlightAll();</script>
    <style>
        .test-question {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 30px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .options {
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin-top: 10px;
        }

        .option {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 8px 12px;
            border-radius: 6px;
            transition: background 0.3s ease;
        }

        .option:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        .progress-bar {
            width: 100%;
            height: 6px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 3px;
            overflow: hidden;
            margin-bottom: 30px;
        }

        .progress-fill {
            height: 100%;
            width: 0%;
            background: var(--accent-color);
            transition: width 0.3s ease;
        }
    </style>
</head>
<body>
<div class="auth-container">
    <header>
        <h1>Центр профессионального тестирования</h1>
        <p>Оцените навыки сотрудников быстро и объективно</p>
    </header>

    <main>
        <section class="hero">
            <div class="hero-content">
                <h2>Тест: ${test.title}</h2>
                <p>${test.description}</p>

                <div class="progress-bar">
                    <div class="progress-fill" id="progress"></div>
                </div>

                <form id="testForm" action="/test/result" method="post">
                    <input type="hidden" name="testId" value="${test.id}">

                    <c:forEach items="${test.questions}" var="q" varStatus="questionLoop">
                        <div class="test-question" data-question-id="${q.id}">
                            <div class="question-text">
                                <strong>Вопрос ${questionLoop.index + 1}:</strong><pre><code class="language-java">${q.text}</code></pre>
                            </div>

                            <div class="options" data-question-type="${q.questionType}">
                                <c:forEach items="${q.options}" var="o" varStatus="optionLoop">
                                    <label class="option">
                                        <c:choose>
                                            <c:when test="${q.questionType == 0}">
                                                <input type="radio" name="question_${q.id}"
                                                       value="${o.id}" required>
                                            </c:when>
                                            <c:otherwise>
                                                <input type="checkbox" name="question_${q.id}_option_${o.id}">
                                            </c:otherwise>
                                        </c:choose>
                                            ${o.text}
                                    </label>
                                </c:forEach>
                            </div>
                        </div>
                    </c:forEach>

                    <button type="submit" class="btn btn-register">
                        <i class="fas fa-check-circle"></i> Завершить тест
                    </button>
                </form>
            </div>
        </section>
    </main>

    <footer>
        <p>© 2025 Центр профессионального тестирования. Все права защищены.</p>
    </footer>
</div>

<script>
    // Простой JS для прогресса прохождения теста
    const options = document.querySelectorAll('.options');
    const totalQuestions = options.length;
    const progressFill = document.getElementById('progress');

    function updateProgress() {
        let filled = 0;

        options.forEach(container => {
            const questionType = container.getAttribute('data-question-type');
            const inputs = container.querySelectorAll('input[type="radio"], input[type="checkbox"]');

            if (questionType === '0') {
                const anySelected = Array.from(inputs).some(input => input.checked);
                if (anySelected) filled++;
            } else {
                const anyChecked = Array.from(inputs).some(input => input.checked);
                if (anyChecked) filled++;
            }
        });

        const percent = Math.round((filled / totalQuestions) * 100);
        progressFill.style.width = percent + '%';
    }

    document.querySelectorAll('input[type="radio"], input[type="checkbox"]').forEach(input => {
        input.addEventListener('change', updateProgress);
    });

    window.onload = () => updateProgress();
</script>
</body>
</html>