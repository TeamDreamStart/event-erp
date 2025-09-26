<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>findPassword</title>
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
				<a href="#">Event</a>
				<a href="#">Notice</a>
				<a href="#">Help</a>
			</nav>
	</header>
	<div class="container">
		<h2>Find</h2>
		<div class="findUid-section">
			<form action="#" method="post">
				<div class="findUid-form">
					<label for="email">이메일로</label>
				<input type="text" name="userEmail" id="email" placeholder="이메일을 입력하세요." required>
				<button type="button" class="btn-send-code">인증번호 전송</button>
				</div>

				<div class="findUid-form">
					<label for="verificationCode">인증번호</label>
					<input type="text" id="verificationCode" name="verificationCode" placeholder="인증번호를 입력하세요." required>
					<button type="button" class="btn-verify">확인</button>
				</div>
				<button type="submit" class="btn-find-uid">아이디 찾기</button>
			</form>
		</div>

		<div class="findPassword-section">
			<form action="/reset-password" method="post">
				<div class="findPassword-form">
					<label for="email">이메일로</label>
				<input type="text" name="userEmail" id="email" placeholder="이메일을 입력하세요." required>
				<button type="button" class="btn-send-code">인증번호 전송</button>
				</div>

				<div class="findPassword-form">
					<label for="verificationCode">인증번호</label>
					<input type="text" id="verificationCode" name="verificationCode" placeholder="인증번호를 입력하세요." required>
					<button type="button" class="btn-verify">확인</button>
				</div>
				<button type="submit" class="btn-find-pass">비밀번호 찾기</button>
			</form>
		</div>
	</div> <hr>
	
	<footer class="footer">
		<p>수원시 팔달구 덕영대로 895번길 11</p>
		<p>대표전화. 031-420-4204</p>
		<hr class="footer-hr">
		<p>@jfdfhfksehfkjsnckaul</p>
	</footer>
</body>
</html>