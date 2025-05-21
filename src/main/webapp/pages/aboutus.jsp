<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String contextPath = request.getContextPath();
%>    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Smart Home Care</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <link rel="stylesheet" href="<%=contextPath%>/stylesheets/index.css">
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --accent-color: #4895ef;
            --success-color: #4CAF50;
            --error-color: #f44336;
            --text-color: #333;
            --light-text: #777;
            --bg-color: #f9fafb;
            --card-bg: #fff;
            --border-radius: 12px;
            --box-shadow: 0 8px 20px rgba(0,0,0,0.08);
            --transition: all 0.3s ease;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background: var(--bg-color);
            color: var(--text-color);
            line-height: 1.6;
        }
        
        .main-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        /* Header fixes */
        .navbar {
            background: linear-gradient(135deg, #4a90e2, #2c7bdc);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        .nav-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 0;
        }
        
        /* About Us Content */
        .page-header {
            text-align: center;
            margin: 40px 0 30px;
        }
        
        .page-header h1 {
            font-size: 2.8rem;
            color: var(--secondary-color);
            margin-bottom: 15px;
        }
        
        .page-header p {
            font-size: 1.2rem;
            color: var(--light-text);
            max-width: 800px;
            margin: 0 auto;
        }
        
        /* Mission Section */
        .mission-section {
            display: flex;
            flex-wrap: wrap;
            gap: 40px;
            margin: 60px 0;
            align-items: center;
        }
        
        .mission-content {
            flex: 1;
            min-width: 300px;
        }
        
        .mission-image {
            flex: 1;
            min-width: 300px;
            border-radius: var(--border-radius);
            overflow: hidden;
            box-shadow: var(--box-shadow);
        }
        
        .mission-image img {
            width: 100%;
            height: auto;
            display: block;
        }
        
        .section-title {
            font-size: 2rem;
            color: var(--primary-color);
            margin-bottom: 20px;
            position: relative;
        }
        
        .section-title:after {
            content: '';
            position: absolute;
            left: 0;
            bottom: -10px;
            width: 60px;
            height: 4px;
            background: var(--accent-color);
        }
        
        /* Team Section */
        .team-section {
            margin: 80px 0;
        }
        
        .team-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 30px;
            margin-top: 40px;
        }
        
        .team-member {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            overflow: hidden;
            box-shadow: var(--box-shadow);
            transition: var(--transition);
            text-align: center;
        }
        
        .team-member:hover {
            transform: translateY(-10px);
        }
        
        .member-image {
            width: 100%;
            height: 250px;
            object-fit: cover;
        }
        
        .member-info {
            padding: 20px;
        }
        
        .member-name {
            font-size: 1.3rem;
            margin-bottom: 5px;
            color: var(--secondary-color);
        }
        
        .member-position {
            color: var(--accent-color);
            font-weight: 500;
            margin-bottom: 15px;
        }
        
        /* Contact Section */
        .contact-container {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
            background: var(--card-bg);
            border-radius: var(--border-radius);
            overflow: hidden;
            box-shadow: var(--box-shadow);
            margin: 60px 0;
        }
        
        .contact-info {
            flex: 1;
            min-width: 300px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 40px 30px;
        }
        
        .contact-info h2 {
            font-size: 1.8rem;
            margin-bottom: 15px;
            position: relative;
        }
        
        .contact-info h2:after {
            content: '';
            position: absolute;
            left: 0;
            bottom: -8px;
            width: 50px;
            height: 3px;
            background: white;
        }
        
        .contact-info p {
            margin-bottom: 30px;
            font-size: 1.1rem;
        }
        
        .contact-info ul {
            list-style: none;
        }
        
        .contact-info li {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .contact-info img.dashboard {
            width: 24px;
            height: 24px;
            margin-right: 15px;
            filter: brightness(0) invert(1);
        }
        
        .contact-form {
            flex: 1;
            min-width: 300px;
            padding: 40px 30px;
        }
        
        .contact-form h2 {
            color: var(--text-color);
            margin-bottom: 25px;
            position: relative;
        }
        
        .contact-form h2:after {
            content: '';
            position: absolute;
            left: 0;
            bottom: -8px;
            width: 50px;
            height: 3px;
            background: var(--primary-color);
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            color: var(--light-text);
            font-weight: 500;
        }
        
        input[type="text"],
        input[type="email"], 
        textarea {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
            transition: var(--transition);
        }
        
        input:focus, textarea:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.15);
        }
        
        textarea {
            min-height: 120px;
            resize: vertical;
        }
        
        .form-actions {
            text-align: right;
        }
        
        .btn {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border: none;
            padding: 12px 28px;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
        }
        
        .btn:hover {
            background: linear-gradient(135deg, var(--secondary-color), var(--primary-color));
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(67, 97, 238, 0.3);
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .mission-section {
                flex-direction: column;
            }
            
            .contact-container {
                flex-direction: column;
            }
            
            .contact-info, .contact-form {
                padding: 30px 20px;
            }
            
            .page-header h1 {
                font-size: 2.2rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/pages/header.jsp"></jsp:include>

    <div class="main-container">
        <header class="page-header">
            <h1>About SmartTech</h1>
            <p>Your comfort is our priority. We provide smart solutions that anticipate your needs and enhance your home experience..</p>
        </header>
        
        <section class="mission-section">
            <div class="mission-content">
                <h2 class="section-title">Our Mission</h2>
                <p>At SmartTech, we believe technology should simplify your life, not complicate it. Founded in 2020, we've been helping thousands of customers transform their houses into smart homes with our carefully curated selection of products.</p>
                <p>Our team of experts tests every product we sell to ensure it meets our high standards for quality, reliability, and ease of use. We're committed to providing exceptional customer service and making smart home technology accessible to everyone.</p>
                <p>Whether you're looking to automate your lighting, secure your home, or control your appliances remotely, we have the solutions and expertise to help you every step of the way.</p>
            </div>
           
        </section>
        
        <section class="team-section">
            <h2 class="section-title" style="text-align: center;">Meet Our Team</h2>
            <div class="team-grid">
                <div class="team-member">
                    <img src="<%=contextPath%>/resources/images/aboutus/team1.jpg" alt="Team Member" class="member-image">
                    <div class="member-info">
                        <h3 class="member-name">Aastha Aryal</h3>
                        <p class="member-position">CEO & Founder</p>
                        <p>With over 15 years in home automation, John leads our vision for smarter living.</p>
                    </div>
                </div>
                <div class="team-member">
                    <img src="<%=contextPath%>/resources/images/aboutus/team2.jpg" alt="Team Member" class="member-image">
                    <div class="member-info">
                        <h3 class="member-name">Kriti Lama</h3>
                        <p class="member-position">Product Specialist</p>
                        <p>Sarah tests every product to ensure it meets our rigorous standards.</p>
                    </div>
                </div>
                <div class="team-member">
                    <img src="<%=contextPath%>/resources/images/aboutus/team3.jpg" alt="Team Member" class="member-image">
                    <div class="member-info">
                        <h3 class="member-name">Salina Lama</h3>
                        <p class="member-position">Customer Support</p>
                        <p>Michael and his team provide award-winning customer service.</p>
                    </div>
                </div>
                <div class="team-member">
                    <img src="<%=contextPath%>/resources/images/aboutus/team4.jpg" alt="Team Member" class="member-image">
                    <div class="member-info">
                        <h3 class="member-name">Emily Wilson</h3>
                        <p class="member-position">Technical Expert</p>
                        <p>Emily helps customers with installation and troubleshooting.</p>
                    </div>
                </div>
            </div>
        </section>
        
        <div class="contact-container">
            <div class="contact-info">
                <h2>Get In Touch</h2>
                <p>Have questions about our products or services? We'd love to hear from you!</p>
                <ul>
                    <li><img src="<%=contextPath%>/resources/images/aboutus/phone.png" class="dashboard"><span>Phone: +977-984578990</span></li>
                    <li><img src="<%=contextPath%>/resources/images/aboutus/location.png" class="dashboard"><span>Address: Baneshowr, Kathmandu, Nepal</span></li>
                    <li><img src="<%=contextPath%>/resources/images/aboutus/email.png" class="dashboard"><span>Email: SmartTech@gmail.com</span></li>
                    <li><img src="<%=contextPath%>/resources/images/aboutus/clock.png" class="dashboard"><span>Hours: Sun-Fri 9AM-6PM</span></li>
                </ul>
            </div>
            <div class="contact-form">
                <h2>Send Us a Message</h2>
                <form action="<%=contextPath%>/ContactServlet" method="post">
                    <div class="form-group">
                        <label for="name">Your Name:</label>
                        <input type="text" id="name" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Your Email:</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="message">Your Message:</label>
                        <textarea id="message" name="message" required></textarea>
                    </div>
                    <div class="form-actions">
                        <button type="submit" class="btn">Send Message</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>