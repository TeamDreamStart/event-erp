<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<script src="/js/main.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet"/>
<title>header</title>
<style>
	@font-face {
    font-family: 'Peristiwa';
    src: url('/resources/font/Peristiwa.otf') format('opentype');
    font-weight: normal;
    font-style: normal;
}
    .header {
        position: relative;
        display: flex;
        flex-direction: column;
        /* header 내부 패딩을 0으로 설정하여 body의 120px 패딩을 내부 컨텐츠의 기준으로 사용 */
        padding: 20px 0 0; 
        min-height: 120px;
        background-color: transparent;
        height: auto;
    }
    .header-top { 
        display: flex; 
        justify-content: space-between; 
        align-items: flex-start; 
        width: 100%; 
        position: static; 
        height: auto;
        padding-bottom: 20px;
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
    font-size: 40px;
}

.header-right {
    display: flex;
    align-items: flex-start;
}

.user-actions {
    display: flex;
    align-items: center;
    position: relative;
    height: 38px;
    font-size: 20px;
}
.mypage-link {
    background-color: #ffffff;
    border: none;
    font-family: 'Montserrat', sans-serif;
    color: #595959;
    cursor: pointer;
    padding: 8px 16px; /* 내부 패딩 */
    border-radius: 0px;
    text-decoration: none;
    margin-right: 10px;
    display: inline-flex;
    justify-content: center; 
    align-items: center;
    min-width: 92px; 
    height: 100%;
    box-sizing: border-box;
    font-size: 16px;
    
}

.mypage-link:hover {
    background-color: #e0e0e0;
}

/* login 버튼 스타일 */
.btn-login {
    text-decoration: none;
    background-color: #222222;
    color: #E5E2DB;
    border: none;
    font-family: 'Montserrat', sans-serif;
    cursor: pointer;
    padding: 8px 16px; /* mypage-link와 동일한 패딩 유지 */
    border-radius: 0px; /* 모서리 각지게 */
    display: inline-flex; /* flex를 사용하여 텍스트 중앙 정렬 및 높이 제어 */
    justify-content: center; /* 텍스트 가로 중앙 정렬 */
    align-items: center; /* 텍스트 세로 중앙 정렬 */
    min-width: 92px; 
    height: 100%; /* 부모 .user-actions의 높이에 맞춤 */
    box-sizing: border-box; /* 패딩과 보더가 너비에 포함 */
    font-size: 16px;
}

.btn-login:hover {
    background-color: #555;
}

    .hr1 {
        border: none;
        border-top: 1px solid #222222;
        margin-bottom: 0;
        margin-top: 0;
        width: 100%; 
        box-sizing: border-box;
        margin-bottom: 50px;
    }
		.header-nav {
        display: flex;
        width: 100%; 
        align-items: center;
        justify-content: space-between; 
        margin-bottom: 12px;
        left: 0;
        font-size: 20px;
    }

    .header-nav a {
        text-decoration: none;
        color: #222222; 
        margin-right: 30px;
        font-weight: 500;
        cursor: pointer;
    }
    .header-nav a:hover{
        color: #08f;
    }

    .header-nav a:last-child {
        margin-right: 0; 
    }

    .dropdown-container {
        position: relative;
        margin-left: auto; 
    }
    /* Help 레이블을 header-nav의 flex 흐름 밖으로 뺌 */
    .help {
        font-size: 20px;
        font-weight: 500;
        color: #222222;
        cursor: pointer;
				user-select: none;
    }
    .menu {
        list-style: none; 
        margin: 0;
        position: absolute;
        /* Help 오른쪽 끝에 정렬 */
        right: 0; 
        top: 100%; 
        background-color: #ffffff; 
        border: 1px solid #ccc; 
        box-shadow: 0 2px 4px rgba(0,0,0,0.1); 
        z-index: 104; 
        display: none; 
        padding-left: 21px;
        padding-bottom: 21px;
        padding-right: 96px;
    }
    
    /* Help 텍스트에 호버 시 메뉴 표시 */
    .dropdown-container:hover .menu{
        display: block;
    }
    
    .menu li {
        padding-top: 25px;
        font-size: 16px;
        color: #222222;
        white-space: nowrap;
        text-align: left;
    }
    .menu li a {
        text-decoration: underline;
    }
    
    .menu a:hover{
        background-color: transparent;
        cursor: pointer;
        color: #08f; 
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
					<a href="/my-info" class="mypage-link">my page</a>
					<a href="/login" class="btn-login">login</a>
				</span>
			</span>
		</div>
			<nav class="header-nav">
				<a href="#">Visit</a>
				<a href="/events">Event</a>
				<a href="/reservations/guest-check">Reservation</a>
                <div class="dropdown-container">
                    <label class="help">Help</label>
                    <ul class="menu">
                        <li><a href="/notices">Notice</a></li>
                        <li><a href="/qna">Q&A</a></li>
                    </ul>
                </div>
            </nav>
            <hr class="hr1">
	</header>
</body>
</html>