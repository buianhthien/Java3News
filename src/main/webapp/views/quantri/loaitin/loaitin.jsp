<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="f"%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/Assignment_BAT/css/form.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script>
    function confirmDelete() {
        return confirm("Bạn có chắc chắn muốn xóa loại tin này?");
    }
</script>
<h1>QUẢN LÝ LOẠI TIN</h1>
    <!-- Category List -->
    <section class="list-section">
      <h2>DANH SÁCH LOẠI TIN</h2>
      <button class="Them" style="float: right; margin-bottom: 10px;" ><a href="/Assignment_BAT/loaitin/create">Thêm mới</a></button>
      <table>
        <thead>
          <tr>
            <th>Mã loại tin</th>
            <th>Tên loại tin</th>
            <th>Hành động</th>
          </tr>
        </thead>
        <tbody id="categoryList">
          <!-- Sample row -->
          <c:forEach var="item" items="${categories}">
          <tr id="cat1">
            <td>${item.categoryID}</td>
            <td>${item.categoryName}</td>
            <td><button class="edit-btn"><a href="/Assignment_BAT/loaitin/update?id=${item.categoryID}">Sửa</a></button>
				<form action="/Assignment_BAT/loaitin/delete" method="post" onsubmit="return confirmDelete();">
					<input name="id" value="${item.categoryID}" type="hidden">
					<button class="delete-btn">Xóa</button>
				</form>
			</td>
          </tr>
          </c:forEach>
          <!-- More rows will be dynamically added here -->
        </tbody>
      </table>
    </section>

    <!-- <script>
      // Function to add a new category to the list
      document
        .getElementById("categoryForm")
        .addEventListener("submit", function (event) {
          event.preventDefault(); // Prevent form from submitting

          // Get form data
          const id = document.getElementById("id").value;
          const name = document.getElementById("name").value;

          // Create new row HTML
          const newRow = `
        <tr id="cat${id}">
          <td>${id}</td>
          <td>${name}</td>
          <td>
            <button class="edit-btn">Edit</button>
            <button class="delete-btn" onclick="deleteCategory('cat${id}')">Delete</button>
          </td>
        </tr>
      `;

          // Add the new row to the table
          document
            .getElementById("categoryList")
            .insertAdjacentHTML("beforeend", newRow);

          // Optionally, clear the form after adding
          this.reset();
        });

      // Function to delete a category
      function deleteCategory(categoryId) {
        const confirmDelete = confirm(
          "Are you sure you want to delete this category?"
        );
        if (confirmDelete) {
          const categoryRow = document.getElementById(categoryId);
          if (categoryRow) {
            categoryRow.remove();
          }
        }
      }
    </script> -->
</body>
</html>