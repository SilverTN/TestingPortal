<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Вход в систему</title>
    <link rel="stylesheet" href="../styles/main.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<div class="auth-login-container">
    <header>
        <h1>Центр профессионального тестирования</h1>
        <p>Оцените навыки сотрудников быстро и объективно</p>
    </header>

    <main>
        <section class="hero">
            <div class="hero-content">
                <h2>Войдите в аккаунт</h2>
                <p>Введите свои данные для входа в систему</p>

                <!-- Сообщение об ошибке -->
                <% if (request.getAttribute("error") != null) { %>
                <p style="color: red; background: rgba(255, 0, 0, 0.1); padding: 10px; border-radius: 6px;">
                    <%= request.getAttribute("error") %>
                </p>
                <% } %>

                <!-- Форма входа -->
                <form action="/login" method="post" class="auth-form">
                    <div class="input-group">
                        <label for="username" style="display: flex; align-items: center; gap: 10px; text-align: left; width: 100%;">
                            <i class="fas fa-user" style="width: 16px; text-align: center;"></i> Имя пользователя
                        </label>
                        <input type="text" id="username" name="username" required
                               placeholder="Введите ваше имя пользователя"
                               style="text-align: left; padding-left: 40px; width: 100%;">
                    </div>

                    <div class="input-group">
                        <label for="password" style="display: flex; align-items: center; gap: 10px; text-align: left; width: 100%;">
                            <i class="fas fa-lock" style="width: 16px; text-align: center;"></i> Пароль
                        </label>
                        <input type="password" id="password" name="password" required
                               placeholder="Введите пароль"
                               style="text-align: left; padding-left: 40px; width: 100%;">
                    </div>

                    <button type="submit" class="btn btn-login">
                        <i class="fas fa-sign-in-alt"></i> Войти
                    </button>
                </form>

                <p class="form-footer">Нет аккаунта? <a href="/registration" class="link" style="color: #3a7fdb">Зарегистрируйтесь</a></p>
            </div>
        </section>
    </main>

    <footer>
        <p>© 2025 Центр профессионального тестирования. Все права защищены.</p>
    </footer>
</div>
</body>
</html>