<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="f"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="/Assignment_BAT/css/trangcon.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
@charset "UTF-8";

body {
	background: url(/Assignment_BAT/images/bann.jpg) no-repeat 0px 12px;
}

h1.tieuDe {
	font-size: 30px;
	color: #fff;
	padding: 40px 0;
	text-align: center;
	/*-- w3layouts --*/
	text-transform: uppercase;
}

.signUpForm {
	background-color: #202123;
	width: 40%;
	margin: 0 auto 50px;
	padding: 0;
}

.signUpForm .SignUpForm-item {
	width: 100%;
	height: 250px;
	padding: 50px 0 0;
	background-color: #202123;
	justify-content: space-between;
}

input#email {
	width: 300px;
	height: 50px;
	padding: 0 15px;
	color: #fff;
	font-size: 17px;
	font-weight: 200;
	background-color: transparent;
	/*-- w3layouts --*/
	border-bottom: 5px solid #fff;
	border-top-color: transparent;
	border-left-color: transparent;
	border-right-color: transparent;
	font-family: "Raleway", sans-serif;
	margin: 0 auto 20px;
	display: block;
	outline: none;
}

input#email:focus, input#email:hover {
	color: #fff;
	border-bottom: 5px solid #2fa1b3;
}

input::-webkit-input-placeholder {
	color: rgba(255, 255, 255, 0.5) !important;
}

input:-moz-placeholder {
	/* Firefox 18- */
	color: rgba(255, 255, 255, 0.5) !important;
}

input::-moz-placeholder {
	/* Firefox 19+ */
	color: rgba(255, 255, 255, 0.5) !important;
}

input:-ms-input-placeholder {
	color: rgba(255, 255, 255, 0.5) !important;
}

input:hover::-webkit-input-placeholder {
	color: #2fa1b3 !important;
}

input:hover:-moz-placeholder {
	/* Firefox 18- */
	color: #2fa1b3 !important;
}

input:hover::-moz-placeholder {
	/* Firefox 19+ */
	color: #2fa1b3 !important;
}

input:hover:-ms-input-placeholder {
	color: #2fa1b3 !important;
}

input.register {
	width: 335px;
	margin: 30px auto;
	display: block;
	height: 50px;
	text-align: center;
	font-size: 17px;
	font-weight: normal;
	color: #fff;
	background-color: #2fa1b3;
	border-color: transparent;
	font-family: "Raleway", sans-serif;
}

.register:hover {
	background-color: white;
	color: black;
}
</style>
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
				<li
					class="<c:if test='${item.categoryID == currentCategoryID}'>active</c:if>"><a
					href="${pageContext.request.contextPath}/nguoidung">Trang chủ</a></li>
				<c:forEach var="item" items="${loaiTinList}">
					<li><a
						href="/Assignment_BAT/menu/loaitin?id=${item.categoryID}">${item.categoryName}</a>
					</li>
				</c:forEach>
				<li><a href="#">Về chúng tôi</a></li>
			</ul>
		</div>
	</div>
	<h1 class="tieuDe">Đăng ký nhận thông báo</h1>
	<div class="signUpForm">
	<c:if test="${not empty message}">
    <div class="mess"
         style="color: ${messageType == 'success' ? 'green' : 'red'};
                text-align: center;
                padding: 10px;
                height: 30px">
        ${message}
    </div>
</c:if><c:if test="${not empty errorMessage}">
			<div class="mess"
				style="color: red; text-align: center; padding: 10px; height: 30px">
				${errorMessage}</div>
		</c:if>
		<div class="SignUpForm-item">
			<form action="/Assignment_BAT/dangky" method="post">
				<div class="form-element">
					<input id="email" name="email"
						placeholder="mail@example.com" />
				</div>
				<input id="submit" type="submit" class="register" value="Đăng ký" />
			</form>
		</div>
		<div class="clear"></div>
	</div>
</body>
</html>