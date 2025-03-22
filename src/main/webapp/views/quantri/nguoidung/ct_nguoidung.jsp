<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="f"%>
<!DOCTYPE html>
<link rel="stylesheet" type="text/css" href="/Assignment_BAT/css/form.css">
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>QUẢN LÝ NGƯỜI DÙNG</h1>

    
    <section class="form-section">
    <!-- CRUD Form -->
    <c:if test="${not empty errorMessage}">
    <div class="mess" style="color: red; text-align: center; padding: 10px; height: 30px">
        ${errorMessage}
    </div>
</c:if>
      <form action="/Assignment_BAT/nguoidung/create" id="userForm" method="post" > 
        <label for="id">Mã người dùng:</label>
        <input type="text" id="id" name="id"  />

        <label for="password">Mật khẩu:</label>
        <input type="password" id="password" name="password"  />

        <label for="fullname">Họ và tên:</label>
        <input type="text" id="fullname" name="fullname" />

        <label for="birthday">Ngày sinh:</label>
        <input type="date" id="birthday" name="birthday"  />

        <label for="gender">Giới tính:</label>
        <select id="gender" name="gender" >
          <option value="true">Nam</option>
          <option value="false">Nữ</option>
        </select>

        <label for="mobile">Số điện thoại:</label>
        <input type="text" id="mobile" name="mobile" />

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" />

        <label for="role">Vai trò:</label>
        <select id="role" name="role" >
          <option value="true">Quản trị</option>
          <option value="false">Phóng viên</option>
        </select>

        <button type="submit">Lưu</button>
      </form>
    </section>
</body>
</html>