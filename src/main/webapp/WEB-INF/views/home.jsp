<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page session="false"%>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css"/>
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<link href="<c:url value='/resources/css/home.css'/>" rel="stylesheet" type="text/css"/>
<script src="<c:url value='/js/main.js'/>"></script>
<link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet"/>
<title>Home</title>
</head>
<body>  
	<header class="header">
		<div class="header-top">
		<span class="header-left">
			<a href="/" class="logo-link"><span class="logo">D</span></a>
			</span>
			<span class="header-right">
				<span class="user-actions">
					<button class="membership">Membership
						<li>
							<a href="#">로그인</a>
							<a href="#">로그아웃</a>
							<a href="#">회원가입</a>
						</li>
					</button>
					<a href="#">Tickets</a>
				</span>
			</span>
		</div>
			<nav class="header-nav">
				<a href="#">Visit</a>
				<a href="#">Exhibitions</a>
				<a href="#">Store</a>
			</nav>
	</header>
	<main>
		<section class="main-visual">
			<hr>
			<figure>
				<img src="<c:url value='/resources/img/grand.jpg'/>" alt="메인 베너입니다." class="visual-image"/>
				<figcaption class="hidden">할아버지 할머니가 미술관 구경하는 배너</figcaption>
			</figure><hr>
			<div class="museum-status">
				<p>open 10:30 a.m.</p>
				<p>close 18:00 p.m.</p>
			</div>
		</section>

		<!-- Swiper -->
	<section class="horizontal-scroll-section exhibitions">
		<div class="section-header">
			<h2>Exhibitions</h2>
		</div>

  <div #swiperRef="" class="swiper mySwiper">
    <div class="swiper-wrapper">
      <article class="exhibition-card swiper-slide">
				<div class="placeholder">
				</div>
				<figure class="exhibition-1">
					<img src="<c:url value='/resources/img/ham.jpg'/>" alt="햄스터 이미지를 넣습니다."/>
					<figcaption>귀여운 햄쥐기 이미지</figcaption>
				</figure>
				<p class="title">전시1</p>
				</article>
				<article class="exhibition-card swiper-slide">
				<div class="placeholder"></div>
				<figure class="exhibition-2">
					<img src="<c:url value='/resources/img/ham1.jpg'/>" alt="햄스터 이미지1를 넣습니다."/>
				</figure>
				<p class="title">전시2</p>
				</article>
				<article class="exhibition-card swiper-slide">
				<div class="placeholder"></div>
				<figure class="exhibition-3">
					<img src="<c:url value='/resources/img/ham2.jpg'/>" alt="햄스터 이미지2를 넣습니다."/>
				</figure>
				<p class="title">전시3</p>
				</article>
				<article class="exhibition-card swiper-slide">
				<div class="placeholder"></div>
				<figure class="exhibition-4">
					<img src="<c:url value='/resources/img/ham3.jpg'/>" alt="햄스터 이미지3를 넣습니다."/>
				</figure>
				<p class="title">전시4</p>
				</article>
				<article class="exhibition-card swiper-slide">
				<div class="placeholder"></div>
				<figure class="exhibition-5">
					<img src="<c:url value='/resources/img/ham4.jpg'/>" alt="햄스터 이미지4를 넣습니다."/>
				</figure>
				<p class="title">전시5</p>
				</article>
				<article class="exhibition-card swiper-slide">
				<div class="placeholder"></div>
				<a href="#"><figure class="exhibition-6">
					<img src="<c:url value='/resources/img/ham5.jpg'/>" alt="햄스터 이미지를 넣습니다."/>
				</figure></a>
				<p class="title">전시6</p>
				</article>
    </div>
    <div class="swiper-button-prev"></div>
    <div class="swiper-button-next"></div>
  </div>

  <!-- <p class="append-buttons">
		<button class="prepend-2-slides">Prepend 2 Slides</button>
    <button class="prepend-slide">Prepend Slide</button>
    <button class="append-slide">Append Slide</button>
    <button class="append-2-slides">Append 2 Slides</button>
  </p> -->

  <!-- Swiper JS -->
  <!-- <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script> -->

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
		<h1>Contacts</h1>
		<address class="footer-address">
      수원시 팔달구 덕영대로 899번길 11
    </address>
      <div class="footer-phone">
        대표전화: 031-420-4204
      </div>
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
