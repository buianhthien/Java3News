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
    <title>Quản Lý Tin Tức</title>
</head>
<style>
.select {
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    width: 100%;
    height: auto;
}
.checkboxs {
    left: 0;
}
</style>
<body>
    <h1>QUẢN LÝ TIN TÚC</h1>

    <!-- CRUD Form -->
    <c:if test="${not empty error}">
        <div class = "mess" style="color: red;text-align: center; padding: 10px; height: 30px">
            ${error}
        </div>
    </c:if>
    <section class="form-section">
   <c:if test="${not empty errorMessage}">
    <div class="mess" style="color: red; text-align: center; padding: 10px; height: 30px">
        ${errorMessage}
    </div>
</c:if>
        <form action="/Assignment_BAT/tintuc/create" id="newsForm" method="post" enctype="multipart/form-data">
<!--             <label for="id">Mã tin:</label>
            <input type="text" id="id" name="id" readonly />
 -->
            <label for="title">Tiêu đề:</label>
            <input type="text" id="title" name="title" />

            <label for="content">Nội dung:</label>
            <textarea id="content" name="content" rows="5"></textarea>

            <label for="image">Hình/Video:</label>
            <input type="file" name="image"/>

<!--             <label for="postedDate">Ngày đăng:</label>
            <input type="date" id="postedDate" name="postedDate"  /> -->

<!--             <label for="author">Mã phóng viên:</label>
            <input type="text" id="author" name="author" /> -->

            <label for="viewCount">Lượt xem:</label>
            <input type="number" id="viewCount" name="viewCount" value="0" readonly="readonly" />

            <label for="categoryId">Loại tin:</label>
            <select class="select" id="categoryId" name="categoryId">
                <c:forEach var="category" items="${ds}">
                    <option value="${category.categoryID}">${category.categoryName}</option>
                </c:forEach>
            </select>

            <label for="home">Trang nhất:</label>
            <input class="checkboxs" type="checkbox" id="home" name="home" />

            <button type="submit">Lưu</button>
        </form>
    </section>
</body>
</html>
