<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<script src="<c:url value='/js/main.js'/>"></script>
<link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet"/>
<title>findPassword</title>
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
	</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<main>
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
	</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
</body>
</html>