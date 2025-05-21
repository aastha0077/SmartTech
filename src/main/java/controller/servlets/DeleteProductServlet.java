package controller.servlets;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.DatabaseService;
import utils.StringUtils;

@WebServlet("/DeleteProduct")
public class DeleteProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DatabaseService db;
    public DeleteProductServlet() {
    	this.db = new DatabaseService();
    	
        
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int productId = Integer.parseInt(request.getParameter("productId"));
		int result = db.deleteProduct(productId);
		request.getRequestDispatcher("/AdminProducts").forward(request, response);

		
	}
	
	@Override
	protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int productId = Integer.parseInt(req.getParameter("productId"));
		int result = db.deleteProduct(productId);
		if(result==1) {
			req.setAttribute(StringUtils.MESSAGE_SUCCESS, "SuccessFully deleted");
			req.getRequestDispatcher(StringUtils.PAGE_URL_ADMIN).forward(req, resp);

			
		}else if(result==-1) {
			
			req.setAttribute(StringUtils.MESSAGE_SUCCESS, "Product Doesnot Exists");
			req.getRequestDispatcher(StringUtils.PAGE_URL_ADMIN).forward(req, resp);
			
			
		}else {
			System.out.print("What the fuck");
			
		}
		
	}	

}
