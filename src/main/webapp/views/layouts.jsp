<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%-- 	<jsp:include page="layouts/nav.jsp"></jsp:include> --%>
	<div id="content" style="margin-top: 30px">
		<jsp:include page="${admin}"></jsp:include>
	</div>
</body>
</html>