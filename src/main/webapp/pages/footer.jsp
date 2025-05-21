<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%
String contextPath = (String)request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
  <link href="https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,100;0,300;0,400;0,700;0,900;1,100;1,300;1,400;1,700;1,900&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Lato', sans-serif;
    }

    footer {
      background: linear-gradient(to right, #1a3a63, #2c5282);
      color: white;
      padding: 40px 20px;
    }

    .footerLeft {
      display: flex;
      flex-wrap: wrap;
      justify-content: space-between;
      margin-bottom: 30px;
    }

    .footerMenu {
      margin-right: 30px;
      margin-bottom: 20px;
    }

    .fMenuTitle {
      font-size: 18px;
      margin-bottom: 15px;
      color: #90cdf4;
      font-weight: 700;
    }

    .fList {
      list-style: none;
    }

    .fListItem {
      margin-bottom: 8px;
      cursor: pointer;
      transition: all 0.3s ease;
    }

    .fListItem:hover {
      color: #90cdf4;
      transform: translateX(5px);
    }

    .footerRight {
      padding-top: 20px;
      border-top: 1px solid rgba(255, 255, 255, 0.2);
    }

    .footerRightMenu {
      margin-bottom: 20px;
    }

    .fMail {
      display: flex;
      margin-top: 10px;
    }

    .fInput {
      padding: 10px;
      border: none;
      border-radius: 4px 0 0 4px;
      outline: none;
      width: 200px;
    }

    .fButton {
      padding: 10px 15px;
      background-color: #90cdf4;
      color: #1a3a63;
      font-weight: bold;
      border: none;
      border-radius: 0 4px 4px 0;
      cursor: pointer;
      transition: all 0.3s ease;
    }

    .fButton:hover {
      background-color: #63b3ed;
    }

    .fIcons {
      display: flex;
      gap: 15px;
      margin-top: 10px;
    }

    .fIcon {
      width: 30px;
      height: 30px;
      filter: brightness(0) invert(1);
      transition: all 0.3s ease;
    }

    .fIcon:hover {
      transform: scale(1.1);
      filter: invert(80%) sepia(30%) saturate(500%) hue-rotate(180deg) brightness(100%) contrast(95%);
    }

    .copyright {
      font-size: 14px;
      color: #ccc;
    }

    @media only screen and (min-width: 768px) {
      footer {
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
      }

      .footerLeft {
        width: 60%;
        border-right: 1px solid rgba(255, 255, 255, 0.2);
        padding-right: 30px;
        margin-bottom: 0;
      }

      .footerRight {
        width: 35%;
        padding-top: 0;
        border-top: none;
      }
    }
  </style>
</head>

<body>
  <footer>
    <div class="footerLeft">
      <div class="footerMenu">
        <h1 class="fMenuTitle">About Us</h1>
        <ul class="fList">
          <li class="fListItem">Company</li>
          <li class="fListItem">Contact</li>
          <li class="fListItem">Careers</li>
          <li class="fListItem">Affiliates</li>
          <li class="fListItem">Stores</li>
        </ul>
      </div>
      <div class="footerMenu">
        <h1 class="fMenuTitle">Useful Links</h1>
        <ul class="fList">
          <li class="fListItem">Support</li>
          <li class="fListItem">Refund</li>
          <li class="fListItem">FAQ</li>
          <li class="fListItem">Feedback</li>
          <li class="fListItem">Stories</li>
        </ul>
      </div>
      <div class="footerMenu">
        <h1 class="fMenuTitle">Products</h1>
        <ul class="fList">
          <li class="fListItem">Laptops</li>
          <li class="fListItem">Phones</li>
          <li class="fListItem">Accessories</li>
          <li class="fListItem">Refrigerators</li>
          <li class="fListItem">Vacuum Cleaners</li>
        </ul>
      </div>
    </div>
    <div class="footerRight">
      <div class="footerRightMenu">
        <h1 class="fMenuTitle">Subscribe to our newsletter</h1>
        <div class="fMail">
          <input type="text" placeholder="your@email.com" class="fInput">
          <button class="fButton">Join!</button>
        </div>
      </div>
      <div class="footerRightMenu">
        <h1 class="fMenuTitle">Follow Us</h1>
        <div class="fIcons">
          <img src="<%=contextPath%>/resources/images/image24.png" alt="" class="fIcon">
          <img src="<%=contextPath%>/resources/images/image25.png" alt="" class="fIcon">
          <img src="<%=contextPath%>/resources/images/image26.png" alt="" class="fIcon">
          <img src="<%=contextPath%>/resources/images/image27.png" alt="" class="fIcon">
        </div>
      </div>
      <div class="footerRightMenu">
        <span class="copyright">@SmartTech. All rights reserved. 2024.</span>
      </div>
    </div>
  </footer>
</body>
</html>