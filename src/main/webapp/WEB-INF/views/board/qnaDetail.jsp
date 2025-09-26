<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>qnadetail</title>
</head>
<body>
	<header class="header">
      <div class="header-top">
      <span class="header-left">
         <a href="/" class="logo-link"><span class="logo">D</span></a>
         </span>
         <span class="header-right">
            <span class="user-actions">
               <button class="membership">login
                  <li>
                     <a href="#">로그인</a>
                     <a href="#">로그아웃</a>
                     <a href="#">회원가입</a>
                  </li>h
               </button>
               <a href="#">mypage</a>
            </span>
         </span>
      </div>
         <nav class="header-nav">
            <a href="#">Visit</a>
            <a href="#">Event</a>
            <a href="#">Store</a>
         </nav>
   </header>

   <main>
	<section class="qna-section">
		<h2>Q&A</h2>
		<div class="qna-header">
			<h3>홈페이지 이용하기 좋은 최적화된 웹브라우저는 무엇인가요?</h3>
			<div class="qna-meta">
				<span>작성자: 서*리</span> | <span>등록일자: 2025-09-19</span> | <span>상태: 답변완료</span>
			</div>
		</div>
		<div class="qna-content">
			<p>홈페이지 이용에 최적화된 웹브라우저는 특정 브라우저 하나보다는,<br>
				사용자의 기기, OS(운영체제), 그리고 웹사이트의 최신 기술 지원 여부에 따라 달라집니다.<br>
				일반적으로 Google Chrome, Microsoft Edge, Safari, Firefox 등이<br>
				최신 기술을 지원하며 안정적으로 홈페이지를 보여주며,<br>
				국내에서는 네이버 웨일 또한 높은 점유율을 보입니다.<br>
			</p>
			<p>충분한 답변이 되셨길 바라며 오늘도 좋은 하루 보내세요.</p>
			<p>감사합니다.</p>
		</div>
		<div class="back-button-container">
				<button class="back-button">목록</button>
			</div>
	</section>
   </main>
   <div class="post-navigation">
      <div class="nav-item">
         <span class="nav-label">이전글</span>
         <div class="nav-link">
         <a href="/qna">강연 당일 예매 취소가 가능한가요?</a>
      </div>
      </div>
      <div class="nav-item">
         <span class="nav-label">다음글</span>
         <div class="nav-link">
        <a href="/qna">홈페이지에 있는 강의관련 이미지를 사용해도 되나요?</a>
      </div>
      </div>
   </div>

<footer class="footer">
      <p>수원시 팔달구 덕영대로 895번길 11</p>
      <p>대표전화. 031-420-4204</p>
      <hr class="footer-hr">
      <p>@jfdfhfksehfkjsnckaul</p>
   </footer>
</body>
</html>