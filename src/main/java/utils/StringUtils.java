package utils;
import java.io.File;
import java.nio.file.Paths;
public class StringUtils {
	// Start: DB Connection
	public static final String DRIVER_NAME = "com.mysql.cj.jdbc.Driver";
	public static final String LOCALHOST_URL = "jdbc:mysql://localhost:3306/SmartTech";
	public static final String LOCALHOST_USERNAME = "root";
	public static final String LOCALHOST_PASSWORD = "";
	// End: DB Connection
	// Start: Queries
	public static final String QUERY_REGISTER_USER = "INSERT INTO user ("
			+ "full_name, email,  user_name, phone_number, address, password,birth_date,gender,role,user_image)"
			+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?,? )";
	public static final String QUERY_ADD_PRODUCT = "INSERT into product(product_id, product_name, description, price, category_id,quantity,product_image)values(?,?,?,?,?,?,?)";
	public static final String QUERY_PRODUCT_CHECK = "SELECT * FROM product where product_id =?";
	public static final String QUERY_PRODUCT_DELETE = "DELETE FROM product where product_id = ?";
	public static final String QUERY_ADMIN_UPDATE = "UPDATE  User SET full_name = ?, address= ?, phone_number = ?,email= ?, gender= ?,user_image = ? where user_name = ?";
	public static final String QUERY_LOGIN_USER_CHECK = "SELECT * FROM User WHERE user_name = ?";
	public static final String QUERY_LOGIN_PASSWORD_CHECK = "SELECT password FROM User where user_name = ?";
	public static final String QUERY_LOGIN_USER_DETAILS = "SELECT user_name, password,role FROM User WHERE user_name = ? ";
	public static final String QUERY_SIGNUP_PHONE_CHECK = "SELECT * FROM User where phone_number = ? ";
	public static final String QUERY_SIGNUP_EMAIL_CHECK = "SELECT * FROM User where email = ?";
	public static final String QUERY_GET_ALL_PRODUCTS = "SELECT * FROM product";
	// End: Queries
	// Start: Parameter names
	public static final String USERNAME = "userName";
	public static final String USER_NAME = "user_name";
	public static final String FIRST_NAME = "firstName";
	public static final String LAST_NAME = "lastName";
	public static final String BIRTHDAY = "birthday";
	public static final String GENDER = "gender";
	public static final String EMAIL = "email";
	public static final String PHONE_NUMBER = "phoneNumber";
	public static final String SUBJECT = "subject";
	public static final String PASSWORD = "password";
	public static final String RETYPE_PASSWORD = "retypePassword";
	// End: Parameter names
	// Start: Validation Messages
	// Register Page Messages
	public static final String MESSAGE_SUCCESS_REGISTER = "Successfully Registered!";
	public static final String MESSAGE_ERROR_REGISTER = "Please correct the form data.";
	public static final String MESSAGE_ERROR_USERNAME = "Username is already registered.";
	public static final String MESSAGE_ERROR_PHONE_NUMBER = "Phone number is already registered.";
	public static final String MESSAGE_ERROR_PASSWORD_UNMATCHED = "Password is not matched.";
	public static final String MESSAGE_ERROR_INCORRECT_DATA = "Please correct all the fields.";
	public static final String MESSAGE_ERROR_PHONE = "Please correct all the fields.";
	public static final String MESSAGE_ERROR_EMAIL  = "Email is already registered";
	public static final String MESSAGE_ERROR_LOGIN_USERNAME = "Username doesnot exists";
	public static final String MESSAGE_ERROR_LOGIN_PASSOWRD = "Incorrect password";
	
	// Login Page Messages
	public static final String MESSAGE_SUCCESS_LOGIN = "Successfully LoggedIn!";
	public static final String MESSAGE_ERROR_LOGIN = "Either username or password is not correct!";
	public static final String MESSAGE_ERROR_CREATE_ACCOUNT = "Account for this username is not registered! Please create a new account.";

	
	//public static final String IMAGE_DIR_USER = "Users/neerazanpokhrel/Desktop/Week3Tutorial/src/main/webapp/resources/images/user/";
	//public static final String IMAGE_DIR_SAVE_PATH =  File.separator + IMAGE_DIR_USER;
	
	public static final String IMAGE_DIR_PRODUCT = "/Users/raghabpokhrel/Desktop/Advanced_Java/smarttech/src/main/webapp/resources/images/products/";

	public static final String IMAGE_DIR_SAVE_PATH = IMAGE_DIR_PRODUCT; // Use the same path directly
//	public static final String IMAGE_DIR_SAVE_PATH = Paths.get(
//		    System.getProperty("user.home"),
//		    "Desktop", "Advanced_Java", "Ecommerce-JEE-", "src", "main", "webapp", "resources", "images", "products"
//		).toAbsolutePath().toString();
	
//	public static final String IMAGE_DIR_SAVE_PATH = 	"/Users/raghabpokhrel/Desktop/Advanced_Java/Ecommerce-JEE-/src/main/webapp/resources/images/products/";

	public static final String IMAGE_DIR_USER = "/Users/raghabpokhrel/Desktop/Advanced_Java/smarttech"+ "/src/main/webapp/resources/images/users/";
	public static final String IMAGE_DIR_SAVE_PATH_USER =  File.separator + IMAGE_DIR_USER;
	
	// Other Messages
	public static final String MESSAGE_ERROR_SERVER = "An unexpected server error occurred.";
	public static final String MESSAGE_SUCCESS_DELETE = "Successfully Deleted!";
	public static final String MESSAGE_ERROR_DELETE = "Cannot delete the user!";

	public static final String MESSAGE_SUCCESS = "successMessage";
	public static final String MESSAGE_ERROR = "errorMessage";
	public static final String PRODUCTS_LISTS = "productList"; 
	// End: Validation Messages
	// Start: JSP Route
	public static final String PAGE_URL_LOGIN = "/pages/login.jsp";
	public static final String PAGE_URL_SIGNUP = "/pages/signup.jsp";
	public static final String PAGE_URL_WELCOME = "/pages/welcome.jsp";
	public static final String PAGE_URL_FOOTER = "pages/footer.jsp";
	public static final String PAGE_URL_HEADER = "pages/header.jsp";
	public static final String PAGE_URL_ADMIN =  "/pages/admin.jsp";
	public static final String PAGE_URL_HOME = "/index.jsp";
	public static final String URL_LOGIN = "/login.jsp";
	public static final String URL_PRODUCTS = "/pages/products.jsp";
	public static final String URL_INDEX = "/home.jsp";
	// End: JSP Route
	// Start: Servlet Route
	public static final String SERVLET_URL_LOGIN = "/login";
	public static final String SERVLET_URL_REGISTER = "/signup";
	public static final String SERVLET_URL_LOGOUT = "/logout";
	public static final String SERVLET_URL_HOME = "/Home";
	// End: Servlet Route
	// Start: Normal Text
	public static final String USER = "user";
	public static final String SUCCESS = "success";
	public static final String TRUE = "true";
	public static final String JSESSIONID = "JSESSIONID";
	public static final String LOGIN = "Login";
	public static final String LOGOUT = "Logout";
	public static final String STUDENT_MODEL = "studentModel";
	// End: Normal Text
	public static final String QUERY_GET_ALL_STUDENTS = null;
}