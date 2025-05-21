package controller.servlets;

import java.io.IOException;
import java.util.ArrayList;


import Model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.DatabaseService;
import utils.StringUtils;


@WebServlet("/UserOrderHistory")
public class UserOrderHistory extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DatabaseService dbController;
       
    
    public UserOrderHistory() {
        super();
        dbController = new DatabaseService();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session  = request.getSession();
		String userName =(String) session.getAttribute(StringUtils.USERNAME);
		ArrayList<Order> orders =(ArrayList<Order>) dbController.getUserOrderHistory(userName);
		request.setAttribute("orders", orders);
		request.getRequestDispatcher("/pages/user_order_history.jsp").forward(request, response);
		
		
		
	
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
