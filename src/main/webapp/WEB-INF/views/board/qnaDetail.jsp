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
/* 기존 qnaform CSS 그대로 복사 */
body {
	background-color: #F5F5F5;
	font-family: 'Montserrat';
	margin: 0;
	padding: 0;
	display: flex;
	flex-direction: column;
	align-items: center;
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
	max-width: 900px;
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
	color: #222;
	text-decoration: none;
	padding-bottom: 10px;
	transition: color 0.2s;
}

.header-nav a:hover {
	color: #0088ff;
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
	padding-right: 20px;
}

.user-actions a {
	text-decoration: none;
	color: #222;
	font-size: 0.95em;
	padding: 8px 15px;
}

.user-actions a:last-child {
	background-color: #222;
	color: #E5E2DB;
	border-radius: 3px;
}

/* 상세보기 스타일 */
.detail-group {
	margin-bottom: 25px;
	padding: 20px;
	background-color: #FAF9F6;
	border: 1px solid #222;
	border-radius: 4px;
}

.detail-group label {
	display: block;
	font-weight: bold;
	color: #222;
	margin-bottom: 10px;
	font-size: 0.95em;
}

.detail-group .detail-content {
	background-color: #fff;
	padding: 10px 15px;
	border-radius: 4px;
	border: 1px solid #ccc;
	min-height: 40px;
}

/* 내용 영역 */
.detail-group .detail-content.textarea {
	min-height: 200px;
	white-space: pre-wrap;
}

/* 푸터 스타일 */
.footer {
	background-color: #CBD4C2;
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
	display: none;
}

.footer p:last-child {
	margin-top: 15px;
	font-weight: bold;
}
</style>

<title>qnaDetail</title>
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
						</li>
					</button> <a href="#">Tickets</a>
			</span>
			</span>
		</div>
		<nav class="header-nav">
			<a href="#">Visit</a> <a href="#">Event</a> <a href="#">Notice</a>
		</nav>
	</header>

	<div class="qna-form-container">
		<h1>질문 상세보기</h1>

		<div class="detail-group">
			<label>작성자</label>
			<div class="detail-content">
				${postDTO.userId }
			</div>
		</div>

		<div class="detail-group">
			<label>제목</label>
			<div class="detail-content">
				${postDTO.title}
			</div>
		</div>

		<div class="detail-group">
			<label>질문 내용</label>
			<div class="detail-content textarea">
				${postDTO.content}
			</div>
		</div>

		<div class="detail-group">
			<label>작성일</label>
			<div class="detail-content">
				${postDTO.createdAt}
			</div>
		</div>
		<div class="detail-group">
			<label>답변</label>
			<c:forEach var="commentDTO" items="${commentList }">
				<div class="detail-content">
				${commentDTO.content }
				</div>
			</c:forEach>
		</div>

	</div>
	<button onclick="location.href='/qna'" type="button">목록</button>

	<footer class="footer">
		<p>수원시 팔달구 덕영대로 895번길 11</p>
		<p>대표전화. 031-420-4204</p>
		<hr class="footer-hr">
		<p>@jfdfhfksehfkjsnckaul</p>
	</footer>
</body>
</html>
