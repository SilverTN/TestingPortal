<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ru">
<head>
  <meta charset="UTF-8">
  <title>Выберите тест</title>
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
      <div class="hero-content">
        <h2>Выберите тест для прохождения</h2>
        <p>Доступные тесты:</p>

        <div class="test-grid">
          <c:forEach items="${tests}" var="test">
            <div class="test-card">
              <h3>${test.title}</h3>
              <p>${test.description}</p>
              <a href="/start-test?testId=${test.id}" class="btn btn-login">
                <i class="fas fa-play-circle"></i> Начать
              </a>
            </div>
          </c:forEach>
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