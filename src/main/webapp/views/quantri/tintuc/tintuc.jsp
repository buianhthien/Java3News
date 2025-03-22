<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<html>
<head>
<link rel="stylesheet" type="text/css" href="/Assignment_BAT/css/form.css">
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    .hinhanh {
        width: 100px;
        height: 100px;
    }

    .table {
        table-layout: fixed;
    }

    th, td {
        padding: 8px;
        border: 1px solid #ddd;
        text-align: left;
        word-wrap: break-word;
    }

    td.content-column {
        white-space: normal;
        overflow-wrap: break-word;
        word-break: break-word;
        width: 300px;
    }

    .alert {
        padding: 15px;
        margin-bottom: 20px;
        border: 1px solid #d6e9c6;
        border-radius: 4px;
        color: #3c763d;
        background-color: #dff0d8;
        display: inline-block;
    }
</style>
</head>
<body>
    <h1>QUẢN LÝ TIN TỨC</h1>
    <section class="list-section">
        <h2>DANH SÁCH TIN TỨC</h2>
        
        <!-- Hiển thị thông báo -->
        <c:if test="${not empty sessionScope.message}">
            <div class="alert alert-success">
                ${sessionScope.message}
            </div>
            <c:remove var="message" scope="session" />
        </c:if>
        
        <button class="Them" style="float: right; margin-bottom: 10px;">
            <a href="/Assignment_BAT/tintuc/create">Thêm mới</a>
        </button>
        <table>
            <thead>
                <tr>
                    <th>Mã tin</th>
                    <th>Tiêu đề</th>
                    <th>Nội dung</th>
                    <th>Hình/Video</th>
                    <th>Ngày đăng</th>
                    <th>Mã phóng viên</th>
                    <th>Số lượt xem</th>
                    <th>Mã loại tin</th>
                    <th>Trang nhất</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${news}">
                    <tr>
                        <td>${item.newsID}</td>
                        <td>${item.title}</td>
                        <td class="content-column">${fn:substring(item.content, 0, 150)}</td>
                        <td><img class="hinhanh" alt="${item.title}"
                            src="${pageContext.request.contextPath}${item.image}?t=${System.currentTimeMillis()}"
                            width="50px" height="50px"></td>
                        <td><fmt:formatDate value="${item.postDate}" pattern="dd/MM/yyyy HH:mm" /></td>
                        <td>${item.author}</td>
                        <td>${item.viewCount}</td>
                        <td>${item.categoryID}</td>
                        <td>${item.home ? "Có" : "Không"}</td>
                        <td>
                            <button class="edit-btn">
                                <a href="/Assignment_BAT/tintuc/update?id=${item.newsID}">Sửa</a>
                            </button>
                            <form action="/Assignment_BAT/tintuc/delete" method="post" onsubmit="return confirmDelete();">
                                <input name="id" value="${item.newsID}" type="hidden">
                                <button class="delete-btn">Xóa</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </section>
    <script>
        function confirmDelete() {
            return confirm("Bạn có chắc chắn muốn xóa tin này?");
        }
    </script>
</body>
</html>