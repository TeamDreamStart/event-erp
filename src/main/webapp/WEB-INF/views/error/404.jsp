<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700;900&display=swap" rel="stylesheet"/>
  <title>404 Not Found</title>
  <link rel="stylesheet" type="text/css" href="/resources/css/error.css">
</head>
<body>
  <jsp:include page="/WEB-INF/views/common/header.jsp"/>
<main>
	<div class="error-main">
		<div class="error-text">
			<h1>Oops!</h1>
			<p class="text1">404 - 페이지를 찾을 수 없습니다.</p>
		</div>
    <c:set var="reqUri" value="${requestScope['javax.servlet.error.request_uri']}" />
    <p>요청하신 주소: <b><c:out value="${reqUri}"/></b></p>
		<article class="error-img">
			<img id="error-icon" src="/resources/img/error.png" alt="오류 아이콘" style="width: 100px;">
			<button onclick="history.back()" id="btn-back">이전으로</button>
		</article>
	</div>
</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
</body>
</html>
