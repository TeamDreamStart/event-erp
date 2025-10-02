<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<script src="/js/main.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet"/>
<title>error</title>
<style>
    body {
        background-color: #E5E2DB;
        color: #222222;
        font-family: 'Montserrat', sans-serif;
        font-size: medium;
        margin: 0;
        padding: 0 120px 60px; 
        line-height: 1;
    }
    main {
        margin-top: 0; 
        padding: 0; 
    }
    .error-main {
        /* 전체 콘텐츠를 중앙 정렬 */
        text-align: center; 
    }
    .error-text h1{
        font-weight: bold;
        font-size: 60px;
        line-height: 80px;
    }
    .error-text p {
        font-size: 20px;
        line-height: 30px;
    }
    .error-text .text2 {
        margin-bottom: 50px;

    }
    .error-img {
        display: flex;
        flex-direction: column;
        align-items: center; /* 가로 중앙 정렬 */
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
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<main>
	<div class="error-main">
		<div class="error-text">
			<h1>Oops!</h1>
			<p class="text1">페이지 경로가 올바르지 않습니다.</p>
			<p class="text2">주소가 잘못 입력되었거나 변경 혹은 삭제되어 요청하신 페이지를 찾을 수 없습니다.</p>
		</div>
		<article class="error-img">
			<img id="error-icon" src="/resources/img/error.png" alt="오류 아이콘" style="width: 100px;">
			<button onclick="history.back()" id="btn-back">이전으로</button>
		</article>
	</div>
</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
</body>
</html>