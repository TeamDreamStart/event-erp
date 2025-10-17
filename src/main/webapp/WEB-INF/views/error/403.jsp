<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700;900&display=swap" rel="stylesheet"/>
  <title>403 Forbidden</title>
  <link rel="stylesheet" type="text/css" href="/resources/css/error.css">
</head>
<body>
  <jsp:include page="/WEB-INF/views/common/header.jsp"/>
<main>
	<div class="error-main">
		<div class="error-text">
			<h1>Oops!</h1>
			<p class="text1">403 - 접근 권한이 없습니다.</p>
		</div>

  <sec:authorize access="isAuthenticated()">
    <p><b><sec:authentication property="principal.name"/></b> 님은 이 페이지에 접근 권한이 없습니다.</p>
  </sec:authorize>

  <sec:authorize access="isAnonymous()">
    <p>로그인 후 다시 시도해주세요.</p>
  </sec:authorize>

  <p>
    <article class="error-img">
			<img id="error-icon" src="/resources/img/error.png" alt="오류 아이콘" style="width: 100px;">
      <button onclick="history.back()" id="btn-back">이전으로</button>
      <sec:authorize access="isAuthenticated()"> | <a href="/logout" id="btn-back">로그아웃</a></sec:authorize>
      <sec:authorize access="isAnonymous()"> | <a href="/login" id="btn-back">로그인</a></sec:authorize>
		</article>
  </p>
  </div>
  </main>
  <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>
