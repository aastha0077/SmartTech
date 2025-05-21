<%@ page import="utils.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String contextPath = request.getContextPath();
String errMsg = (String) request.getAttribute(StringUtils.MESSAGE_ERROR);
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Login</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <style>
    :root {
      --primary-blue: #1a73e8;
      --light-blue: #e8f0fe;
      --hover-blue: #0d62d1;
      --error-red: #d93025;
      --border-color: #dadce0;
      --text-dark: #202124;
      --text-gray: #5f6368;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    body {
      background: linear-gradient(135deg, #f5f9ff 0%, #deeaff 100%);
      min-height: 100vh;
    }

    /* Header Styles */
    .navbar {
      background: linear-gradient(135deg, #4a90e2, #2c7bdc);
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
      padding: 15px 0;
    }

    .container {
      max-width: 1200px;
      margin: 0 auto;
      padding: 0 20px;
    }

    .nav-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .brand-logo {
      font-size: 24px;
      font-weight: 700;
      color: white;
      text-decoration: none;
      display: flex;
      align-items: center;
    }

    .brand-logo i {
      margin-right: 10px;
      color: #ffcc00;
    }

    /* Login Container */
    .login-wrapper {
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 40px 20px;
    }

    .login-container {
      width: 100%;
      max-width: 500px;
      background-color: white;
      border-radius: 12px;
      box-shadow: 0 12px 28px rgba(0, 0, 0, 0.12);
      overflow: hidden;
      padding: 40px;
      margin-top: 30px;
    }

    .form-header {
      margin-bottom: 30px;
      text-align: center;
    }

    .form-header h2 {
      color: var(--primary-blue);
      font-size: 32px;
      font-weight: 700;
      margin-bottom: 10px;
    }

    .form-header p {
      color: var(--text-gray);
      font-size: 16px;
    }

    .error-msg {
      background-color: rgba(217, 48, 37, 0.1);
      color: var(--error-red);
      padding: 12px;
      border-radius: 8px;
      margin-bottom: 20px;
      font-size: 14px;
      border-left: 4px solid var(--error-red);
    }

    .input-group {
      margin-bottom: 20px;
      position: relative;
    }

    .input-group input {
      width: 100%;
      padding: 15px;
      font-size: 16px;
      border: 1px solid var(--border-color);
      border-radius: 8px;
      outline: none;
      transition: border 0.2s ease;
    }

    .input-group input::placeholder {
      color: var(--text-gray);
    }

    .input-group input:focus {
      border-color: var(--primary-blue);
      box-shadow: 0 0 0 2px rgba(26, 115, 232, 0.2);
    }

    .btn-login {
      width: 100%;
      padding: 15px;
      background-color: var(--primary-blue);
      color: white;
      border: none;
      border-radius: 8px;
      font-size: 16px;
      font-weight: 600;
      cursor: pointer;
      transition: background-color 0.2s ease;
    }

    .btn-login:hover {
      background-color: var(--hover-blue);
    }

    .register-link {
      text-align: center;
      margin-top: 25px;
      color: var(--text-gray);
      font-size: 15px;
    }

    .register-link a {
      color: var(--primary-blue);
      text-decoration: none;
      font-weight: 600;
    }

    .register-link a:hover {
      text-decoration: underline;
    }

    @media (max-width: 768px) {
      .login-container {
        padding: 30px 20px;
      }
      
      .form-header h2 {
        font-size: 28px;
      }
    }
  </style>
</head>
<body>
  <!-- Header Section -->
           <jsp:include page="/pages/header.jsp"></jsp:include>
       

  <!-- Login Form Section -->
  <div class="login-wrapper">
    <div class="login-container">
      <div class="form-header">
        <h2>Welcome Back</h2>
        <p>Please enter your credentials to login</p>
      </div>

      <% if (errMsg != null) { %>
      <div class="error-msg">
        <%= errMsg %>
      </div>
      <% } %>

      <form action="<%=contextPath+StringUtils.SERVLET_URL_LOGIN %>" method="post">
        <div class="input-group">
          <input
            type="text"
            name="userName"
            placeholder="Username"
            required
            autofocus="autofocus"
          />
        </div>
        <div class="input-group">
          <input
            type="password"
            name="password"
            placeholder="Password"
            required
          />
        </div>
        <button class="btn-login" type="submit">Log In</button>
      </form>
      
      <div class="register-link">
        Don't have an account? <a href="<%=contextPath%>/pages/signup.jsp">Register</a>
      </div>
    </div>
  </div>
</body>
</html>