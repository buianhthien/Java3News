<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>

<html>
<head>
<link rel="stylesheet" type="text/css" href="/Assignment_BAT/css/trangchu.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<nav id="navbar">
      <ul class="menu2 row">
        <li>
          <a href="/Assignment_BAT/nguoidung">Trang chủ</a>
        </li>
          <c:forEach var="item" items="${loaiTinList}">
    <li class="${item.categoryID == currentCategoryID ? 'active' : ''}">
        <a href="/Assignment_BAT/menu/loaitin?id=${item.categoryID}">${item.categoryName}</a>
    </li>
</c:forEach>
      </ul>
    </nav>
</body>
</html>