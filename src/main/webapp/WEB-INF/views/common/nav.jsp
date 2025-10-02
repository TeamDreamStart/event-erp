<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<script src="/js/main.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet"/>
<title>nav</title>
<style>
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
</body>
</html>