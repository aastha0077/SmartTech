package Model;

import java.io.Serializable;

public class CartModel implements Serializable {
	private static final long serialVersionUID = 1L;

	int cartId;
	
	String productName;
	
	String imageUrl;
	
	String description;
	
	int quantity;
	
	int price;
	
	int productId;

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public CartModel() {
		
		
	}
	
	public CartModel(int cartId, String productName, String imageUrl, String description, int quantity,int price,int productId) {
		super();
		this.cartId = cartId;
		this.productName = productName;
		this.imageUrl = imageUrl;
		this.description = description;
		this.quantity = quantity;
		this.price = price;
		this.productId =productId;
	}

	public int getCartId() {
		return cartId;
	}

	public void setCartId(int cartId) {
		this.cartId = cartId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	
	
	
	
		

}
