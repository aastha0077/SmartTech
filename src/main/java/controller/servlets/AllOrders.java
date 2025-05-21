package controller.servlets;

import java.io.IOException;
import java.util.ArrayList;


import Model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.DatabaseService;


@WebServlet("/AllOrders")
public class AllOrders extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DatabaseService dbController;
       
    
    public AllOrders() {
        super();
        this.dbController = new DatabaseService();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			
			ArrayList<Order> orders= (ArrayList<Order>) dbController.getAllOrders();
			request.setAttribute("orders", orders);
			request.getRequestDispatcher("/pages/order_history.jsp").forward(request, response);				
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
