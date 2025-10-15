<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://www.dafont.com/peristiwa.font" rel="stylesheet"> 
		<link href="https://fonts.google.com/specimen/Montserrat" rel="stylesheet"> 
		<link rel="stylesheet" href="/webapp/resources/css/noticeList.css">

      <style>
.body{
        font-family: 'Montserrat';
        color: #222;
        font-size: 16px;
        margin: 0;
        padding: 0;
        line-height: 1.6;
        background-color:#E5E2DB ;
}

a{
    text-decoration: none;
    color: inherit;
}

h1,h2,h3 .header a, .header-nav a{
    font-weight: 300; 
}

/*헤더 스타일*/

.header{
   padding: 25px;
   padding-bottom: 25px;
   background-color: #F5F5F5;
}
  

.header-top{
    display: flex;
    justify-content: space-between;
    align-items: flex-start; /*로고와 우측 액션을 상단 정렬*/
    position: relative;
    margin-bottom: 30px;
}

.header-left{
    display: flex;
    flex-direction: column;
}

.logo-link{
    font-family: 'peristiwa';
    font-size: 64px;
    color: #222;
    font-weight: 300;
    letter-spacing: -2px;
    padding-bottom: 25px;  /*네비게이션과의 간격*/
}

.header-right{
    display: flex;
    align-items: center;
    position: absolute;  /*절대 위치로 우측 상단에 고정*/
    top: 0;
    right: 40px;
    font-size: 20px;
    padding-top: 10px;
}


/*로그인 버튼 스타일*/
.user-action{  
       display: flex;
    align-items: center;
}

.user-actions > a {
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
   .header-nav{
    display: flex;
    gap: 40px;
    font-size: 30px;
    font-weight: 300;
    padding-left: 20px;
}

.header-nav a{
    padding-bottom: 10px;
    transition: color 0.2s;
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

.notice-qa-box{
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

.notice-qa-box a{
    display: block;
    padding: 3px 0;
}


/*메인 콘텐츠 notice 섹션*/
main{
    max-width: 1200px;
    margin: 0 auto;
    padding-top: 30px;
    position: relative;
    background-color: #FAF9F6;
    padding-bottom: 80px;
}

.notice-section{
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 40ox;  /*좌우 여백*/
}

.notice-section h2{
    font-size: 30px;
    margin-bottom: 50px;
    text-align: center;
    border-bottom: none;
    padding-bottom: 5px;
    font-weight: bold;
}


/*공지 제목과 메타 정보*/
.notice-header{
    max-width: 800px;
    border-bottom: 1px solid #222;
    padding-bottom: 10px;
    margin-bottom: 20px;
}

.notice-header h3{
    font-size: 14px;
    font-weight: 400;
    margin: 0;
}

.notice-meta{
    font-size: 16px;
    color: #AFAFAF;
    text-align: right;
    margin-top: 5px;
}


/*공지 내용 박스*/
.notice-content{
    max-width: 800px;
    margin: 0 auto;
    padding: 30px;
    background-color: #F5F5F5;
    border: 1px solid #222;
}

.notice-content p{
    margin: 15px 0;
    font-size: 14px;
    line-height: 1.8;
}

.notice-content strong{
    color: red; /*점검 시간은 빨간색으로 강조*/
    font-weight: 600;
}

.nav-links-container{
    margin-top: 40px; /* 공지 상자와의 간격 */
    padding: 0; 
    border-top: 2px solid #ddd; /* 상단 구분선 */
    border-bottom: 2px solid #ddd; /* 하단 구분선 */
    background-color: #FAF9F6; /* 배경색 */
}

/* 테이블 레이아웃을 사용하여 디자인 구현 */
.nav-table {
    width: 100%;
    border-collapse: collapse; 
    font-size: 15px;
}

.nav-table tr {
    /* 첫 번째 행 아래에만 얇은 구분선 */
    border-bottom: 1px solid #eee;
}

.nav-table tr:last-child {
    border-bottom: none;
}

.link-label-cell {
    /* 라벨 셀 스타일 */
    width: 80px; 
    font-weight: 500; 
    color: #555;
    padding: 15px 0;
    text-align: center;
    vertical-align: middle;
    background-color: #f7f7f7; /* 라벨 배경색 */
    border-right: 1px solid #eee; /* 라벨과 제목 사이 구분선 */
    /* .notice-section에 20px 패딩이 있으므로, 여기서도 20px 보정 */
    padding-left: 20px; 
    padding-right: 20px;
}

.link-title-cell {
    /* 제목 셀 스타일 */
    padding: 15px 20px;
    width: auto;
}

.link-title a{
    color: #555; 
    transition: color 0.2s, text-decoration 0.2s;
    /* 제목이 길어져도 한 줄로 처리 */
    display: block;
    overflow: hidden;
    text-overflow: ellipsis; 
    white-space: nowrap; 
    font-weight: 400;
}

.link-title a:hover{
    color: #2980B9;
    text-decoration: underline;
}

/*목록 버튼*/
.back-button-container{
    max-width: 800px;
    margin: 30px auto 0 auto;
    text-align: right;
} 

.back-button{
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

.back-button:hover{
    background-color: #FAF9F6;
}

.nav-links-container{
    max-width: 800px;
    margin: 30px auto 0 auto;
    border-top: 1px solid #222; /* 구분선 */
    font-size: 14px;
}

.nav-link-item{
    display: flex;
    padding: 10px 0;
    border-bottom: 1px solid #ddd; /* 각 항목 구분선 */
    align-items: center;
}

.nav-link-item:last-child{
    border-bottom: none; /* 마지막 항목의 하단선 제거 */
}

.link-label{
    width: 60px; /* 라벨 너비 고정 */
    font-weight: 600;
    color: #222;
    padding-right: 15px;
    box-sizing: border-box;
    text-align: left;
}

.link-title a{
    color: #555;
    transition: color 0.2s;
    overflow: hidden;
    text-overflow: ellipsis; /* 텍스트가 길 경우 ... 처리 */
    white-space: nowrap; /* 줄바꿈 방지 */
    display: block;
    max-width: 700px; /* 제목 최대 너비 */
}

.link-title a:hover{
    color: #000;
    text-decoration: underline;
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