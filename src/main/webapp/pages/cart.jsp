<%@page import="Model.CartModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Product"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>  

    
    
 <%
 ArrayList<CartModel> products =(ArrayList<CartModel>) request.getAttribute("cartList");
 String contextPath = request.getContextPath();
 %> 
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Shopping Cart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <style>
      /* Global styles */
      * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      }
      
      body {
        background-color: #f8f9fa;
        color: #333;
      }
      
      /* Main container */
      .container {
        max-width: 1000px;
        margin: 2rem auto;
        padding: 0 20px;
      }
      
      /* Page heading */
      .page-heading {
        text-align: center;
        margin-bottom: 2rem;
        color: #2c3e50;
        position: relative;
        padding-bottom: 10px;
      }
      
      .page-heading:after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 50%;
        transform: translateX(-50%);
        width: 80px;
        height: 3px;
        background-color: #3498db;
      }
      
      /* Empty cart message */
      .empty-cart {
        text-align: center;
        padding: 3rem;
        background-color: white;
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      }
      
      .empty-cart i {
        font-size: 4rem;
        color: #bdc3c7;
        margin-bottom: 1rem;
        display: block;
      }
      
      .empty-cart h3 {
        color: #7f8c8d;
        font-weight: 500;
      }
      
      .empty-cart a {
        display: inline-block;
        margin-top: 1rem;
        padding: 8px 16px;
        background-color: #3498db;
        color: white;
        text-decoration: none;
        border-radius: 4px;
        transition: background-color 0.3s;
      }
      
      .empty-cart a:hover {
        background-color: #2980b9;
      }
      
      /* Cart summary */
      .cart-summary {
        margin-bottom: 1rem;
        background-color: white;
        padding: 15px;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      }
      
      /* Product list */
      .product-list {
        background-color: white;
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        overflow: hidden;
        margin-bottom: 2rem;
      }
      
      .product-row {
        display: flex;
        align-items: center;
        padding: 20px;
        border-bottom: 1px solid #eee;
        transition: all 0.3s ease;
      }
      
      .product-row:last-child {
        border-bottom: none;
      }
      
      .product-row:hover {
        background-color: #f9f9f9;
      }
      
      .product-image {
        width: 80px;
        height: 80px;
        object-fit: cover;
        border-radius: 8px;
        margin-right: 20px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      }
      
      .product-info {
        flex-grow: 1;
      }
      
      .product-name {
        font-size: 18px;
        font-weight: 600;
        color: #2c3e50;
        margin-bottom: 5px;
      }
      
      .product-description {
        color: #7f8c8d;
        font-size: 14px;
        margin-bottom: 5px;
        line-height: 1.4;
      }
      
      .product-quantity {
        display: inline-block;
        background-color: #ecf0f1;
        padding: 3px 10px;
        border-radius: 20px;
        font-size: 13px;
        color: #2c3e50;
        font-weight: 500;
      }
      
      .product-quantity i {
        margin-right: 5px;
        color: #3498db;
      }
      
      .product-actions {
        display: flex;
        align-items: center;
      }
      
      .remove-button {
        background-color: #e74c3c;
        color: white;
        border: none;
        padding: 8px 16px;
        font-size: 14px;
        cursor: pointer;
        border-radius: 6px;
        transition: all 0.3s;
        display: flex;
        align-items: center;
      }
      
      .remove-button:hover {
        background-color: #c0392b;
        transform: translateY(-2px);
      }
      
      .remove-button i {
        margin-right: 6px;
      }
      
      /* Order section */
      .order-section {
        background-color: white;
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        padding: 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
      }
      
      .continue-shopping {
        background-color: transparent;
        border: 2px solid #3498db;
        color: #3498db;
        padding: 10px 20px;
        font-size: 16px;
        cursor: pointer;
        border-radius: 6px;
        transition: all 0.3s;
        text-decoration: none;
        display: inline-block;
      }
      
      .continue-shopping:hover {
        background-color: #f1f9ff;
      }
      
      .continue-shopping i {
        margin-right: 6px;
      }
      
      .buy-button {
        background-color: #2ecc71;
        color: white;
        border: none;
        padding: 12px 24px;
        font-size: 16px;
        cursor: pointer;
        border-radius: 6px;
        transition: all 0.3s;
        display: flex;
        align-items: center;
        font-weight: 500;
      }
      
      .buy-button:hover {
        background-color: #27ae60;
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(46, 204, 113, 0.3);
      }
      
      .buy-button i {
        margin-right: 8px;
      }
      
      /* Responsive styles */
      @media (max-width: 768px) {
        .product-row {
          flex-direction: column;
          align-items: flex-start;
        }
        
        .product-image {
          margin-bottom: 15px;
          margin-right: 0;
          width: 100%;
          max-width: 200px;
          height: auto;
        }
        
        .product-info {
          width: 100%;
          margin-bottom: 15px;
        }
        
        .product-actions {
          width: 100%;
          justify-content: flex-end;
        }
        
        .order-section {
          flex-direction: column;
        }
        
        .continue-shopping {
          margin-bottom: 15px;
          width: 100%;
          text-align: center;
        }
        
        .buy-button {
          width: 100%;
          justify-content: center;
        }
      }
    </style>
  </head>
  <body>
    <jsp:include page="/pages/header.jsp"></jsp:include>
    
    <div class="container">
      <h1 class="page-heading">Your Shopping Cart</h1>
      
      <c:if test="${empty cartList}">
        <div class="empty-cart">
          <i class="fas fa-shopping-cart"></i>
          <h3>Your cart is empty</h3>
          <p>Looks like you haven't added any products to your cart yet.</p>
          <a href="<%=contextPath%>/Home"><i class="fas fa-arrow-left"></i> Continue Shopping</a>
        </div>
      </c:if>
      
      <c:if test="${not empty cartList}">
        <div class="cart-summary">
          <p><i class="fas fa-info-circle"></i> You have <strong>${cartList.size()}</strong> item(s) in your cart</p>
        </div>
        
        <div class="product-list">
          <c:forEach var="product" items="${cartList}">
            <div class="product-row">
              <img class="product-image" src="resources/images/products/${product.imageUrl}" alt="${product.productName}">
              
              <div class="product-info">
                <p class="product-name">${product.productName}</p>
                <p class="product-description">${product.description}</p>
                <p class="product-quantity"><i class="fas fa-cubes"></i> Quantity: ${product.quantity}</p>
              </div>
              
              <div class="product-actions">
                <form action="<%=contextPath%>/RemoveCart" method="post">
                  <button type="submit" class="remove-button">
                    <i class="fas fa-trash-alt"></i> Remove
                  </button>
                  <input type="hidden" name="cartId" value="${product.cartId}" />
                </form>
              </div>
            </div>
          </c:forEach>
        </div>
        
        <div class="order-section">
          <a href="<%=contextPath%>/Home" class="continue-shopping">
            <i class="fas fa-arrow-left"></i> Continue Shopping
          </a>
          
          <form id="buy-form" action="<%=contextPath%>/OrderServlet">
            <button type="submit" class="buy-button">
              <i class="fas fa-check-circle"></i> Proceed to Checkout
            </button>
          </form>
        </div>
      </c:if>
    </div>
    
    <jsp:include page="/pages/footer.jsp"></jsp:include>
  </body>
</html>