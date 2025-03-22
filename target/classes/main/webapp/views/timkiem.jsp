<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/trangcon.css">
<meta charset="UTF-8">
<title>${newtem.title}</title>
<!-- Tiêu đề trang sẽ lấy từ tiêu đề bài viết -->
<script>
	function toggleMenu() {
		const menu = document.getElementById("menu");
		menu.classList.toggle("menu-open");
	}
</script>
</head>
<style>
.sidebar ul li a {
	margin-bottom: 10px;
	font-size: 18px;
	color: #555;
	text-decoration: none;
}

.read-more .read-more-content a {
	margin-bottom: 10px;
	font-size: 18px;
	color: #555;
	text-decoration: none;
}

.read-more-content:hover {
	background-color: #e4e6e8;
}

.search-container {
	align-items: center; /* Căn giữa ô tìm kiếm */
	width: 100%; /* Chiều rộng của ô tìm kiếm */
	position: relative; /* Để nút tìm kiếm có thể nằm bên trong */
	margin-bottom: 50px;
}

.search-container input {
	width: 100%;
	padding: 10px; /* Thêm padding cho input */
	border: 1px solid #ccc; /* Biên cho input */
	border-radius: 5px; /* Bo góc cho input */
	margin-right: -30px;
	padding: 10px; /* Đẩy input vào trong để tạo khoảng cách với nút */
}

.search-container button {
	position: absolute; /* Đặt nút tìm kiếm ở vị trí tuyệt đối */
	right: 10px; /* Khoảng cách từ bên phải */
	top: 35%; /* Đặt ở giữa theo chiều dọc */
	transform: translateY(-50%); /* Căn giữa nút */
	border: none; /* Bỏ border cho button */
	background-color: transparent; /* Nền trong suốt */
	cursor: pointer; /* Đổi con trỏ khi hover */
	height: 20px;
}

.content-news {
	width: 100%;
	display: flex;
	gap: 20px;
	margin-top: 30px;
}

.content-news a {
	font-size: 22px;
	font-weight: bold;
	margin-top: 10px;
	text-decoration: none;
	color: black;
}

.content-news img {
	width: 20%;
	height: 150px;
}
</style>
<body>
	<header>
		<div class="menu-icon" onclick="toggleMenu()">
			<span>&#9776;</span>
		</div>
		<div class="logo">
			<img src="${pageContext.request.contextPath}/images/bm-logo.png"
				alt="Logo" />
		</div>
		<div class="social-icons">
			<a href="#">Facebook</a> <a href="#">Google</a>
		</div>
	</header>
	<hr />

	<div class="menu-container" id="menu">
		<div class="menu">
			<button class="close-btn" onclick="toggleMenu()">Đóng</button>
			<ul>
				<li><a href="${pageContext.request.contextPath}/nguoidung">Trang
						chủ</a></li>
				<c:forEach var="item" items="${loaiTinList}">
					<li><a
						href="/Assignment_BAT/menu/loaitin?id=${item.categoryID}">${item.categoryName}</a>
					</li>
				</c:forEach>
				<li><a href="#">Về chúng tôi</a></li>
			</ul>
		</div>
	</div>

	<div class="container">

		<div class="main-content">
			<div class="search-container">
				<form action="/Assignment_BAT/seach" method="get">
					<!-- Thêm thẻ form -->
					<input type="text" name="keyword"
						placeholder="Nhập nội dung tìm kiếm" />
					<button type="submit">
						<img src="/Assignment_BAT/images/seacd.jpg" alt="Tìm kiếm" />
					</button>
				</form>
			</div>

			<h1>Kết quả tìm kiếm</h1>
			<c:if test="${not empty error}">
				<p style="color: red;">${error}</p>
			</c:if>

			<c:if test="${not empty results}">
				<c:forEach var="tin" items="${results}">
					<div class="content-news">
						<img alt="Hình"
							src="${pageContext.request.contextPath}${tin.image}">
						<div>
							<a href="/Assignment_BAT/chitiet?id=${tin.newsID}">${tin.title}</a><br>
							<span><fmt:formatDate value="${tin.postDate}"
									pattern="dd/MM/yyyy HH:mm" /></span>
							<p>${fn:substring(tin.content,0,300)}...</p>
						</div>
					</div>
				</c:forEach>
			</c:if>
		</div>
		<div class="sidebar">
			<h2>XEM NHIỀU</h2>
			<ul>
				<c:forEach var="item" items="${tintuc}" varStatus="status">
					<li><span>${status.count}.</span> <a
						href="/Assignment_BAT/chitiet?id=${item.newsID}">${item.title}</a></li>
				</c:forEach>
			</ul>
			<div class="read-more">
				<h3>ĐỌC TIẾP</h3>

				<c:forEach var="item" items="${news}" varStatus="status">
					<c:if test="${item.newsID != newtem.newsID && status.index < 10}">
						<div class="read-more-content">
							<img src="${pageContext.request.contextPath}${item.image}"
								alt="${item.title}" /> <a
								href="/Assignment_BAT/chitiet?id=${item.newsID}">${item.title}</a>
						</div>
					</c:if>
				</c:forEach>
			</div>
		</div>
	</div>

	<jsp:include page="layouts/footer.jsp"></jsp:include> 
</body>
</html>
