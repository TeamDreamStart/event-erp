<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
<body>
	<header class="header">
		<div class="header-top">
			<span class="header-left">
				<a href="/" class="logo-link"><span class="logo">D</span></a>
			</span>
			<span class="header-right">
				<span class="user-actions">
					<a href="#" class="mypage-link">my page</a>
					<button class="btn-login">login</button>
				</span>
			</span>
		</div>
			<nav class="header-nav">
				<a href="#">Visit</a>
				<a href="/events">Event</a>
				<a href="/notices">Notice</a>
				<a href="#">Help</a>
			</nav>
	</header>
	<div class="container">
		<h2 class="login-title">Login</h2>
		<div class="login-section">
			<form action="#" method="post">
				<div class="login-form">
					<label for="username">아이디</label>
					<input type="text" name="username" id="username" placeholder="아이디를 입력하세요." required>
					<label for="password">비밀번호</label>
					<input type="password" name="password" id="password" placeholder="비밀번호를 입력하세요." required>
				</div>
				<div class="find-link">
					<a href="/find-password">아이디 · 비밀번호 찾기</a>
				</div>
				<div class="login-button">
					<button type="submit" class="btn btn-login">로그인</button>
					<a href="/join" class="btn btn-register">회원가입</a>
				</div>
			</form>
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