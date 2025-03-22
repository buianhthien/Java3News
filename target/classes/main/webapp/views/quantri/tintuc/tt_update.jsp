<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="f"%>

<html>
<head>
<link rel="stylesheet" type="text/css"
	href="/Assignment_BAT/css/form.css">
<meta charset="UTF-8">
<title>Quản Lý Tin Tức</title>
</head>
<body>
	<h1>QUẢN LÝ TIN TỨC</h1>
	<section class="form-section">
	<c:if test="${not empty errorMessage}">
    <div class="mess" style="color: red; text-align: center; padding: 10px; height: 30px">
        ${errorMessage}
    </div>
</c:if>
		<form action="/Assignment_BAT/tintuc/update/${news.newsID}" id="newsForm"
			method="post" enctype="multipart/form-data">

			<input type="hidden" name="id" value="${news.newsID}" />
			 <label for="title">Tiêu đề:</label> <input type="text" id="title"
				name="title" value="${news.title}" /> <label for="content">Nội
				dung:</label>
			<textarea id="content" name="content" rows="5">${news.content}</textarea>
			
			<label for="image">Hình/Video:</label>
			<div style= "height: 55px; width: 100%; margin-right: 22px;">
			<!-- Input để người dùng có thể chọn hình ảnh mới -->
		    <input type="file" name="image" />
			<!-- Hiển thị file hiện tại dưới dạng text -->
		    <c:if test="${not empty news.image}">
		        <p style = "font-size: 12px; margin-top: 5px" >File hiện tại: ${news.image}</p>
		        <!-- Lưu đường dẫn của hình hiện tại vào input hidden -->
		        <input type="hidden" name="currentImage" value="${news.image}" />
		    </c:if>    
			</div>

<%-- 			<label for="postedDate">Ngày
				đăng:</label> <input type="date" id="postedDate" name="postedDate"
				value="${news.postDate}"/>	 --%>																															
 

			<label for="author">Mã phóng viên:</label> <input type="text"
				id="author" name="author" value="${news.author}" readonly="readonly" /> <label
				for="viewCount">Lượt xem:</label> <input type="number"
				id="viewCount" name="viewCount" value="${news.viewCount}" readonly="readonly" /> <label
				for="categoryId">Mã loại tin:</label> <select id="categoryId"
				name="categoryId" style = "width: 100%; ">
				<c:forEach var="category" items="${ds}">
					<option value="${category.categoryID}"
						${category.categoryID == news.categoryID ? 'selected' : ''}>
						${category.categoryName}</option>
				</c:forEach>
			</select> <label for="home">Trang nhất:</label> <input type="checkbox"
				id="home" name="home" ${news.home ? 'checked' : ''} />


			<button type="submit">Lưu</button>
		</form>
	</section>
</body>
</html>
