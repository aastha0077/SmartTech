package Model;

import java.sql.Date;

public class Order {
	int orderId;
	
	Date orderDate;
	
	String status;
	
	String userName;
	
	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	int totalPrice;
	
	int productPrice;

	int quantity;
	
	int producId;
	
	String productName;
	
	
	
	
	
	
	public Order() {
		
		
		
	}

	public Order(int orderId, Date orderDate, String status, String userName, int totalPrice, int productPrice,
			int quantity, int producId) {
		super();
		this.orderId = orderId;
		this.orderDate = orderDate;
		this.status = status;
		this.userName = userName;
		this.totalPrice = totalPrice;
		this.productPrice = productPrice;
		this.quantity = quantity;
		this.producId = producId;
	}

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public int getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getProducId() {
		return producId;
	}

	public void setProducId(int producId) {
		this.producId = producId;
	}

	
	
	
		

}
