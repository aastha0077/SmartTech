package controller.servlets;





import java.io.File;
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


@WebServlet("/AddProduct")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
maxFileSize = 1024 * 1024 * 10, // 10MB
maxRequestSize = 1024 * 1024 * 50)

public class AddProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DatabaseService db = new DatabaseService();

        public AddProductServlet() {
        super();
    }


	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int productId=     Integer.parseInt(request.getParameter("productId"));
		System.out.println("product id");
		System.out.println(productId);
		String productName =  request.getParameter("productName");
		String description = request.getParameter("productDescription");
		int price = Integer.parseInt(request.getParameter("productPrice"));
		System.out.print(request.getParameter("categoryId"));
		int categoryId = Integer.parseInt(request.getParameter("categoryId"));
		
		int quantity = Integer.parseInt(request.getParameter("productQuantity"));
		Part part = request.getPart("productImage");
		
		Product product = new Product(productId, productName, description, price, categoryId, quantity,part);
		String savePath = StringUtils.IMAGE_DIR_SAVE_PATH;
		
		// Handle image file directory and saving
	    System.out.println("Save path: " + savePath);
	    
	    // Create directory if it doesn't exist (double-check before writing)
	    File saveDir = new File(savePath);
	    if (!saveDir.exists()) {
	        boolean created = saveDir.mkdirs();
	        System.out.println("Creating directory result: " + created);
	        
	        // If directory creation failed, check the parent directory
	        if (!created) {
	            System.out.println("Parent directory exists: " + saveDir.getParentFile().exists());
	            System.out.println("Parent directory path: " + saveDir.getParentFile().getAbsolutePath());
	        }
	    }
	    
		System.out.println(savePath);
	    String fileName = product.getImageUrlFromPart();
	    System.out.println("file name");
	    System.out.println(fileName);
	    if(!fileName.isEmpty() && fileName != null)
    		part.write(savePath + fileName);

		
	int res = db.addProduct(product);
	if (res==1) {
		request.setAttribute("productAdded", "yes");
		request.getRequestDispatcher("/pages/admin.jsp").forward(request, response);
		}
	else if(res==-1) {
		
		request.setAttribute("alreadyExists", "yes");
		request.getRequestDispatcher("/pages/admin.jsp").forward(request, response);
			
		
	}	
		
	}


}
