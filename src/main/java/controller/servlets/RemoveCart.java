package controller.servlets;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.DatabaseService;


@WebServlet("/RemoveCart")
public class RemoveCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DatabaseService dbController;
       
    
    public RemoveCart() {
    	super();
    	this.dbController  = new DatabaseService();   
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	int cartId = Integer.parseInt(request.getParameter("cartId"));
	System.out.print(cartId);
	int result = dbController.removeCart(cartId);
	if(result==1) {
		
		response.sendRedirect(request.getContextPath()+"/CartList");
	}
	
	
	}

}
