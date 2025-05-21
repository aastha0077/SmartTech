package controller.servlets;

import java.io.IOException;


import Model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import service.DatabaseService;
import utils.StringUtils;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
maxFileSize = 1024 * 1024 * 10, // 10MB
maxRequestSize = 1024 * 1024 * 50)
@WebServlet("/UpdateProduct")
public class UpdateProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DatabaseService db;
       
    
    public UpdateProduct() {
        super();
        db = new DatabaseService();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int productId= Integer.parseInt(request.getParameter("productId"));
		String productName =  request.getParameter("productName");
		String description = request.getParameter("productDescription");
		int price = Integer.parseInt(request.getParameter("productPrice"));
		int categoryId = Integer.parseInt(request.getParameter("categoryId"));
		int quantity = Integer.parseInt(request.getParameter("productQuantity"));
		Part part = request.getPart("productImage");
		
		Product product = new Product(productId, productName, description, price, categoryId, quantity,part);
		String savePath = StringUtils.IMAGE_DIR_SAVE_PATH;
	    String fileName = product.getImageUrlFromPart();
	    if(!fileName.isEmpty() && fileName != null)
    		part.write(savePath + fileName);

			
	    int res = db.updateProduct(product);
	    System.out.print("result:"+res);
	    if(res==1) {
	    	
	    	request.setAttribute("productUpdated", "true");
	    	request.getRequestDispatcher("/pages/admin.jsp").forward(request, response);
	    	
	    }else if (res==-1) {
	    	
	    	request.setAttribute("productUpdate","false" );
	    	request.getRequestDispatcher("/pages/admin.jsp").forward(request, response);
	    	
			
		}
	
	
	}

}
