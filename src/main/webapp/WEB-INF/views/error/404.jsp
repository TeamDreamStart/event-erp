<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>404 Not Found</title>
</head>
<body>
  <h2>404 - 페이지를 찾을 수 없습니다.</h2>

  <c:set var="reqUri" value="${requestScope['javax.servlet.error.request_uri']}" />
  <p>요청하신 주소: <b><c:out value="${reqUri}"/></b></p>

  <p><a href="/">홈으로</a></p>
</body>
</html>
