<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://www.dafont.com/peristiwa.font" rel="stylesheet">
<link href="https://fonts.google.com/specimen/Montserrat"
	rel="stylesheet">
<link rel="stylesheet" href="/webapp/resources/css/noticeList.css">

<style>
.body {
	font-family: 'Montserrat';
	color: #222;
	font-size: 16px;
	margin: 0;
	padding: 0;
	line-height: 1.6;
	background-color: #E5E2DB;
}

a {
	text-decoration: none;
	color: inherit;
}

h1, h2, h3 .header a, .header-nav a {
	font-weight: 300;
}

/*헤더 스타일*/
.header {
	padding: 25px;
	padding-bottom: 25px;
	background-color: #F5F5F5;
}

.header-top {
	display: flex;
	justify-content: space-between;
	align-items: flex-start; /*로고와 우측 액션을 상단 정렬*/
	position: relative;
	margin-bottom: 30px;
}

.header-left {
	display: flex;
	flex-direction: column;
}

.logo-link {
	font-family: 'peristiwa';
	font-size: 64px;
	color: #222;
	font-weight: 300;
	letter-spacing: -2px;
	padding-bottom: 25px; /*네비게이션과의 간격*/
}

.header-right {
	display: flex;
	align-items: center;
	position: absolute; /*절대 위치로 우측 상단에 고정*/
	top: 0;
	right: 40px;
	font-size: 20px;
	padding-top: 10px;
}

/*로그인 버튼 스타일*/
.user-action {
	display: flex;
	align-items: center;
}

.user-actions>a {
	margin-left: 20px;
}

/*로그인 버튼 스타일*/
.membership {
	background: #222;
	color: #fff;
	border: none;
	padding: 5px 15px;
	font-size: 20px;
	cursor: pointer;
	margin-left: 20px;
	font-weight: 400;
}

/*help,notice/qna 섹션 구현을 위한 추가 css*/
.header-nav {
	display: flex;
	font-size: 14px;
	letter-spacing: -0.5px;
}

.header-nav a {
	margin-right: 40px;
	padding-bottom: 3px;
	transition: color 0.2s;
}

.header-help {
	position: absolute;
	top: 5px;
	right: -10px;
	font-size: 30px;
	font-weight: 300;
}

.notice-qa-box {
	position: absolute;
	top: 50px;
	right: 40px;
	width: 100px;
	text-align: center;
	border: 1px solid #333333;
	font-size: 14px;
	padding: 5px 0;
	z-index: 10; /* 다른 요소 위에 표시 */
}

.notice-qa-box a {
	display: block;
	padding: 3px 0;
}

/*메인 콘텐츠 notice 섹션*/
main {
	max-width: 1200px;
	margin: 0 auto;
	padding-top: 30px;
	position: relative;
	background-color: #FAF9F6;
	padding-bottom: 80px;
}

.notice-section {
	max-width: 1200px;
	margin: 0 auto;
	padding: 0 40ox; /*좌우 여백*/
}

.notice-section h2 {
	font-size: 30px;
	margin-bottom: 50px;
	text-align: center;
	border-bottom: none;
	padding-bottom: 5px;
}

/*공지 제목과 메타 정보*/
.notice-header {
	max-width: 800px;
	border-bottom: 1px solid #222;
	padding-bottom: 10px;
	margin-bottom: 20px;
}

.notice-header h3 {
	font-size: 14px;
	font-weight: 400;
	margin: 0;
}

.notice-meta {
	font-size: 16px;
	color: #AFAFAF;
	text-align: right;
	margin-top: 5px;
}

/*공지 내용 박스*/
.notice-content {
	max-width: 800px;
	margin: 0 auto;
	padding: 30px;
	background-color: #F5F5F5;
	border: 1px solid #222;
}

.notice-content p {
	margin: 15px 0;
	font-size: 14px;
	line-height: 1.8;
}

.notice-content strong {
	color: red; /*점검 시간은 빨간색으로 강조*/
	font-weight: 600;
}

/*목록 버튼*/
.back-button-container {
	max-width: 800px;
	margin: 30px auto 0 auto;
	text-align: right;
}

.back-button {
	background-color: #FAF9F6;
	border: 1px solid #222;
	color: #222;
	padding: 10px 20px;
	cursor: pointer;
	font-size: 14px;
	transition: background-color 0.2, border-color 0.2s;
	width: 108px;
	height: 34px;
	box-sizing: border-box;
}

.back-button:hover {
	background-color: #FAF9F6;
}

/* 4. Footer 영역 스타일 */
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

<title>noticedetail</title>
</head>
<body>
	<header class="header">
		<div class="header-top">
			<span class="header-left"> <a href="/" class="logo-link"><span
					class="logo">D</span></a>
			</span> <span class="header-right"> <span class="user-actions">
					<button class="membership">
						login
						<li><a href="#">로그인</a> <a href="#">로그아웃</a> <a href="#">회원가입</a>
						</li>h
					</button> <a href="#">mypage</a>
			</span>
			</span>
		</div>
		<nav class="header-nav">
			<a href="#">Visit</a> <a href="#">Event</a> <a href="#">Reservation</a>
		</nav>
	</header>

	<main>
		<section class="notice-section">
			<h2>Notice</h2>
			<div class="notice-header">
				<h3>${postDTO.title }</h3>
				<div class="notice-meta">
					<span>등록일자: ${postDTO.createdAt }</span> | <span>조회:
						${postDTO.viewCount }</span>
				</div>
			</div>
			<div class="notice-content">
				<c:if test="${not empty fileList }">
					<c:forEach var="fileDTO" items="${fileList}">
						<img
							src="${pageContext.request.contextPath}/resources/uploadTemp/${fileDTO.storedPath}/${fileDTO.uuid}_${fileDTO.originalName}"
							alt="${fileDTO.originalName}">
					</c:forEach>
					<br>
				</c:if>
				<c:if test="${empty fileList }">
					<span>* 첨부된 사진이 없습니다.</span><br>
				</c:if>
				${postDTO.content }
			</div>
			<div class="back-button-container">
				<button class="back-button" onclick="location.href='/notices'">목록</button>
			</div>
		</section>
	</main>

	<footer class="footer">
		<p>수원시 팔달구 덕영대로 895번길 11</p>
		<p>대표전화. 031-420-4204</p>
		<hr class="footer-hr">
		<p>@jfdfhfksehfkjsnckaul</p>
	</footer>
</body>
</html>