<%@page import="jakarta.servlet.http.HttpSession" %>
    <%@page import="java.io.PrintWriter" %>
        <%@page import="Model.Product" %>
            <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
                import="utils.StringUtils" %>
                <%@page import="Model.Product" %>
                    <%@page import="java.util.ArrayList" %>
                        <%@page import="utils.StringUtils" %>

                            <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
                                <%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

                                    <% String contextPath=(String)request.getContextPath(); HttpSession
                                        userSession=request.getSession(); String currentUser=(String)
                                        userSession.getAttribute(StringUtils.USERNAME); String orderSuccess=(String)
                                        request.getAttribute("orderSuccess"); %>

                                        <!DOCTYPE html>
                                        <html lang="en">

                                        <head>
                                            <meta charset="UTF-8">
                                            <meta http-equiv="X-UA-Compatible" content="IE=edge">
                                            <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                            <link rel="stylesheet" href="<%=contextPath%>/stylesheets/index.css">
                                            <!-- Font Awesome for icons -->
                                            <link rel="stylesheet"
                                                href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
                                            <!-- Google Fonts -->
                                            <link rel="preconnect" href="https://fonts.googleapis.com">
                                            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                                            <link
                                                href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
                                                rel="stylesheet">

                                            <title>Smart Tech - Premium Electronics</title>
                                            <style>
                                                /* Base Styles */
                                                * {
                                                    margin: 0;
                                                    padding: 0;
                                                    box-sizing: border-box;
                                                }

                                                :root {
                                                    --primary-color: #0052cc;
                                                    --secondary-color: #ff6b00;
                                                    --light-bg: #f8f9fa;
                                                    --dark-text: #333;
                                                    --light-text: #f8f9fa;
                                                    --gray-text: #6c757d;
                                                    --border-color: #dee2e6;
                                                    --success-color: #28a745;
                                                }

                                                body {
                                                    font-family: 'Poppins', sans-serif;
                                                    color: var(--dark-text);
                                                    background-color: var(--light-bg);
                                                    line-height: 1.6;
                                                }

                                                /* Hero Banner */
                                                .hero-section {
                                                    position: relative;
                                                    height: 400px;
                                                    overflow: hidden;
                                                    margin-bottom: 40px;
                                                }

                                                .hero-section img {
                                                    width: 100%;
                                                    height: 100%;
                                                    object-fit: cover;
                                                }

                                                .hero-content {
                                                    position: absolute;
                                                    top: 0;
                                                    left: 0;
                                                    width: 100%;
                                                    height: 100%;
                                                    display: flex;
                                                    flex-direction: column;
                                                    justify-content: center;
                                                    padding: 0 50px;
                                                    background: linear-gradient(90deg, rgba(0, 0, 0, 0.7) 0%, rgba(0, 0, 0, 0.4) 50%, rgba(0, 0, 0, 0.1) 100%);
                                                    color: white;
                                                }

                                                .hero-content h1 {
                                                    font-size: 2.5rem;
                                                    margin-bottom: 15px;
                                                    font-weight: 700;
                                                }

                                                .hero-content p {
                                                    font-size: 1.1rem;
                                                    max-width: 600px;
                                                    margin-bottom: 20px;
                                                }

                                                .shop-now-btn {
                                                    display: inline-block;
                                                    background-color: var(--secondary-color);
                                                    color: white;
                                                    padding: 12px 30px;
                                                    border-radius: 30px;
                                                    text-decoration: none;
                                                    font-weight: 600;
                                                    transition: all 0.3s ease;
                                                    border: none;
                                                    cursor: pointer;
                                                }

                                                .shop-now-btn:hover {
                                                    background-color: #e55f00;
                                                    transform: translateY(-2px);
                                                }

                                                /* Category Section */
                                                .category-section {
                                                    padding: 30px 0;
                                                    max-width: 1200px;
                                                    margin: 0 auto;
                                                }

                                                .section-title {
                                                    text-align: center;
                                                    margin-bottom: 30px;
                                                    position: relative;
                                                    font-size: 28px;
                                                    font-weight: 600;
                                                }

                                                .section-title::after {
                                                    content: '';
                                                    display: block;
                                                    width: 80px;
                                                    height: 3px;
                                                    background-color: var(--secondary-color);
                                                    margin: 15px auto 0;
                                                }

                                                .category-container {
                                                    display: flex;
                                                    justify-content: center;
                                                    gap: 20px;
                                                    flex-wrap: wrap;
                                                    margin-bottom: 40px;
                                                }

                                                .category-card {
                                                    width: 180px;
                                                    text-align: center;
                                                    padding: 20px;
                                                    border-radius: 10px;
                                                    background-color: white;
                                                    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
                                                    transition: all 0.3s ease;
                                                    cursor: pointer;
                                                }

                                                .category-card:hover {
                                                    transform: translateY(-5px);
                                                    box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
                                                }

                                                .category-icon {
                                                    font-size: 2.5rem;
                                                    color: var(--primary-color);
                                                    margin-bottom: 15px;
                                                }

                                                .category-name {
                                                    font-weight: 500;
                                                }

                                                /* Product Grid */
                                                .product-section {
                                                    max-width: 1200px;
                                                    margin: 0 auto;
                                                    padding: 20px;
                                                }

                                                .product-grid {
                                                    display: grid;
                                                    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                                                    gap: 25px;
                                                }

                                                .product {
                                                    background-color: white;
                                                    border-radius: 10px;
                                                    overflow: hidden;
                                                    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.08);
                                                    transition: all 0.3s ease;
                                                    position: relative;
                                                }

                                                .product:hover {
                                                    transform: translateY(-5px);
                                                    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.12);
                                                }

                                                .product-badge {
                                                    position: absolute;
                                                    top: 15px;
                                                    left: 0;
                                                    background-color: var(--secondary-color);
                                                    color: white;
                                                    padding: 5px 12px;
                                                    font-size: 0.8rem;
                                                    font-weight: 600;
                                                    border-radius: 0 4px 4px 0;
                                                }

                                                .product-img-container {
                                                    height: 200px;
                                                    display: flex;
                                                    align-items: center;
                                                    justify-content: center;
                                                    padding: 20px;
                                                    background-color: #f5f5f5;
                                                }

                                                .product img {
                                                    max-width: 100%;
                                                    max-height: 160px;
                                                    object-fit: contain;
                                                    transition: transform 0.3s ease;
                                                }

                                                .product:hover img {
                                                    transform: scale(1.05);
                                                }

                                                .product-info {
                                                    padding: 20px;
                                                }

                                                .product-name {
                                                    font-size: 1.1rem;
                                                    font-weight: 600;
                                                    margin-bottom: 8px;
                                                    color: var(--dark-text);
                                                }

                                                .product-description {
                                                    font-size: 0.85rem;
                                                    color: var(--gray-text);
                                                    margin-bottom: 15px;
                                                    display: -webkit-box;
                                                    -webkit-line-clamp: 2;
                                                    -webkit-box-orient: vertical;
                                                    overflow: hidden;
                                                }

                                                .product-price {
                                                    font-size: 1.25rem;
                                                    font-weight: 700;
                                                    color: var(--primary-color);
                                                    margin-bottom: 15px;
                                                }

                                                .product-rating {
                                                    display: flex;
                                                    align-items: center;
                                                    margin-bottom: 15px;
                                                }

                                                .stars {
                                                    color: #ffc107;
                                                    margin-right: 8px;
                                                }

                                                .rating-count {
                                                    font-size: 0.8rem;
                                                    color: var(--gray-text);
                                                }

                                                .product-actions {
                                                    display: flex;
                                                    gap: 10px;
                                                }

                                                .add-to-cart,
                                                .buy-now {
                                                    flex: 1;
                                                    padding: 10px 0;
                                                    border: none;
                                                    border-radius: 5px;
                                                    font-weight: 600;
                                                    cursor: pointer;
                                                    transition: all 0.2s ease;
                                                    display: flex;
                                                    align-items: center;
                                                    justify-content: center;
                                                    gap: 8px;
                                                }

                                                .add-to-cart {
                                                    background-color: var(--primary-color);
                                                    color: white;
                                                }

                                                .add-to-cart:hover {
                                                    background-color: #0046ad;
                                                }

                                                .buy-now {
                                                    background-color: var(--secondary-color);
                                                    color: white;
                                                }

                                                .buy-now:hover {
                                                    background-color: #e55f00;
                                                }

                                                /* Features Section */
                                                .features-section {
                                                    background-color: white;
                                                    padding: 50px 20px;
                                                    margin: 50px 0;
                                                }

                                                .features-container {
                                                    max-width: 1200px;
                                                    margin: 0 auto;
                                                    display: grid;
                                                    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                                                    gap: 30px;
                                                }

                                                .feature {
                                                    text-align: center;
                                                    padding: 20px;
                                                }

                                                .feature-icon {
                                                    font-size: 2.5rem;
                                                    color: var(--primary-color);
                                                    margin-bottom: 15px;
                                                }

                                                .feature-title {
                                                    font-size: 1.2rem;
                                                    font-weight: 600;
                                                    margin-bottom: 10px;
                                                }

                                                .feature-desc {
                                                    color: var(--gray-text);
                                                    font-size: 0.9rem;
                                                }

                                                /* Newsletter */
                                                .newsletter-section {
                                                    background-color: var(--primary-color);
                                                    padding: 40px 20px;
                                                    color: white;
                                                    text-align: center;
                                                }

                                                .newsletter-container {
                                                    max-width: 700px;
                                                    margin: 0 auto;
                                                }

                                                .newsletter-title {
                                                    font-size: 1.8rem;
                                                    margin-bottom: 15px;
                                                }

                                                .newsletter-desc {
                                                    margin-bottom: 25px;
                                                }

                                                .newsletter-form {
                                                    display: flex;
                                                    max-width: 500px;
                                                    margin: 0 auto;
                                                }

                                                .newsletter-input {
                                                    flex: 1;
                                                    padding: 15px;
                                                    border: none;
                                                    border-radius: 5px 0 0 5px;
                                                    font-size: 1rem;
                                                }

                                                .newsletter-btn {
                                                    padding: 0 25px;
                                                    background-color: var(--secondary-color);
                                                    color: white;
                                                    border: none;
                                                    border-radius: 0 5px 5px 0;
                                                    cursor: pointer;
                                                    font-weight: 600;
                                                    transition: background-color 0.3s ease;
                                                }

                                                .newsletter-btn:hover {
                                                    background-color: #e55f00;
                                                }

                                                /* Responsive */
                                                @media (max-width: 992px) {
                                                    .hero-content h1 {
                                                        font-size: 2rem;
                                                    }

                                                    .hero-content p {
                                                        font-size: 1rem;
                                                    }

                                                    .hero-section {
                                                        height: 350px;
                                                    }
                                                }

                                                @media (max-width: 768px) {
                                                    .hero-content {
                                                        padding: 0 30px;
                                                    }

                                                    .hero-content h1 {
                                                        font-size: 1.8rem;
                                                    }

                                                    .product-grid {
                                                        grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
                                                    }

                                                    .hero-section {
                                                        height: 300px;
                                                    }
                                                }

                                                @media (max-width: 576px) {
                                                    .hero-content h1 {
                                                        font-size: 1.5rem;
                                                    }

                                                    .hero-content p {
                                                        font-size: 0.9rem;
                                                    }

                                                    .shop-now-btn {
                                                        padding: 10px 20px;
                                                    }

                                                    .product-grid {
                                                        grid-template-columns: 1fr;
                                                        max-width: 350px;
                                                        margin: 0 auto;
                                                    }

                                                    .hero-section {
                                                        height: 250px;
                                                    }
                                                }

                                                /* Success notification */
                                                .notification {
                                                    position: fixed;
                                                    top: 20px;
                                                    right: 20px;
                                                    padding: 15px 25px;
                                                    background-color: var(--success-color);
                                                    color: white;
                                                    border-radius: 5px;
                                                    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
                                                    display: flex;
                                                    align-items: center;
                                                    gap: 10px;
                                                    z-index: 1000;
                                                    animation: slideIn 0.5s ease, fadeOut 0.5s ease 4.5s forwards;
                                                }

                                                @keyframes slideIn {
                                                    from {
                                                        transform: translateX(100%);
                                                        opacity: 0;
                                                    }

                                                    to {
                                                        transform: translateX(0);
                                                        opacity: 1;
                                                    }
                                                }

                                                @keyframes fadeOut {
                                                    from {
                                                        opacity: 1;
                                                    }

                                                    to {
                                                        opacity: 0;
                                                        visibility: hidden;
                                                    }
                                                }
                                            </style>
                                        </head>

                                        <body>
                                            <!-- Include Header -->
                                            <jsp:include page="/pages/header.jsp"></jsp:include>

                                            <!-- Hero Banner Section -->
                                            <section class="hero-section">
                                                <img src="<%=contextPath%>/resources/background.jpeg"
                                                    alt="Smart Tech Electronics" class="sliderImg">
                                                <div class="hero-content">
                                                    <h1>Welcome to Smart Tech</h1>
                                                    <p>Discover premium electronics for your modern lifestyle. The
                                                        latest technology at unbeatable prices.</p>
                                                    <button class="shop-now-btn">Shop Now <i
                                                            class="fas fa-arrow-right"></i></button>
                                                </div>
                                            </section>

                                            <!-- Categories Section -->
                                            <section class="category-section">
                                                <h2 class="section-title">Browse Categories</h2>
                                                <div class="category-container">
                                                    <div class="category-card">
                                                        <div class="category-icon"><i class="fas fa-wind"></i></div>
                                                        <div class="category-name">Air Conditioners</div>
                                                    </div>
                                                    <div class="category-card">
                                                        <div class="category-icon"><i class="fas fa-broom"></i></div>
                                                        <div class="category-name">Vacuum Cleaners</div>
                                                    </div>
                                                    <div class="category-card">
                                                        <div class="category-icon"><i class="fas fa-snowflake"></i>
                                                        </div>
                                                        <div class="category-name">Refrigerators</div>
                                                    </div>
                                                    <div class="category-card">
                                                        <div class="category-icon"><i class="fas fa-tv"></i></div>
                                                        <div class="category-name">Smart TVs</div>
                                                    </div>
                                                    <div class="category-card">
                                                        <div class="category-icon"><i class="fas fa-blender"></i></div>
                                                        <div class="category-name">Kitchen Appliances</div>
                                                    </div>
                                                </div>
                                            </section>

                                            <!-- Featured Products Section -->
                                            <section class="product-section">
                                                <h2 class="section-title">Featured Products</h2>
                                                <div class="product-grid">
                                                    <div class="product">
                                                        <div class="product-img-container">
                                                            <img src="<%=contextPath%>/resources/images/air-conditioner.jpg"
                                                                alt="Air Conditioner">
                                                        </div>
                                                        <div class="product-info">
                                                            <h3 class="product-name">Smart Air Conditioner</h3>
                                                            <p class="product-description">
                                                                Efficient cooling and heating with smart technology.</p>
                                                            <div class="product-price">$399.99</div>
                                                            <div class="product-rating">
                                                                <div class="stars">
                                                                    <i class="fas fa-star"></i>
                                                                    <i class="fas fa-star"></i>
                                                                    <i class="fas fa-star"></i>
                                                                    <i class="fas fa-star"></i>
                                                                    <i class="fas fa-star-half-alt"></i>
                                                                </div>
                                                                <span class="rating-count">(128)</span>
                                                            </div>
                                                            <div class="product-actions">
                                                                <button class="add-to-cart"><i
                                                                        class="fas fa-shopping-cart"></i> Add to
                                                                    Cart</button>
                                                                <button class="buy-now"><i class="fas fa-bolt"></i> Buy
                                                                    Now</button>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- Sample Product 4 -->
                                                    <div class="product">
                                                        <div class="product-img-container">
                                                            <img src="<%=contextPath%>/resources/images/air-purifier.jpg"
                                                                alt="Air Purifier">
                                                        </div>
                                                        <div class="product-info">
                                                            <h3 class="product-name">HEPA Air Purifier</h3>
                                                            <p class="product-description">Removes 99.97% of airborne
                                                                particles with silent operation and air quality monitor.
                                                            </p>
                                                            <div class="product-price">$199.99</div>
                                                            <div class="product-rating">
                                                                <div class="stars">
                                                                    <i class="fas fa-star"></i>
                                                                    <i class="fas fa-star"></i>
                                                                    <i class="fas fa-star"></i>
                                                                    <i class="fas fa-star"></i>
                                                                    <i class="fas fa-star-half-alt"></i>
                                                                </div>
                                                                <span class="rating-count">(215)</span>
                                                            </div>
                                                            <div class="product-actions">
                                                                <button class="add-to-cart"><i
                                                                        class="fas fa-shopping-cart"></i> Add to
                                                                    Cart</button>
                                                                <button class="buy-now"><i class="fas fa-bolt"></i> Buy
                                                                    Now</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </section>

                                            <!-- Newsletter Section -->
                                            <section class="newsletter-section">
                                                <div class="newsletter-container">
                                                    <h2 class="newsletter-title">Stay Updated</h2>
                                                    <p class="newsletter-desc">Subscribe to our newsletter for exclusive
                                                        deals and the latest tech news.</p>
                                                    <form class="newsletter-form">
                                                        <input type="email" class="newsletter-input"
                                                            placeholder="Enter your email address" required>
                                                        <button type="submit" class="newsletter-btn">Subscribe</button>
                                                    </form>
                                                </div>
                                            </section>

                                            <!-- Include Footer -->
                                            <jsp:include page="<%=StringUtils.PAGE_URL_FOOTER%>"></jsp:include>

                                            <!-- Success Notification -->
                                            <% if(orderSuccess !=null) { %>
                                                <div class="notification">
                                                    <i class="fas fa-check-circle"></i>
                                                    Products will be delivered soon. Thank you for your order!
                                                </div>
                                                <% } %>

                                                    <script>
        // Show notification if order is successful
        <% if (orderSuccess != null) { %>
                                                            // Notification will auto-hide after 5 seconds (via CSS animation)
                                                            setTimeout(function () {
                                                                document.querySelector('.notification').style.display = 'none';
                                                            }, 5000);
        <% } %>

                                                            // Shop Now button functionality
                                                            document.querySelector('.shop-now-btn').addEventListener('click', function () {
                                                                // Scroll to product section
                                                                document.querySelector('.product-section').scrollIntoView({
                                                                    behavior: 'smooth'
                                                                });
                                                            });

                                                        // Category cards functionality
                                                        document.querySelectorAll('.category-card').forEach(function (card) {
                                                            card.addEventListener('click', function () {
                                                                // Here you would typically filter products by category
                                                                // For now, just scroll to products
                                                                document.querySelector('.product-section').scrollIntoView({
                                                                    behavior: 'smooth'
                                                                });
                                                            });
                                                        });
                                                    </script>
                                        </body>

                                        </html>