<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://www.dafont.com/peristiwa.font" rel="stylesheet">
<link href="https://fonts.google.com/specimen/Montserrat"
	rel="stylesheet">
<link rel="stylesheet" href="/webapp/resources/css/noticeList.css">


<style>

/*기본 스타일 및 레이아웃 설정*/
body {
	background-color: #F5F5F5;
	font-family: 'Montserrat';
	margin: 0;
	padding: 0;
	display: flex;
	flex-direction: column;
	align-items: center; /*전체 페이지 내용을 중앙에 배치*/
	color: #222;
	line-height: 1.6;
}

.qna-form-container {
	width: 900px;
	background-color: #F5F5F5;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0, 05);
	padding: 30px 50px;
	margin-top: 0px;
}

h1 {
	text-align: center;
	font-size: 2em;
	font-weight: 500;
	margin-bottom: 40px;
	padding-top: 20px;
	color: #222;
}

/*헤더 스타일*/
.header {
	width: 100%;
	max-width: 900px; /*폼 컨테이너와 동일한 너비로 설정*/
	background-color: #F5F5F5;
	border-bottom: 1px solid #222;
	padding: 10px 0;
	box-sizing: border-box;
}

.header-top {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 0 50px;
}

.logo {
	font-family: 'peristiwa';
	font-size: 64px;
	font-style: italic;
	color: #222;
	display: inline-block;
	margin-left: 20px;
}

.header-nav {
	display: flex;
	gap: 40px;
	font-size: 30px;
	font-weight: 300;
	padding-left: 20px;
}

.header-nav a {
	color: #222; /*커서가 가지 않았을 때 검은색 텍스트*/
	text-decoration: none; /*텍스트 밑줄 제거*/
	padding-bottom: 10px;
	transition: color 0.2s;
}

.header-nav a:hover {
	color: #0088ff; /*마우스 가져다 댔을 때 텍스트 색상 변경*/
}

.user-actions {
	display: flex;
	align-items: center;
	gap: 15px;
}

.membership {
	background: none;
	border: none;
	cursor: pointer;
	font-size: 0.95em;
	color: #222;
	position: relative;
	padding-right: 20px; /*화살표 공긴*/
}

.membership li { /*membership 드롭다운 메뉴 스타일(현재 html 구조 수정 필요)*/
	display: none; /*일단 숨김*/
}

.user-actions a {
	text-decoration: none;
	color: #222;
	font-size: 0.95em;
	padding: 8px 15px;
}

.user-actions a:last-child {
	/*ticket 버튼 스타일*/
	background-color: #222;
	color: #E5E2DB;
	border-radius: 3px;
}

/*폼 스타일*/
.form-group {
	margin-bottom: 25px;
	border: 1px solid #222;
	padding: 20px;
	background-color: #FAF9F6;
}

.form-group:last-of-type {
	margin-bottom: 30px;
}

.form-group label {
	display: block;
	font-weight: bold;
	color: #222;
	margin-bottom: 10px;
	font-size: 0.95em;
}

.form-group label[for="qna-title"]::after, .form-group label[for="qna-content"]::after
	{
	content: '*';
	color: red;
	font-weight: normal;
}

input[type="text"], textarea {
	width: 100%;
	padding: 12px;
	border: 1px solid #222;
	border-radius: 4px;
	box-sizing: border-box;
	font-size: 1em;
}

textarea {
	resize: vertical;
	min-height: 200px;
}

/*버튼 스타일*/
.button-container {
	text-align: center;
	margin-top: 30px;
}

.sumit-button {
	padding: 12px 30px;
	background-color: #CBD4C2;
	color: #222;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-size: 1.1em;
	transition: background-color 0.2s;
}

.sumit-button:hover {
	background-color: #0088ff;
}

/*푸터 스타일*/
.footer {
	background-color: #CBD4C2; /* 연한 녹색 계열 배경 */
	color: #222;
	padding: 30px 0;
	margin-top: 80px;
	text-align: center;
}

.footer-content p {
	margin: 5px 0;
	font-size: 14px;
}

.footer-hr {
	display: none; /* 디자인에 hr이 없으므로 숨김 처리 */
}

.footer p:last-child {
	margin-top: 15px;
	font-weight: bold;
}
</style>

<title>qnaform</title>
</head>
<body>
	<header class="header">
		<div class="header-top">
			<span class="header-left"> <a href="/" class="logo-link"><span
					class="logo">D</span></a>
			</span> <span class="header-right"> <span class="user-actions">
					<button class="membership">
						Membership
						<li><a href="#">로그인</a> <a href="#">로그아웃</a> <a href="#">회원가입</a>
						</li>h
					</button> <a href="#">Tickets</a>
			</span>
			</span>
		</div>
		<nav class="header-nav">
			<a href="#">Visit</a> <a href="#">Event</a> <a href="#">Notice</a>
		</nav>
	</header>
	<div class="qna-form-container">
		<h1>질문하기</h1>

		<form action="/qna/form" method="post">
			<!-- 토큰 -->
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
			<div class="form-group">
			<label for="userId">작성자</label>
				<input class="form-control" type="text" name="userId"
					value="<sec:authentication property='principal.userId' />" readonly />
			</div>
			<div class="form-group">
				<label for="qna-title">제목</label> <input type="text" id="qna-title"
					name="title" placeholder="제목을 입력하세요">
			</div>

			<div class="form-group">
				<label for="qna-content">질문 내용</label>
				<textarea id="qna-content" name="content" rows="10"
					placeholder="여기에 내용을 써주세요."></textarea>
			</div>
			
			<div class="button-container">
				<input type="submit" value="저장하기" class="submit-button">
			</div>
		
		<input type="hidden" name="visibility" value="PUBLIC">
		<input type="hidden" name="category" value="QNA">
		<input type="hidden" name="pinned" value="0">
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