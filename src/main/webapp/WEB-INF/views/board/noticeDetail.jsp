<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.cdnfonts.com/css/peristiwa" rel="stylesheet">
<link href="https://fonts.google.com/specimen/Montserrat" rel="stylesheet">
 <link rel="stylesheet" href="/webapp/resources/css/noticeList.css">

<style>

body {

 /* 1. 페이지 바탕 색상: E5E2DB */
 background-color: #E5E2DB;
 font-family: 'Montserrat';
 margin: 0;
 padding: 0;
 color: #222;
 display: flex;
flex-direction: column;
align-items: center; /* 전체 콘텐츠 중앙 정렬 */
min-height: 100vh;
}


main {
width: 1440px; /* 메인 콘텐츠 너비 (헤더 너비와 일치) */
background-color: #E5E2DB; /* 메인 배경은 흰색으로 유지 */
padding-top: 50px; /* 상단 여백 */
box-sizing: border-box;
flex-grow: 1;
}

/* ---------------------------------------------------- */
/* 헤더 스타일 조정 (피그마 치수 기반) */
/* ---------------------------------------------------- */

.header {
 width: 1440px; /* 전체 너비 */
 height: 135px; /* 피그마 이미지에서 확인되는 높이 */
 background-color: #E5E2DB;
display: flex;
 flex-direction: column;
padding: 0 100px;
 box-sizing: border-box;
 position: relative; /* 자식 요소 위치 지정을 위해 */
}


.header-left{
 margin-right: 150px;
}


/*헤더 상단(로고,mypage, login)*/
.header-top {
display: flex;
justify-content: space-between; /* mypage, login 쪽을 오른쪽으로 */
 align-items: center;
 padding-top: 30px; /* 상단 여백 조정 */
height: 50px;
}

.logo-link{
text-decoration: none;
}

.logo {
font-family:'Peristiwa', sans-serif;
font-size:64px;
color: #222;
margin-left: 22px;
font-style: italic;
}

.header-left{ /*로고 포함*/
 position: relative;
}

/*mypage, login, help버튼 그룹*/
.header-right {
display: flex;
align-items: center;
font-size: 16px;
position: relative;
}

/*mypage 버튼 스타일*/
.header-right a[href="#"]:first-child {
width: 136px;
height: 42px;
line-height: 42px; /* 텍스트 수직 중앙 정렬 */
text-align: center;
color: #222;
text-decoration: none;
padding: 0;
background-color: #fff;
border: 1px solid #ddd;
margin-right: -1px; /* login 버튼과 붙도록 */
}

.membership {
width: 136px;
height: 42px;
background-color: #222; color: #fff;
border: none;
cursor: pointer;
margin-right: 0;
font-size: 20px;
}

/* Notice / Q&A 박스 위치 및 스타일 */
.header-help {
position: absolute;
right: -100px;
top: 50px;
display: flex;
flex-direction: column;
align-items: flex-end;
}

.header-help > a {
display: block;
font-size: 24px;
color: #222;
text-decoration: none;
font-weight: 500;
padding: 10px 0;
}

.notice-qa-box {
position: absolute;
top: 45px; right: 0;
width: 80px;
border: 1px solid #222;
background-color: #fff;
display: flex;
flex-direction: column;
align-items: center;
padding: 5px 0;
z-index: 10;
}

.notice-qa-box a {
font-size: 14px;
color: #222;
text-decoration: none;
line-height: 1.5;
margin: 0;
padding: 2px 5px;
font-weight: normal;
}

/* 네비게이션 메뉴 스타일 */
.header-nav {
display: flex;
justify-content: flex-start;
align-items: center;
height: 45px;
position: relative;
padding-bottom: 5px;
}

.header-nav a {
font-size: 30px;
color: #222;
text-decoration: none;
margin-right: 150px;
font-weight: 500;
}

.header-nav a:last-child{
margin-right: 0;
}

.header-nav::after{
content: '';
position: absolute;
bottom: 0;
left: -100px;
right: -100px;
height: 1px;
background-color: #222;
}

/* ---------------------------------------------------- */
/* 공지사항 본문 섹션 스타일 */
/* ---------------------------------------------------- */

.notice-section {
width: 1440px;
margin: 0 auto;
background-color: transparent;
padding-bottom: 100px;
position: relative;
}

.notice-section h2 {
text-align: center;
font-size: 30px;
font-weight: bold;
margin-bottom: 40px;
margin-top: 50px;
}

.notice-header {
width: 968px;
margin: 0 auto;
position: relative;
border-top: 1px solid #222;
padding-top: 20px;
padding-bottom: 20px;
padding-left: 40px;
padding-right: 40p;
box-sizing: border-box;
}

.notice-header::after{
content: "";
display: table;
clear: both;
}

.notice-header h3 { /*부제목*/
font-size: 14px;
font-weight: bold;
color: #222;
font-weight: normal;
margin: 0;
float: left;
width: 60%;
}

.notice-header h3::after{
content: '';
display: block;
width: 100%;
height: 1px;
background-color: #AFAFAF;
margin-top: 10px;
}

.notice-meta {
font-size: 16px;
color: #AFAFAF;
float: right;
width: 40%;
text-align: right;
margin-top: -10px;
padding-bottom: 5px;
border-bottom: 1px solid #AFAFAF;
}

/* 공지사항 내용 상자 영역 */
.notice-content {
width: 888px;
height: 588px;
margin: 0 auto;
padding: 40px;
border: 1px solid #FAF9F6;
background-color: #FAF9F6;
line-height: 1.6;
box-sizing: border-box;
overflow: auto;
margin-top: -1px;
}

.notice-content p {
margin: 0 0 20px 0;
font-size: 16px;
color: #222;
line-height: 1.6;
}

.notice-content strong {
color: #FF0000;
font-weight: bold;
}

/* [시스템 점검 안내] 부분을 위한 스타일링 */
.notice-content p:nth-child(4) { /* 시스템 점검 안내 p 태그 */
margin: 25px 0;
padding: 0;
border: none; /* 내부 구분선 제거 */
}

/* 목록 버튼 */
.back-button-container {
width: 968px;
margin: 0 auto;
padding-top: 32px;
padding-right: 0px;
box-sizing: border-box;
text-align: right;
padding-right: 0;
}

.back-button {
width: 106px;
height: 34px;
border-radius: 14px;
background-color: #fff;
border: 1px solid #222;
cursor: pointer;
font-size: 14px;
}

/* ---------------------------------------------------- */
/* 푸터 스타일 (간단히 구조만 잡음) */
/* ---------------------------------------------------- */
.footer {
width: 1440px;
background-color: #CBD4C2;
padding: 20px 0;
text-align: center;
font-size: 14px;
color: #222;
margin-top: 50px; /* 메인 컨텐츠와의 간격 */
}

.footer p {
margin: 5px 0;
}

.footer-hr {
border: none;
border-top: 1px solid #222;
width: 1317px;
margin: 10px auto;
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
						<img style="width:100%"
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

	<footer>

	</footer>
</body>
</html>