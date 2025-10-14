<%@ page contentType="text/html; charset=UTF-8" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>500 Internal Server Error</title>
</head>
<body>
  <h2>500 - 서버 내부 오류가 발생했습니다.</h2>

  <!-- 개발 중엔 메시지 정도만 노출 (실운영에선 감출 것) -->
  <c:if test="${not empty exception}">
    <p>예외: <b><c:out value="${exception.getClass().getSimpleName()}"/></b></p>
    <p>메시지: <c:out value="${exception.message}"/></p>
  </c:if>

  <p><a href="/">홈으로</a></p>
</body>
</html>
