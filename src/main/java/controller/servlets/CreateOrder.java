package controller.servlets;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.DatabaseService;
import utils.StringUtils;

@WebServlet("/CreateOrder")
public class CreateOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DatabaseService dbController;
       
    public CreateOrder() {
        super();
    	dbController = new DatabaseService();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession userSession = request.getSession();
		String userName = (String)userSession.getAttribute(StringUtils.USERNAME);
		int result  = dbController.createOrder(userName);
		if(result==1) {
			
			request.setAttribute("orderSuccess", "Success");
			request.getRequestDispatcher("/home.jsp").forward(request, response);	
			
		}else {
	
		}
				
	}

}
