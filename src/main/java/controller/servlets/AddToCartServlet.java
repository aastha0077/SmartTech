package controller.servlets;

import java.io.IOException;
import java.util.ArrayList;



import Model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.DatabaseService;
import utils.StringUtils;

/**
 * Servlet implementation class AddToCartServlet
 */
@WebServlet("/AddToCart")
public class AddToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DatabaseService controller;
       
    
    public AddToCartServlet() {
        super();
        this.controller = new DatabaseService();
        		
       
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(true);
		if(session==null) {
			request.setAttribute("loginFirst", "loginFirst");
			request.getRequestDispatcher(StringUtils.URL_PRODUCTS).forward(request, response);		
			
		}
		
		
		if(session!=null) {
			String userName =(String) session.getAttribute(StringUtils.USERNAME);
			int productId = Integer.parseInt(request.getParameter("productId"));
			int res = controller.addToCart(userName, productId);
			if(res==1) {
				//request.getRequestDispatcher(request.getContextPath()+"/Home").forward(request, response);
				//response.sendRedirect(request.getContextPath()+"/Home");
				ArrayList<Product> products = (ArrayList<Product>) controller.getProductsInfo();
				request.setAttribute(StringUtils.PRODUCTS_LISTS, products);
				request.setAttribute("added", "added");
				request.getRequestDispatcher(StringUtils.URL_PRODUCTS).forward(request, response);	

				
			}else if(res==0) {
				ArrayList<Product> products = (ArrayList<Product>) controller.getProductsInfo();
				request.setAttribute(StringUtils.PRODUCTS_LISTS, products);
				request.setAttribute("quantity", "Out of stock");
				request.getRequestDispatcher(StringUtils.URL_PRODUCTS).forward(request, response);	
				
			}
				
			
		}
		
	}

}
