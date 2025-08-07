package filters;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebFilter(filterName = "AuthFilter", urlPatterns = {"/home", "/logout"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        HttpSession session = httpRequest.getSession(false);
        Object user = session != null ? session.getAttribute("user") : null;

        if (user == null) {
            // Пользователь не авторизован — перенаправляем на login
            httpResponse.sendRedirect("login");
        } else {
            // Пользователь авторизован — пускаем дальше
            chain.doFilter(request, response);
        }
    }

    @Override
    public void init(FilterConfig filterConfig) {}

    @Override
    public void destroy() {}
}

