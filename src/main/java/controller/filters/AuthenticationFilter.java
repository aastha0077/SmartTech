package controller.filters;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.StringUtils;

public class AuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String uri = req.getRequestURI();

        // Get session information
        HttpSession session = req.getSession(false);
        boolean isLoggedIn = session != null && session.getAttribute(StringUtils.USERNAME) != null;
        boolean isAdmin = isLoggedIn && "username".equals(session.getAttribute(StringUtils.USERNAME));

        // Always allow static resources and home page
        if (uri.endsWith(".css") || uri.endsWith(".png") || uri.endsWith(".jpg") || uri.endsWith("home.jsp")) {
            chain.doFilter(request, response);
            return;
        }

        // Allow access to these pages without authentication
        if (uri.endsWith(StringUtils.URL_INDEX) || uri.endsWith("/") || 
            uri.endsWith("products.jsp") || uri.endsWith("aboutus.jsp") || 
            uri.endsWith("header.jsp") || uri.endsWith("footer.jsp") ||
            uri.endsWith("filteredproducts.jsp")) {
            chain.doFilter(request, response);
            return;
        }

        // Allow access to login/signup related pages only when not logged in
        boolean isLoginPage = uri.endsWith("login.jsp") || uri.endsWith(StringUtils.PAGE_URL_LOGIN);
        boolean isLoginServlet = uri.endsWith(StringUtils.SERVLET_URL_LOGIN);
        boolean isLogoutServlet = uri.endsWith(StringUtils.SERVLET_URL_LOGOUT);
        boolean isSignupPage = uri.endsWith("signup.jsp") || uri.endsWith(StringUtils.PAGE_URL_SIGNUP);
        boolean isSignupServlet = uri.endsWith("/signup");

        if (isLoginPage || isLoginServlet || isSignupPage || isSignupServlet) {
            if (isLoggedIn) {
                // Redirect to appropriate page if already logged in
                res.sendRedirect(isAdmin ? StringUtils.PAGE_URL_ADMIN : req.getContextPath() + "/home.jsp");
                return;
            }
            chain.doFilter(request, response);
            return;
        }

        // Admin-specific pages
        if (uri.endsWith("admin.jsp") || uri.endsWith("admin_product.jsp") || uri.endsWith("admin_details.jsp")) {
            if (!isLoggedIn) {
                res.sendRedirect(req.getContextPath() + StringUtils.PAGE_URL_LOGIN);
                return;
            }
            if (!isAdmin) {
                res.sendRedirect(req.getContextPath() + "/home.jsp");
                return;
            }
            chain.doFilter(request, response);
            return;
        }

        // User-specific pages
        if (uri.endsWith("cart.jsp") || uri.endsWith("user_order_history.jsp") || uri.endsWith("user_profile.jsp")) {
            if (!isLoggedIn) {
                res.sendRedirect(req.getContextPath() + StringUtils.PAGE_URL_LOGIN);
                return;
            }
            if (isAdmin) {
                res.sendRedirect(req.getContextPath() + StringUtils.PAGE_URL_ADMIN);
                return;
            }
            chain.doFilter(request, response);
            return;
        }

        // Allow access to common servlets
        if (uri.endsWith(StringUtils.SERVLET_URL_HOME) || uri.endsWith("ProductDetail") || uri.endsWith("AddToCart")) {
            chain.doFilter(request, response);
            return;
        }

        // Default behavior for other cases
        if (!isLoggedIn) {
            res.sendRedirect(req.getContextPath() + StringUtils.PAGE_URL_LOGIN);
        } else {
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}