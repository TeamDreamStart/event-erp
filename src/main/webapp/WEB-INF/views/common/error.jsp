<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<script src="<c:url value='/js/main.js'/>"></script>
<link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet"/>
<title>error</title>
<style>
	@font-face {
    font-family: 'Peristiwa';
    src: url('/resources/css/font/Peristiwa.otf') format('opentype');
    font-weight: normal;
    font-style: normal;
}
	body {
		background-color: #E5E2DB;
		color: #222222;
		font-family: 'Montserrat', sans-serif;
		font-size: medium;
		margin: 0;
		padding: 0 120px;;
		line-height: 1;
	}
	.header {
		position: relative;
		display: flex;
		flex-direction: column;
		padding: 20px 120px 0;
		min-height: 120px;
		background-color: transparent;
		height: auto;
	}
	.header-top { 
    display: flex; /* D 로고와 user-actions를 가로로 배치 */
    justify-content: space-between; /* 양 끝으로 밀어냄 */
    align-items: flex-start; /* 상단 정렬 (D 로고와 Membership/Tickets를 상단에 맞춤) */
    width: 100%; /* 부모(header) 너비에 꽉 채움 */
    position: absolute; /* header 내에서 절대 위치 지정 */
    top: 20px; /* header의 상단 패딩과 동일하게 맞춤 */
    left: 50px; /* header의 좌측 패딩과 동일하게 맞춤 */
    width: calc(100% - 100px); /* header의 좌우 패딩을 제외한 너비 */
    height: auto;
}

.header-left {
    /* 로고를 감싸는 역할만 함 */
}
.logo-link {
    text-decoration: none;
    color: inherit;
    display: block;
}

.logo {
    font-family: 'Peristiwa', cursive;
    font-size: 3em;
    /* color는 logo-link에서 inherit 하므로 여기서 변경 필요 없음 */
}

.header-right {
    display: flex;
    align-items: flex-start;
}

.user-actions {
    display: flex;
    align-items: center;
    position: relative;
    /* gap: 10px; /* 버튼 간 간격 추가 - 필요하다면 주석 해제 */
    /* 두 버튼의 높이를 명확하게 지정 (padding 8px + border 1px*2 + 텍스트 높이) */
    height: 38px;
}
.mypage-link {
    background-color: #f8f8f8;
    border: 1px solid #ccc;
    font-family: 'Montserrat', sans-serif;
    font-size: 1.1em;
    color: #333;
    cursor: pointer;
    padding: 8px 15px; /* 내부 패딩 */
    border-radius: 0px; /* 이미지에 맞춰 모서리 각지게 */
    text-decoration: none;
    margin-right: 10px;
    display: inline-flex; /* flex를 사용하여 텍스트 중앙 정렬 및 높이 제어 */
    justify-content: center; /* 텍스트 가로 중앙 정렬 */
    align-items: center; /* 텍스트 세로 중앙 정렬 */
    /* width: 90px; */ /* 정확한 픽셀값보다는 min-width로 유연하게 가져가는 것이 좋습니다. */
    min-width: 90px; /* 내용에 따라 너비가 유동적으로 변하되 최소 너비 보장 */
    height: 100%; /* 부모 .user-actions의 높이에 맞춤 */
    box-sizing: border-box; /* 패딩과 보더가 너비에 포함되도록 */
    
}

.mypage-link:hover {
    background-color: #e0e0e0; /* 호버 시 배경색 변경 */
}

/* login 버튼 스타일 */
.btn-login {
    background-color: #333;
    color: #fff;
    border: none; /* 이미지에 맞춰 테두리 제거 */
    font-family: 'Montserrat', sans-serif;
    font-size: 1.1em;
    cursor: pointer;
    padding: 8px 15px; /* mypage-link와 동일한 패딩 유지 */
    border-radius: 0px; /* 이미지에 맞춰 모서리 각지게 */
    font-weight: 500;
    display: inline-flex; /* flex를 사용하여 텍스트 중앙 정렬 및 높이 제어 */
    justify-content: center; /* 텍스트 가로 중앙 정렬 */
    align-items: center; /* 텍스트 세로 중앙 정렬 */
    /* width: 90px; */ /* 정확한 픽셀값보다는 min-width로 유연하게 가져가는 것이 좋습니다. */
    min-width: 90px; /* mypage-link와 동일한 최소 너비 설정 */
    height: 100%; /* 부모 .user-actions의 높이에 맞춤 */
    box-sizing: border-box; /* 패딩과 보더가 너비에 포함되도록 */
}

.btn-login:hover {
    background-color: #555;
}

.header-nav {
    position: absolute; /* header 내에서 절대 위치 지정 */
    bottom: 20px; /* header의 하단 패딩과 동일하게 맞춤 */
    left: 50px; /* header의 좌측 패딩과 동일하게 맞춤 */
    display: flex;
    width: calc(100% - 100px); /* header의 좌우 패딩을 제외한 너비 */
}

.header-nav a {
    text-decoration: none;
    color: #222222; /* #000 -> #222222 */
    margin-right: 30px;
    font-size: 1.1em;
    font-weight: 500;
		cursor: pointer;
}

.header-nav a:last-child {
    margin-right: 0;
}

main {
    margin-top: none; /* `header-nav`와의 간격을 줄이기 위해 0에서 20px로 수정 */
}
.error-main .hr1 {
    border: none;
    border-top: 1px solid #ccc;
    margin-bottom: 32px; /* `visual-image`와의 간격을 늘리기 위해 0에서 30px로 수정 */
    width: 100%;
}
.error-main {
		text-align: center;
}
.error-text h1{
	font-size: bold 3em;
}
.footer{
	padding-left: 36px;
	padding-right: 36px;
	border: 1px solid #222222;
	justify-content: left;
	background-color: #CBD4C2;
}
.footer .address{
	margin-top: 64px;
	margin-bottom: 16px;
}
.footer hr{
	margin-bottom: 28px;
	margin-top: 28px;
	height: 1px;
		width: 100%;
}
.footer .other{
	margin-bottom: 28px;
}
</style>
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
			</nav>
	</header>
<main>
	<div class="error-main">
		<hr class="hr1">
		<div class="error-text">
			<h1>Oops!</h1>
			<p>오류 페이지입니다.</p>
			<p>잘못된 접근입니다. 이전으로 돌아가세요.</p>
		</div>
		<article class="error-img">
			<img id="error-icon" src="/resources/img/error.png" alt="오류 아이콘">
			<button onclick="history.back()" id="btn-back">이전으로</button>
		</article>
	</div>
</main>
<footer class="footer">
		<p class="address">수원시 팔달구 덕영대로 895번길 11</p>
		<p class="call">대표전화. 031-420-4204</p>
		<hr class="footer-hr">
		<p class="other">@jfdfhfksehfkjsnckaul</p>
	</footer>
</body>
</html>