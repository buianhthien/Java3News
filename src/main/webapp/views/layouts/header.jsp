<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--  <link rel="stylesheet" type="text/css" href="/Assignment_BAT/css/trangchu.css"> -->
<div class="slideshow-container">
	<!-- Full-width images with number and caption text -->
	<div class="mySlides fade">
		<img class="slide-img"
			src="/Assignment_BAT/images/Screenshot 2024-10-12 094925.png" />
	</div>

	<div class="mySlides fade">
		<img class="slide-img"
			src="/Assignment_BAT/images/Screenshot 2024-10-12 095002.png" />
	</div>

	<div class="mySlides fade">

		<img class="slide-img"
			src="/Assignment_BAT/images/Screenshot 2024-10-12 094925.png" />
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
		setTimeout(showSlides, 5000); // Change image every 2 seconds
	}
</script>
<style>
.header {
	display: flex; /* Sử dụng Flexbox để căn chỉnh các phần tử */
	justify-content: space-between; /* Căn giữa các phần tử */
	align-items: center; /* Căn giữa theo chiều dọc */
	padding: 10px 20px; /* Khoảng cách xung quanh header */
	background-color: #f8f9fa; /* Màu nền cho header */
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Đổ bóng nhẹ */
	width: 78%;
	margin-left: 148px;
}

.logos img {
	max-height: 50px; /* Đảm bảo chiều cao logo không quá 50px */
}

.search-container {
	display: flex; /* Sử dụng Flexbox cho ô tìm kiếm */
	align-items: center; /* Căn giữa ô tìm kiếm */
	width: 600px; /* Chiều rộng của ô tìm kiếm */
	position: relative; /* Để nút tìm kiếm có thể nằm bên trong */
}

.search-container input {
	flex: 1; /* Để input chiếm hết chiều rộng còn lại */
	width: 600px;
	padding: 10px; /* Thêm padding cho input */
	border: 1px solid #ccc; /* Biên cho input */
	border-radius: 5px; /* Bo góc cho input */
	margin-right: -30px;
	/* Đẩy input vào trong để tạo khoảng cách với nút */
}

.search-container button {
	position: absolute; /* Đặt nút tìm kiếm ở vị trí tuyệt đối */
	right: -10px; /* Khoảng cách từ bên phải */
	top: 50%; /* Đặt ở giữa theo chiều dọc */
	transform: translateY(-50%); /* Căn giữa nút */
	border: none; /* Bỏ border cho button */
	background-color: transparent; /* Nền trong suốt */
	cursor: pointer; /* Đổi con trỏ khi hover */
	height: 20px;
}

.auth-links {
	display: flex; /* Sử dụng Flexbox cho phần đăng nhập, đăng ký */
	align-items: center; /* Căn giữa theo chiều dọc */
}

.auth-links a {
	margin-left: 20px; /* Khoảng cách giữa các link */
	text-decoration: none; /* Bỏ gạch chân cho link */
	color: black; /* Màu chữ cho link */
	font-weight: bold; /* Đậm chữ */
}

.auth-links a::hover {
	color: #2fa1b3;
}
</style>

<div class="header">
	<div class="logos">
		<img src="/Assignment_BAT/images/bm-logo.png" alt="Logo" />
	</div>
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
	<div class="auth-links">
		<a href="/Assignment_BAT/dangnhap">Đăng nhập</a> <a
			href="/Assignment_BAT/dangky">Đăng ký</a>
	</div>
</div>

