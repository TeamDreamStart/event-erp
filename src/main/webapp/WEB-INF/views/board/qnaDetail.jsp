<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <link href="https://fonts.cdnfonts.com/css/peristiwa" rel="stylesheet">
    <link rel="stylesheet" href="qnaDetail.css">

<style>
body {
    /* 기본 폰트와 배경색 설정 */
    font-family: 'Montserrat'; 
    color: #222; 
    margin: 0;
    padding: 0;
    background-color:#E5E2DB;
}

main {
    /* 메인 콘텐츠 중앙 정렬 및 최대 너비 설정 */
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
}

/*==================================
  2. 헤더 (Header) 스타일
==================================*/
.header {
    max-width: 1200px;
    border-bottom: 1px solid #222; 
    padding: 20px 0;
    margin-bottom: 50px;
    position: relative;
}

.header-top {
    max-width: 1000px;
    margin: 0 auto;
    padding: 0 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    position: relative;
}

/* 로고 스타일 */
.logo {
    font-family:'Peristiwa', sans-serif;
    font-size: 64px;
    color: #222; 
    margin-left: 20px;
}

.logo-link {
    text-decoration: none;
    color: inherit;
}

/* 유저 액션 (mypage, login) 스타일 */
.user-actions a {
   font-weight: bold;
    border-left: 1px solid #222;
    padding-left: 15px;
}

.membership {
    background-color: #222; 
    color: #fff;
    border: none;
    padding: 8px 15px;
    cursor: pointer;
    font-size: 20px;
    text-transform: uppercase;
    position: relative; 
    z-index: 10;
}

.user-actions {
    display: flex;
    align-items: center;
}

/* GNB (Visit, Event, Reservation) 스타일 */
 .header-nav{
    display: flex;
    gap: 40px;
    font-size: 30px;
    font-weight: 300;
    padding-left: 20px;
    margin-bottom: 20px;
}

.header-nav a{
   color: #222;
    padding-bottom: 10px;
    transition: color 0.2s;
    text-decoration: none;
}

.header-nav a:hover{
    color: #0088ff;
}

.header-help{
    position: absolute;
    top: 5px;
    right: -10px;
    font-size: 30px;
    font-weight: 300;
}


/*==================================
  3. Q&A 폼 (Form) 스타일
==================================*/
.page-title {
    text-align: center;
    font-size: 30px;
    font-weight: bold;
    margin-bottom: 50px;
    letter-spacing: 2px;
}

.qna-from {
    max-width: 600px;
    margin: 0 auto;
    padding: 20px 0;
}

.guide-text {
    text-align: center;
    font-size: 14px;
    color: #222;
    border: 1px solid #ccc; /* --light-border-color 대체 */
    padding: 10px;
    border-radius: 5px;
    margin-bottom: 30px;
}

.form-group {
    display: flex;
    margin-bottom: 15px;
    border: 1px solid #ccc; /* --light-border-color 대체 */
}

.form-label {
    width: 80px;
    background-color: #f7f7f7;
    padding: 15px 10px;
    text-align: center;
    border-right: 1px solid #ccc; /* --light-border-color 대체 */
    box-sizing: border-box;
    font-size: 15px;
}

.form-group input,
.form-group textarea {
    flex-grow: 1;
    border: none;
    padding: 15px 20px;
    font-size: 16px;
    box-sizing: border-box;
    resize: none;
    outline: none;
}

.content-area {
    margin-bottom: 30px;
}

.content-area textarea {
    height: 150px;
}

/* 버튼 그룹 스타일 */
.button-group {
    text-align: center;
    margin-top: 20px;
}

.button-group button {
    padding: 10px 25px;
    margin: 0 5px;
    border: 1px solid #ccc; /* --light-border-color 대체 */
    cursor: pointer;
    font-size: 14px;
}

.btn-cancel {
    background-color: #F2F0EF;
    color: #222;
}

.btn-submit {
    background-color: #BFD4F9; 
    color: #fff;
    /*border-color: #6a9cff;*/
}


/*==================================
  4. 푸터 (Footer) 스타일
==================================*/
.footer {
    background-color: #CBD4C2; /* 연한 녹색 계열 배경 */
    color: #222;
    padding: 30px 20px;
    margin-top: 80px;
    margin-bottom: 30px;
}

.footer p {
    margin: 5px 0;
    font-size: 14px;
    text-align: left;
}
.footer-hr {
    display: block;
    width: 100%;
    border: none;
    border-top: 1px solid #222;
    margin: 15px 0;
}

.footer p:last-child {
    margin-top: 15px;
} 

</style>

<title>qnadetail</title>
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
