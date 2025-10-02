<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<script src="/js/main.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@12/swiper-bundle.min.css"/>

<script src="https://cdn.jsdelivr.net/npm/swiper@12/swiper-bundle.min.js"></script>
<title>home</title>
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
        padding: 0 120px 60px; 
        line-height: 1;
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

    .hr1 {
        border: none;
        border-top: 1px solid #222222;
        margin-bottom: 0;
        margin-top: 0;
        width: 100%; 
        box-sizing: border-box;
        margin-bottom: 50px;
    }
    main {
        margin-top: 0; 
        padding: 0; 
    }
    .hidden {
        display: none;
    }
	.main-visual figure {
    margin: 0; /* figure의 기본 마진 제거 */
    width: 100%; /* figure가 부모(.main-visual)의 100%를 차지하도록 */
    line-height: 0; /* 이미지 하단에 생길 수 있는 미세한 여백 제거 */
}

.visual-image {
    width: 100%; /* 부모 figure의 100%를 차지하여 hr 선과 동일한 가로 길이 */
    height: auto;
    display: block;
    margin: 0; /* 이미지 자체의 마진은 0으로 설정. hr과의 간격은 main-visual hr에서 조절 */
}
.museum-status {
    text-align: right;
    margin-top: 20px;
    font-size: 20px;
    right: 0;
    margin-bottom: 80;
}

.museum-status p {
    margin: 5px 0;
}

.section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
}
.section-header h2{
    font-size: 20px;
    font-weight: bold;
    
}
		.hr2{
			border: none;
		border-top: 1px solid #222222;
		margin-bottom: 0;
        margin-top: 50px;
        width: 100%; 
        box-sizing: border-box;
		}
		.footer{
	padding: 0px 36px;
	margin-top: 68px;
	border: 1px solid #222222;
	justify-content: left;
	background-color: #CBD4C2;
	color: #222222;
}
.footer{
	padding-left: 36px;
	padding-right: 36px;
	margin-top: 100px;
	border: 1px solid #222222;
	justify-content: left;
	background-color: #CBD4C2;
    font-size: 16px;
}
.footer .address{
	margin-top: 64px;
	margin-bottom: 16px;
}
.footer hr{
	margin-bottom: 28px;
	margin-top: 28px;
	height: 1px;
	border: none;
    border-top: 1px solid #222222;
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
	<main>
		<section class="main-visual">
			<figure>
				<img src="<c:url value='/resources/img/grand.jpg'/>" alt="메인 베너입니다." class="visual-image"/>
				<figcaption class="hidden">할아버지 할머니가 미술관 구경하는 배너</figcaption>
			</figure><hr class="hr2">
			<div class="museum-status">
				<p>open 10:30 a.m.</p>
				<p>close 18:00 p.m.</p>
			</div>
		</section>

		<!-- Swiper -->
	<section class="horizontal-scroll-section exhibitions">
		<div class="section-header">
			<h2>Event</h2>
		</div>

<div #swiperRef="" class="swiper mySwiper">
    <div class="swiper-wrapper">
    <article class="event-card swiper-slide">
				<div class="placeholder">
				</div>
				<figure class="event-1">
					<img src="<c:url value='/resources/img/event1.jpg'/>" alt="전시 1을 넣습니다."/>
					<figcaption class="hidden">포스터 이미지</figcaption>
				</figure>
				<p class="title">오전과 오후 사이</p>
				</article>
				<article class="event-card swiper-slide">
				<div class="placeholder"></div>
				<figure class="event-2">
					<img src="<c:url value='/resources/img/event2.jpg'/>" alt="전시 2를 넣습니다."/>
				</figure>
				<p class="title">도로 위의 밤</p>
				</article>
				<article class="event-card swiper-slide">
				<div class="placeholder"></div>
				<figure class="event-3">
					<img src="<c:url value='/resources/img/event3.jpg'/>" alt="전시 3을 넣습니다."/>
				</figure>
				<p class="title">시선</p>
				</article>
				<article class="event-card swiper-slide">
				<div class="placeholder"></div>
				<figure class="event-4">
					<img src="<c:url value='/resources/img/event4.jpg'/>" alt="전시 4를 넣습니다."/>
				</figure>
				<p class="title">머무를 곳</p>
				</article>

		<section class="calendar-section">
			<div class="section-header">
				<h2>Calendar</h2>
				<div id="calendar"></div>
	<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.19/index.global.min.js"></script>
			<script>
					document.addEventListener('DOMContentLoaded', function() {
			const rawEvents = [
									{title: '회의A', start: '2025-09-17', order: 1, allDay: true },
					{title: '회의B', start: '2025-09-17', order: 2, allDay: true },
					{title: '회의C', start: '2025-09-18', order: 3, allDay: true },
					{title: '점심약속', start: '2025-09-22', order: 1, allDay: true }
							];
						var calendarEl = document.getElementById('calendar');
						var calendar = new FullCalendar.Calendar(calendarEl, {
				
							locale: 'ko', // 한국어 세팅
							initialView: 'dayGridMonth',
							eventOrder: 'order', // 정렬 기준 필드
							eventOrderStrict: true, // 순서 강제 적용
							fixedWeekCount: false, 
							headerToolbar: { // 버튼 위치
									left: 'prev', 
									center: 'title',
									right: 'next',
							},
							height: 'auto', // 높이 자동 조절
							dayCellContent: function(arg) { // 셀(일자) 텍스트 정의
									return {
									html: arg.date.getDate().toString() // '1일' → '1'로 표시
									};
							},
				events: rawEvents, // 이벤트 정의
							dateClick : function(info) { // 날짜 클릭 이벤트
					alert("선택하신 날짜에 일정이 없습니다.");
				},
				eventClick : function(info) { // 이벤트 클릭 이벤트
					alert("선택하신 날짜에 이벤트가 있습니다.");
				}
						});
						calendar.render();
					});
		
			</script>
				<span class="calendar-add">더보기</span>
				
				<span class="notice-label">Notic</span>
			</div>
		</section>
	</main>
<footer class="footer">
		<p class="address">수원시 팔달구 덕영대로 895번길 11</p>
		<p class="call">대표전화. 031-420-4204</p>
		<hr class="footer-hr">
		<p class="other">@jfdfhfksehfkjsnckaul</p>
	</footer>

<!-- Initialize Swiper -->
<script>
    var swiper = new Swiper(".mySwiper", {
    slidesPerView: 3,
    centeredSlides: true,
    spaceBetween: 30,
    pagination: {
        el: ".swiper-pagination",
        type: "fraction",
    },
    navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev",
    },
    });
</script>
</body>


</html>
