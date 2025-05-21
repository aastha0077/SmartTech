package controller.servlets;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;



@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    // Clear cookie
		Cookie[] cookies = request.getCookies();
    	if(cookies != null){
	    	for(Cookie cookie : cookies){
	    		cookie.setMaxAge(0);
	    		response.addCookie(cookie);
	    	}
    	}
        // Clear session
    	HttpSession session = request.getSession(false);
    	if(session != null){
    		session.invalidate();
    	}
    	response.sendRedirect(request.getContextPath()+"/pages/login.jsp");
	}

}
