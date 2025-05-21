package controller.servlets;

import java.io.IOException;
import java.util.ArrayList;


import Model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.DatabaseService;
@WebServlet("/AdminProducts")
public class AdminProducts extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DatabaseService dbController;
	
    public AdminProducts() {
    	dbController = new DatabaseService();
        
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ArrayList<Product> products = (ArrayList<Product>) dbController.getAllProducts();
		request.setAttribute("productList", products);
		request.getRequestDispatcher("/pages/admin_product.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
