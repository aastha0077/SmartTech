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
import utils.StringUtils;
@WebServlet("/Category")
public class Category extends HttpServlet {
	private static final long serialVersionUID = 1L;   
    DatabaseService dbController;
    public Category() {
        super();
        this.dbController = new DatabaseService();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String category = request.getParameter("category");
		if(category.equals("all")){

			ArrayList<Product> products = (ArrayList<Product>) dbController.getProductsInfo();
			request.setAttribute(StringUtils.PRODUCTS_LISTS, products);
			request.getRequestDispatcher("/pages/products.jsp").forward(request, response);
			
		}else {
			ArrayList<Product> products = (ArrayList<Product>) dbController.getProductsCategoryWise(category);
			request.setAttribute(StringUtils.PRODUCTS_LISTS, products);
			request.getRequestDispatcher("/pages/products.jsp").forward(request, response);	
			
		}
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	
	}

}
