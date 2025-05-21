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
String contextPath =(String)request.getContextPath();
HttpSession userSession = request.getSession();
String currentUser = (String) userSession.getAttribute(StringUtils.USERNAME);
String quantity =(String) request.getAttribute("quantity");
String productAdded =(String) request.getAttribute("added");
String orderSuccess =(String)request.getAttribute("orderSuccess");
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <title>Smart Tech - Product Catalog</title>
    <style>
        /* Base Styles */
        :root {
            --primary-color: #0052cc;
            --secondary-color: #ff6b00;
            --light-bg: #f8f9fa;
            --dark-text: #333;
            --light-text: #f8f9fa;
            --gray-text: #6c757d;
            --border-color: #dee2e6;
            --success-color: #28a745;
            --out-of-stock: #dc3545;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--light-bg);
            color: var(--dark-text);
            line-height: 1.6;
        }
        
        /* Page Header */
        .page-header {
            background-color: white;
            padding: 30px 20px;
            text-align: center;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .page-header h1 {
            font-size: 2rem;
            color: var(--dark-text);
            margin-bottom: 10px;
        }
        
        .page-header p {
            color: var(--gray-text);
            max-width: 700px;
            margin: 0 auto;
        }
        
        /* Category Navigation */
        .category-nav {
            background-color: white;
            padding: 15px 20px;
            margin-bottom: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            max-width: 1200px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .category-nav form {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 12px;
        }
        
        .category-btn {
            padding: 12px 20px;
            border: none;
            border-radius: 30px;
            background-color: var(--light-bg);
            color: var(--dark-text);
            font-weight: 500;
            font-size: 0.9rem;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .category-btn:hover, .category-btn.active {
            background-color: var(--primary-color);
            color: white;
            transform: translateY(-2px);
        }
        
        .category-icon {
            font-size: 1.1rem;
        }
        
        /* Product Grid */
        .products-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        .products-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .products-title {
            font-size: 1.5rem;
            font-weight: 600;
        }
        
        .product-count {
            color: var(--gray-text);
            font-size: 0.9rem;
        }
        
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 25px;
            margin-bottom: 50px;
        }
        
        .product {
            background-color: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
            position: relative;
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        
        .product:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        
        .product-img-container {
            height: 180px;
            padding: 20px;
            background-color: #f5f5f5;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        
        .product img {
            max-width: 100%;
            max-height: 140px;
            object-fit: contain;
            transition: all 0.3s ease;
        }
        
        .product:hover img {
            transform: scale(1.05);
        }
        
        .product-info {
            padding: 20px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }
        
        .product-name {
            font-size: 1rem;
            font-weight: 600;
            margin-bottom: 5px;
            line-height: 1.4;
        }
        
        .product-price {
            color: var(--primary-color);
            font-weight: 700;
            font-size: 1.1rem;
            margin: 10px 0;
        }
        
        .product-stock {
            font-size: 0.8rem;
            font-weight: 500;
            padding: 3px 10px;
            border-radius: 20px;
            display: inline-block;
            margin-bottom: 10px;
        }
        
        .in-stock {
            background-color: rgba(40, 167, 69, 0.1);
            color: var(--success-color);
        }
        
        .out-of-stock {
            background-color: rgba(220, 53, 69, 0.1);
            color: var(--out-of-stock);
        }
        
        .product-actions {
            margin-top: auto;
            display: flex;
            gap: 10px;
        }
        
        .action-form {
            flex: 1;
        }
        
        .action-btn {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 8px;
            font-weight: 500;
            font-size: 0.8rem;
            cursor: pointer;
            transition: all 0.25s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
        }
        
        .details-btn {
            background-color: var(--light-bg);
            color: var(--dark-text);
        }
        
        .details-btn:hover {
            background-color: #e0e0e0;
        }
        
        .cart-btn {
            background-color: var(--primary-color);
            color: white;
        }
        
        .cart-btn:hover {
            background-color: #0046ad;
        }
        
        .cart-btn:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }
        
        /* Empty state */
        .empty-state {
            text-align: center;
            padding: 50px 20px;
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        }
        
        .empty-icon {
            font-size: 3rem;
            color: var(--gray-text);
            margin-bottom: 20px;
        }
        
        .empty-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 10px;
        }
        
        .empty-desc {
            color: var(--gray-text);
            margin-bottom: 20px;
        }
        
        .browse-btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 30px;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        
        .browse-btn:hover {
            background-color: #0046ad;
        }
        
        /* Notification */
        .notification {
            position: fixed;
            bottom: 30px;
            right: 30px;
            max-width: 350px;
            background-color: white;
            border-radius: 8px;
            padding: 15px 20px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
            display: flex;
            align-items: center;
            gap: 15px;
            z-index: 1000;
            opacity: 0;
            transform: translateY(20px);
            transition: opacity 0.3s ease, transform 0.3s ease;
        }
        
        .notification.show {
            opacity: 1;
            transform: translateY(0);
        }
        
        .notification-icon {
            height: 40px;
            width: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
        }
        
        .notification-success {
            background-color: rgba(40, 167, 69, 0.1);
            color: var(--success-color);
        }
        
        .notification-error {
            background-color: rgba(220, 53, 69, 0.1);
            color: var(--out-of-stock);
        }
        
        .notification-content {
            flex: 1;
        }
        
        .notification-title {
            font-weight: 600;
            margin-bottom: 3px;
        }
        
        .notification-message {
            font-size: 0.85rem;
            color: var(--gray-text);
        }
        
        .notification-close {
            background: none;
            border: none;
            font-size: 1rem;
            cursor: pointer;
            color: var(--gray-text);
            padding: 5px;
        }
        
        /* Responsive Styles */
        @media (max-width: 992px) {
            .product-grid {
                grid-template-columns: repeat(3, 1fr);
            }
        }
        
        @media (max-width: 768px) {
            .product-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .page-header h1 {
                font-size: 1.8rem;
            }
            
            .category-btn {
                padding: 10px 15px;
                font-size: 0.85rem;
            }
        }
        
        @media (max-width: 576px) {
            .product-grid {
                grid-template-columns: 1fr;
                max-width: 350px;
                margin-left: auto;
                margin-right: auto;
            }
            
            .category-nav form {
                flex-direction: column;
                align-items: stretch;
            }
            
            .category-btn {
                justify-content: center;
            }
            
            .page-header h1 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>

<body>
    <!-- Include Header -->
    <jsp:include page="/pages/header.jsp"></jsp:include>
    
    <!-- Page Header -->
    <header class="page-header">
        <h1>Browse Our Premium Electronics</h1>
        <p>Discover top-quality products for your smart home and modern lifestyle</p>
    </header>
    
    <!-- Category Navigation -->
    <div class="category-nav">
        <form action="<%=contextPath%>/Category" method="get">
            <button type="submit" name="category" value="all" class="category-btn">
                <span class="category-icon"><i class="fas fa-th-large"></i></span> All Products
            </button>
            <button type="submit" name="category" value="Vaccum Cleaner" class="category-btn">
                <span class="category-icon"><i class="fas fa-broom"></i></span> Vacuum Cleaners
            </button>
            <button type="submit" name="category" value="Refrigerator" class="category-btn">
                <span class="category-icon"><i class="fas fa-snowflake"></i></span> Refrigerators
            </button>
            <button type="submit" name="category" value="Air Conditioner" class="category-btn">
                <span class="category-icon"><i class="fas fa-wind"></i></span> Air Conditioners
            </button>
            <button type="submit" name="category" value="Washing Machine" class="category-btn">
                <span class="category-icon"><i class="fas fa-tshirt"></i></span> Washing Machines
            </button>
            <button type="submit" name="category" value="TV" class="category-btn">
                <span class="category-icon"><i class="fas fa-tv"></i></span> TVs
            </button>
            <button type="submit" name="category" value="Fan" class="category-btn">
                <span class="category-icon"><i class="fas fa-fan"></i></span> Fans
            </button>
        </form>
    </div>
    
    <!-- Products Section -->
    <section class="products-container">
        <!-- Products Header -->
        <div class="products-header">
            <h2 class="products-title">Featured Products</h2>
            <c:if test="${not empty productList}">
                <span class="product-count">${productList.size()} products found</span>
            </c:if>
        </div>
        
        <!-- Product Grid -->
        <div class="product-grid">
            <c:if test="${empty productList}">
                <div class="empty-state">
                    <div class="empty-icon"><i class="fas fa-search"></i></div>
                    <h3 class="empty-title">No Products Found</h3>
                    <p class="empty-desc">We couldn't find any products matching your criteria.</p>
                    <form action="<%=contextPath%>/Category" method="get">
                        <button type="submit" name="category" value="all" class="browse-btn">
                            Browse All Products
                        </button>
                    </form>
                </div>
            </c:if>
            
            <c:if test="${not empty productList}">
                <c:forEach var="product" items="${productList}">
                    <div class="product">
                        <div class="product-img-container">
                            <img src="<%=contextPath%>/resources/images/products/${product.imageUrlFromPart}" alt="${product.imageUrlFromPart}" />
                        </div>
                        <div class="product-info">
                            <h3 class="product-name">${product.productName}</h3>
                            <div class="product-price">₹${product.price}</div>
                            <c:choose>
                                <c:when test="${product.quantity==0}">
                                    <span class="product-stock out-of-stock"><i class="fas fa-times-circle"></i> Out of Stock</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="product-stock in-stock"><i class="fas fa-check-circle"></i> In Stock</span>
                                </c:otherwise>
                            </c:choose>
                            
                            <div class="product-actions">
                                <form class="action-form" method="post" action="<%=contextPath%>/ProductDetail">
                                    <input type="hidden" name="productId" value="${product.productId}" />
                                    <button type="submit" class="action-btn details-btn">
                                        <i class="fas fa-info-circle"></i> See Details
                                    </button>
                                </form>
                                <form class="action-form" action="<%
                                    if(currentUser==null){
                                        out.print(contextPath+"/AddtoCart");
                                    } else {
                                        out.print(contextPath+"/AddToCart");
                                    }
                                %>" method="post">
                                    <input type="hidden" name="productId" value="${product.productId}" />
                                    <button type="submit" class="action-btn cart-btn" 
                                        <c:if test="${product.quantity==0}">disabled</c:if>>
                                        <i class="fas fa-shopping-cart"></i> Add to Cart
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
        </div>
    </section>
    
    <!-- Include Footer -->
    <jsp:include page="/pages/footer.jsp"></jsp:include>
    
    <!-- Notification System (replaces alerts) -->
    <div id="notification" class="notification">
        <div id="notification-icon" class="notification-icon"></div>
        <div class="notification-content">
            <div id="notification-title" class="notification-title"></div>
            <div id="notification-message" class="notification-message"></div>
        </div>
        <button class="notification-close" onclick="closeNotification()">
            <i class="fas fa-times"></i>
        </button>
    </div>
    
    <script>
        // Show notification
        function showNotification(type, title, message) {
            const notification = document.getElementById('notification');
            const notificationIcon = document.getElementById('notification-icon');
            const notificationTitle = document.getElementById('notification-title');
            const notificationMessage = document.getElementById('notification-message');
            
            // Set notification content
            notificationTitle.textContent = title;
            notificationMessage.textContent = message;
            
            // Set notification type
            if (type === 'success') {
                notificationIcon.className = 'notification-icon notification-success';
                notificationIcon.innerHTML = '<i class="fas fa-check"></i>';
            } else if (type === 'error') {
                notificationIcon.className = 'notification-icon notification-error';
                notificationIcon.innerHTML = '<i class="fas fa-exclamation-triangle"></i>';
            }
            
            // Show notification
            notification.classList.add('show');
            
            // Auto hide after 5 seconds
            setTimeout(() => {
                closeNotification();
            }, 5000);
        }
        
        // Close notification
        function closeNotification() {
            const notification = document.getElementById('notification');
            notification.classList.remove('show');
        }
        
        // Handle stock notification
        <% if(quantity != null) { %>
            showNotification('error', 'Out of Stock', 'The product is currently out of stock.');
        <% } %>
        
        // Handle add to cart notification
        <% if(productAdded != null) { %>
            showNotification('success', 'Added to Cart', 'Product has been added to your cart successfully.');
        <% } %>
        
        // Highlight active category (if applicable)
        document.addEventListener('DOMContentLoaded', function() {
            // Get current category from URL if available
            const urlParams = new URLSearchParams(window.location.search);
            const currentCategory = urlParams.get('category');
            
            if (currentCategory) {
                const categoryButtons = document.querySelectorAll('.category-btn');
                categoryButtons.forEach(button => {
                    if (button.value === currentCategory) {
                        button.classList.add('active');
                    }
                });
            }
        });
    </script>
</body>

</html>