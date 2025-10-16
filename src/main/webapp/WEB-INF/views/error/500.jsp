<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700;900&display=swap" rel="stylesheet"/>
  <title>500 Internal Server Error</title>
  <link rel="stylesheet" type="text/css" href="/resources/css/error.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<main>
	<div class="error-main">
		<div class="error-text">
			<h1>Oops!</h1>
			<p class="text1">500 - 서버 내부 오류가 발생했습니다.</p>
		</div>
    <c:if test="${not empty exception}">
      <p>예외: <b><c:out value="${exception.getClass().getSimpleName()}"/></b></p>
      <p>메시지: <c:out value="${exception.message}"/></p>
    </c:if>
		<article class="error-img">
			<img id="error-icon" src="/resources/img/error.png" alt="오류 아이콘" style="width: 100px;">
			<button onclick="history.back()" id="btn-back">이전으로</button>
		</article>
	</div>
</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
  <!-- 개발 중엔 메시지 정도만 노출 (실운영에선 감출 것) -->
</body>
</html>
