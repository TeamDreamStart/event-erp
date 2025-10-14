<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- current -->
<title>Home</title>
<style>
.header-top {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 10px 16px;
	border-bottom: 1px solid #eee
}

.user-actions {
	display: flex;
	gap: 10px;
	align-items: center
}

.btn {
	appearance: none;
	border: 1px solid #222;
	background: #fff;
	cursor: pointer;
	padding: 6px 12px;
	text-decoration: none;
	display: inline-flex;
	align-items: center
}

.btn-primary {
	background: #e9efe6;
	border-color: #a5b49c
}
</style>
</head>
<body>
	<header class="header">
		<div class="header-top">
			<a href="<c:url value='/'/>">D</a>

			<div class="user-actions">
				<!-- 로그인 상태 -->
				<sec:authorize access="isAuthenticated()">
					<span> <strong><sec:authentication
								property="principal.username" /></strong> 님 환영합니다 👋
					</span>
					<a class="btn" href="<c:url value='/myinfo'/>">my info</a>
					<!-- 로그아웃은 POST + CSRF -->
					<form method="post" action="<c:url value='/logout'/>"
						style="margin: 0">
						<sec:csrfInput />
						<button type="submit" class="btn btn-primary">logout</button>
					</form>
				</sec:authorize>

				<!-- 비로그인 상태 -->
				<!-- security사용해야해서 input -> sec -->
				<sec:authorize access="isAnonymous()">
					<a class="btn btn-primary" href="<c:url value='/login'/>">login</a>
					<a class="btn" href="<c:url value='/join'/>">join</a>
				</sec:authorize>
			</div>
		</div>
	</header>

	<article>
		<h1>Hello world!</h1>
		<p>The time on the server is ${serverTime}.</p>
		<!-- 나머지 컨텐츠 그대로 유지 -->
		<a href="/list-test">회원목록 테스트</a> <a href="/board-test">게시판 테스트</a>
		<a href="/admin">어드민페이지</a>
		<a href="/admin/surveys">어드민용 설문조사 리스트</a>
	</article> 
<!-- current end-->

<script src="/js/main.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@12/swiper-bundle.min.css"/>

<script src="https://cdn.jsdelivr.net/npm/swiper@12/swiper-bundle.min.js"></script>
<title>home</title>
<link rel="stylesheet" type="text/css" href="/resources/css/home.css">
<style>
    body {
		background-color: #E5E2DB;
		color: #222222;
		font-family: 'Montserrat', sans-serif;
		font-size: medium;
		margin: 0;
		padding: 0 120px 60px; 
		line-height: 1;
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
    user-select: none;
    cursor: default;
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
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
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
                </div>
    <div class="swiper-button-prev"></div>
    <div class="swiper-button-next"></div>
</div>

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
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
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
