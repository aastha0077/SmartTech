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
        --primary-color: #3498db;
        --secondary-color: #2980b9;
        --success-color: #27ae60;
        --pending-color: #f39c12;
        --danger-color: #e74c3c;
        --text-color: #333;
        --light-text: #666;
        --lighter-text: #999;
        --background: #f9f9f9;
        --card-bg: #ffffff;
        --border-color: #e1e1e1;
        --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        --hover-shadow: 0 8px 15px rgba(0, 0, 0, 0.15);
        --border-radius: 8px;
        --transition: all 0.3s ease;
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
        background-color: var(--background);
        color: var(--text-color);
        line-height: 1.6;
        padding: 30px 0;
        min-height: 100vh;
    }

    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 20px;
    }

    .page-header {
        margin-bottom: 30px;
        text-align: center;
        position: relative;
        padding-bottom: 15px;
    }

    .page-header h1 {
        font-size: 2.5rem;
        font-weight: 600;
        color: var(--text-color);
        margin-bottom: 5px;
    }

    .page-header p {
        color: var(--light-text);
        font-size: 1.1rem;
    }

    .page-header::after {
        content: "";
        position: absolute;
        bottom: 0;
        left: 50%;
        transform: translateX(-50%);
        width: 100px;
        height: 4px;
        background-color: var(--primary-color);
        border-radius: 2px;
    }

    .card {
        background-color: var(--card-bg);
        border-radius: var(--border-radius);
        box-shadow: var(--shadow);
        padding: 20px;
        margin-bottom: 20px;
        transition: var(--transition);
    }

    .card:hover {
        box-shadow: var(--hover-shadow);
    }

    .table-responsive {
        overflow-x: auto;
        -webkit-overflow-scrolling: touch;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        border-spacing: 0;
        border-radius: var(--border-radius);
        overflow: hidden;
    }

    th, td {
        padding: 16px;
        text-align: left;
        vertical-align: middle;
    }

    th {
        background-color: var(--primary-color);
        color: white;
        font-weight: 500;
        font-size: 1rem;
        white-space: nowrap;
        position: relative;
    }

    th:not(:last-child)::after {
        content: "";
        position: absolute;
        right: 0;
        top: 25%;
        height: 50%;
        width: 1px;
        background-color: rgba(255, 255, 255, 0.3);
    }

    tbody tr {
        transition: var(--transition);
        border-bottom: 1px solid var(--border-color);
    }

    tbody tr:last-child {
        border-bottom: none;
    }

    tbody tr:hover {
        background-color: rgba(52, 152, 219, 0.05);
    }

    td {
        color: var(--light-text);
        font-size: 0.95rem;
    }

    .status-badge {
        display: inline-block;
        padding: 6px 12px;
        border-radius: 20px;
        font-size: 0.85rem;
        font-weight: 500;
        text-align: center;
        min-width: 100px;
    }

    .status-delivered {
        background-color: rgba(39, 174, 96, 0.15);
        color: var(--success-color);
    }

    .status-pending {
        background-color: rgba(243, 156, 18, 0.15);
        color: var(--pending-color);
    }

    .price {
        font-weight: 500;
        color: var(--text-color);
    }

    .btn {
        display: inline-block;
        font-weight: 500;
        text-align: center;
        white-space: nowrap;
        vertical-align: middle;
        user-select: none;
        padding: 8px 16px;
        font-size: 0.95rem;
        line-height: 1.5;
        border-radius: var(--border-radius);
        transition: var(--transition);
        cursor: pointer;
        border: none;
    }

    .btn-primary {
        background-color: var(--primary-color);
        color: white;
    }

    .btn-primary:hover {
        background-color: var(--secondary-color);
    }

    .btn-success {
        background-color: var(--success-color);
        color: white;
    }

    .btn-disabled {
        background-color: #e1e1e1;
        color: var(--lighter-text);
        cursor: not-allowed;
    }

    .order-id {
        font-family: monospace;
        background-color: rgba(0, 0, 0, 0.05);
        padding: 3px 8px;
        border-radius: 4px;
        font-size: 0.9rem;
    }

    .product-name {
        font-weight: 500;
        color: var(--text-color);
    }

    .empty-state {
        text-align: center;
        padding: 40px 0;
    }

    .empty-state p {
        color: var(--lighter-text);
        font-size: 1.1rem;
        margin-top: 10px;
    }

    /* Responsive adjustments */
    @media (max-width: 768px) {
        .container {
            padding: 0 10px;
        }
        
        .page-header h1 {
            font-size: 2rem;
        }
        
        th, td {
            padding: 12px 10px;
        }
        
        .status-badge {
            min-width: unset;
        }
    }
</style>
</head>
<body>

<div class="container">
    <div class="page-header">
        <h1>Order History</h1>
        <p>Track and manage customer orders</p>
    </div>

    <div class="card">
        <div class="table-responsive">
            <table>
                <thead>
                    <tr>
                        <th>Ordered By</th>
                        <th>Order ID</th>
                        <th>Order Date</th>
                        <th>Product Name</th>
                        <th>Price</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty orders}">
                            <c:forEach var="order" items="${orders}">
                                <tr>
                                    <td>${order.userName}</td>
                                    <td><span class="order-id">${order.orderId}</span></td>
                                    <td>${order.orderDate}</td>
                                    <td><span class="product-name">${order.productName}</span></td>
                                    <td><span class="price">Rs ${order.productPrice}</span></td>
                                    <td>
                                        <span class="status-badge ${order.status eq 'Delivered' ? 'status-delivered' : 'status-pending'}">
                                            ${order.status}
                                        </span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${order.status == 'Delivered'}">
                                                <button class="btn btn-disabled" disabled>Completed</button>
                                            </c:when>
                                            <c:otherwise>
                                                <form style="display:inline" method="post" action="<%=contextPath%>/ChangeDeliveryStatus">
                                                    <input type="hidden" name="orderId" value="${order.orderId}">
                                                    <button class="btn btn-primary">Mark Delivered</button>    
                                                </form>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>  
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="7">
                                    <div class="empty-state">
                                        <p>No orders found in the system.</p>
                                    </div>
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    // Add any necessary JavaScript functionality here
    document.addEventListener('DOMContentLoaded', function() {
        // You can add interactive elements if needed
        console.log('Order History page loaded');
    });
</script>

</body>
</html>