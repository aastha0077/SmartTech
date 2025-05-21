<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<%@page import="Model.Order"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
String contextPath = (String) request.getContextPath();
%>

<title>Order History</title>
<style>
:root {
  --primary-color: #3a86ff;
  --secondary-color: #ff6b6b;
  --background-color: #f8f9fa;
  --card-background: #ffffff;
  --text-primary: #333333;
  --text-secondary: #6c757d;
  --success-color: #4caf50;
  --pending-color: #ff9800;
  --border-radius: 8px;
  --box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
  --transition: all 0.3s ease;
}

body {
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  background-color: var(--background-color);
  margin: 0;
  padding: 0;
  color: var(--text-primary);
  line-height: 1.6;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
}

.page-header {
  margin-bottom: 30px;
  text-align: center;
  position: relative;
}

h1 {
  font-size: 32px;
  font-weight: 600;
  color: var(--primary-color);
  margin-bottom: 10px;
  padding-bottom: 15px;
  position: relative;
}

h1::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 50%;
  transform: translateX(-50%);
  width: 80px;
  height: 4px;
  background-color: var(--secondary-color);
  border-radius: 2px;
}

.orders-card {
  background-color: var(--card-background);
  border-radius: var(--border-radius);
  box-shadow: var(--box-shadow);
  padding: 20px;
  margin-bottom: 30px;
  transition: var(--transition);
}

.orders-card:hover {
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
  transform: translateY(-5px);
}

table {
  width: 100%;
  border-collapse: separate;
  border-spacing: 0;
  margin: 10px 0;
}

th, td {
  padding: 16px 12px;
  text-align: left;
}

th {
  background-color: var(--primary-color);
  color: white;
  font-weight: 600;
  text-transform: uppercase;
  font-size: 14px;
  letter-spacing: 0.5px;
}

th:first-child {
  border-top-left-radius: var(--border-radius);
}

th:last-child {
  border-top-right-radius: var(--border-radius);
}

tr:last-child td:first-child {
  border-bottom-left-radius: var(--border-radius);
}

tr:last-child td:last-child {
  border-bottom-right-radius: var(--border-radius);
}

tbody tr {
  transition: var(--transition);
  border-bottom: 1px solid #eaeaea;
}

tbody tr:hover {
  background-color: rgba(58, 134, 255, 0.05);
}

tbody tr:last-child {
  border-bottom: none;
}

.order-id {
  font-weight: 600;
  color: var(--primary-color);
}

.product-price {
  font-weight: 600;
  color: var(--text-primary);
}

.product-name {
  color: var(--text-primary);
}

.status {
  display: inline-block;
  padding: 6px 12px;
  border-radius: 20px;
  font-size: 14px;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.status-pending {
  background-color: rgba(255, 152, 0, 0.1);
  color: var(--pending-color);
  border: 1px solid var(--pending-color);
}

.status-delivered {
  background-color: rgba(76, 175, 80, 0.1);
  color: var(--success-color);
  border: 1px solid var(--success-color);
}

.no-orders {
  text-align: center;
  padding: 30px;
  color: var(--text-secondary);
  font-size: 18px;
}

@media (max-width: 768px) {
  .container {
    padding: 15px;
  }
  
  th, td {
    padding: 12px 8px;
    font-size: 14px;
  }
  
  .status {
    padding: 4px 8px;
    font-size: 12px;
  }
  
  h1 {
    font-size: 28px;
  }
  
  /* Make table responsive on mobile */
  table, thead, tbody, th, td, tr {
    display: block;
  }
  
  thead tr {
    position: absolute;
    top: -9999px;
    left: -9999px;
  }
  
  tr {
    margin-bottom: 15px;
    border: 1px solid #eaeaea;
    border-radius: var(--border-radius);
    box-shadow: 0 1px 3px rgba(0,0,0,0.05);
  }
  
  td {
    border: none;
    position: relative;
    padding-left: 50%;
    text-align: right;
  }
  
  td:before {
    position: absolute;
    top: 12px;
    left: 12px;
    width: 45%;
    padding-right: 10px;
    white-space: nowrap;
    font-weight: 600;
    text-align: left;
  }
  
  td:nth-of-type(1):before { content: "Order ID"; }
  td:nth-of-type(2):before { content: "Order Date"; }
  td:nth-of-type(3):before { content: "Product Price"; }
  td:nth-of-type(4):before { content: "Product Name"; }
  td:nth-of-type(5):before { content: "Status"; }
}
</style>
</head>
<body>
<jsp:include page="/pages/header.jsp"></jsp:include>

<div class="container">
  <div class="page-header">
    <h1>Order History</h1>
  </div>

  <div class="orders-card">
    <c:choose>
      <c:when test="${not empty orders}">
        <table>
          <thead>
            <tr>
              <th>Order ID</th>
              <th>Order Date</th>
              <th>Product Price</th>
              <th>Product Name</th>
              <th>Status</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="order" items="${orders}">
              <tr>
                <td><span class="order-id">${order.orderId}</span></td>
                <td>${order.orderDate}</td>
                <td><span class="product-price">Rs ${order.productPrice}</span></td>
                <td><span class="product-name">${order.productName}</span></td>
                <td>
                  <span class="status <c:if test='${order.status eq "Delivered"}'>status-delivered</c:if><c:if test='${order.status eq "Pending"}'>status-pending</c:if>">
                    ${order.status}
                  </span>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </c:when>
      <c:otherwise>
        <div class="no-orders">
          <p>You don't have any orders yet.</p>
        </div>
      </c:otherwise>
    </c:choose>
  </div>
</div>

<jsp:include page="/pages/footer.jsp"></jsp:include>
</body>
</html>