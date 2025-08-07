<%--
  Created by IntelliJ IDEA.
  User: Сергей
  Date: 26.06.2025
  Time: 2:24
  To change this template use File | Settings | File Templates.
  Редактирование вопросов и вариантов ответа
--%>
<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ru">
<head>
  <meta charset="UTF-8">
  <title>Редактировать вопросы</title>
  <link rel="stylesheet" href="../../styles/main.css">
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

  <style>
    .question-block {
      margin-bottom: 30px;
      padding: 15px;
      border: 1px solid #ccc;
      border-radius: 8px;
    }

    .option-group {
      display: flex;
      align-items: center;
      margin-bottom: 10px;
    }

    .option-group input[type="text"] {
      flex: 1;
      padding: 8px;
      margin-right: 10px;
    }

    .btn-sm {
      font-size: 0.9rem;
      padding: 6px 12px;
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
        <h2>Вопросы теста: ${test.title}</h2>

        <form id="questionsForm" action="/admin/test/update-questions" method="post">
          <input type="hidden" name="testId" value="${test.id}">

          <div id="questionsContainer">
            <!-- Вопросы из модели -->
            <c:forEach items="${test.questions}" var="q" varStatus="loop">
              <div class="question-block" data-question-id="${q.id}">
                <input type="hidden" name="questionId_${loop.index}" value="${q.id}">
                <div class="input-group">
                  <label for="questionText_${loop.index}">Текст вопроса:</label>
                  <textarea id="questionText_${loop.index}" name="questionText_${loop.index}" required class="input-question-text">${q.text}</textarea>
                </div>

                <div class="input-group">
                  <label>Тип вопроса:</label>
                  <select name="questionType_${loop.index}">
                    <option value="0" ${q.questionType == 0 ? 'selected' : ''}>Один правильный</option>
                    <option value="1" ${q.questionType == 1 ? 'selected' : ''}>Множественный выбор</option>
                  </select>
                </div>

                <h4>Варианты ответов:</h4>
                <div class="options-container" data-index="${loop.index}">
                  <c:forEach items="${q.options}" var="o" varStatus="optLoop">
                    <div class="option-group">
                      <input type="text" name="optionText_${loop.index}_${optLoop.index}"
                             value="${o.text}" required style="flex: 1; padding: 8px; margin-right: 10px;">
                      <label>
                        <input type="checkbox" name="isCorrect_${loop.index}_${optLoop.index}" ${o.isCorrect() ? 'checked' : ''}>
                        Верный
                      </label>
                      <button type="button" class="btn btn-register btn-sm" onclick="removeOption(this)">
                        <i class="fas fa-trash"></i>
                      </button>
                    </div>
                  </c:forEach>
                </div>

                <button type="button" class="btn btn-login" onclick="addOption(this, ${loop.index})">
                  <i class="fas fa-plus"></i> Добавить вариант
                </button>
              </div>
            </c:forEach>
          </div>

          <button type="button" class="btn btn-register" onclick="addQuestion()">
            <i class="fas fa-plus"></i> Добавить вопрос
          </button>

          <button type="submit" class="btn btn-register" style="margin-top: 20px;">
            <i class="fas fa-save"></i> Сохранить изменения
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
  let questionIndex = ${test.questions.size()}; // Начинаем с существующего количества вопросов

  function getNewQuestionHTML(index) {
    return `
            <div class="question-block new-question" data-index="\${index}">
                <div class="input-group">
                    <label>Текст вопроса:</label>
                    <input type="text" name="questionText_\${index}" required style="width: 100%; padding: 8px;">
                </div>

                <div class="input-group">
                    <label>Тип вопроса:</label>
                    <select name="questionType_\${index}">
                        <option value="0">Один правильный</option>
                        <option value="1">Множественный выбор</option>
                    </select>
                </div>

                <h4>Варианты ответов:</h4>
                <div class="options-container" data-index="\${index}">
                    <div class="option-group">
                        <input type="text" name="optionText_\${index}_0" required style="flex: 1; padding: 8px; margin-right: 10px;">
                        <label><input type="checkbox" name="isCorrect_\${index}_0"> Верный</label>
                        <button type="button" class="btn btn-register btn-sm" onclick="removeOption(this)">
                            <i class="fas fa-trash"></i>
                        </button>
                    </div>
                </div>

                <button type="button" class="btn btn-login" onclick="addOption(this, \${index})">Добавить вариант</option>
                <button type="button" class="btn btn-register" onclick="removeQuestion(this)">Удалить вопрос</button>
            </div>
        `;
  }

  function addQuestion() {
    const container = document.getElementById("questionsContainer");
    const div = document.createElement("div");
    div.innerHTML = getNewQuestionHTML(questionIndex);
    container.appendChild(div);
    questionIndex++;
  }

  function addOption(button, qIndex) {
    const container = button.closest(".question-block") || button.closest(".new-question");
    const optionsContainer = container.querySelector(".options-container[data-index='" + qIndex + "']");

    const optIndex = optionsContainer.querySelectorAll(".option-group").length;

    const optionGroup = document.createElement("div");
    optionGroup.className = "option-group";

    optionGroup.innerHTML = `
            <input type="text" name="optionText_\${qIndex}_\${optIndex}" required style="flex: 1; padding: 8px; margin-right: 10px;">
            <label><input type="checkbox" name="isCorrect_\${qIndex}_\${optIndex}"> Верный</label>
            <button type="button" class="btn btn-register btn-sm" onclick="removeOption(this)">
                <i class="fas fa-trash"></i>
            </button>
        `;

    optionsContainer.appendChild(optionGroup);
  }

  function removeOption(button) {
    const group = button.closest(".option-group");
    if (group && group.parentNode.querySelectorAll(".option-group").length > 1) {
      group.remove();
    } else {
      alert("Должен быть хотя бы один вариант ответа");
    }
  }

  function removeQuestion(button) {
    const block = button.closest(".question-block, .new-question");
    if (!block.classList.contains("question-block")) {
      if (confirm("Удалить вопрос?")) {
        block.remove();
      }
    } else {
      alert("Нельзя удалить существующий вопрос напрямую. Реализуйте отдельную логику удаления через DAO.");
    }
  }
</script>
</body>
</html>