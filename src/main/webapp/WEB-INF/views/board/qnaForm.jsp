<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>qnaform</title>
</head>
<body>
	<header class="header">
      <div class="header-top">
      <span class="header-left">
         <a href="/" class="logo-link"><span class="logo">D</span></a>
         </span>
         <span class="header-right">
            <span class="user-actions">
               <button class="membership">Membership
                  <li>
                     <a href="#">로그인</a>
                     <a href="#">로그아웃</a>
                     <a href="#">회원가입</a>
                  </li>h
               </button>
               <a href="#">Tickets</a>
            </span>
         </span>
      </div>
         <nav class="header-nav">
            <a href="#">Visit</a>
            <a href="#">Event</a>
            <a href="#">Notice</a>
         </nav>
   </header>
	<div class="qna-form-container">
		<h1>질문하기</h1>

		<form action="/action_target.php" method="post">
			<div class="form-group">
				<label for="qna-title">제목</label>
				<input type="text" id="qna-title" name="title" placeholder="제목을 입력하세요">
			</div>

			<div class="form-group">
				<label for="qna-content">질문 내용</label>
				<textarea id="qna-content" name="content" rows="10" placeholder="여기에 내용을 써주세요."></textarea>
			</div>

			<div class="button-container">
				<input type="submit" value="저장하기" class="submit-button">
			</div>
			
		</form>
	</div>

	<footer class="footer">
      <p>수원시 팔달구 덕영대로 895번길 11</p>
      <p>대표전화. 031-420-4204</p>
      <hr class="footer-hr">
      <p>@jfdfhfksehfkjsnckaul</p>
   </footer>
</body>
</html>