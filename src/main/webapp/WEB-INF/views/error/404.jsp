<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700;900&display=swap" rel="stylesheet"/>
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/common.css'/>">
  <title>404 Not Found</title>
	<style>
      body {
 background: #E5E2DB;
}
    .error-main {
        /* 전체 콘텐츠를 중앙 정렬 */
        text-align: center;
        margin-bottom: 140px;
    }
    .error-text h1{
        font-weight: 900;
        font-size: 60px;
        line-height: 80px;
        margin-bottom: 40px;
    }
    .error-text p {
        font-size: 20px;
        line-height: 30px;
        color: #444444;
      }
      .error-text .text1 {
        font-size: 30px;
        margin-bottom: 40px;

    }
    .error-img {
        display: flex;
        flex-direction: column;
        align-items: center; /* 가로 중앙 정렬 */
        margin-bottom: 140px;
    }
    .error-img button {
        margin-top: 50px;
        display: block;
        text-align: center;
        background-color: #ffffff;
        border: 1px solid #ccc;
        font-family: 'Montserrat', sans-serif;
        font-size: 18px;
        color: #222222;
        cursor: pointer;
        padding: 8px 16px;
        border-radius: 0px;
        text-decoration: none;
        justify-content: center;
        align-items: center;
        min-width: 92px;
        height: 100%;
        box-sizing: border-box;
        margin-top: 28px;
          margin-left: auto;
        margin-right: auto;
}
   
    .error-img button:hover {
    background-color: #e0e0e0;
}
.error-img a{
  text-decoration: none;
color: #222222;
  margin-top: 50px;
        display: block;
        text-align: center;
        background-color: #ffffff;
        border: 1px solid #ccc;
        font-family: 'Montserrat', sans-serif;
        font-size: 18px;
        color: #222222;
        cursor: pointer;
        padding: 8px 16px;
        border-radius: 0px;
        text-decoration: none;
        justify-content: center;
        align-items: center;
        min-width: 92px;
        height: 100%;
        box-sizing: border-box;
        margin-left: auto;
        margin-right: auto;
}

  </style>
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
    <p style="font-size: 20px; margin-bottom: 54px;">요청하신 주소: <b><c:out value="${reqUri}"/></b></p>
		<article class="error-img">
			<img id="error-icon" src="/resources/img/error.png" alt="오류 아이콘" style="width: 100px;">
			<button onclick="history.back()" id="btn-back">이전으로</button>
		</article>
	</div>
</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
</body>
</html>
