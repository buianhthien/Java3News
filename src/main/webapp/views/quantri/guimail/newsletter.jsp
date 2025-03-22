<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
	<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="f"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/Assignment_BAT/css/form.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <h1>NEWS LETTER </h1>
    <section class="list-section">
  <!--   <button class="Them" style="float: right; margin-bottom: 10px;" ><a href="/Assignment_BAT/loaitin/create">Thêm mới</a></button> -->
      <table>
        <thead>
          <tr>	
            <th>Email</th>
            <th>Trạng thái</th>
<!--             <th>Hành động</th> -->
          </tr>
        </thead>
        <tbody id="newsletterList">
        <c:forEach var = "item" items="${emails}">
        	 <tr id="nl1">
            <td>${item.email}</td>
            <td>${item.status}</td>
            <%-- <td>
              <button class="edit-btn">
                <a href="/Assignment_BAT/newletter/update?id=${item.email}">Sửa</a>
              </button>
              <form action="/Assignment_BAT/newletter/delete" method="post" onsubmit="return confirmDelete();">
					<input name="id" value="${item.email}" type="hidden">
					<button class="delete-btn">Xóa</button>
				</form>
            </td> --%>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </section>

  
</body>
</html>