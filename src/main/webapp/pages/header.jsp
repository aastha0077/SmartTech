<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="utils.StringUtils"%>  
<%
String contextPath = request.getContextPath();
HttpSession userSession = request.getSession();
String currentUser = (String) userSession.getAttribute(StringUtils.USERNAME);
%>
  
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%=contextPath%>/stylesheets/index.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <title>Smart Home Care</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background-color: #f9f9f9;
        }
        
        /* Navigation Container */
        .navbar {
            background: linear-gradient(135deg, #4a90e2, #2c7bdc);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        /* Top Navigation Bar */
        .nav-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 0;
        }
        
        .brand {
            display: flex;
            align-items: center;
        }
        
        .brand-logo {
            font-size: 28px;
            font-weight: 700;
            color: #fff;
            text-decoration: none;
            display: flex;
            align-items: center;
            transition: all 0.3s ease;
        }
        
        .brand-logo:hover {
            transform: scale(1.05);
        }
        
        .brand-logo i {
            margin-right: 10px;
            color: #ffcc00;
        }
        
        /* Search Bar */
        .search-container {
            position: relative;
            width: 100%;
            max-width: 400px;
        }
        
        .search-input {
            width: 100%;
            padding: 12px 45px 12px 20px;
            border: none;
            border-radius: 25px;
            background-color: rgba(255, 255, 255, 0.2);
            color: #fff;
            font-size: 16px;
            transition: all 0.3s ease;
        }
        
        .search-input::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }
        
        .search-input:focus {
            outline: none;
            background-color: rgba(255, 255, 255, 0.3);
            box-shadow: 0 0 0 2px rgba(255, 255, 255, 0.5);
        }
        
        .search-icon {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: rgba(255, 255, 255, 0.7);
            font-size: 18px;
        }
        
        /* User Actions */
        .user-actions {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        
        .btn {
            background: none;
            border: none;
            color: #fff;
            cursor: pointer;
            font-size: 16px;
            padding: 8px 16px;
            border-radius: 4px;
            transition: all 0.2s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
        }
        
        .btn:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }
        
        .btn-primary {
            background-color: #ffcc00;
            color: #2c7bdc;
            font-weight: 600;
        }
        
        .btn-primary:hover {
            background-color: #ffd633;
            color: #2c7bdc;
        }
        
        .btn i {
            margin-right: 8px;
        }
        
        /* Bottom Navigation Bar */
        .nav-bottom {
            display: flex;
            justify-content: center;
            background-color: rgba(0, 0, 0, 0.1);
            padding: 4px 0;
        }
        
        .nav-menu {
            display: flex;
            list-style: none;
            margin: 0;
            padding: 0;
        }
        
        .nav-menu li {
            position: relative;
        }
        
        .nav-link {
            display: block;
            padding: 12px 20px;
            color: #fff;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            border-radius: 4px;
        }
        
        .nav-link i {
            margin-right: 8px;
        }
        
        .nav-link.active,
        .nav-link:hover {
            background-color: rgba(255, 255, 255, 0.15);
        }
        
        .nav-link.active::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 25px;
            height: 3px;
            background-color: #ffcc00;
            border-radius: 2px;
        }
        
        /* Dropdown Menu for Responsive Design */
        .mobile-menu-btn {
            display: none;
            background: none;
            border: none;
            color: #fff;
            font-size: 24px;
            cursor: pointer;
        }
        
        /* Responsive Design */
        @media (max-width: 1024px) {
            .search-container {
                max-width: 300px;
            }
        }
        
        @media (max-width: 768px) {
            .nav-top {
                flex-wrap: wrap;
            }
            
            .search-container {
                order: 3;
                max-width: 100%;
                margin-top: 15px;
            }
            
            .nav-bottom {
                overflow-x: auto;
                justify-content: flex-start;
            }
            
            .nav-menu {
                width: 100%;
            }
        }
        
        @media (max-width: 576px) {
            .nav-link {
                padding: 12px 15px;
                font-size: 14px;
            }
            
            .brand-logo {
                font-size: 24px;
            }
            
            .user-actions {
                gap: 10px;
            }
            
            .btn {
                padding: 8px 12px;
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="container">
            <div class="nav-top">
                <div class="brand">
                    <a href="<%=contextPath%>/home.jsp" class="brand-logo">
                        <i class="fas fa-home"></i>
                        Smart Tech
                    </a>
                </div>
                
                <div class="search-container">
                    <form action="<%=contextPath%>/Search">
                        <input type="text" name="productName" class="search-input" placeholder="Search for products...">
                        <i class="fas fa-search search-icon"></i>
                    </form>
                </div>
                
                <div class="user-actions">
                    <% if (currentUser != null) { %>
                        <a href="<%=contextPath%>/CartList" class="btn">
                            <i class="fas fa-shopping-cart"></i>
                            <span class="cart-count">0</span>
                        </a>
                    <% } %>
                    
                    <% if (currentUser == null) { %>
                        <a href="<%=contextPath%>/pages/signup.jsp" class="btn">
                            <i class="fas fa-user-plus"></i> Sign Up
                        </a>
                        <a href="<%=contextPath%>/pages/login.jsp" class="btn btn-primary">
                            <i class="fas fa-sign-in-alt"></i> Login
                        </a>
                    <% } else { %>
                        <a href="<%=contextPath%>/AdminProfileServlet" class="btn">
                            <i class="fas fa-user-circle"></i> Profile
                        </a>
                        <form action="<%=contextPath + StringUtils.SERVLET_URL_LOGOUT%>" method="post" style="display: inline;">
                            <button type="submit" class="btn">
                                <i class="fas fa-sign-out-alt"></i> Logout
                            </button>
                        </form>
                    <% } %>
                </div>
            </div>
        </div>
        
        <div class="nav-bottom">
            <div class="container">
                <ul class="nav-menu">
                    <li>
                        <a href="<%=contextPath%>/home.jsp" class="nav-link" id="nav-home">
                            <i class="fas fa-home"></i> Home
                        </a>
                    </li>
                    <li>
                        <a href="<%=contextPath%>/Home" class="nav-link" id="nav-products">
                            <i class="fas fa-box-open"></i> Products
                        </a>
                    </li>
                    <% if (currentUser != null) { %>
                        <li>
                            <a href="<%=contextPath%>/AdminProfileServlet" class="nav-link" id="nav-profile">
                                <i class="fas fa-user"></i> Profile
                            </a>
                        </li>
                        <li>
                            <a href="<%=contextPath%>/CartList" class="nav-link" id="nav-cart">
                                <i class="fas fa-shopping-cart"></i> Cart
                            </a>
                        </li>
                        <li>
                            <a href="<%=contextPath%>/UserOrderHistory" class="nav-link" id="nav-orders">
                                <i class="fas fa-history"></i> Order History
                            </a>
                        </li>
                    <% } %>
                    <li>
                        <a href="<%=contextPath%>/pages/aboutus.jsp" class="nav-link" id="nav-about">
                            <i class="fas fa-info-circle"></i> About Us
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <script>
        // Get current page URL
        const currentPage = window.location.href;
        
        // Get all nav links
        const navLinks = document.querySelectorAll('.nav-link');
        
        // Set active class based on current URL
        navLinks.forEach(link => {
            // Get link URL
            const linkUrl = link.getAttribute('href');
            
            // Check if current URL contains the link URL
            if (currentPage.includes(linkUrl) && linkUrl !== '<%=contextPath%>/') {
                link.classList.add('active');
            }
            
            // Special case for home page
            if (currentPage.endsWith('<%=contextPath%>/') && link.id === 'nav-home') {
                link.classList.add('active');
            }
        });
        
        // Add smooth scrolling for internal links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function(e) {
                e.preventDefault();
                document.querySelector(this.getAttribute('href')).scrollIntoView({
                    behavior: 'smooth'
                });
            });
        });
    </script>
</body>
</html>