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

    <!-- CRUD Form -->
   
    <section class="form-section">
    <c:if test="${not empty errorMessage}">
    <div class="mess" style="color: red; text-align: center; padding: 10px; height: 30px">
        ${errorMessage}
    </div>
</c:if>
      <form action="/Assignment_BAT/nguoidung/update/${nguoidung.userID}" id="userForm" method="post" > 
        <label for="id">Mã người dùng:</label>
        <input type="text" id="id" name="id" value="${nguoidung.userID}" />

        <label for="password">Mật khẩu:</label>
        <input type="password" id="password" name="password" value="${nguoidung.password}" />

        <label for="fullname">Họ và tên:</label>
        <input type="text" id="fullname" name="fullname" value="${nguoidung.fullName}"  />

        <label for="birthday">Ngày sinh:</label>
        <input type="date" id="birthday" name="birthday" value="${nguoidung.birthday}"  />

        <label for="gender">Giới tính:</label>
        <select id="gender" name="gender"  >
          <option value="true" ${nguoidung.gender == true ? 'selected' : ''}>Nam</option>
          <option value="false"${nguoidung.gender == false ? 'selected' : ''}>Nữ</option>
        </select>

        <label for="mobile">Số điện thoại:</label>
        <input type="text" id="mobile" name="mobile" value="${nguoidung.mobile}" />

        <label for="email">Email:</label>
        <input  id="email" name="email" value="${nguoidung.email}" />

        <label for="role">Vai trò:</label>
        <select id="role" name="role" >
          <option value="true" ${nguoidung.role == true ? 'selected' : ''}>Quản trị</option>
          <option value="false" ${nguoidung.role == false ? 'selected' : ''}>Phóng viên</option>
        </select>

        <button type="submit">Lưu</button>
      </form>
    </section>
</body>
</html>