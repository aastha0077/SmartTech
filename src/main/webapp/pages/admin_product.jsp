<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="Model.Product"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String contextPath = (String) request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Product Details</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
  :root {
    --primary-color: #4361ee;
    --secondary-color: #3f37c9;
    --accent-color: #4895ef;
    --danger-color: #e63946;
    --warning-color: #ffb703;
    --success-color: #06d6a0;
    --text-color: #2b2d42;
    --light-text: #8d99ae;
    --background-color: #f8f9fa;
    --card-color: #ffffff;
    --border-color: #e0e0e0;
    --hover-color: #f1f5f9;
  }

  * {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
  }

  body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: var(--background-color);
    color: var(--text-color);
    line-height: 1.6;
    padding: 20px;
  }

  .container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
    background-color: var(--card-color);
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  }

  .header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
    border-bottom: 2px solid var(--border-color);
    padding-bottom: 15px;
  }

  h1 {
    color: var(--primary-color);
    font-size: 28px;
    font-weight: 600;
  }

  .table-responsive {
    overflow-x: auto;
    margin-bottom: 20px;
  }

  table {
    width: 100%;
    border-collapse: collapse;
    margin: 20px 0;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
  }

  th, td {
    padding: 15px;
    text-align: left;
    border-bottom: 1px solid var(--border-color);
  }

  th {
    background-color: var(--primary-color);
    color: white;
    font-weight: 500;
    text-transform: uppercase;
    font-size: 14px;
    letter-spacing: 0.5px;
  }

  tr:nth-child(even) {
    background-color: rgba(0, 0, 0, 0.02);
  }

  tr:hover {
    background-color: var(--hover-color);
  }

  img {
    max-width: 50px;
    max-height: 50px;
    border-radius: 4px;
  }

  .btn {
    padding: 8px 16px;
    color: white;
    border: none;
    cursor: pointer;
    border-radius: 5px;
    transition: all 0.3s ease;
    margin: 2px;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    font-size: 14px;
    font-weight: 500;
  }

  .btn i {
    margin-right: 5px;
  }

  .btn-delete {
    background-color: var(--danger-color);
  }

  .btn-delete:hover {
    background-color: #c1121f;
  }

  .btn-edit {
    background-color: var(--accent-color);
  }

  .btn-edit:hover {
    background-color: #2c7da0;
  }

  .btn-save {
    background-color: var(--success-color);
  }

  .btn-save:hover {
    background-color: #05a57a;
  }

  .btn-cancel {
    background-color: var(--warning-color);
  }

  .btn-cancel:hover {
    background-color: #e9c46a;
  }

  .action-cell {
    display: flex;
    gap: 5px;
  }

  input[type="text"], input[type="number"] {
    padding: 10px;
    width: 100%;
    border: 1px solid var(--border-color);
    border-radius: 4px;
    font-size: 14px;
    transition: border-color 0.3s;
  }

  input[type="text"]:focus, input[type="number"]:focus {
    border-color: var(--primary-color);
    outline: none;
    box-shadow: 0 0 0 2px rgba(67, 97, 238, 0.2);
  }

  .badge {
    display: inline-block;
    padding: 4px 8px;
    border-radius: 12px;
    font-size: 12px;
    font-weight: bold;
    background-color: var(--accent-color);
    color: white;
  }

  .empty-message {
    text-align: center;
    padding: 20px;
    color: var(--light-text);
    font-style: italic;
  }

  /* Modal styles */
  .modal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
  }

  .modal-content {
    background-color: var(--card-color);
    margin: 15% auto;
    padding: 20px;
    border-radius: 8px;
    width: 80%;
    max-width: 500px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
  }

  .modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    padding-bottom: 10px;
    border-bottom: 1px solid var(--border-color);
  }

  .modal-title {
    font-size: 20px;
    font-weight: 600;
    color: var(--text-color);
  }

  .modal-body {
    margin-bottom: 20px;
  }

  .modal-footer {
    display: flex;
    justify-content: flex-end;
    gap: 10px;
  }

  .close {
    color: var(--light-text);
    font-size: 24px;
    font-weight: bold;
    cursor: pointer;
  }

  .close:hover {
    color: var(--text-color);
  }

  @media (max-width: 768px) {
    .btn {
      padding: 6px 10px;
      font-size: 12px;
    }
    
    th, td {
      padding: 10px;
    }

    .header {
      flex-direction: column;
      gap: 10px;
      align-items: flex-start;
    }

    .modal-content {
      width: 90%;
      margin: 20% auto;
    }
  }
</style>
</head>
<body>

<div class="container">
  <div class="header">
    <h1>Product Inventory</h1>
  </div>

  <div class="table-responsive">
    <table id="productTable">
      <thead>
        <tr>
          <th>ID</th>
          <th>Product Name</th>
          <th>Price</th>
          <th>Category</th>
          <th>Quantity</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody> 
        <c:if test="${not empty productList}">		
          <c:forEach var="product" items="${productList}">
            <tr id="row-${product.productId}">
              <td>${product.productId}</td>
              <td class="product-name">${product.productName}</td>
              <td class="product-price">${product.price}</td>
              <td class="product-category">${product.categoryId}</td>
              <td class="product-quantity">${product.quantity}</td>
              <td class="action-cell">
                <button class="btn btn-edit" onclick="enableEdit(${product.productId})">
                  <i class="fas fa-edit"></i> Edit
                </button>
                <button class="btn btn-delete" onclick="confirmDelete(${product.productId}, '${product.productName}')">
                  <i class="fas fa-trash-alt"></i> Delete
                </button>
              </td>
            </tr>
          </c:forEach>	
        </c:if>
        <c:if test="${empty productList}">
          <tr>
            <td colspan="6" class="empty-message">No products available</td>
          </tr>
        </c:if>
      </tbody>
    </table>
  </div>
</div>

<!-- Delete Confirmation Modal -->
<div id="deleteModal" class="modal">
  <div class="modal-content">
    <div class="modal-header">
      <span class="modal-title">Confirm Delete</span>
      <span class="close" onclick="closeModal()">&times;</span>
    </div>
    <div class="modal-body">
      <p>Are you sure you want to delete the product "<span id="productNameToDelete"></span>"?</p>
      <p>This action cannot be undone.</p>
    </div>
    <div class="modal-footer">
      <button class="btn btn-cancel" onclick="closeModal()">Cancel</button>
      <form id="deleteForm" method="post" action="<%=contextPath%>/DeleteProduct">
        <input type="hidden" name="productId" id="productIdToDelete">
        <button type="submit" class="btn btn-delete">Delete</button>
      </form>
    </div>
  </div>
</div>

<script>
function enableEdit(productId) {
  const row = document.getElementById(`row-${productId}`);
  
  // Get current values
  const name = row.querySelector('.product-name').textContent;
  const price = row.querySelector('.product-price').textContent;
  const category = row.querySelector('.product-category').textContent;
  const quantity = row.querySelector('.product-quantity').textContent;
  
  // Replace text with input fields
  row.querySelector('.product-name').innerHTML = `<input type="text" id="name-${productId}" value="${name}">`;
  row.querySelector('.product-price').innerHTML = `<input type="number" id="price-${productId}" value="${price}">`;
  row.querySelector('.product-category').innerHTML = `<input type="number" id="category-${productId}" value="${category}">`;
  row.querySelector('.product-quantity').innerHTML = `<input type="number" id="quantity-${productId}" value="${quantity}">`;
  
  // Replace Edit button with Save and Cancel
  const actionCell = row.querySelector('td:last-child');
  actionCell.innerHTML = `
    <button class="btn btn-save" onclick="saveChanges(${productId})">
      <i class="fas fa-save"></i> Save
    </button>
    <button class="btn btn-cancel" onclick="cancelEdit(${productId}, '${name}', ${price}, ${category}, ${quantity})">
      <i class="fas fa-times"></i> Cancel
    </button>
    <button class="btn btn-delete" onclick="confirmDelete(${productId}, '${name}')">
      <i class="fas fa-trash-alt"></i> Delete
    </button>
  `;
}

function cancelEdit(productId, name, price, category, quantity) {
  const row = document.getElementById(`row-${productId}`);
  
  // Restore original values
  row.querySelector('.product-name').textContent = name;
  row.querySelector('.product-price').textContent = price;
  row.querySelector('.product-category').textContent = category;
  row.querySelector('.product-quantity').textContent = quantity;
  
  // Restore original buttons
  const actionCell = row.querySelector('td:last-child');
  actionCell.innerHTML = `
    <button class="btn btn-edit" onclick="enableEdit(${productId})">
      <i class="fas fa-edit"></i> Edit
    </button>
    <button class="btn btn-delete" onclick="confirmDelete(${productId}, '${name}')">
      <i class="fas fa-trash-alt"></i> Delete
    </button>
  `;
}

function saveChanges(productId) {
  const name = document.getElementById(`name-${productId}`).value;
  const price = document.getElementById(`price-${productId}`).value;
  const category = document.getElementById(`category-${productId}`).value;
  const quantity = document.getElementById(`quantity-${productId}`).value;
  
  // Create form dynamically
  const form = document.createElement('form');
  form.method = 'post';
  form.action = '<%=contextPath%>/UpdateProduct';
  
  // Add hidden inputs
  function addInput(name, value) {
    const input = document.createElement('input');
    input.type = 'hidden';
    input.name = name;
    input.value = value;
    form.appendChild(input);
  }
  
  addInput('productId', productId);
  addInput('productName', name);
  addInput('productPrice', price);
  addInput('categoryId', category);
  addInput('productQuantity', quantity);
  
  // Submit form
  document.body.appendChild(form);
  form.submit();
}

// Delete confirmation functions
let deleteModal = document.getElementById('deleteModal');

function confirmDelete(productId, productName) {
  document.getElementById('productNameToDelete').textContent = productName;
  document.getElementById('productIdToDelete').value = productId;
  deleteModal.style.display = 'block';
}

function closeModal() {
  deleteModal.style.display = 'none';
}

// Close modal when clicking outside of it
window.onclick = function(event) {
  if (event.target == deleteModal) {
    closeModal();
  }
}
</script>

</body>
</html>