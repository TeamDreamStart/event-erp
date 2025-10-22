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
 <title>403 Forbidden</title>
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
  
  /* 버튼들을 담을 새로운 컨테이너 스타일: 버튼을 수평으로 정렬 */
  .button-container {
    display: flex; /* Flexbox 활성화 */
    justify-content: center; /* 버튼들을 가로 중앙 정렬 */
    align-items: center;
    gap: 10px; /* 버튼 사이 간격 */
    margin-top: 28px; /* 이미지와의 간격 */
  }
  
  /* 버튼과 앵커 태그의 공통 스타일 */
  .error-img button, 
  .error-img a {
    margin: 0; /* 기존 마진 제거 */
    display: flex; 
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
    height: 40px; 
    box-sizing: border-box; 
  }
  
  .error-img button:hover,
  .error-img a:hover {
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
   <p class="text1">403 - 접근 권한이 없습니다.</p>
   
   <sec:authorize access="isAuthenticated()">
    <p><b><sec:authentication property="principal.name"/></b> 님은 이 페이지에 접근 권한이 없습니다.</p>
   </sec:authorize>
   
   <sec:authorize access="isAnonymous()">
    <p style="margin-bottom: 54px;">로그인 후 다시 시도해주세요.</p>
   </sec:authorize>
  </div>

 <p>
  <article class="error-img">
   <img id="error-icon" src="/resources/img/error.png" alt="오류 아이콘" style="width: 100px;">
   
      <div class="button-container">
    <button onclick="history.back()">이전으로</button>
    <sec:authorize access="isAuthenticated()">
          <a href="/logout">로그아웃</a>
        </sec:authorize>
    <sec:authorize access="isAnonymous()">
          <a href="/login">로그인</a>
        </sec:authorize>
      </div>
  </article>
 </p>
 </div>
 </main>
 <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>