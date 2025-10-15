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

/*헤더 상단(로고,mypage, login)*/
.header-top {   
    display: flex;
    justify-content: space-between; /* mypage, login 쪽을 오른쪽으로 */
    align-items: center;
    padding-top: 30px; /* 상단 여백 조정 */
    padding-bottom: 10px;
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


/*mtpage, login, help버튼 그룹*/
.header-right {
    display: flex;
    align-items: center;
    font-size: 16px;
    position: relative;
}

/*mypage 버튼 스타일*/
.header-right a {
    color: #222;
    text-decoration: none;
    margin-right: 0;
    padding: 8px 15px;
    background-color: #FFFFFF;
    /*border: 1px solid #FFFFFF;*/
}

.membership {
    width: 80px;
    height: 34px;
    border: none;
    padding: 5px 15px;
    border-radius: 5px;
    margin-right: 0px;
    font-weight: bold;
    background-color: #222;
    color: #FFFFFF;
    cursor: pointer;
}

/* Notice / Q&A 박스 위치 및 스타일 */
.header-help {
    position: absolute;
    right: 0;
    top: 50px;
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    font-size: 30px;
    font-weight: 500;
}

.header-help > a { /* 'Help' 텍스트 숨김 (피그마에 없는 요소이므로) */
    display: block;
    font-size: 24px;
    color: #333;
    text-decoration: none;
    font-weight: 500;
    margin-right: 0;
    position: relative;
    top: 0; /* nav 라인에 수직 정렬을 위해 0으로 설정 */
    padding: 10px 0; /* 네비게이션 항목과 비슷한 여백을 줘서 높이 맞추기 */
}

.notice-qa-box {
    position: absolute;
    top: 30px; /* login 버튼 라인 아래로 위치 조정 */
    right: 0;
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    font-size: 16px;
    line-height: 1.5;
}

.notice-qa-box a {
    margin-left: 0;
}

/* 네비게이션 메뉴 스타일 */
.header-nav {
    display: flex;
    justify-content: space-between;
    align-items: center;
    height: 45px;
    position: relative;
    padding-bottom: 5px;
    width: 100%;
}

.header-nav a {
    font-size: 30px;
    font-weight: 500;
    color: #222;
    text-decoration: none;
    margin-right: 0;
    width: 150px;
    text-align: left;
}

/* ---------------------------------------------------- */
/* 공지사항 본문 섹션 스타일 */
/* ---------------------------------------------------- */
.notice-section {
    width: 100%;
    max-width: 1440px;
    margin: 0 auto;
    background-color: transparent;
    padding-bottom: 100px;
}

.notice-section h2 {
    text-align: center;
    font-size: 30px;
    font-weight: bold;
    margin-bottom: 40px;
    margin-top: 50px;
}

.notice-header {
    width: 888px;
    margin: 0 auto;
    text-align: center;
    border-top: 1px solid #222;
    padding-top: 26px;
    padding-left: 40px;
    padding-right: 40px;
    box-sizing: border-box;
}


.notice-header h3 {
    font-size: 14px;
    color: #222;
    font-weight: normal;
    margin-bottom: 10px;
    text-align: left;
}

.notice-meta {
    font-size: 16px;
    color: #AFAFAF;
    text-align: right;
    margin-bottom: 20px;
}

/* 공지사항 내용 상자 영역 */
.notice-content {
    width: 888px; 
    height: 588px;
    margin: 0 auto;
    padding: 40px;
    background-color: #FAF9F6;
    box-shadow: 0 2px 5px rgba(0,0,0,0.05);
    line-height: 1.6;
    box-sizing: border-box;
    overflow: auto;
}

.notice-content p {
    margin: 0 0 15px 0;
    font-size: 16px;
    color: #222;
}

.notice-content strong {
    font-weight: bold;
}

/* [시스템 점검 안내] 부분을 위한 스타일링 */
.notice-content p:nth-child(4) { /* 시스템 점검 안내 p 태그 */
    padding-top: 20px;
    padding-bottom: 20px;
    border-top: 1px solid #AFAFAF; /* 2. 첫 번째 줄 색상: AFAFAF */
    border-bottom: 1px solid #AFAFAF; /* 2. 두 번째 줄 색상: AFAFAF */
    margin-top: 20px;
    margin-bottom: 20px;
}

/* 목록 버튼 */
.back-button-container {
    width: 968px;
    margin: 0 auto;
    padding-top: 32px;
    padding-right: 0px;
    box-sizing: border-box;
    text-align: right;
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
    width: 200px;
    margin: 10px auto;
} 

      </style>

<title>noticedetail</title>
</head>
<body>
	<header class="header">
    <div class="header-top">
        <span class="header-left">
            <a href="/" class="logo-link"><span class="logo">D</span></a>
        </span>
        <span class="header-right">
            <a href="#">mypage</a>
            <button class="membership">login</button>
            <div class="header-help">
                <a href="#">Help</a>
                <div class="notice-qa-box">
                    <a href="#">Notice</a>
                    <a href="#">Q&A</a>
                </div>
            </div>
        </span>
        </div>
    <nav class="header-nav">
        <a href="#">Visit</a>
        <a href="#">Event</a>
        <a href="#">Reservation</a>
    </nav>
</header>
   <main>
		<section class="notice-section">
			<h2>Notice</h2>
			<div class="notice-header">
				<h3>9/26(금) 새벽 2시~4시 30분 시스템 점검 안내</h3>
				<div class="notice-meta">
					<span>등록일자: 2025-09-21</span> | <span>조회: 2,964</span>
				</div>
			</div>
			<div class="notice-content">
				<p>안녕하세요. D입니다.</p>
				<p>항상 D를 이용해주시는 회원 여러분들께 감사의 말씀을 드립니다.</p>
				<p>D는 안정적인 서비스 제공을 위해 아래와 같이 시스템 업그레이드 및 점검 작업을 진행합니다.<br>작업 시간 동안 사이트 접속이 일시적으로 제한될 수 있으니 양해 부탁드립니다. </p>
				<p>[시스템 점검 안내]<br>일시: <strong>2025년 9월 26일(금) 새벽 02:00 ~ 04:30 (약 2시간 30분)</strong><br>내용: 시스템 점검에 따른 일시적 사이트 접속 제한</p>
				<p>빠른 시간 내에 점검을 오나료하여 정상적인 서비스 이용이 가능하도록 하겠습니다.<br>D는 항상 회원 여러분들의 편의와 서비스 품질 향상을 위해 최선을 다하겠습니다.</p>
				<p>감사합니다.</p>
			</div>
			<div class="back-button-container">
				<button class="back-button">목록</button>
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