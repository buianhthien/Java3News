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
<h1>News letter</h1>
      <c:if test="${not empty errorMessage}">
    <div class="mess" style="color: red; text-align: center; padding: 10px; height: 30px">
        ${errorMessage}
    </div>
</c:if>
    <section class="form-section">
      <form action="/Assignment_BAT/newletter/update/${emails.email}" id="newsletterForm" method="post">
        <c:if test="${not empty errorMessage}">
			<div class="mess"
				style="color: red; text-align: center; padding: 10px; height: 30px">
				${errorMessage}</div>
		</c:if>
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" value="${emails.email}" />

        <label for="enabled">Trạng thái:</label>
        <select id="enabled" name="enabled">
          <option value="true"${emails.status == true ? 'selected' : ''}>Bật</option>
          <option value="false" ${emails.status == false ? 'selected' : ''}>Tắt</option>
        </select>

        <button type="submit">Lưu</button>
      </form>
    </section>
</body>
</html>