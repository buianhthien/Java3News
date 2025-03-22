<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="f"%>
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
   .read-more .read-more-content a{
	margin-bottom: 10px;
    font-size: 18px;
    color: #555;
    text-decoration: none;
}
	.read-more-content:hover {
	background-color: #e4e6e8;
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
			<div class="header" style="border-bottom: 4px solid #e5e5e5;">
				<h1>${newtem.title}</h1>
				<span>${newtem.ltName.categoryName} | <fmt:formatDate value="${newtem.postDate}"
										pattern="dd/MM/yyyy HH:mm" /></span>
			</div>
			<div class="image-section">
				<img src="${pageContext.request.contextPath}${newtem.image}" alt="Hình ảnh của ${newtem.title}" />
			</div>

			<div class="content">
				<p>${newtem.content}</p>
			</div>
			<p class="tacgia">Lượt xem: ${newtem.viewCount}</p>
			<p class="tacgia">Tác giả: ${useMap[newtem.author]}</p>
			
			<!-- Tên tác giả -->
		</div>

		<div class="sidebar">
			<h2>XEM NHIỀU</h2>
			<ul>
			<c:forEach var = "item" items="${tintuc}" varStatus="status" >
				<li><span>${status.count}.</span> <a href="/Assignment_BAT/chitiet?id=${item.newsID}">${item.title}</a></li>
			</c:forEach>
			</ul>
			<div class="read-more">
				<h3>ĐỌC TIẾP</h3>
				
				<c:forEach var="item" items="${top5News}" varStatus="status">
				<c:if test="${item.newsID != newtem.newsID && status.index < 10}">
				<div class="read-more-content">
					<img
						src="${pageContext.request.contextPath}${item.image}"
						alt="${item.title}" />
					<a href="/Assignment_BAT/chitiet?id=${item.newsID}">${item.title}</a>
				</div>
				</c:if>
				</c:forEach>
			</div>
		</div>
	</div>

	<div class="comment">
		<h3>Bình luận</h3>
		<input type="text" name="comment" />
		<button>Gửi</button>
	</div>
</body>
</html>
