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

%>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link
        href="https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,100;0,300;0,400;0,700;0,900;1,100;1,300;1,400;1,700;1,900&display=swap"
        rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="<%=contextPath%>/stylesheets/index.css">

    <title>E.Store</title>
     <style>
     /* Basic reset */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: Arial, sans-serif;
  padding: 20px; /* Add some padding around the grid */
}

.product-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); /* Responsive grid, each column min 200px wide */
  gap: 20px; /* Spacing between products */
  margin: 0 20px; /* Add margin to the left and right sides */
}

.product {
  border: 1px solid #ccc;
  border-radius: 10px;
  padding: 10px;
  text-align: center;
  overflow: hidden; /* Prevents content from overlapping */
  transition: all 0.5s ease; /* Extra smooth transition for hover effect */
}

.product img {
  width: auto;
  max-height: 150px; /* Limit the maximum height of the image */
  object-fit: contain; /* Ensure the whole image is displayed within its container */
  border-radius: 5px;
  transition: all 0.5s ease; /* Extra smooth transition for hover effect */
}

.product p {
  margin-top: 5px;
  font-size: 14px; /* Decrease font size for product name */
  font-weight: bold; /* Make product name bold */
}

.product p.price {
  font-weight: bold;
  margin: 5px 0;
  font-size: 12px; /* Decrease font size for price */
}

.product button {
  padding: 8px 16px;
  color: #fff;
  border: none;
  border-radius: 20px;
  cursor: pointer;
  transition: background-color 0.3s ease, color 0.3s ease; /* Smooth transition for hover effect */
}

.product .add-to-cart {
  background-color: #ff5c5c; /* Red color for add to cart button */
}

.product .see-details {
  background-color: #4CAF50; /* Green color for see details button */
}

.product button:hover {
  filter: brightness(90%);
}

.product:hover {
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); /* Add shadow effect on hover */
  transform: translateY(-5px); /* Move the product slightly up on hover */
}

.product:hover img {
  filter: brightness(80%); /* Decrease brightness of the image on hover */
}

.product button:hover {
  filter: brightness(110%);
}
    </style>
</head>

<body>
  <jsp:include page="/pages/header.jsp"></jsp:include>
    
    
       <div class="product-grid">
      <!-- Product items -->
      
      
       <c:if test="${empty filteredProducts}">
		<p>No Products found.</p>
		</c:if>
		<c:if test="${not empty filteredProducts}">
				
		<c:forEach var="product" items="${filteredProducts}">	
			
		<div class="product">
        <img src="resources/images/products/${product.imageUrlFromPart}" alt="Product 8 Image" />
        <p>${product.productName}</p>
        <p class="price">${product.price}</p>
        <form style="display:inline;" method="post"action="<%=contextPath%>/ProductDetail">
		<input type="hidden" name="productId" value="${product.productId}" />
		<button class="see-details">See Details</button>
		</form>
		<form style="display:inline;" action="<%
			if(currentUser==null){
					
				 out.print(contextPath+"/AddtoCart");
				
			}	
			
			else{
				
				out.print(contextPath+"/AddToCart");	
			}%>
			"
			
			  method="post"> 
		<input type="hidden" name="productId" value="${product.productId}" />
		<button class="add-to-cart">Add to Cart</button>
		</form>
        
        
      	</div>						
		</c:forEach>
		</c:if>
 
    </div>
    
   
    
    
    
	<jsp:include page="/pages/footer.jsp"></jsp:include>
   
</body>

</html>