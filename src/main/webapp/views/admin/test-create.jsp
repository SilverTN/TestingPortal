<%--
  Created by IntelliJ IDEA.
  User: Сергей
  Date: 26.06.2025
  Time: 2:23
  To change this template use File | Settings | File Templates.
  Форма создания теста
--%>
<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Добавить тест</title>
    <link rel="stylesheet" href="../../styles/main.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<div class="container">
    <header>
<%--        <img src="../../images/logo.png" alt="Логотип портала тестирования" class="logo">--%>
        <h1>Центр профессионального тестирования</h1>
        <p>Оцените навыки сотрудников быстро и объективно</p>
    </header>

    <main>
        <section class="hero">
            <div class="hero-content">
                <h2>Добавить новый тест</h2>
                <form action="/admin/test/create" method="post" class="auth-form">
                    <div class="input-group">
                        <label for="title">Название теста</label>
                        <input type="text" id="title" name="title" required minlength="3" maxlength="255" placeholder="Введите название теста">
                    </div>

                    <div class="input-group">
                        <label for="description">Описание теста</label>
                        <textarea id="description" name="description" rows="5" placeholder="Введите описание теста"></textarea>
                    </div>

                    <button type="submit" class="btn btn-register">
                        <i class="fas fa-save"></i> Сохранить тест
                    </button>
                </form>
            </div>
        </section>
    </main>

    <footer>
        <p>© 2025 Центр профессионального тестирования. Все права защищены.</p>
    </footer>
</div>
</body>
</html>
