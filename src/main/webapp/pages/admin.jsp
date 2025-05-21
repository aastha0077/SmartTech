<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="Model.Product"%>
<%
String contextPath =(String) request.getContextPath();
String alreadyExists = (String) request.getAttribute("alreadyExists");
String productAdded = (String)request.getAttribute("productAdded");
%> 

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | Smart Home Care</title>
    <link rel="stylesheet" href="<%=contextPath%>/stylesheets/admin.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
      :root {
        --primary-color: #3498db;
        --secondary-color: #2ecc71;
        --danger-color: #e74c3c;
        --text-color: #333;
        --light-bg: #f8f9fa;
        --border-radius: 8px;
        --box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        --transition: all 0.3s ease;
      }

      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }

      body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f4f6f9;
        color: var(--text-color);
        line-height: 1.6;
      }

      .container {
        display: flex;
        min-height: 100vh;
      }

      /* Sidebar Styles */
      .sidebar {
        width: 260px;
        background: linear-gradient(180deg, #2c3e50, #34495e);
        color: white;
        padding: 20px 0;
        height: 100vh;
        position: fixed;
        box-shadow: var(--box-shadow);
        z-index: 1000;
      }

      .logo-details {
        display: flex;
        align-items: center;
        padding: 0 20px 20px;
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        margin-bottom: 20px;
      }

      .logo {
        width: 40px;
        height: 40px;
        margin-right: 15px;
        filter: brightness(0) invert(1);
      }

      .title h4 {
        font-size: 18px;
        margin-bottom: 5px;
      }

      .title p {
        font-size: 12px;
        opacity: 0.7;
      }

      .sidebar ul {
        list-style: none;
      }

      .sidebar ul li {
        padding: 14px 20px;
        margin: 0 10px 5px;
        border-radius: var(--border-radius);
        transition: var(--transition);
        cursor: pointer;
        display: flex;
        align-items: center;
      }

      .sidebar ul li:hover {
        background-color: rgba(255, 255, 255, 0.1);
      }

      .sidebar ul li img {
        width: 20px;
        height: 20px;
        margin-right: 10px;
        filter: brightness(0) invert(1);
      }

      .sidebar ul li span {
        font-size: 14px;
      }

      .sidebar ul li button {
        background: transparent;
        border: none;
        color: white;
        font-size: 14px;
        cursor: pointer;
        width: 100%;
        text-align: left;
        font-family: inherit;
      }

      /* Main Content Styles */
      .main-content {
        flex: 1;
        padding: 30px;
        margin-left: 260px;
      }

      .page-header {
        margin-bottom: 30px;
      }

      .page-header h1 {
        font-size: 28px;
        color: var(--text-color);
        margin-bottom: 10px;
      }

      .page-header p {
        color: #6c757d;
      }

      .action-row {
        display: flex;
        gap: 20px;
        margin-bottom: 30px;
        flex-wrap: wrap;
      }

      .card {
        background-color: white;
        border-radius: var(--border-radius);
        padding: 20px;
        box-shadow: var(--box-shadow);
        transition: var(--transition);
        flex: 1;
        min-width: 200px;
      }

      .card:hover {
        transform: translateY(-5px);
      }

      .card a {
        display: flex;
        flex-direction: column;
        align-items: center;
        text-decoration: none;
        color: var(--text-color);
      }

      .card img {
        width: 40px;
        height: 40px;
        margin-bottom: 15px;
      }

      .card button {
        background-color: var(--primary-color);
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: var(--border-radius);
        cursor: pointer;
        font-size: 14px;
        font-weight: 600;
        width: 100%;
        transition: var(--transition);
      }

      .card button:hover {
        opacity: 0.9;
      }

      .card button.danger {
        background-color: var(--danger-color);
      }

      .card button.success {
        background-color: var(--secondary-color);
      }

      /* Modal Styles */
      .modal {
        display: none;
        position: fixed;
        z-index: 1100;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgba(0, 0, 0, 0.5);
        backdrop-filter: blur(3px);
        animation: fadeIn 0.3s ease;
      }

      @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
      }

      @keyframes slideUp {
        from { transform: translateY(50px); opacity: 0; }
        to { transform: translateY(0); opacity: 1; }
      }

      .modal-content {
        background-color: white;
        margin: 5% auto;
        padding: 30px;
        border-radius: var(--border-radius);
        box-shadow: var(--box-shadow);
        width: 90%;
        max-width: 500px;
        position: relative;
        animation: slideUp 0.4s ease;
      }

      .modal-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
        padding-bottom: 15px;
        border-bottom: 1px solid #eee;
      }

      .modal-header h2 {
        font-size: 22px;
        color: var(--text-color);
      }

      .close {
        position: absolute;
        top: 20px;
        right: 20px;
        font-size: 24px;
        color: #aaa;
        cursor: pointer;
        transition: var(--transition);
      }

      .close:hover {
        color: var(--text-color);
      }

      .form-group {
        margin-bottom: 20px;
      }

      .form-group label {
        display: block;
        font-weight: 600;
        margin-bottom: 8px;
        color: #555;
        font-size: 14px;
      }

      .form-control {
        width: 100%;
        padding: 12px;
        border: 1px solid #ddd;
        border-radius: var(--border-radius);
        font-size: 14px;
        transition: var(--transition);
      }

      .form-control:focus {
        border-color: var(--primary-color);
        outline: none;
        box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
      }

      textarea.form-control {
        resize: vertical;
        min-height: 100px;
      }

      .file-input {
        display: block;
        width: 100%;
        padding: 12px;
        border: 1px solid #ddd;
        border-radius: var(--border-radius);
        background-color: var(--light-bg);
        font-size: 14px;
        cursor: pointer;
      }

      select.form-control {
        appearance: none;
        background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='%23333' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpath d='M6 9l6 6 6-6'/%3E%3C/svg%3E");
        background-repeat: no-repeat;
        background-position: right 12px center;
        padding-right: 40px;
      }

      .btn {
        padding: 12px 24px;
        font-size: 14px;
        font-weight: 600;
        border: none;
        border-radius: var(--border-radius);
        cursor: pointer;
        transition: var(--transition);
      }

      .btn-primary {
        background-color: var(--primary-color);
        color: white;
      }

      .btn-primary:hover {
        background-color: #2980b9;
      }

      .btn-danger {
        background-color: var(--danger-color);
        color: white;
      }

      .btn-success {
        background-color: var(--secondary-color);
        color: white;
      }

      .btn-block {
        display: block;
        width: 100%;
      }

      /* Responsive design */
      @media screen and (max-width: 768px) {
        .container {
          flex-direction: column;
        }
        
        .sidebar {
          width: 100%;
          height: auto;
          position: relative;
          padding: 10px 0;
        }
        
        .main-content {
          margin-left: 0;
          padding: 20px;
        }
        
        .action-row {
          flex-direction: column;
        }
        
        .card {
          width: 100%;
        }
      }
    </style>
</head>
<body>
    <div class="container">
        <nav class="sidebar">
            <div class="logo-details">
                <img src="<%=contextPath%>/resources/images/admin/icons8-smart-home-50.png" class="logo">
                <div class="title">
                    <h4>SmartTech</h4>
                    <p>One Solution for Every Problem</p>
                </div>
            </div>
            <ul>
                <li><i class="fas fa-tachometer-alt" style="color: white; margin-right: 10px;"></i><span>Dashboard</span></li>
                <li><i class="fas fa-users" style="color: white; margin-right: 10px;"></i><span>Users</span></li>
                <li><i class="fas fa-box" style="color: white; margin-right: 10px;"></i>
                    <form action="<%=contextPath%>/AdminProducts" method="post">
                        <button type="submit">Products</button>
                    </form>
                </li>
                <li><i class="fas fa-shopping-cart" style="color: white; margin-right: 10px;"></i>
                    <form action="<%=contextPath%>/AllOrders" method="post">
                        <button type="submit">Order History</button>
                    </form>
                </li>
                <li><i class="fas fa-cog" style="color: white; margin-right: 10px;"></i>
                    <form action="<%=contextPath%>/AdminProfileServlet">
                        <button type="submit">Settings</button>
                    </form>
                </li>
                <li><i class="fas fa-sign-out-alt" style="color: white; margin-right: 10px;"></i>
                    <form action="<%=contextPath%>/logout" method="post">
                        <button type="submit">Logout</button>
                    </form>
                </li>
            </ul>
        </nav>
        
        <div class="main-content">
            <div class="page-header">
                <h1>Product Management</h1>
                <p>Manage your product inventory with ease</p>
            </div>
            
            <div class="action-row">
                <div class="card">
                    <a href="#">
                        <i class="fas fa-edit" style="font-size: 40px; color: #3498db; margin-bottom: 15px;"></i>
                        <button id="openUpdateButton" class="btn btn-primary">Update Product</button>
                    </a>
                </div>
                <div class="card">
                    <a href="#">
                        <i class="fas fa-plus-circle" style="font-size: 40px; color: #2ecc71; margin-bottom: 15px;"></i>
                        <button id="openCustomFormBtn" class="btn btn-success">Add Product</button>
                    </a>
                </div>
                <div class="card">
                    <a href="#">
                        <i class="fas fa-trash-alt" style="font-size: 40px; color: #e74c3c; margin-bottom: 15px;"></i>
                        <button id="openDeleteBtn" class="btn btn-danger">Delete Product</button>
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Delete Product Modal -->
    <div id="deleteForm" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <div class="modal-header">
                <h2>Delete Product</h2>
            </div>
            <form id="productForm" action="<%=contextPath%>/DeleteProduct" method="post">
                <div class="form-group">
                    <label for="productID">Product ID:</label>
                    <input type="number" id="productID" name="productId" class="form-control" required />
                </div>
                <button type="submit" class="btn btn-danger btn-block">Delete Product</button>
            </form>
        </div>
    </div>
    
    <!-- Add Product Modal -->
    <div id="customProductForm" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <div class="modal-header">
                <h2>Add New Product</h2>
            </div>
            <form action="<%= contextPath%>/AddProduct" method="post" id="productAddForm" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="customProductId">Product ID:</label>
                    <input type="text" id="customProductId" name="productId" class="form-control" required />
                </div>
                <div class="form-group">
                    <label for="customProductName">Product Name:</label>
                    <input type="text" id="customProductName" name="productName" class="form-control" required />
                </div>
                <div class="form-group">
                    <label for="customProductDescription">Description:</label>
                    <textarea id="customProductDescription" name="productDescription" class="form-control" required></textarea>
                </div>
                <div class="form-group">
                    <label for="customProductPrice">Price:</label>
                    <input type="number" id="customProductPrice" name="productPrice" class="form-control" required />
                </div>
                <div class="form-group">
                    <label for="appliance">Category:</label>
                    <select id="appliance" name="categoryId" class="form-control">
                        <option value="1">Vacuum Cleaner</option>
                        <option value="2">Refrigerator</option>
                        <option value="3">Air Conditioner</option>
                        <option value="4">Washing Machine</option>
                         <option value="5">TV</option>
                        <option value="6">Fan</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="customProductQuantity">Quantity:</label>
                    <input type="number" id="customProductQuantity" name="productQuantity" class="form-control" required />
                </div>
                <div class="form-group">
                    <label for="customProductImage">Product Image:</label>
                    <input type="file" id="customProductImage" name="productImage" class="file-input" accept="image/*" />
                </div>
                <button type="submit" class="btn btn-success btn-block">Add Product</button>
            </form>
        </div>
    </div>
    
    <!-- Update Product Modal -->
    <div id="customProductForm2" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <div class="modal-header">
                <h2>Update Product</h2>
            </div>
            <form action="<%= contextPath%>/UpdateProduct" method="post" id="productForm2" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="updateProductId">Product ID:</label>
                    <input type="text" id="updateProductId" name="productId" class="form-control" required />
                </div>
                <div class="form-group">
                    <label for="updateProductName">Product Name:</label>
                    <input type="text" id="updateProductName" name="productName" class="form-control" required />
                </div>
                <div class="form-group">
                    <label for="updateProductDescription">Description:</label>
                    <textarea id="updateProductDescription" name="productDescription" class="form-control" required></textarea>
                </div>
                <div class="form-group">
                    <label for="updateProductPrice">Price:</label>
                    <input type="number" id="updateProductPrice" name="productPrice" class="form-control" required />
                </div>
                <div class="form-group">
                    <label for="updateAppliance">Category:</label>
                    <select id="updateAppliance" name="categoryId" class="form-control">
                        <option value="1">Vacuum Cleaner</option>
                        <option value="2">Refrigerator</option>
                        <option value="3">Air Conditioner</option>
                        <option value="4">Washing Machine</option>
                        <option value="5">TV</option>
                        <option value="6">Fan</option>
                        
                    </select>
                </div>
                <div class="form-group">
                    <label for="updateProductQuantity">Quantity:</label>
                    <input type="number" id="updateProductQuantity" name="productQuantity" class="form-control" required />
                </div>
                <div class="form-group">
                    <label for="updateProductImage">Product Image:</label>
                    <input type="file" id="updateProductImage" name="productImage" class="file-input" accept="image/*" />
                </div>
                <button type="submit" class="btn btn-primary btn-block">Update Product</button>
            </form>
        </div>
    </div>
    
    <script>
        // Alert messages
        <% if(alreadyExists != null) { %>
            alert("Product ID already exists");
        <% } %>
        
        <% if(productAdded != null) { %>
            alert("Product Added Successfully");
        <% } %>
        
        // Delete Product Modal
        const deleteModal = document.getElementById("deleteForm");
        const deleteBtn = document.getElementById("openDeleteBtn");
        const deleteClose = deleteModal.querySelector(".close");
        
        deleteBtn.addEventListener("click", function() {
            deleteModal.style.display = "block";
        });
        
        deleteClose.addEventListener("click", function() {
            deleteModal.style.display = "none";
        });
        
        // Add Product Modal
        const addModal = document.getElementById("customProductForm");
        const addBtn = document.getElementById("openCustomFormBtn");
        const addClose = addModal.querySelector(".close");
        
        addBtn.addEventListener("click", function() {
            addModal.style.display = "block";
        });
        
        addClose.addEventListener("click", function() {
            addModal.style.display = "none";
        });
        
        // Update Product Modal
        const updateModal = document.getElementById("customProductForm2");
        const updateBtn = document.getElementById("openUpdateButton");
        const updateClose = updateModal.querySelector(".close");
        
        updateBtn.addEventListener("click", function() {
            updateModal.style.display = "block";
        });
        
        updateClose.addEventListener("click", function() {
            updateModal.style.display = "none";
        });
        
        // Close modals when clicking outside
        window.addEventListener("click", function(event) {
            if (event.target == deleteModal) {
                deleteModal.style.display = "none";
            }
            if (event.target == addModal) {
                addModal.style.display = "none";
            }
            if (event.target == updateModal) {
                updateModal.style.display = "none";
            }
        });
    </script>
</body>
</html>