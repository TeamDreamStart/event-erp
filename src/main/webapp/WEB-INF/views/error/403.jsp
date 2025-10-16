<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
  <title>403 Forbidden</title>
</head>
<body>
  <h2>403 - 접근 권한이 없습니다.</h2>

  <sec:authorize access="isAuthenticated()">
    <p><b><sec:authentication property="principal.name"/></b> 님은 이 페이지에 접근 권한이 없습니다.</p>
  </sec:authorize>

  <sec:authorize access="isAnonymous()">
    <p>로그인 후 다시 시도해주세요.</p>
  </sec:authorize>

  <p>
    <a href="/">홈으로</a>
    <sec:authorize access="isAuthenticated()"> | <a href="/logout">로그아웃</a></sec:authorize>
    <sec:authorize access="isAnonymous()"> | <a href="/login">로그인</a></sec:authorize>
  </p>
</body>
</html>
