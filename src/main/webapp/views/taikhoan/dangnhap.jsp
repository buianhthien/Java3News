<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="f"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="/Assignment_BAT/css/dangnhap.css">
<link rel="stylesheet" type="text/css"
	href="/Assignment_BAT/css/trangcon.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script>
		function toggleMenu() {
			const menu = document.getElementById("menu");
			menu.classList.toggle("menu-open");
		}
	</script>
	<header>
		<div class="menu-icon" onclick="toggleMenu()">
			<span>&#9776;</span>
			<!-- Icon ba gạch -->
		</div>
		<div class="logo">
			<img src="/Assignment_BAT/images/bm-logo.png" alt="" />
		</div>
		<div class="social-icons">
			<a href="#">Facebook</a> <a href="#">Twitter</a>
		</div>
	</header>
	<hr />
	<div class="menu-container" id="menu">
		<div class="menu">
			<button class="close-btn" onclick="toggleMenu()">Đóng</button>
			<ul>
				<li><a href="${pageContext.request.contextPath}/nguoidung">Trang
						chủ</a></li>
				<%-- <c:forEach var="item" items="${loaiTinList}">
					<li
						class="<c:if test='${item.categoryID == currentCategoryID}'>active</c:if>"><a
						href="/Assignment_BAT/menu/loaitin?id=${item.categoryID}">${item.categoryName}</a>
					</li>
				</c:forEach> --%>
				<c:forEach var="item" items="${loaiTinList}">
    <li class="${item.categoryID == currentCategoryID ? 'active' : ''}">
        <a href="/Assignment_BAT/menu/loaitin?id=${item.categoryID}">${item.categoryName}</a>
    </li>
</c:forEach>
				<li><a href="#">Về chúng tôi</a></li>
			</ul>
		</div>
	</div>
	<div class="header-w3l">
		<h1>Login</h1>
	</div>
	<!--//header-->
	<!--main-->
	<!-- Hiển thị thông báo lỗi nếu có -->

	<div class="loginForm">
		<!--form-stars-here-->
		<c:if test="${not empty error}">
			<div class="mess"
				style="color: red; text-align: center; padding: 10px; height: 30px">
				${error}</div>
		</c:if>
		<div class="loginForm-item">
			<form action="/Assignment_BAT/dangnhap" method="post">
				<div class="login-element">
					<input id="username" type="text" name="Username"
						placeholder="Tên đăng nhập " />
				</div>
				<div class="login-element">
					<input id="password" type="password" name="Password"
						placeholder="Mật khẩu" />
				</div>
				<input id="submit" type="submit" class="login" value="Đăng nhập" />
			</form>
		</div>
	</div>
</body>
</html>