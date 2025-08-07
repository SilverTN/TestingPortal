<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Регистрация</title>
    <link rel="stylesheet" href="../styles/main.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<div class="auth-login-container">
    <header>
<%--        <img src="../images/logo.png" alt="Логотип портала тестирования" class="logo">--%>
        <h1>Центр профессионального тестирования</h1>
        <p>Оцените навыки сотрудников быстро и объективно</p>
    </header>

    <main>
        <section class="hero">
            <div class="hero-content">
                <h2>Создайте аккаунт</h2>
                <p>Заполните форму ниже, чтобы зарегистрироваться</p>

                <!-- Сообщение об ошибке -->
                <% if (request.getAttribute("error") != null) { %>
                <p style="color: red; background: rgba(255, 0, 0, 0.1); padding: 10px; border-radius: 6px;">
                    <%= request.getAttribute("error") %>
                </p>
                <% } %>

                <!-- Форма регистрации -->
                <form action="/registration" method="post" class="auth-form">
                    <div class="input-group">
                        <label for="username" style="display: flex; align-items: center; gap: 10px; text-align: left;">
                            <i class="fas fa-user"></i> Имя пользователя
                        </label>
                        <input type="text" id="username" name="username" required minlength="3" maxlength="50"
                               placeholder="Введите ваше имя пользователя" style="text-align: left; padding-left: 40px;">
                    </div>

                    <div class="input-group">
                        <label for="password" style="display: flex; align-items: center; gap: 10px; text-align: left;">
                            <i class="fas fa-lock"></i> Пароль
                        </label>
                        <input type="password" id="password" name="password" required minlength="6"
                               placeholder="Введите пароль" style="text-align: left; padding-left: 40px;">
                    </div>

                    <div class="input-group">
                        <label for="confirm_password" style="display: flex; align-items: center; gap: 10px; text-align: left;">
                            <i class="fas fa-lock"></i> Подтвердите пароль
                        </label>
                        <input type="password" id="confirm_password" name="confirm_password" required minlength="6"
                               placeholder="Подтвердите пароль" style="text-align: left; padding-left: 40px;">
                    </div>

                    <div class="input-group">
                        <label for="email" style="display: flex; align-items: center; gap: 10px; text-align: left;">
                            <i class="fas fa-envelope"></i> Email
                        </label>
                        <input type="text" id="email" name="email" required minlength="3" maxlength="50"
                               placeholder="Введите email" style="text-align: left; padding-left: 40px;">
                    </div>

                    <button type="submit" class="btn btn-register">
                        <i class="fas fa-user-plus"></i> Зарегистрироваться
                    </button>
                </form>

                <p class="form-footer">Уже есть аккаунт? <a href="/login" class="link" style="color: #3a7fdb">Войдите</a></p>
            </div>
        </section>
    </main>

    <footer>
        <p>© 2025 Центр профессионального тестирования. Все права защищены.</p>
    </footer>
</div>

<!-- Простая валидация на стороне клиента -->
<script>
    document.querySelector('form').addEventListener('submit', function(e) {
        const password = document.getElementById('password').value;
        const confirm = document.getElementById('confirm_password').value;

        if (password !== confirm) {
            e.preventDefault();
            alert('Пароли не совпадают!');
        }
    });
</script>
</body>
</html>