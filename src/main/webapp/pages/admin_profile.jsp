<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="Model.User" import="utils.StringUtils" %>
 
<%
    User admin  =(User)request.getAttribute("user");
    String contextPath = request.getContextPath();
    String imageUrl = admin.getImageUrlFromPart();  
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Admin Profile</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
      :root {
        --primary-color: #3498db;
        --primary-hover: #2980b9;
        --secondary-color: #2ecc71;
        --secondary-hover: #27ae60;
        --text-color: #333;
        --light-text: #666;
        --border-color: #ddd;
        --bg-color: #f9f9f9;
        --card-bg: #fff;
        --error-color: #e74c3c;
        --shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        --border-radius: 8px;
      }

      * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
      }

      body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: var(--bg-color);
        color: var(--text-color);
        line-height: 1.6;
        min-height: 100vh;
      }

      .page-container {
        display: flex;
        flex-direction: column;
        min-height: 100vh;
      }

      .header {
        background-color: var(--primary-color);
        color: white;
        padding: 20px 0;
        text-align: center;
        box-shadow: var(--shadow);
      }

      .header h1 {
        margin: 0;
        font-weight: 500;
      }

      .content-container {
        display: flex;
        justify-content: center;
        padding: 40px 20px;
        flex: 1;
      }

      .profile-container {
        background-color: var(--card-bg);
        border-radius: var(--border-radius);
        padding: 30px;
        box-shadow: var(--shadow);
        max-width: 900px;
        width: 100%;
        position: relative;
      }

      .back-button {
        position: absolute;
        top: 20px;
        right: 20px;
        background: none;
        border: none;
        font-size: 1.2rem;
        color: var(--light-text);
        cursor: pointer;
        transition: color 0.3s;
        display: flex;
        align-items: center;
        gap: 5px;
      }

      .back-button:hover {
        color: var(--primary-color);
      }

      .profile-header {
        display: flex;
        flex-direction: column;
        align-items: center;
        margin-bottom: 30px;
        position: relative;
      }

      .profile-picture {
        position: relative;
        margin-bottom: 15px;
      }

      .profile-picture img {
        width: 150px;
        height: 150px;
        border-radius: 50%;
        object-fit: cover;
        border: 3px solid var(--primary-color);
        box-shadow: var(--shadow);
        transition: transform 0.3s ease;
      }

      .profile-picture:hover img {
        transform: scale(1.05);
      }

      .profile-title {
        text-align: center;
        margin-bottom: 20px;
      }

      .profile-title h2 {
        font-weight: 600;
        color: var(--primary-color);
        margin-bottom: 5px;
      }

      .profile-title p {
        color: var(--light-text);
        font-size: 0.9rem;
      }

      .form-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 20px;
      }

      @media (max-width: 768px) {
        .form-grid {
          grid-template-columns: 1fr;
        }
      }

      .form-group {
        margin-bottom: 20px;
        position: relative;
      }

      .form-group label {
        display: block;
        margin-bottom: 8px;
        font-weight: 500;
        color: var(--light-text);
        font-size: 0.9rem;
      }

      .form-control {
        width: 100%;
        padding: 12px 15px;
        border: 1px solid var(--border-color);
        border-radius: var(--border-radius);
        font-size: 1rem;
        transition: all 0.3s;
        background-color: #f8f9fa;
      }

      .form-control:focus {
        outline: none;
        border-color: var(--primary-color);
        box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
        background-color: white;
      }

      .form-control::placeholder {
        color: #aaa;
      }

      .input-icon {
        position: absolute;
        right: 15px;
        top: 40px;
        color: var(--light-text);
      }

      .file-input-wrapper {
        position: relative;
        overflow: hidden;
        display: inline-block;
        cursor: pointer;
      }

      .file-input-wrapper input[type="file"] {
        position: absolute;
        left: 0;
        top: 0;
        opacity: 0;
        cursor: pointer;
        width: 100%;
        height: 100%;
      }

      .file-input-label {
        background-color: var(--secondary-color);
        color: white;
        padding: 12px 20px;
        border-radius: var(--border-radius);
        display: inline-block;
        transition: background-color 0.3s;
        font-weight: 500;
        text-align: center;
        width: 100%;
      }

      .file-input-wrapper:hover .file-input-label {
        background-color: var(--secondary-hover);
      }

      .file-name {
        margin-top: 8px;
        font-size: 0.85rem;
        color: var(--light-text);
        text-align: center;
      }

      .form-footer {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 30px;
        padding-top: 20px;
        border-top: 1px solid var(--border-color);
      }

      .btn {
        padding: 12px 24px;
        border: none;
        border-radius: var(--border-radius);
        font-size: 1rem;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.3s;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        min-width: 150px;
      }

      .btn-primary {
        background-color: var(--primary-color);
        color: white;
      }

      .btn-primary:hover {
        background-color: var(--primary-hover);
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      }

      .btn-secondary {
        background-color: var(--secondary-color);
        color: white;
      }

      .btn-secondary:hover {
        background-color: var(--secondary-hover);
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      }

      .btn-outline {
        background-color: transparent;
        border: 1px solid var(--border-color);
        color: var(--light-text);
      }

      .btn-outline:hover {
        background-color: #f1f1f1;
        color: var(--text-color);
      }

      .change-photo-btn {
        position: absolute;
        bottom: 0;
        right: 0;
        background-color: var(--primary-color);
        color: white;
        width: 40px;
        height: 40px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        border: 3px solid white;
        box-shadow: var(--shadow);
        transition: all 0.3s;
      }

      .change-photo-btn:hover {
        background-color: var(--primary-hover);
        transform: scale(1.1);
      }

      .photo-upload-modal {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        z-index: 1000;
        justify-content: center;
        align-items: center;
      }

      .modal-content {
        background-color: white;
        padding: 30px;
        border-radius: var(--border-radius);
        max-width: 500px;
        width: 100%;
        position: relative;
      }

      .modal-close {
        position: absolute;
        top: 15px;
        right: 15px;
        background: none;
        border: none;
        font-size: 1.5rem;
        cursor: pointer;
        color: var(--light-text);
      }

      .modal-title {
        margin-bottom: 20px;
        color: var(--primary-color);
      }
      
      .required-indicator {
        color: var(--error-color);
        margin-left: 3px;
      }
      
      .footer {
        text-align: center;
        padding: 20px;
        background-color: var(--primary-color);
        color: white;
        margin-top: auto;
      }
    </style>
  </head>
  <body>
    <div class="page-container">
      <header class="header">
        <h1>Admin Profile</h1>
      </header>
      
      <div class="content-container">
        <form action="<%=contextPath%>/ModifyAdmin" method="post" enctype="multipart/form-data" id="profileForm">
          <div class="profile-container">
            <a href="home.jsp" class="back-button">
              <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
            
            <div class="profile-header">
              <div class="profile-picture">
                <img src="<%=contextPath%>/resources/images/users/<%=imageUrl%>" alt="Profile Picture" id="profilePreview" />
                <label for="imageSelect" class="change-photo-btn" title="Change profile photo">
                  <i class="fas fa-camera"></i>
                </label>
                <input type="file" id="imageSelect" name="userImage" style="display: none;">
              </div>
              
              <div class="profile-title">
                <h2>Edit Your Profile</h2>
                <p>Update your personal information and profile picture</p>
              </div>
            </div>
            
            <div class="form-grid">
              <div class="form-group">
                <label for="fullName">Full Name <span class="required-indicator">*</span></label>
                <input 
                  type="text" 
                  id="fullName" 
                  name="userFullName" 
                  class="form-control" 
                  value="<%=admin.getFullName() %>" 
                  required
                  placeholder="Enter your full name"
                />
                <i class="fas fa-user input-icon"></i>
              </div>
              
              <div class="form-group">
                <label for="userEmail">Email Address <span class="required-indicator">*</span></label>
                <input
                  type="email"
                  id="userEmail"
                  class="form-control"
                  value="<%=admin.getEmail()%>"
                  name="userEmail"
                  required
                  placeholder="Enter your email address"
                />
                <i class="fas fa-envelope input-icon"></i>
              </div>
              
              <div class="form-group">
                <label for="userPhoneNumber">Phone Number <span class="required-indicator">*</span></label>
                <input
                  type="text"
                  id="userPhoneNumber"
                  class="form-control"
                  value="<%=admin.getPhoneNumber() %>"
                  name="userPhoneNumber"
                  required
                  placeholder="Enter your phone number"
                />
                <i class="fas fa-phone input-icon"></i>
              </div>
              
              <div class="form-group">
                <label for="userAddress">Address <span class="required-indicator">*</span></label>
                <input
                  type="text"
                  id="userAddress"
                  class="form-control"
                  value="<%=admin.getAddress() %>"
                  name="userAddress"
                  required
                  placeholder="Enter your address"
                />
                <i class="fas fa-map-marker-alt input-icon"></i>
              </div>
              
              <div class="form-group">
                <label for="userBirthDate">Birth Date <span class="required-indicator">*</span></label>
                <input
                  type="date"
                  id="userBirthDate"
                  class="form-control"
                  value="1990-01-01"
                  name="userBirthDate"
                  required
                />
                <i class="fas fa-calendar input-icon"></i>
              </div>
              
              <div class="form-group">
                <label for="userGender">Gender <span class="required-indicator">*</span></label>
                <select id="userGender" class="form-control" name="userGender">
                  <option value="Male" <%=admin.getGender().equals("Male") ? "selected" : "" %>>Male</option>
                  <option value="Female" <%=admin.getGender().equals("Female") ? "selected" : "" %>>Female</option>
                  <option value="Other" <%=admin.getGender().equals("Other") ? "selected" : "" %>>Other</option>
                </select>
                <i class="fas fa-venus-mars input-icon"></i>
              </div>
              
              <div class="form-group" style="grid-column: span 2;">
                <label for="image">Profile Picture <span class="required-indicator">*</span></label>
                <div class="file-input-wrapper">
                  <span class="file-input-label" id="fileLabel">
                    <i class="fas fa-upload"></i> Choose a file
                  </span>
                  <input 
                    type="file" 
                    id="image" 
                    name="userImage" 
                    class="form-control-file" 
                    required="required" 
                    accept="image/*"
                  >
                </div>
                <div class="file-name" id="fileName">No file chosen</div>
              </div>
            </div>
            
            <div class="form-footer">
              <a href="home.jsp" class="btn btn-outline">
                <i class="fas fa-times"></i> Cancel
              </a>
              <button type="submit" id="editButton" class="btn btn-primary">
                <i class="fas fa-save"></i> Save Changes
              </button>
            </div>
          </div>
        </form>
      </div>
      
      <footer class="footer">
        <p>&copy; <%= java.time.Year.now() %> Admin Dashboard. All rights reserved.</p>
      </footer>
    </div>

    <script>
      document.addEventListener('DOMContentLoaded', function() {
        // Set the gender value
        var gender = "<%=admin.getGender() %>";
        var genderSelect = document.getElementById("userGender");
        
        for(var i = 0; i < genderSelect.options.length; i++) {
          if(genderSelect.options[i].value === gender) {
            genderSelect.selectedIndex = i;
            break;
          }
        }
        
        // Display the file name when a file is selected
        document.getElementById('image').addEventListener('change', function(e) {
          var fileName = e.target.files[0] ? e.target.files[0].name : 'No file chosen';
          document.getElementById('fileName').textContent = fileName;
          document.getElementById('fileLabel').innerHTML = '<i class="fas fa-check"></i> File Selected';
        });
        
        // Quick profile image preview when selected through the camera icon
        document.getElementById('imageSelect').addEventListener('change', function(e) {
          if(e.target.files && e.target.files[0]) {
            var reader = new FileReader();
            
            reader.onload = function(e) {
              document.getElementById('profilePreview').src = e.target.result;
              
              // Also update the main file input
              var mainFileInput = document.getElementById('image');
              
              // Create a new DataTransfer object
              const dataTransfer = new DataTransfer();
              
              // Add the file to the DataTransfer object
              dataTransfer.items.add(document.getElementById('imageSelect').files[0]);
              
              // Set the main file input's files to the DataTransfer's files
              mainFileInput.files = dataTransfer.files;
              
              // Update the file name display
              var fileName = mainFileInput.files[0] ? mainFileInput.files[0].name : 'No file chosen';
              document.getElementById('fileName').textContent = fileName;
              document.getElementById('fileLabel').innerHTML = '<i class="fas fa-check"></i> File Selected';
            }
            
            reader.readAsDataURL(e.target.files[0]);
          }
        });
        
        // Form validation
        document.getElementById('profileForm').addEventListener('submit', function(event) {
          var inputs = this.querySelectorAll('input[required], select[required]');
          var valid = true;
          
          inputs.forEach(function(input) {
            if (!input.value.trim()) {
              input.style.borderColor = 'var(--error-color)';
              valid = false;
            } else {
              input.style.borderColor = 'var(--border-color)';
            }
          });
          
          if (!valid) {
            event.preventDefault();
            alert('Please fill in all required fields.');
          }
        });
      });
    </script>
  </body>
</html>