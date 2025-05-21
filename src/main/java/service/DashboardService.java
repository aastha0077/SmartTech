package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Model.Order;
import Model.Product;
import config.DbConfig;
import utils.StringUtils;


public class DashboardService {
	private final DbConfig dbConfig;
	private Connection connection;

	public DashboardService(DbConfig dbConfig) {
		this.dbConfig = dbConfig;
		try {
			this.connection = dbConfig.getConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public List<Product> getProductsInfo() {
		try {

			PreparedStatement st = connection.prepareStatement(StringUtils.QUERY_GET_ALL_PRODUCTS);
			ResultSet result = st.executeQuery();
			ArrayList<Product> products = new ArrayList<Product>();
			while (result.next()) {
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

		} catch (SQLException e) {

			e.printStackTrace();
			return null;
		}
	}

	public int addProduct(Product product) {
		try {

			PreparedStatement st = connection.prepareStatement(StringUtils.QUERY_ADD_PRODUCT);
			PreparedStatement stProductCheck = connection.prepareStatement(StringUtils.QUERY_PRODUCT_CHECK);
			stProductCheck.setInt(1, product.getProductId());
			ResultSet res = stProductCheck.executeQuery();
			if (res.next()) {

				return -1;
			}

			st.setInt(1, product.getProductId());
			st.setString(2, product.getProductName());
			st.setString(3, product.getDescription());
			st.setInt(4, product.getPrice());
			st.setInt(5, product.getCategoryId());
			st.setInt(6, product.getQuantity());
			st.setString(7, product.getImageUrlFromPart());
			int result = st.executeUpdate();
			if (result > 0) {

				return 1;
			}

		} catch (SQLException e) {

			e.printStackTrace();
		}
		return 0;

	}

	public int updateProduct(Product product) {
		try {
			int productId = product.getProductId();

			PreparedStatement st = connection.prepareStatement("SELECT * FROM Product WHERE  product_id = ?");
			st.setInt(1, productId);
			ResultSet set1 = st.executeQuery();
			if (set1.next()) {
				PreparedStatement st2 = connection.prepareStatement(
						"UPDATE Product set product_name= ?, description = ?, price= ?, category_id=?,quantity=?,product_image=? WHERE product_id =?");
				st2.setString(1, product.getProductName());
				st2.setString(2, product.getDescription());
				st2.setInt(3, product.getPrice());
				st2.setInt(4, product.getCategoryId());
				st2.setInt(5, product.getQuantity());
				st2.setString(6, product.getImageUrlFromPart());
				st2.setInt(7, productId);
				int r = st2.executeUpdate();
				if (r > 0) {

					return 1;
				}

			} else {

				return -1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return 0;

	}

	public int deleteProduct(int productID) {
		try {

			PreparedStatement stCheck = connection.prepareStatement(StringUtils.QUERY_PRODUCT_CHECK);
			stCheck.setInt(1, productID);
			ResultSet res1 = stCheck.executeQuery();
			if (res1.next()) {
				PreparedStatement stDeleteCart = connection.prepareStatement("DELETE FROM Cart where product_id = ?");
				stDeleteCart.setInt(1, productID);

				PreparedStatement stDeleteOrder = connection
						.prepareStatement("DELETE FROM order_details where product_id = ?");
				stDeleteOrder.setInt(1, productID);
				stDeleteOrder.executeUpdate();

				PreparedStatement stDelete = connection.prepareStatement(StringUtils.QUERY_PRODUCT_DELETE);
				stDelete.setInt(1, productID);
				int res2 = stDelete.executeUpdate();
				if (res2 > 1) {

					return 1;

				}

			} else {

				return -1;
			}

		} catch (SQLException e) {

			e.printStackTrace();
			return 0;
		}
		return 0;

	}

	public List<Order> getAllOrders() {
		try {

			PreparedStatement st = connection.prepareStatement("SELECT \n" + "    od.order_id, \n"
					+ "    od.order_date, \n" + "    od.status, \n" + "    od.user_name, \n" + "    pd.quantity, \n"
					+ "    pd.price, \n" + "    p.product_name\n" + "FROM \n" + "    order_table od\n" + "JOIN \n"
					+ "    order_details pd ON od.order_id = pd.order_id\n" + "JOIN \n"
					+ "    Product p ON pd.product_id = p.product_id;\n" + "");

			ResultSet result = st.executeQuery();
			ArrayList<Order> orders = new ArrayList<Order>();
			while (result.next()) {
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
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public void changeDeliveryStatus(int orderId) {
		try {

			PreparedStatement st = connection
					.prepareStatement("UPDATE order_table set status ='Delivered' where order_id=?");
			st.setInt(1, orderId);
			st.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public List<Order> getUserOrderHistory(String userName) {
		try {

			PreparedStatement st = connection.prepareStatement("SELECT \n" + "    od.order_id, \n"
					+ "    od.order_date, \n" + "    od.status, \n" + "    od.user_name, \n" + "    pd.quantity, \n"
					+ "    pd.price, \n" + "    p.product_name\n" + "FROM \n" + "    order_table od\n" + "JOIN \n"
					+ "    order_details pd ON od.order_id = pd.order_id\n" + "JOIN \n"
					+ "    Product p ON pd.product_id = p.product_id\n" + "where user_name = ?;");

			st.setString(1, userName);
			ResultSet result = st.executeQuery();
			ArrayList<Order> orders = new ArrayList<Order>();
			while (result.next()) {
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

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return null;
	}

	public List<Order> getRecentOrders() {
		try {

			PreparedStatement st = connection.prepareStatement("SELECT * FROM order_table");
			ResultSet result = st.executeQuery();
			List<Order> orders = new ArrayList<Order>();
			int i = 1;
			while (i <= 5) {
				Order order = new Order();
				order.setOrderId(result.getInt("order_id"));
				order.setOrderDate(result.getDate("order_date"));
				order.setStatus(result.getString("status"));
				order.setUserName(result.getString("user_name"));
				order.setTotalPrice(result.getInt("total_price"));
				orders.add(order);

			}

			return orders;

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return null;
	}

	public int getTotalPrice(String userName) {

		try {

			PreparedStatement stPrice = connection.prepareStatement(
					"SELECT SUM(Product.price * Cart.quantity) AS total_price\n" + "			FROM Product\n"
							+ "			JOIN Cart ON Product.product_id = Cart.product_id where Cart.user_name = ?;\n"
							+ "");
			stPrice.setString(1, userName);
			ResultSet result = stPrice.executeQuery();
			int totalPrice = 0;
			if (result.next()) {

				totalPrice = result.getInt("total_price");

			}

			return totalPrice;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}

	public int getProductsQuantity() {

		try {

			PreparedStatement st = connection.prepareStatement("SELECT SUM(quantity) FROM product");
			ResultSet result = st.executeQuery();
			if (result.next()) {

				int sum = result.getInt(1);
				return sum;

			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return 0;

	}

	public List<Product> getAllProducts() {
		try {

			PreparedStatement st = connection.prepareStatement(StringUtils.QUERY_GET_ALL_PRODUCTS);
			ResultSet result = st.executeQuery();
			ArrayList<Product> products = new ArrayList<Product>();
			while (result.next()) {
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

		} catch (SQLException e) {

			e.printStackTrace();
			return null;
		}
	}

	public Product getProductDetail(int productId) {
		// TODO Auto-generated method stub
		return null;
	}

	public ArrayList<Product> getProductsCategoryWise(String category) {
		// TODO Auto-generated method stub
		return null;
	}

	public int createOrder(String userName) {
		// TODO Auto-generated method stub
		return 0;
	}
}