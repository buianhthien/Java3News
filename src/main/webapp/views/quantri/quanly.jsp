<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
	
	

<!DOCTYPE html>

<html>
<head>
<link rel="stylesheet" type="text/css"
	href="/Assignment_BAT/css/quanly.css" />
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- Slideshow container -->
	<div class="slideshow-container">
		<!-- Full-width images with number and caption text -->
		<div class="mySlides fade">
			<img
				src="/Assignment_BAT/images/Screenshot 2024-10-12 094925.png"
				style="width: 100%" />
		</div>

		<div class="mySlides fade">
			<img
				src="/Assignment_BAT/images/Screenshot 2024-10-12 095002.png"
				style="width: 100%" />
		</div>

		<div class="mySlides fade">
			<img
				src="/Assignment_BAT/images/Screenshot 2024-10-12 094925.png"
				style="width: 100%" />
		</div>

		<!-- Next and previous buttons -->
		<a class="prev" onclick="plusSlides(-1)">&#10094;</a> <a class="next"
			onclick="plusSlides(1)">&#10095;</a>
	</div>
	<br />

	<script>
		let slideIndex = 1;
		showSlides(slideIndex);

		// Next/previous controls
		function plusSlides(n) {
			showSlides((slideIndex += n));
		}

		// Thumbnail image controls
		function currentSlide(n) {
			showSlides((slideIndex = n));
		}

		function showSlides(n) {
			let i;
			let slides = document.getElementsByClassName("mySlides");
			let dots = document.getElementsByClassName("dot");
			if (n > slides.length) {
				slideIndex = 1;
			}
			if (n < 1) {
				slideIndex = slides.length;
			}
			for (i = 0; i < slides.length; i++) {
				slides[i].style.display = "none";
			}
			for (i = 0; i < dots.length; i++) {
				dots[i].className = dots[i].className.replace(" active", "");
			}
			slides[slideIndex - 1].style.display = "block";
			dots[slideIndex - 1].className += " active";
		}

		showSlides();

		function showSlides() {
			let i;
			let slides = document.getElementsByClassName("mySlides");
			for (i = 0; i < slides.length; i++) {
				slides[i].style.display = "none";
			}
			slideIndex++;
			if (slideIndex > slides.length) {
				slideIndex = 1;
			}
			slides[slideIndex - 1].style.display = "block";
			setTimeout(showSlides, 2000); // Change image every 2 seconds
		}
	</script>
	<hr />
	<div class="container">
		<aside class="sidebar">
			<h2>Quản trị</h2>
			<hr style="margin-top: 10px; font-weight: bold" />
			<nav>
				<ul>
					<li><a href="#" onclick="loadContent('bangdieukhien')">Bảng điều khiển</a></li>
					<li><a href="/Assignment_BAT/nguoidung" onclick="loadContent('trangchu')">Trang chủ</a></li>
					<li><a href="#" onclick="loadContent('tintuc')">Tin tức</a></li>

					<!-- Mục này chỉ hiển thị nếu là quản lý -->
					<c:if test="${sessionScope.role == 'admin'}">
						<li><a href="#" onclick="loadContent('loaitin')">Loại tin</a></li>
						<li><a href="#" onclick="loadContent('nguoidung')">Người dùng</a></li>
						<li><a href="#" onclick="loadContent('taotinmoi')">Newsletter</a></li>
					</c:if>
					<li><a href="#" onclick="loadContent('settings')">Cài đặt</a></li>
					<li><a href="/Assignment_BAT/dangxuat">Đăng xuất</a></li>
				</ul>
			</nav>
		</aside>
		<div class="main-content">
			<article style="height: auto">
    <iframe id="contentFrame" name="content"
            src="/Assignment_BAT/views/quantri/tongquan.jsp" width="100%"
            style="overflow: hidden; border: none; min-height:1200px" scrolling="no"></iframe>
</article>
			<div class="footer">
				<h1>WELCOME
		 			${fn:toUpperCase(sessionScope.loggedInUser.fullName)}</h1>
			</div>
		</div>
	</div>

	<script>
		function loadContent(page) {
			var iframe = document.getElementById("contentFrame");

			// Cập nhật src của iframe dựa trên trang được chọn
			switch (page) {
			case "bangdieukhien":
				iframe.src = "/Assignment_BAT/views/quantri/tongquan.jsp";
				break;
			/* case "trangchu":
				iframe.src = "/Assignment_BAT/quantri/home";
				break; */
			case "tintuc":
				iframe.src = "/Assignment_BAT/tintuc/index";
				break;
			case "loaitin":
				iframe.src = "/Assignment_BAT/loaitin/index";
				break;
			case "nguoidung":
				iframe.src = "/Assignment_BAT/nguoidung/index";
				break;
			case "taotinmoi":
				iframe.src = "/Assignment_BAT/newletter/index";
				break;
			case "settings":
				iframe.src = "/Admin/settings.html";
				break;
			// case "dangxuat":
			// iframe.src = "/DangKy/login.html";
			// break;
			default:
				iframe.src = "/Assignment_BAT/views/quantri/tongquan.jsp";
			}
		}

		function resizeIframe() {
			var iframe = document.getElementById("contentFrame");
			iframe.style.height = iframe.contentWindow.document.body.scrollHeight
					+ "px";
		}
		window.addEventListener("load", function() {
			var iframe = document.getElementById("contentFrame");
			iframe.onload = resizeIframe;
		});
	</script>
</body>
</html>