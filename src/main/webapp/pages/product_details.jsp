<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="Model.Product"%>
<%
Product product =(Product)request.getAttribute("product");

%>    
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Product Details</title>
    <style>
      /* Basic CSS styles */
      body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
      }
      .container {
        max-width: 800px;
        margin: 20px auto;
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      }
      .product-image {
        text-align: center;
        margin-bottom: 20px;
      }
      .product-image img {
        width: auto;
        height: 400px; /* Adjust the height as needed */
        max-width: 100%;
        border-radius: 8px;
      }
      .product-info {
        margin-top: 20px;
      }
      table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
      }
      th,
      td {
        padding: 8px;
        text-align: left;
        border-bottom: 1px solid #ddd;
      }
      th {
        background-color: #f2f2f2;
      }
      .btn {
        display: inline-block;
        padding: 10px 20px;
        background-color: #4caf50;
        color: white;
        text-decoration: none;
        border: none;
        border-radius: 4px;
        cursor: pointer;
      }
      .btn:hover {
        background-color: #45a049;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <div class="product-image">
        <img src="resources/images/products/${product.imageUrlFromPart}" alt="Product Image" />
      </div>
      <div class="product-info">
        <h2>Product Name</h2>
        <table>
          <tr>
            <th>Description</th>
            <td><%=product.getDescription() %></td>
          </tr>
          <tr>
            <th>Price</th>
            <td><%=product.getPrice() %></td>
          </tr>
          <tr>
            <th>Name</th>
            <td><%=product.getProductName() %></td>
          </tr>
          <!-- Add more rows for other information -->
        </table>
        <button class="btn buy-btn">Buy Now</button>
        <button class="btn add-to-cart-btn">Add to Cart</button>
      </div>
    </div>

    <script>
      // JavaScript for Buy Now and Add to Cart buttons
      document.querySelector(".buy-btn").addEventListener("click", function () {
        // Redirect to checkout page or purchase flow
        alert("Redirecting to checkout page...");
        // Replace the alert with actual redirection logic
      });

      document
        .querySelector(".add-to-cart-btn")
        .addEventListener("click", function () {
          // Add product to cart logic
          alert("Product added to cart!");
          // Replace the alert with actual cart addition logic
        });
    </script>
  </body>
</html>
    