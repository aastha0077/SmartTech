<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "utils.StringUtils"%>
    
<%
String contextPath = request.getContextPath();
String errMsg = (String) request.getAttribute(StringUtils.MESSAGE_ERROR);
String successMsg = (String) request.getAttribute(StringUtils.MESSAGE_SUCCESS);
String username = (String) request.getAttribute(StringUtils.USERNAME);
String successParam = request.getParameter(StringUtils.SUCCESS);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
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
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            line-height: 1.6;
        }
        
        .signup-form {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            width: 100%;
            max-width: 900px;
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }
        
        .form-header {
            padding: 25px 30px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            text-align: center;
            position: relative;
        }
        
        .form-header h2 {
            color: white;
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 5px;
        }
        
        .form-header p {
            color: rgba(255, 255, 255, 0.85);
            font-size: 16px;
        }
        
        .container {
            padding: 30px;
        }
        
        .main {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
        }
        
        .content, .contents {
            flex: 1;
            min-width: 300px;
        }
        
        .input-group {
            margin-bottom: 20px;
            position: relative;
        }
        
        .input-group i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--light-text);
        }
        
        .input-group input,
        .input-group select {
            width: 100%;
            padding: 12px 15px 12px 45px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
            transition: var(--transition);
        }
        
        .input-group input:focus,
        .input-group select:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.15);
        }
        
        .date-details, .gender-details, .form-group {
            margin-bottom: 25px;
        }
        
        .section-title {
            display: block;
            margin-bottom: 10px;
            font-weight: 600;
            color: var(--text-color);
            font-size: 16px;
        }
        
        .category {
            display: flex;
            gap: 15px;
            margin-top: 10px;
        }
        
        .gender-option {
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
        }
        
        .gender-option input[type="radio"] {
            display: none;
        }
        
        .radio-checkmark {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 2px solid #ddd;
            border-radius: 50%;
            position: relative;
        }
        
        .gender-option input[type="radio"]:checked + .radio-checkmark:after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background: var(--primary-color);
        }
        
        .btn {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            width: 100%;
            transition: var(--transition);
            margin-top: 15px;
        }
        
        .btn:hover {
            background: linear-gradient(135deg, var(--secondary-color), var(--primary-color));
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(67, 97, 238, 0.3);
        }
        
        .account {
            text-align: center;
            margin-top: 20px;
            color: var(--light-text);
        }
        
        .account a {
            color: var(--primary-color);
            font-weight: 600;
            text-decoration: none;
            transition: var(--transition);
        }
        
        .account a:hover {
            color: var(--secondary-color);
            text-decoration: underline;
        }
        
        .file-upload {
            position: relative;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        
        .file-upload input[type="file"] {
            opacity: 0;
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            cursor: pointer;
            z-index: 2;
        }
        
        .file-upload-btn {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px 15px;
            border: 1px dashed var(--accent-color);
            border-radius: 6px;
            color: var(--accent-color);
            font-weight: 500;
            cursor: pointer;
            transition: var(--transition);
        }
        
        .file-upload:hover .file-upload-btn {
            background-color: rgba(72, 149, 239, 0.08);
        }
        
        .file-name {
            font-size: 14px;
            color: var(--light-text);
        }
        
        .error-msg {
            color: var(--error-color);
            margin: 5px 0 15px;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        .success-popup {
            position: fixed;
            top: 20px;
            right: 20px;
            background-color: var(--success-color);
            color: white;
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 15px 25px;
            border-radius: 6px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.15);
            z-index: 1000;
            display: none;
            animation: fadeIn 0.5s;
        }
        
        @keyframes fadeIn {
            from {opacity: 0; transform: translateY(-20px);}
            to {opacity: 1; transform: translateY(0);}
        }
        
        @keyframes fadeOut {
            from {opacity: 1; transform: translateY(0);}
            to {opacity: 0; transform: translateY(-20px);}
        }
        
        @media (max-width: 768px) {
            .main {
                flex-direction: column;
                gap: 20px;
            }
            
            .content, .contents {
                min-width: 100%;
            }
            
            .form-header {
                padding: 20px;
            }
            
            .container {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
           <jsp:include page="/pages/header.jsp"></jsp:include>


    <div class="success-popup" id="successPopup">
        <i class="fas fa-check-circle"></i> Registration Successful!
    </div>
    
    <div class="signup-form">
        <div class="form-header">
            <h2>Create Your Account</h2>
            <p>Join us today and enjoy all our features</p>
        </div>
        
        <form action="<%=contextPath+StringUtils.SERVLET_URL_REGISTER %>" method="post" enctype="multipart/form-data">
            <div class="container">
                <% if (errMsg != null) { %>
                    <div class="error-msg">
                        <i class="fas fa-exclamation-circle"></i> <%= errMsg %>
                    </div>
                <% } %>
                
                <div class="main">
                    <div class="content">
                        <div class="input-group">
                            <i class="fas fa-user"></i>
                            <input type="text" name="fullName" placeholder="Full Name" required>
                        </div>
                        
                        <div class="input-group">
                            <i class="fas fa-envelope"></i>
                            <input type="email" name="email" placeholder="Email Address" required>
                        </div>
                        
                        <div class="input-group">
                            <i class="fas fa-user-tag"></i>
                            <input type="text" name="userName" placeholder="Username" required>
                        </div>
                        
                        <div class="input-group">
                            <i class="fas fa-phone"></i>
                            <input type="text" name="phoneNumber" placeholder="Phone Number" required>
                        </div>
                        
                        <div class="input-group">
                            <i class="fas fa-map-marker-alt"></i>
                            <input type="text" name="address" placeholder="Address" required>
                        </div>
                        
                        <div class="input-group">
                            <i class="fas fa-lock"></i>
                            <input type="password" name="password" placeholder="Password" required>
                        </div>
                        
                        <div class="input-group">
                            <i class="fas fa-check-circle"></i>
                            <input type="password" name="confirmPassword" placeholder="Confirm Password" required>
                        </div>
                    </div>
                    
                    <div class="contents">
                        <div class="date-details">
                            <span class="section-title">Birth Date</span>
                            <div class="input-group">
                                <i class="fas fa-calendar"></i>
                                <input name="birthDate" type="date" id="Birtday">
                            </div>
                        </div>
                        
                        <div class="gender-details">
                            <span class="section-title">Gender</span>
                            <div class="category">
                                <label class="gender-option">
                                    <input type="radio" name="gender" value="Male" id="zero-1">
                                    <span class="radio-checkmark"></span>
                                    <span class="gender">Male</span>
                                </label>
                                
                                <label class="gender-option">
                                    <input type="radio" name="gender" value="Female" id="zero-2">
                                    <span class="radio-checkmark"></span>
                                    <span class="gender">Female</span>
                                </label>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <span class="section-title">Profile Picture</span>
                            <div class="file-upload">
                                <label class="file-upload-btn">
                                    <i class="fas fa-cloud-upload-alt"></i>
                                    <span>Choose a file</span>
                                    <input type="file" id="image" name="image">
                                </label>
                                <span class="file-name" id="file-chosen">No file chosen</span>
                            </div>
                        </div>
                        
                        <button class="btn" type="submit">
                            <i class="fas fa-user-plus"></i> Create Account
                        </button>
                        
                        <p class="account">Already have an account? <a href="login.jsp">Log In</a></p>
                    </div>
                </div>
            </div>
        </form>
    </div>
    
    <script>
        // Display file name when selected
        const fileInput = document.getElementById('image');
        const fileChosen = document.getElementById('file-chosen');
        
        fileInput.addEventListener('change', function() {
            if(this.files && this.files[0]) {
                fileChosen.textContent = this.files[0].name;
            } else {
                fileChosen.textContent = 'No file chosen';
            }
        });
        
        // Check if there's a success message to show
        window.onload = function() {
            <% if (successMsg != null) { %>
                var popup = document.getElementById('successPopup');
                popup.style.display = 'flex';
                
                // Hide after 3 seconds
                setTimeout(function() {
                    popup.style.animation = 'fadeOut 0.5s';
                    setTimeout(function() {
                        popup.style.display = 'none';
                    }, 500);
                }, 3000);
            <% } %>
        };
    </script>
</body>
</html>