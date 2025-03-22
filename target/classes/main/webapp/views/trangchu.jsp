<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="/Assignment_BAT/css/trangchu.css" />
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.container p {
	color: white;
	font-size: 16px;
	margin-left: 10px;
}
</style>
<body>
	<div class="container-tong">
		<div class="tintop">
			<p>Tin hot</p>
		</div>
		<div class="container">
			<div class="hinh">

				<div class="main-image">

					<c:forEach var="item" items="${tintuc}" varStatus="status">
						<c:if test="${status.index == 0 && item.home == true}">
							<img src="${pageContext.request.contextPath}${item.image}"
								alt="Main Image" />
							<div class="content-main">
								<a href="/Assignment_BAT/chitiet?id=${item.newsID}">${item.title}</a>
								<p>
									<fmt:formatDate value="${item.postDate}"
										pattern="dd/MM/yyyy HH:mm" />
								</p>
							</div>
						</c:if>
					</c:forEach>


				</div>
				<div class="small-images">
					<div class="small-images-item">
						<c:forEach var="item" items="${tintuc}" varStatus="status">
							<c:if test="${status.index == 1 || status.index == 2 && item.home == true}">
								<div class="content-2">
									<img src="${pageContext.request.contextPath}${item.image}"
										alt="Small Image ${status.index}" />
									<div class="content-small">
										<a href="/Assignment_BAT/chitiet?id=${item.newsID}">${item.title}</a>
										<p>
											<fmt:formatDate value="${item.postDate}"
												pattern="dd/MM/yyyy HH:mm" />
										</p>
									</div>
								</div>
							</c:if>
						</c:forEach>
					</div>
					<div class="small-images-item">
						<c:forEach var="item" items="${tintuc}" varStatus="status">
							<c:if test="${status.index == 3 || status.index == 4 && item.home == true }">
								<div class="content-2">
									<img src="${pageContext.request.contextPath}${item.image}"
										alt="Small Image ${status.index}" />
									<div class="content-small">
										<a href="/Assignment_BAT/chitiet?id=${item.newsID}">${item.title}</a>
										<p>
											<fmt:formatDate value="${item.postDate}"
												pattern="dd/MM/yyyy HH:mm" />
										</p>
									</div>
								</div>
							</c:if>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>

	<hr style="margin-top: 10px" />

	<div class="box-tong">
		<div class="box-phai">
			<div class="tinmoi">
				<p>Tin mới</p>
			</div>
			<div class="content-tinmoi">
				<c:forEach var="item" items="${news}" varStatus="status">
					<!-- Hiển thị bài viết mới nhất -->
					<c:if test="${status.index == 0 && item.home == true}">
						<div class="tinmoi1">
							<img src="${pageContext.request.contextPath}${item.image}"
								alt="${item.title}" /> <a
								href="/Assignment_BAT/chitiet?id=${item.newsID}">${item.title}</a>
							<p>
								<fmt:formatDate value="${item.postDate}"
									pattern="dd/MM/yyyy HH:mm" />
							</p>
							<p>${fn:substring(item.content,0,200)}</p>
						</div>
					</c:if>
				</c:forEach>
				<div class="tinmoi2345">
					<c:forEach var="item" items="${news}" varStatus="status">
						<c:if test="${status.index  >=1 && status.index <= 4 && item.home == true }">
							<!-- Bỏ qua bài viết đầu tiên -->
							<div class="tinmoi-item">
								<img src="${pageContext.request.contextPath}${item.image}"
									alt="${item.title}" />
								<div class="content-tinmoi-item">
									<a href="/Assignment_BAT/chitiet?id=${item.newsID}">${item.title}</a>
									<p>
										<fmt:formatDate value="${item.postDate}"
											pattern="dd/MM/yyyy HH:mm" />
									</p>
								</div>
							</div>
						</c:if>
					</c:forEach>
				</div>
			</div>
			<div class="gadget-world">
				<c:forEach var="item" items="${news}" varStatus="status">
					<c:if test="${status.index > 4 && status.index <=6 && item.home == true}">
						<!-- Bỏ qua bài viết đầu tiên -->
						<div class="gadget-world-item">
							<img src="${pageContext.request.contextPath}${item.image}" alt="" />
							<div class="gadget-world-item-content">
								<a href="/Assignment_BAT/chitiet?id=${item.newsID}">${item.title}</a>
								<p>
									<fmt:formatDate value="${item.postDate}"
										pattern="dd/MM/yyyy HH:mm" />
								</p>
							</div>
						</div>
					</c:if>
				</c:forEach>
			</div>
			<div class="gadget-world-small">
				<div class="gadget-world-left">
					<c:forEach var="item" items="${news}" varStatus="status">
						<c:if test="${status.index > 6 && status.index <10 && item.home == true}">
							<!-- Bỏ qua bài viết đầu tiên -->
							<div class="gadget-world-item1">
								<img src="${pageContext.request.contextPath}${item.image}"
									alt="" />
								<div class="content-gadget-world-item">
									<a href="/Assignment_BAT/chitiet?id=${item.newsID}">${item.title}</a>
									<p>
										<fmt:formatDate value="${item.postDate}"
											pattern="dd/MM/yyyy HH:mm" />
									</p>
								</div>
							</div>
						</c:if>
					</c:forEach>
				</div>
				<div class="gadget-world-right">
					<c:forEach var="item" items="${news}" varStatus="status">
						<c:if test="${status.index > 10 && status.index <14 && item.home == true}">
							<!-- Bỏ qua bài viết đầu tiên -->
							<div class="gadget-world-item1">
								<img src="${pageContext.request.contextPath}${item.image}"
									alt="${item.title}" />
								<div class="content-gadget-world-item">
									<a href="/Assignment_BAT/chitiet?id=${item.newsID}">${item.title}</a>
									<p>
										<fmt:formatDate value="${item.postDate}"
											pattern="dd/MM/yyyy HH:mm" />
									</p>
								</div>
							</div>
						</c:if>
					</c:forEach>
				</div>
			</div>
			<hr style="margin-top: 50px" />
			<div class="dontmiss-qc">
				<div class="bestsmartphone">
					<div class="header3">
						<p>Thời sự</p>
					</div>
					<c:forEach var="item" items="${listnews}" varStatus="status">
						<c:if test="${status.index == 0 && item.home == true }">
							<div class="content-bestsmartphone">
								<img src="${pageContext.request.contextPath}${item.image}"
									alt="" /> <a href="/Assignment_BAT/chitiet?id=${item.newsID}">
									${item.title}</a>
								<p>
									<fmt:formatDate value="${item.postDate}"
										pattern="dd/MM/yyyy HH:mm" />
								</p>
								<p>${fn:substring(item.content,0,500)}...</p>
							</div>
						</c:if>
					</c:forEach>

				</div>

				<div class="dontmiss">
					<c:forEach var="item" items="${listnews}" varStatus="status">
						<c:if test="${status.index >= 1 && status.index < 6 && item.home == true }">
							<div class="content-dontmiss">
								<a href="/Assignment_BAT/chitiet?id=${item.newsID}">${item.title}</a>
								<p>
									<fmt:formatDate value="${item.postDate}"
										pattern="dd/MM/yyyy HH:mm" />
								</p>
							</div>
						</c:if>
					</c:forEach>
				</div>


			</div>
			<div class="view-more">
				<c:forEach var="item" items="${listnews}" varStatus="status">
					<c:if test="${status.index >= 6 && status.index < 8 && item.home == true}">
						<div class="view-more1">
							<img src="${pageContext.request.contextPath}${item.image}"
								alt="${item.title}" />
							<div class="view-more-item">
								<a href="/Assignment_BAT/chitiet?id=${item.newsID}">${item.title}</a>
								<p>
									<fmt:formatDate value="${item.postDate}"
										pattern="dd/MM/yyyy HH:mm" />
								</p>
							</div>
						</div>
					</c:if>
				</c:forEach>
			</div>
			<div class="header4"
				style="margin-left: 40px; width: 20%; height: 20px; padding: 10px; background-color: #2fa1b3; text-align: center; margin-top: 10px; border-radius: 5px;">
				<p style="color: white;">Xã hội</p>
			</div>
			<div class="latest-letter">
				<div class="latest-letter1">
					<c:forEach var="item" items="${ listnews1}" varStatus="status">
						<c:if test="${status.index < 5 && item.home == true }">
							<img src="${pageContext.request.contextPath}${item.image}"
								alt="${item.title}" />
							<a href="/Assignment_BAT/chitiet?id=${item.newsID}">${item.title}</a>
							<p>
								<fmt:formatDate value="${item.postDate}"
									pattern="dd/MM/yyyy HH:mm" />
							</p>
						</c:if>
					</c:forEach>
				</div>
				<div class="latest-letter2">
					<c:forEach var="item" items="${ listnews1}" varStatus="status">
						<c:if test="${status.index >= 5 && status.index <10 && item.home == true }">
							<img src="${pageContext.request.contextPath}${item.image}"
								alt="${item.title}" />
							<a href="/Assignment_BAT/chitiet?id=${item.newsID}">${item.title}</a>
							<p>
								<fmt:formatDate value="${item.postDate}"
									pattern="dd/MM/yyyy HH:mm" />
							</p>
						</c:if>
					</c:forEach>
				</div>
			</div>
		</div>
		<div class="box-trai">
			<div class="content-qc">
				<div class="logo">
					<img src="/Assignment_BAT/images/tải xuống.png" alt="" />
				</div>
			</div>
			<div class="video" style="border-radius: 5px;">
				<p>Thế giới</p>
			</div>
			<c:forEach var="item" items="${listnews2}" varStatus="status">
				<c:if test="${status.index <2 && item.home == true}">
					<div class="video-content">
						<img src="${pageContext.request.contextPath}${item.image}"
							alt="${item.title}" /> <a
							href="/Assignment_BAT/chitiet?id=${item.newsID}">
							${item.title}</a>
						<p>
							<fmt:formatDate value="${item.postDate}"
								pattern="dd/MM/yyyy HH:mm" />
						</p>
					</div>
				</c:if>
			</c:forEach>


			<div class="video" style="border-radius: 5px;">
				<p>Thể thao</p>
			</div>
			<div class="holiday-rc">
				<c:forEach var="item" items="${listnews3}" varStatus="status">
					<c:if test="${status.index <4 && item.home == true}">
						<div class="content-holiday-rc">
							<div class="content-item">
								<a href="/Assignment_BAT/chitiet?id=${item.newsID}">
									${item.title}</a>
								<p>
									<fmt:formatDate value="${item.postDate}"
										pattern="dd/MM/yyyy HH:mm" />
								</p>
							</div>
							<div>
								<img src="${pageContext.request.contextPath}${item.image}"
									alt="${item.title}" />
							</div>
						</div>
					</c:if>
				</c:forEach>
				<div class="banner">
					<img src="/Assignment_BAT/images/banner_hcm_02-min.png" alt="" />
					<a
						href="https://vnexpress.net/newsletters/gioi-thieu?utm_source=vnexpress&utm_medium=displayads&utm_campaign=newsletter_02_default&utm_content=300x600_pc_2709&size=300x600"></a>
				</div>

				<div class="banner1" >
					<img style = "width: 95%;" src="/Assignment_BAT/images/banner2.gif" alt="" /> <a
						href="https://vnexpress.net/newsletters/gioi-thieu?utm_source=vnexpress&utm_medium=displayads&utm_campaign=newsletter_02_default&utm_content=300x600_pc_2709&size=300x600"></a>
				</div>
				<div class="history">
					<h3
						style="margin-bottom: 20px; width: 65%; height: 20px; padding: 10px; background-color: #2fa1b3; border-radius: 5px; text-align: center; margin-top: 10px; color: white;">
						Bài viết đã xem gần đây</h3>
					<c:if test="${not empty recentArticles}">
						<c:forEach var="item" items="${recentArticles}">
							<div class="history-item">
								<img src="${pageContext.request.contextPath}${item.image}"
									alt="${item.title}" />
								<div class="content-history-item">
									<a href="/Assignment_BAT/chitiet?id=${item.newsID}">
										${item.title} </a>
									<p>
										<fmt:formatDate value="${item.postDate}"
											pattern="EEEE, dd/MM/yyyy HH:mm" />
									</p>
								</div>
							</div>
						</c:forEach>
					</c:if>
					<c:if test="${empty recentArticles}">
						<p>Không có bài viết nào đã xem gần đây.</p>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</body>
</html>