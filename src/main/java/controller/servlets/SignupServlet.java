package controller.servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;

 

import Model.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import service.DatabaseService;
import utils.StringUtils;


@WebServlet("/signup")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
maxFileSize = 1024 * 1024 * 10, // 10MB
maxRequestSize = 1024 * 1024 * 50)
public class SignupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	DatabaseService db = new DatabaseService();
       
    
    public SignupServlet() {
        super();
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
		// TODO Auto-generated method stub
		String fullName = request.getParameter("fullName");
	
		String email = request.getParameter("email");

		String userName = request.getParameter("userName");

		String phoneNumber = request.getParameter("phoneNumber");

		
		String address = request.getParameter("address");

		String password = request.getParameter("password");

		String confirmPassword = request.getParameter("confirmPassword");

		LocalDate dob = LocalDate.parse(request.getParameter("birthDate"));
		
		String gender = request.getParameter("gender");
		
		Part imagePart = request.getPart("image");		
		
		String role = "Customer";
		
	
		try {
		
			if(confirmPassword.equals(password)) {
				User user = new User(fullName, email, userName, phoneNumber, address, password,gender,imagePart,dob,role);
				String savePath = StringUtils.IMAGE_DIR_SAVE_PATH_USER;
			    String fileName = user.getImageUrlFromPart();
			    
			    if(!fileName.isEmpty() && fileName != null)
		    	imagePart.write(savePath + fileName);

				int result = db.addUser(user);
				if(result==1) {
					Cookie cookie = new Cookie(gender, gender);
					response.sendRedirect(request.getContextPath()+StringUtils.PAGE_URL_LOGIN);
				}
				else if (result==-1) {
					request.setAttribute(StringUtils.MESSAGE_ERROR, StringUtils.MESSAGE_ERROR_USERNAME);
					RequestDispatcher rd = request.getRequestDispatcher(StringUtils.PAGE_URL_SIGNUP);
					rd.forward(request, response);
					
				}
				else if (result==-2) {
					request.setAttribute(StringUtils.MESSAGE_ERROR, StringUtils.MESSAGE_ERROR_PHONE_NUMBER);
					RequestDispatcher rd = request.getRequestDispatcher(StringUtils.PAGE_URL_SIGNUP);
					rd.forward(request, response);
					
				}else if (result==-3) {
					request.setAttribute(StringUtils.MESSAGE_ERROR, StringUtils.MESSAGE_ERROR_EMAIL);
					RequestDispatcher rd = request.getRequestDispatcher(StringUtils.PAGE_URL_SIGNUP);
					rd.forward(request, response);
				}
			
			}
			else {
				request.setAttribute(StringUtils.MESSAGE_ERROR,StringUtils.MESSAGE_ERROR_PASSWORD_UNMATCHED);
				RequestDispatcher rd = request.getRequestDispatcher(StringUtils.PAGE_URL_SIGNUP);
				rd.forward(request, response);
				
				
			}
		} catch (ClassNotFoundException | SQLException e) {
			
			e.printStackTrace();
		}
		
		
	}

}
