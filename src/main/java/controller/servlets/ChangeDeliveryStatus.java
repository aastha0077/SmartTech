package controller.servlets;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.DatabaseService;

/**
 * Servlet implementation class ChangeDeliveryStatus
 */
@WebServlet("/ChangeDeliveryStatus")
public class ChangeDeliveryStatus extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DatabaseService dbController;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangeDeliveryStatus() {
    	dbController = new DatabaseService();
    	
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int orderId = Integer.parseInt(request.getParameter("orderId"));
		dbController.changeDeliveryStatus(orderId);
		response.sendRedirect(request.getContextPath()+"/AllOrders");
	
	
	}

}
