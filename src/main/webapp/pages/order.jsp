<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@page import="java.io.PrintWriter"%>
<%@page import="Model.Product"%>
<%@page import="Model.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="utils.StringUtils"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%
String contextPath = request.getContextPath();
String totalPrice = (String) request.getAttribute("totalPrice");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Smart Home Care - Checkout</title>
<style>
:root {
  --primary: #4a6baf;
  --primary-light: #6382c9;
  --primary-dark: #3b558c;
  --secondary: #42a5f5;
  --accent: #ff9800;
  --success: #4caf50;
  --error: #f44336;
  --text-dark: #333333;
  --text-light: #666666;
  --text-muted: #9e9e9e;
  --background: #f8f9fa;
  --white: #ffffff;
  --card-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
  --border-radius: 12px;
  --transition: all 0.3s ease;
}

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  background-color: var(--background);
  color: var(--text-dark);
  line-height: 1.6;
}

.checkout-container {
  max-width: 1100px;
  margin: 0 auto;
  padding: 2rem;
}

.page-title {
  margin: 1.5rem 0;
  text-align: center;
  font-size: 2rem;
  color: var(--primary);
  position: relative;
  padding-bottom: 0.5rem;
}

.page-title:after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 50%;
  transform: translateX(-50%);
  width: 80px;
  height: 4px;
  background: var(--accent);
  border-radius: 2px;
}

.checkout-layout {
  display: grid;
  grid-template-columns: 1fr 350px;
  gap: 2rem;
  margin-top: 2rem;
}

.product-list {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 1.5rem;
}

.product-card {
  background: var(--white);
  border-radius: var(--border-radius);
  box-shadow: var(--card-shadow);
  overflow: hidden;
  transition: var(--transition);
  position: relative;
}

.product-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
}

.product-content {
  padding: 1.5rem;
}

.product-name {
  font-size: 1.25rem;
  font-weight: 600;
  color: var(--primary);
  margin-bottom: 0.75rem;
}

.product-details {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 1rem;
}

.quantity-badge {
  display: inline-block;
  background: var(--primary-light);
  color: var(--white);
  padding: 0.35rem 0.75rem;
  border-radius: 50px;
  font-size: 0.85rem;
  font-weight: 500;
}

.product-price {
  font-size: 1.2rem;
  font-weight: 600;
  color: var(--accent);
}

.order-summary {
  background: var(--white);
  border-radius: var(--border-radius);
  box-shadow: var(--card-shadow);
  position: sticky;
  top: 2rem;
}

.summary-header {
  background: var(--primary);
  color: var(--white);
  padding: 1.25rem;
  border-radius: var(--border-radius) var(--border-radius) 0 0;
}

.summary-header h2 {
  font-size: 1.5rem;
  font-weight: 600;
  margin: 0;
}

.summary-content {
  padding: 1.5rem;
}

.summary-row {
  display: flex;
  justify-content: space-between;
  padding: 0.75rem 0;
  border-bottom: 1px solid rgba(0, 0, 0, 0.05);
}

.summary-row:last-child {
  border-bottom: none;
}

.summary-row.total {
  margin-top: 1rem;
  padding-top: 1rem;
  border-top: 2px dashed rgba(0, 0, 0, 0.1);
  font-size: 1.25rem;
  font-weight: 600;
  color: var(--primary);
}

.summary-label {
  color: var(--text-light);
}

.summary-value {
  font-weight: 500;
}

.action-buttons {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1rem;
  margin-top: 2rem;
}

.btn {
  display: inline-block;
  padding: 1rem 1.5rem;
  border-radius: 8px;
  font-size: 1rem;
  font-weight: 500;
  text-align: center;
  border: none;
  cursor: pointer;
  transition: var(--transition);
}

.btn-primary {
  background: var(--primary);
  color: var(--white);
}

.btn-primary:hover {
  background: var(--primary-dark);
}

.btn-outline {
  background: transparent;
  color: var(--text-dark);
  border: 1px solid var(--text-muted);
}

.btn-outline:hover {
  background: rgba(0, 0, 0, 0.05);
}

.empty-cart {
  text-align: center;
  padding: 3rem;
  color: var(--text-muted);
}

.empty-cart p {
  font-size: 1.1rem;
  margin-top: 1rem;
}

@media (max-width: 900px) {
  .checkout-layout {
    grid-template-columns: 1fr;
  }
  
  .order-summary {
    position: static;
    margin-top: 2rem;
  }
}

@media (max-width: 600px) {
  .checkout-container {
    padding: 1rem;
  }
  
  .product-list {
    grid-template-columns: 1fr;
  }
  
  .action-buttons {
    grid-template-columns: 1fr;
  }
}
</style>
</head>
<body>
<jsp:include page="/pages/header.jsp"></jsp:include>

<div class="checkout-container">
  <h1 class="page-title">Smart Home Care Checkout</h1>
  
  <form action="<%=contextPath %>/CreateOrder" method="post">
    <div class="checkout-layout">
      <div class="products-section">
        <c:choose>
          <c:when test="${not empty order}">
            <div class="product-list">
              <c:forEach var="product" items="${order}">
                <div class="product-card">
                  <div class="product-content">
                    <h3 class="product-name">${product.productName}</h3>
                    <div class="product-details">
                      <span class="quantity-badge">Qty: ${product.quantity}</span>
                      <span class="product-price">Rs ${product.price}</span>
                    </div>
                  </div>
                </div>
              </c:forEach>
            </div>
          </c:when>
          <c:otherwise>
            <div class="empty-cart">
              <p>Your cart is empty</p>
            </div>
          </c:otherwise>
        </c:choose>
      </div>
      
      <div class="order-summary">
        <div class="summary-header">
          <h2>Order Summary</h2>
        </div>
        <div class="summary-content">
          <div class="summary-row">
            <span class="summary-label">Subtotal</span>
            <span class="summary-value">Rs <%=totalPrice %></span>
          </div>
          <div class="summary-row">
            <span class="summary-label">Delivery</span>
            <span class="summary-value">Free</span>
          </div>
          <div class="summary-row total">
            <span>Total</span>
            <span>Rs <%=totalPrice %></span>
          </div>
          
          <div class="action-buttons">
            <button type="submit" class="btn btn-primary">Confirm Order</button>
            <button type="button" class="btn btn-outline" onclick="cancelOrder()">Cancel</button>
          </div>
        </div>
      </div>
    </div>
  </form>
</div>

<jsp:include page="/pages/footer.jsp"></jsp:include>

<script>
function cancelOrder() {
  alert("Order Cancelled!");
}
</script>
</body>
</html>