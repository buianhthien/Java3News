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
<h1>QUẢN LÝ LOẠI TIN</h1>

    <!-- CRUD Form -->
    <c:if test="${not empty errorMessage}">
    <div class="mess" style="color: red; text-align: center; padding: 10px; height: 30px">
        ${errorMessage}
    </div>
</c:if>
    <section class="form-section">
      <form action="/Assignment_BAT/loaitin/create" id="categoryForm1" method="post" accept-charset="UTF-8"> 
<!--       <label for="id">Mã loại tin:</label>
        <input type="text" id="id" name="id" readonly />  -->
        <label for="name">Tên loại tin:</label>
        <input type="text" id="name" name="name"  />

        <button type="submit">Lưu</button>
      </form>
    </section>
</body>
</html>