<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="qnaDetail.css">
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
            <a href="#">Reservation</a>
         </nav>
   </header>

   <main>
	<section class="qna-section">
		<h1 class="page-title">Q&A</h1>
	
      <form action="/submmit-qna" method="post" class="qna-from">

         <p class="guide-text">작성하신 문의 내용의 답변은 'mypage>1:1 Q&A'에서 확인 가능합니다.</p>
               
         <div class="form-group">
            <label for="qnaTitle" class="form-label">제목</label>
            <input type="text" id="qnaTitle" name="title" placeholder="제목을 입력하세요." required>
         </div>

         <div class="form-group content-area">
            <label for="qnaContent" class="form-label">내용</label>
            <textarea id="qnaContent" name="content" rows="10" placeholder="내용을 입력하세요." required></textarea>
         </div>

         <div class="button-group">
            <button type="button" class="btn-cancel">취소</button>
            <button type="submit" class="btn-submit">등록</button>
         </div>
      </form> 

<footer class="footer">
      <p>수원시 팔달구 덕영대로 895번길 11</p>
      <p>대표전화. 031-420-4204</p>
      <hr class="footer-hr">
      <p>@jfdfhfksehfkjsnckaul</p>
   </footer>
</body>
</html>