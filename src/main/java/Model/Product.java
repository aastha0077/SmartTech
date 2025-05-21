package Model;

import java.io.File;
import java.io.Serializable;

import jakarta.servlet.http.Part;
import utils.StringUtils;

public class Product implements Serializable {
private static final long serialVersionUID = 1L;

private	int productId;
	
private	String productName;
	
private	String description;
	
	int price;
	
	int categoryId;
	
	int quantity;
	
	private String imageUrlFromPart;
	
	

	public Product() {
		
		
	}


	public Product(int productId, String productName, String description, int price, int categoryId,int quantity,Part part) {
		super();
		this.productId = productId;
		this.productName = productName;
		this.description = description;
		this.price = price;
		this.categoryId = categoryId;
		this.quantity = quantity;
		this.imageUrlFromPart = getImageUrl(part);
	}


	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}
	public int getQuantity() {
		
		return	this.quantity;
	}
	public void setQuantity(int quantity) {
		
		this.quantity = quantity;
	}
	
	public String getImageUrlFromPart() {
		return imageUrlFromPart;
	}


	public void setImageUrlFromPart(String imageUrlFromPart) {
		this.imageUrlFromPart = imageUrlFromPart;
	}

	
	private String getImageUrl(Part part) {
		String savePath = StringUtils.IMAGE_DIR_SAVE_PATH;
		File fileSaveDir = new File(savePath);
		System.out.println("Saving to: " + savePath); // Debug line
		String imageUrlFromPart = null;
		if (!fileSaveDir.exists()) {
		    System.out.println("Creating directory: " + fileSaveDir.mkdirs());
		}
		String contentDisp = part.getHeader("content-disposition");
		String[] items = contentDisp.split(";");
		for (String s : items) {
			if (s.trim().startsWith("filename")) {
				imageUrlFromPart = s.substring(s.indexOf("=") + 2, s.length() - 1);
			}
		}
		if (imageUrlFromPart == null || imageUrlFromPart.isEmpty()) {
			imageUrlFromPart = "download.jpg";
		}
		return imageUrlFromPart;
	}

}
