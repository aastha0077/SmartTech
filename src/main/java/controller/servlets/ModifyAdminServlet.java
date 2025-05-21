package controller.servlets;

import java.io.IOException;




import Model.ModifyUserModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import service.DatabaseService;
import utils.StringUtils;

/**
 * Servlet implementation class ModifyAdminServlet
 */
@WebServlet("/ModifyAdmin")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
maxFileSize = 1024 * 1024 * 10, // 10MB
maxRequestSize = 1024 * 1024 * 50)
public class ModifyAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    DatabaseService dbController;
    public ModifyAdminServlet() {
        super();
        this.dbController = new DatabaseService();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String fullName = request.getParameter("userFullName");
		String address = request.getParameter("userAddress");
		String phoneNumber = request.getParameter("userPhoneNumber");
		String email = request.getParameter("userEmail");
		Part part = request.getPart("userImage");
		String gender= request.getParameter("userGender");
		System.out.print(gender);

		//LocalDate date =LocalDate.parse( request.getParameter("userBirthDate"));
		
		
		
		ModifyUserModel newUser = new ModifyUserModel(fullName, address, phoneNumber, email, gender,part);
		String savePath = StringUtils.IMAGE_DIR_SAVE_PATH_USER;
	    String fileName = newUser.getImageUrlFromPart();
	    
	    if(!fileName.isEmpty() && fileName != null)
    	part.write(savePath + fileName);
	
		HttpSession  userSession  = request.getSession(false);
		String userName = (String)userSession.getAttribute(StringUtils.USERNAME);
		int result = dbController.modifyUser(newUser,userName);
		if(result==1) {
			
		request.getRequestDispatcher("/AdminProfileServlet").forward(request, response);
		
		
		}
			
		
	}

}
