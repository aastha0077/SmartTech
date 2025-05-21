package service;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;


import Model.CartModel;
import Model.ModifyUserModel;
import Model.Order;
import Model.Product;
import Model.User;
import config.DbConfig;
import utils.PasswordEncryption;
import utils.StringUtils;


 
public class DatabaseService {
	
	private	DbConfig dbConfig ;
	
	public DatabaseService () {
		this.dbConfig = new DbConfig();
		
	}
	
	public Connection getConnection() throws ClassNotFoundException, SQLException {
//		Class.forName(StringUtils.DRIVER_NAME);
//		String url = StringUtils.LOCALHOST_URL;
//		String user = StringUtils.LOCALHOST_USERNAME;
//		String pass = StringUtils.LOCALHOST_PASSWORD;
		Connection connection = dbConfig.getConnection();
		return connection;	
		
	}

	
	
	public int addUser(User user) throws ClassNotFoundException, SQLException {
		Connection connection  = getConnection();
		PreparedStatement st = connection.prepareStatement(StringUtils.QUERY_REGISTER_USER);
		
		PreparedStatement stUsername = connection.prepareStatement(StringUtils.QUERY_LOGIN_USER_CHECK);
		stUsername.setString(1, user.getUserName());
		ResultSet resUsername = stUsername.executeQuery();
		if(resUsername.next()) {
			
			return -1;
		}
		
		PreparedStatement stPhoneNumber = connection.prepareStatement(StringUtils.QUERY_SIGNUP_PHONE_CHECK);
		stPhoneNumber.setString(1, user.getPhoneNumber());
		ResultSet resPhoneNumber = stPhoneNumber.executeQuery();
		if(resPhoneNumber.next()) {
			
			return -2;
		}
		
		
		PreparedStatement stEmail = connection.prepareStatement(StringUtils.QUERY_SIGNUP_EMAIL_CHECK);
		stEmail.setString(1, user.getEmail());
		ResultSet resEmail = stEmail.executeQuery();
		if(resEmail.next()) {
			
			return -3;
		}
		
		
		
		
		String fullName =  user.getFullName();
		String email = user.getEmail();
		String userName = user.getUserName();
		String phoneNumber = user.getPhoneNumber();
		String address = user.getAddress();
		String password = user.getPassword();
		LocalDate dob = user.getDob();
		String role = user.getRole();
		String gender = user.getGender();
	
		
		st.setString(1, fullName);
		st.setString(2, email);
		st.setString(3, userName);
		st.setString(4, phoneNumber);
		st.setString(5, address);
		st.setString(6, PasswordEncryption.encrypt(userName, password));
		st.setDate(7, Date.valueOf(dob));
		st.setString(8, gender);
		st.setString(9, role);
		st.setString(10, user.getImageUrlFromPart());
		
		int result = st.executeUpdate();
		if(result>0) {
			
			return 1;
			
		}
		return 0;	
	}
	
	public int userInfo(String userName,String password) {
		
		try {
			Connection connection =  getConnection();
			PreparedStatement stUserName = connection.prepareStatement(StringUtils.QUERY_LOGIN_USER_CHECK);
			stUserName.setString(1, userName);
			ResultSet resUsername = stUserName.executeQuery();
			if(!resUsername.next()) {

				return -2;
				
			}
			PreparedStatement stPassword = connection.prepareStatement(StringUtils.QUERY_LOGIN_PASSWORD_CHECK);
			
			
			
			stPassword.setString(1, userName);
			
			ResultSet resPassword = stPassword.executeQuery();
			if(resPassword.next()) {
				String passwordDb = 	resPassword.getString("password");
				String  decryptedPwd = utils.PasswordEncryption.decrypt(passwordDb, userName);
				if(!decryptedPwd.equals(password)) {
					

					return -3;
					
				}	
				
			}

			
			PreparedStatement stUser = connection.prepareStatement(StringUtils.QUERY_LOGIN_USER_DETAILS);
			stUser.setString(1,userName);
			ResultSet result = stUser.executeQuery();
			if(result.next()) {

				if(result.getString("role").equals("Admin")) {
					String userDb = result.getString("user_name");
					System.out.println(userDb);
					String passwordDb  = result.getString("password");
					System.out.print(passwordDb);
					String decryptedPwd = utils.PasswordEncryption.decrypt(passwordDb, userName);
					System.out.println(decryptedPwd);
					System.out.println(decryptedPwd);
					if(decryptedPwd!=null && userDb.equals(userName) && decryptedPwd.equals(password)) {
					
						return 1;
					} 
					
					
				}
				else {
					
					String userDb = result.getString("user_name");
					System.out.println(userDb);
					String passwordDb  = result.getString("password");
					System.out.println(passwordDb);
					String decryptedPwd = utils.PasswordEncryption.decrypt(passwordDb, userName);
					System.out.println(decryptedPwd);
					if(decryptedPwd!=null && userDb.equals(userName) && decryptedPwd.equals(password)) {
					
						return 2;
					}
					
				}
			}
		}catch (SQLException|ClassNotFoundException e) {
			
			
			return -1;
			
		}
		
		return -1;
			
		
	}
	public List<Product> getProductsInfo(){
		try {
			Connection connection = getConnection();
			PreparedStatement st = connection.prepareStatement(StringUtils.QUERY_GET_ALL_PRODUCTS);
			ResultSet result = st.executeQuery();
			ArrayList<Product> products = new ArrayList<Product>();
			while(result.next()) {
				Product product = new Product();
				product.setProductId(result.getInt("product_id"));
				product.setProductName(result.getString("product_name"));
				product.setDescription(result.getString("description"));
				product.setPrice(result.getInt("price"));
				product.setCategoryId(result.getInt("category_id"));
				product.setQuantity(result.getInt("quantity"));
				product.setImageUrlFromPart(result.getString("product_image"));
				products.add(product);
			
				
				
			}
			
			return products;
			
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
			return null;
		} catch (SQLException e) {
			
			
			e.printStackTrace();
			return null;
		}	
		
	}
	public int addProduct(Product product) {
		try {
			Connection connection = getConnection();
			PreparedStatement st = connection.prepareStatement(StringUtils.QUERY_ADD_PRODUCT);
			PreparedStatement stProductCheck = connection.prepareStatement(StringUtils.QUERY_PRODUCT_CHECK);
			stProductCheck.setInt(1,product.getProductId());
			ResultSet res = stProductCheck.executeQuery();
			if(res.next()) {
				

				return -1;
			}
				
			st.setInt(1,product.getProductId());
			st.setString(2, product.getProductName());
			st.setString(3, product.getDescription());
			st.setInt(4, product.getPrice());
			st.setInt(5, product.getCategoryId());
			st.setInt(6,product.getQuantity() );
			st.setString(7,product.getImageUrlFromPart());			
			int result =st.executeUpdate();
			if(result>0) {
				
				
				return 1;	
			}
				
			
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		return 0;
			
	}
	public int updateProduct(Product product) {
		try {
			int productId = product.getProductId();
			Connection connection = getConnection();
			PreparedStatement st = connection.prepareStatement("SELECT * FROM Product WHERE  product_id = ?");
			st.setInt(1, productId);
			ResultSet set1 = st.executeQuery();
			if(set1.next()) {
				PreparedStatement st2 = connection.prepareStatement("UPDATE Product set product_name= ?, description = ?, price= ?, category_id=?,quantity=?,product_image=? WHERE product_id =?");
				st2.setString(1, product.getProductName());
				st2.setString(2, product.getDescription());
				st2.setInt(3, product.getPrice());
				st2.setInt(4, product.getCategoryId());
				st2.setInt(5, product.getQuantity());
				st2.setString(6,product.getImageUrlFromPart());
				st2.setInt(7, productId);
				int r = st2.executeUpdate();
				if(r>0) {
					
					return 1;
				}
				
				
				
			}else {
				
				return -1;
			}
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		
		
		return 0 ;
		
	}
//	
//	public int updateProduct(Product updatedProduct) {
//	    try {
//	        Connection connection = getConnection();
//
//	        // 1. Check if the product exists
//	        PreparedStatement checkStmt = connection.prepareStatement(StringUtils.QUERY_PRODUCT_CHECK);
//	        checkStmt.setInt(1, updatedProduct.getProductId());
//	        ResultSet existingProduct = checkStmt.executeQuery();
//
//	        if (!existingProduct.next()) {
//	            return -1; // Product not found
//	        }
//
//	        // 2. Get the current values from the database
//	        String currentName = existingProduct.getString("product_name");
//	        String currentDesc = existingProduct.getString("description");
//	        int currentPrice = existingProduct.getInt("price");
//	        int currentCategoryId = existingProduct.getInt("category_id");
//	        int currentQuantity = existingProduct.getInt("quantity");
//	        String currentImageUrl = existingProduct.getString("image_url");
//
//	        // 3. Prepare the UPDATE query (only modify fields with new values)
//	        StringBuilder updateQuery = new StringBuilder("UPDATE products SET ");
//	        List<Object> params = new ArrayList<>();
//
//	        // Product Name
//	        if (updatedProduct.getProductName() != null && !updatedProduct.getProductName().isEmpty()) {
//	            updateQuery.append("product_name = ?, ");
//	            params.add(updatedProduct.getProductName());
//	        } else {
//	            updateQuery.append("product_name = ?, ");
//	            params.add(currentName);
//	        }
//
//	        // Description
//	        if (updatedProduct.getDescription() != null && !updatedProduct.getDescription().isEmpty()) {
//	            updateQuery.append("description = ?, ");
//	            params.add(updatedProduct.getDescription());
//	        } else {
//	            updateQuery.append("description = ?, ");
//	            params.add(currentDesc);
//	        }
//
//	        // Price (assuming 0 means no update)
//	        if (updatedProduct.getPrice() != 0) {
//	            updateQuery.append("price = ?, ");
//	            params.add(updatedProduct.getPrice());
//	        } else {
//	            updateQuery.append("price = ?, ");
//	            params.add(currentPrice);
//	        }
//
//	        // Category ID (assuming 0 means no update)
//	        if (updatedProduct.getCategoryId() != 0) {
//	            updateQuery.append("category_id = ?, ");
//	            params.add(updatedProduct.getCategoryId());
//	        } else {
//	            updateQuery.append("category_id = ?, ");
//	            params.add(currentCategoryId);
//	        }
//
//	        // Quantity (assuming 0 means no update)
//	        if (updatedProduct.getQuantity() != 0) {
//	            updateQuery.append("quantity = ?, ");
//	            params.add(updatedProduct.getQuantity());
//	        } else {
//	            updateQuery.append("quantity = ?, ");
//	            params.add(currentQuantity);
//	        }
//
//	        // Image URL
//	        if (updatedProduct.getImageUrlFromPart() != null && !updatedProduct.getImageUrlFromPart().isEmpty()) {
//	            updateQuery.append("image_url = ?, ");
//	            params.add(updatedProduct.getImageUrlFromPart());
//	        } else {
//	            updateQuery.append("image_url = ?, ");
//	            params.add(currentImageUrl);
//	        }
//
//	        // Remove the last ", " and add WHERE condition
//	        updateQuery.setLength(updateQuery.length() - 2);
//	        updateQuery.append(" WHERE product_id = ?");
//	        params.add(updatedProduct.getProductId());
//
//	        // Execute the update
//	        PreparedStatement updateStmt = connection.prepareStatement(updateQuery.toString());
//	        for (int i = 0; i < params.size(); i++) {
//	            updateStmt.setObject(i + 1, params.get(i));
//	        }
//
//	        int result = updateStmt.executeUpdate();
//	        return result > 0 ? 1 : 0;
//
//	    } catch (ClassNotFoundException e) {
//	        e.printStackTrace();
//	    } catch (SQLException e) {
//	        e.printStackTrace();
//	    }
//	    return 0;
//	}
//	
	
	
	
	
	
	
	
	public  int deleteProduct(int productID)
	{
		try {
			Connection connection = getConnection();
			PreparedStatement stCheck = connection.prepareStatement(StringUtils.QUERY_PRODUCT_CHECK);
			stCheck.setInt(1, productID);
			ResultSet res1 = stCheck.executeQuery();
			if(res1.next()) 
			{
				PreparedStatement stDeleteCart = connection.prepareStatement("DELETE FROM Cart where product_id = ?");
				stDeleteCart.setInt(1, productID);
				
				PreparedStatement stDeleteOrder = connection.prepareStatement("DELETE FROM order_details where product_id = ?");
				stDeleteOrder.setInt(1, productID);
				stDeleteOrder.executeUpdate();
				
				PreparedStatement stDelete = connection.prepareStatement(StringUtils.QUERY_PRODUCT_DELETE);
				stDelete.setInt(1, productID);
				int res2 = stDelete.executeUpdate();
				if(res2>1) 
				{
						
				return 1;
				
				}	
	
			}
			else 
			{
				
				return -1;
			}
			
			
		} catch (ClassNotFoundException | SQLException e) {
			
			e.printStackTrace();
			return 0;
		}
		return 0;	
		
		
	}
	
	public User getUserDetail(String userName) {
		try {
			Connection connection = getConnection();
			PreparedStatement stDetail = connection.prepareStatement("SELECT full_name, address,phone_number,email,birth_date,gender,user_image from user where user_name = ? ");
			stDetail.setString(1, userName);
			ResultSet res = stDetail.executeQuery();
			if(res.next()) {
				
				User user  = new User();
				user.setFullName(res.getString("full_name"));
				user.setAddress(res.getString("address"));
				user.setPhoneNumber(res.getString("phone_number"));
				user.setPhoneNumber(res.getString("phone_number"));
				user.setGender(res.getString("gender"));
				user.setEmail(res.getString("email"));
				user.setImageUrlFromPart(res.getString("user_image"));
				
				return user;	
				
			}
			
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		
		return null;
		
		
	}
	public int  modifyUser(ModifyUserModel user,String userName) {
		try {
			Connection connection = getConnection();
			PreparedStatement st = connection.prepareStatement(StringUtils.QUERY_ADMIN_UPDATE);
			st.setString(1, user.getFullName());
			st.setString(2, user.getAddress());
			st.setString(3, user.getPhoneNumber());
			st.setString(4, user.getEmail());
			st.setString(5, user.getGender());
			st.setString(6,user.getImageUrlFromPart()); 
			st.setString(7, userName);
			int result = st.executeUpdate();
			if(result>0) {
				
				return 1;
				
			}else {
				
				
				return -1;
			}

			
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return 0;
			
		
	}
	
	
	public Product getProductDetail(int productId) {
		try {
			Connection connection  = getConnection();
			PreparedStatement st  = connection.prepareStatement("SELECT * FROM product where product_id =?");
			st.setInt(1, productId);
			ResultSet result = st.executeQuery();
			if(result.next()) {
				Product product  = new Product();
				product.setDescription(result.getString("description"));
				product.setProductName(result.getString("product_name"));
				product.setPrice(result.getInt("price"));
				product.setImageUrlFromPart(result.getString("product_image"));
				return product;
					
				
			}
			
			
			
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return null;
		
		
	}
	
	public int addToCart(String userName, int productId) {
		try {
			Connection connection = getConnection();

			PreparedStatement st = connection.prepareStatement("SELECT quantity from Product where product_id = ?");
			st.setInt(1, productId);
			ResultSet result = st.executeQuery();
			if(result.next()) {
			int quantity = result.getInt(1);
				if(quantity==0) {
				
				return 0;
					}
				
		}
			
			PreparedStatement st3 = connection.prepareStatement("UPDATE Product\n"
					+ "SET quantity = quantity - 1\n"
					+ "WHERE product_id =?");
			st3.setInt(1, productId);
			st3.executeUpdate();
			
			PreparedStatement  st1 = connection.prepareStatement("SELECT product_id from Cart where product_id =?");
			st1.setInt(1, productId);
			ResultSet result1 = st1.executeQuery();
			if(result1.next()) {
				PreparedStatement st2 = connection.prepareStatement("UPDATE Cart\n"
						+ "				SET quantity = quantity + 1\n"
						+ "				WHERE  product_id = ? AND user_name = ?;");
				st2.setInt(1, productId);
				st2.setString(2,userName);
				int result2 = st2.executeUpdate();
				if(result2>0) {
					
					return 1;
					
				}
					
				
			}
			
			
			PreparedStatement statement = connection.prepareStatement("INSERT INTO Cart (product_id, user_name,quantity) values (?,?,?)");
			
			statement.setInt(1, productId);
			statement.setString(2, userName);
			statement.setInt(3,1);
			
			int res = statement.executeUpdate();
			if(res>0) {
				
				return 1;
				
			}
			
			
			
			
		} catch (ClassNotFoundException | SQLException e) {
			
			
			e.printStackTrace();
		}
		
		
		
		return productId;
		
		
		
	}
	
	public List<Product> getAllProducts(){
		try {
			Connection connection = getConnection();
			PreparedStatement st = connection.prepareStatement(StringUtils.QUERY_GET_ALL_PRODUCTS);
			ResultSet result = st.executeQuery();
			ArrayList<Product> products = new ArrayList<Product>();
			while(result.next()) {
				Product product = new Product();
				product.setProductId(result.getInt("product_id"));
				product.setProductName(result.getString("product_name"));
				product.setDescription(result.getString("description"));
				product.setPrice(result.getInt("price"));
				product.setCategoryId(result.getInt("category_id"));
				product.setQuantity(result.getInt("quantity"));
				products.add(product);
			
				
				
			}
			
			return products;
			
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
			return null;
		} catch (SQLException e) {
			
			
			e.printStackTrace();
			return null;
		}	
		
	}
	public int getProductsQuantity() {
		
		
		try {
			Connection	connection = getConnection();
			PreparedStatement st = connection.prepareStatement("SELECT SUM(quantity) FROM product");
			ResultSet result = st.executeQuery();
			if(result.next()) {
				
				int sum = result.getInt(1);
				return sum;
				
			}
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return 0;
			
	}

	public List<CartModel> getAllCartItems(String userName){
		try {
			Connection connection  = getConnection();
			PreparedStatement st = connection.prepareStatement("SELECT Cart.cart_id, Cart.quantity,Product.product_image,Product.price, Product.product_name,Product.description,Product.product_id\n"
					+ "FROM Cart\n"
					+ "JOIN Product ON Cart.product_id = Product.product_id where Cart.user_name= ?");
			st.setString(1, userName);
			ResultSet result = st.executeQuery();
			ArrayList<CartModel> list = new ArrayList<CartModel>();
			while(result.next()) {
				CartModel product = new CartModel();
				product.setCartId(result.getInt("cart_id"));
				product.setDescription(result.getString("description"));
				product.setProductName(result.getString("product_name"));
				product.setImageUrl(result.getString("product_image"));
				product.setQuantity(result.getInt("quantity"));
				product.setPrice(result.getInt("price"));
				product.setProductId(result.getInt("product_id"));
				list.add(product);	
	
			}
			return list;
		} catch (ClassNotFoundException | SQLException e) {

			e.printStackTrace();
		}
		
		return null;	
		
	}
	
	
	
	
	
	public int removeCart(int cartId) {
		try {
			Connection connection = getConnection();
			PreparedStatement statement  = connection.prepareStatement("SELECT product_id from Cart where cart_id = ?");
			PreparedStatement statement2 = connection.prepareStatement("SELECT quantity from Cart where cart_id =?");
			statement2.setInt(1, cartId);
			ResultSet set = statement2.executeQuery();
			int quantity = 0;
			if(set.next()) {
				quantity = set.getInt("quantity");
				
			}
			System.out.print("Quantity:"+quantity);
			statement.setInt(1, cartId);
			ResultSet res = statement.executeQuery();
			if(res.next()) {
				
				int productId = res.getInt("product_id");
				System.out.print("Product id:"+productId);
				
				PreparedStatement statement3 = connection.prepareStatement("UPDATE Product\n"
						+ "				SET quantity = quantity + ?\n"
						+ "				WHERE  product_id = ?");
				statement3.setInt(1, quantity);
				statement3.setInt(2, productId);
				statement3.executeUpdate();
				
				
			}
			PreparedStatement st = connection.prepareStatement("DELETE FROM Cart where cart_id = ?");
			st.setInt(1, cartId);
			int result = st.executeUpdate();
			if(result>0) {
				return 1;
				
			}
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return 0;
		
		
		
	}
	
	public List<Product> getFilteredProducts(String name){
		try {
			
		Connection 	connection = getConnection();
		PreparedStatement st = connection.prepareStatement("SELECT * FROM Product WHERE product_name LIKE ?");
		st.setString(1,"%"+ name+"%");
		ResultSet result = st.executeQuery();
		List<Product> products = new ArrayList<Product>();
 		while(result.next()) {
 			Product product  =  new Product();
			product.setProductId(result.getInt("product_id"));
			product.setProductName(result.getString("product_name"));
			product.setDescription(result.getString("description"));
			product.setPrice(result.getInt("price"));
			product.setCategoryId(result.getInt("category_id"));
			product.setQuantity(result.getInt("quantity"));
			product.setImageUrlFromPart(result.getString("product_image"));
			products.add(product);
 			
 			
 		}
 		return products;

		} catch (ClassNotFoundException | SQLException e) {
						e.printStackTrace();
		}
				return null;
		
		
		
	}
	
	public List<Product> getProductsCategoryWise(String category){
//		
//				("SELECT  Product.*\n"
//				+ "FROM Product_Category\n"
//				+ "JOIN Product ON Product_Category.category_id = Product.category_id where Product_Category.user_name= ?")
		
		try {
			Connection connection  = getConnection();
			PreparedStatement st = connection.prepareStatement("SELECT  Product.*\n"
					+ "FROM Product_Category\n"
					+ "JOIN Product ON Product_Category.Category_id = Product.category_id where Product_Category.category_name= ?");
			st.setString(1, category);
			ResultSet result = st.executeQuery();
			List<Product> products = new ArrayList<Product>();
			while(result.next()) {
				Product product  =  new Product();
				product.setProductId(result.getInt("product_id"));
				product.setProductName(result.getString("product_name"));
				product.setDescription(result.getString("description"));
				product.setPrice(result.getInt("price"));
				product.setCategoryId(result.getInt("category_id"));
				product.setQuantity(result.getInt("quantity"));
				product.setImageUrlFromPart(result.getString("product_image"));
				products.add(product);	
			}
			
			return products;
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		
		
		
		return null;	
		
		
	}
	
	public int createOrder(String userName) {
		try {
			Connection connection = getConnection();
			Date currentDate =Date.valueOf( LocalDate.now());
			String status = "Pending";
			
			PreparedStatement stPrice = connection.prepareStatement("SELECT SUM(Product.price * Cart.quantity) AS total_price\n"
					+ "			FROM Product\n"
					+ "			JOIN Cart ON Product.product_id = Cart.product_id where Cart.user_name = ?;\n"
					+ "");
			stPrice.setString(1, userName);
			ResultSet result = stPrice.executeQuery();
			int totalPrice = 0;
			if(result.next()) {
				
				totalPrice = result.getInt("total_price");
				
			}
		
			PreparedStatement st1 = connection.prepareStatement("INSERT INTO order_table (order_date, status, user_name ,total_price) values (?,?,?,?)");
			st1.setDate(1, currentDate);
			st1.setString(2,status);
			st1.setString(3,userName);
			st1.setInt(4, totalPrice);
			st1.executeUpdate();
			
			PreparedStatement st2 = connection.prepareStatement("SELECT order_id from order_table where user_name = ?");
			st2.setString(1,userName);
			ResultSet set = st2.executeQuery();
			int order_id = 0;
			while(set.next()) {
				
				order_id = set.getInt("order_id");
				
				
			}
			
			
		
			PreparedStatement st3 = connection.prepareStatement("INSERT INTO order_details (quantity, price, order_id, product_id) values (?,?,?,?)");
			
			ArrayList<CartModel> cartList = (ArrayList<CartModel>)getAllCartItems(userName);
			for(CartModel product:cartList) {
				st3.setInt(1, product.getQuantity());
				st3.setInt(2, product.getPrice());
				st3.setInt(3, order_id);
				st3.setInt(4, product.getProductId());	
				st3.executeUpdate();
			}
			
			PreparedStatement st4 = connection.prepareStatement("DELETE FROM Cart where user_name =  ?");
			st4.setString(1, userName);
			st4.executeUpdate();
			
			return 1;
					
			
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return 0;
		
	}
	
	public int getTotalPrice(String userName) {
	
		try {
			Connection connection = getConnection();
			PreparedStatement stPrice = connection.prepareStatement("SELECT SUM(Product.price * Cart.quantity) AS total_price\n"
					+ "			FROM Product\n"
					+ "			JOIN Cart ON Product.product_id = Cart.product_id where Cart.user_name = ?;\n"
					+ "");
			stPrice.setString(1, userName);
			ResultSet result = stPrice.executeQuery();
			int totalPrice = 0;
			if(result.next()) {
				
				totalPrice = result.getInt("total_price");
				
			}
			
			return totalPrice;
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
		
		
		return 0;
		
		
	}
	
	public List<Order> getAllOrders(){
		try {
			Connection connection  = getConnection();
			PreparedStatement st = connection.prepareStatement("SELECT \n"
					+ "    od.order_id, \n"
					+ "    od.order_date, \n"
					+ "    od.status, \n"
					+ "    od.user_name, \n"
					+ "    pd.quantity, \n"
					+ "    pd.price, \n"
					+ "    p.product_name\n"
					+ "FROM \n"
					+ "    order_table od\n"
					+ "JOIN \n"
					+ "    order_details pd ON od.order_id = pd.order_id\n"
					+ "JOIN \n"
					+ "    Product p ON pd.product_id = p.product_id;\n"
					+ "");
			
			ResultSet result = st.executeQuery();
			ArrayList<Order> orders= new ArrayList<Order>();
			while(result.next()) {
				Order order = new Order();
				order.setOrderId(result.getInt("order_id"));
				order.setOrderDate(result.getDate("order_date"));
				order.setStatus(result.getString("status"));
				order.setUserName(result.getString("user_name"));
				order.setProductPrice(result.getInt("price"));
				order.setProductName(result.getString("product_name"));
				orders.add(order);	
				
			}
			
			return orders;
			
			
			
			
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		
		
		
		return null;
		
		
	}
	
	
	public void changeDeliveryStatus(int orderId) {
		try {
			Connection connection = getConnection();
			PreparedStatement st = connection.prepareStatement("UPDATE order_table set status ='Delivered' where order_id=?" );
			st.setInt(1, orderId);
			st.executeUpdate();
			
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		
		
		
		
	}
	
	
	public List<Order> getUserOrderHistory(String userName){
		try {
			Connection connection  = getConnection();
			PreparedStatement st = connection.prepareStatement("SELECT \n"
					+ "    od.order_id, \n"
					+ "    od.order_date, \n"
					+ "    od.status, \n"
					+ "    od.user_name, \n"
					+ "    pd.quantity, \n"
					+ "    pd.price, \n"
					+ "    p.product_name\n"
					+ "FROM \n"
					+ "    order_table od\n"
					+ "JOIN \n"
					+ "    order_details pd ON od.order_id = pd.order_id\n"
					+ "JOIN \n"
					+ "    Product p ON pd.product_id = p.product_id\n"
					+ "where user_name = ?;");
		
			st.setString(1, userName);	
			ResultSet result = st.executeQuery();
			ArrayList<Order> orders= new ArrayList<Order>();
			while(result.next()) {
				Order order = new Order();
				order.setOrderId(result.getInt("order_id"));
				order.setOrderDate(result.getDate("order_date"));
				order.setStatus(result.getString("status"));
				order.setUserName(result.getString("user_name"));
				order.setProductPrice(result.getInt("price"));
				order.setProductName(result.getString("product_name"));
				orders.add(order);	
				
			}
			
			return orders;
			
			
			
			
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
	
		return null;
		
		
	}
	
	public List<Order> getRecentOrders(){
		try {
			Connection connection = getConnection();
			PreparedStatement st = connection.prepareStatement("SELECT * FROM order_table");
			ResultSet result = st.executeQuery();
			List<Order> orders = new ArrayList<Order>(); 
			int i = 1;
			while(i<=5) {
				Order order = new Order();
				order.setOrderId(result.getInt("order_id"));
				order.setOrderDate(result.getDate("order_date"));
				order.setStatus(result.getString("status"));
				order.setUserName(result.getString("user_name"));
				order.setTotalPrice(result.getInt("total_price"));
				orders.add(order);
				
				
			}
			
			return orders;
			
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		
		return null;
		
		
	}
	
}

	
	

	

