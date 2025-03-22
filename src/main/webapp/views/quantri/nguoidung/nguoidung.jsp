<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="f"%>
 
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" type="text/css" href="/Assignment_BAT/css/form.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<script>
    function confirmDelete() {
        return confirm("Bạn có chắc chắn muốn xóa người dùng này?");
    }
    
    setTimeout(function() {
        let alertBox = document.getElementById("alertMessage");
        if (alertBox) {
            alertBox.style.transition = "opacity 0.5s ease";
            alertBox.style.opacity = "0"; 

            setTimeout(() => {
                alertBox.style.display = "none";
            }, 500); // Ẩn hoàn toàn sau khi mờ dần
        }
    }, 3000); // Ẩn sau 3 giây
</script>
<h1>QUẢN LÝ NGƯỜI DÙNG</h1>
  <section class="list-section">
    <h2>DANH SÁCH NGƯỜI DÙNG</h2>
        <c:if test="${not empty message}">
    <div id="alertMessage" class="mess" style="color: green; text-align: center; padding: 10px; height: 30px">
        ${message}
    </div>
</c:if>
     <button class="Them" style="float: right; margin-bottom: 10px;" ><a href="/Assignment_BAT/nguoidung/create">Thêm mới</a></button>
    <table>
      <thead>
        <tr>
          <th>Mã đăng nhập</th>
          <th>Mật khẩu</th>
          <th>Họ và tên</th>
          <th>Ngày sinh</th>
          <th>Giới tính</th>
          <th>Số điện thoại</th>
          <th>Email</th>
          <th>Vai trò</th>
          <th>Hành động</th>
        </tr>
      </thead>
      <tbody id="userList">
      <c:forEach var="item" items="${users}">
        <tr id="user1">
			<td>${item.userID}</td>
			<td>${item.password}</td>
			<td>${item.fullName}</td>
			<td>${item.birthday}</td>
			<td>${item.gender?"Nam":"Nữ"}</td>
			<td>${item.mobile}</td>
			<td>${item.email}</td>
			<td>${item.role?"Quản lý":"Phóng viên" }</td>
			<td><button class="edit-btn"><a href="/Assignment_BAT/nguoidung/update?id=${item.userID}">Sửa</a></button>
				<form action="/Assignment_BAT/nguoidung/delete" method="post" onsubmit="return confirmDelete();">
					<input name="id" value="${item.userID}" type="hidden">
					<button class="delete-btn">Xóa</button>
				</form>
			</td>
          <!-- <td>
            <button  <a href="chitietnguoidung.html">Chỉnh sửa</a></button>
            <button  >Xóa</button>
          </td> -->
        </tr>
        </c:forEach>
        
      </tbody>
    </table>
  </section>

  <!-- <script>
    // Function to add a new user item to the list
    document.getElementById('userForm').addEventListener('submit', function(event) {
      event.preventDefault(); // Prevent form from submitting

      // Get form data
      const id = document.getElementById('id').value;
      const fullname = document.getElementById('fullname').value;
      const birthday = document.getElementById('birthday').value;
      const gender = document.getElementById('gender').value === 'true' ? 'Male' : 'Female';
      const mobile = document.getElementById('mobile').value;
      const email = document.getElementById('email').value;
      const role = document.getElementById('role').value === 'true' ? 'Administrator' : 'Journalist';

      // Create new row HTML
      const newRow = `
        <tr id="user${id}">
          <td>${id}</td>
          <td>${fullname}</td>
          <td>${birthday}</td>
          <td>${gender}</td>
          <td>${mobile}</td>
          <td>${email}</td>
          <td>${role}</td>
          <td>
            <button class="edit-btn">Edit</button>
            <button class="delete-btn" onclick="deleteUser('user${id}')">Delete</button>
          </td>
        </tr>
      `;

      // Add the new row to the table
      document.getElementById('userList').insertAdjacentHTML('beforeend', newRow);

      // Optionally, clear the form after adding
      this.reset();
    });

    // Function to delete a user item
    function deleteUser(userId) {
      const confirmDelete = confirm("Are you sure you want to delete this user?");
      if (confirmDelete) {
        const userRow = document.getElementById(userId);
        if (userRow) {
          userRow.remove();
        }
      }
    }
  </script> -->
</body>
</body>
</html>