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
    <style>
      body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
        min-height: 100vh;
      }

      .page-container {
        display: flex;
        flex-direction: column;
        min-height: 100vh;
      }

      .content-container {
        display: flex;
        justify-content: center;
        align-items: center;
        flex: 1;
        padding: 20px;
      }

      .profile-container {
        background-color: #fff;
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        max-width: 800px;
        width: 100%;
        box-sizing: border-box;
      }

      .profile-picture {
        text-align: center;
        margin-bottom: 20px;
      }

      .profile-picture img {
        width: 250px;
        height: 250px;
        border-radius: 50%;
        border: 2px solid #333;
        object-fit: cover;
      }

      .profile-details {
        margin-top: 20px;
      }

      .profile-details p {
        margin: 10px 0;
      }

      .edit-input {
        border: 1px solid #ccc;
        border-radius: 5px;
        padding: 10px;
        width: calc(100% - 22px);
        margin-bottom: 15px;
      }

      .edit-input:focus {
        outline: none;
        border-color: #007bff;
      }

      .edit-button {
        background-color: #007bff;
        color: #fff;
        border: none;
        padding: 12px 24px;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
        text-decoration: none;
        display: inline-block;
      }

      .edit-button:hover {
        background-color: #0056b3;
      }

      .change-profile-button {
        background-color: #28a745;
        color: #fff;
        border: none;
        padding: 8px 16px;
        border-radius: 5px;
        cursor: pointer;
        margin-bottom: 20px;
        font-size: 14px;
      }

      .change-profile-button:hover {
        background-color: #218838;
      }
      
      .file-input-container {
        margin-bottom: 15px;
      }
      
      .file-input-container label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
      }
    </style>
  </head>
  <body>
    <div class="page-container">
      <!-- Include Header -->
      <jsp:include page="/pages/header.jsp"></jsp:include>
      
      <div class="content-container">
        <form action="<%=contextPath%>/ModifyAdmin" method="post" enctype="multipart/form-data">
          <div class="profile-container">
            <div class="profile-picture">
              <img src="<%=contextPath%>/resources/images/users/<%=imageUrl%>" alt="Profile Picture" />
            </div>
            <div class="profile-details">
              <input type="text" id="fullName" name="userFullName" class="edit-input" value="<%=admin.getFullName() %>" required/>
              <input
                type="text"
                id="userAddress"
                class="edit-input"
                value="<%=admin.getAddress() %>"
                name="userAddress"
                required
              />
              <input
                type="text"
                id="userPhoneNumber"
                class="edit-input"
                value="<%=admin.getPhoneNumber() %>"
                name="userPhoneNumber"
                required
              />
              <input
                type="email"
                id="userEmail"
                class="edit-input"
                value="<%=admin.getEmail()%>"
                name="userEmail"
                required
              />
              <input
                type="date"
                id="userBirthDate"
                class="edit-input"
                value="1990-01-01"
                name="userBirthDate"
                required
              />
              
              <div class="file-input-container">
                <label for="image">Profile Picture</label>
                <input type="file" id="image" name="userImage" class="edit-input" required="required">
              </div>
              
              <select id="userGender" class="edit-input" name="userGender">
                <option value="Male" <%=admin.getGender().equals("Male") ? "selected" : "" %>>Male</option>
                <option value="Female" <%=admin.getGender().equals("Female") ? "selected" : "" %>>Female</option>
                <option value="Other" <%=admin.getGender().equals("Other") ? "selected" : "" %>>Other</option>
              </select>
              
              <button id="editButton" class="edit-button">Save Changes</button>
              <a style="margin-left:20px" class="edit-button" href="home.jsp">Back</a>
            </div>
          </div>
        </form>
      </div>
    </div>

    <script>
      // Set the selected gender value from the admin object
      document.addEventListener('DOMContentLoaded', function() {
        var gender = "<%=admin.getGender() %>";
        var genderSelect = document.getElementById("userGender");
        
        for(var i = 0; i < genderSelect.options.length; i++) {
          if(genderSelect.options[i].value === gender) {
            genderSelect.selectedIndex = i;
            break;
          }
        }
      });

     
    </script>
  </body>
</html>