<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/common.css'/>">
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700;900&display=swap" rel="stylesheet"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@12/swiper-bundle.min.css"/>
<link href="https://fonts.cdnfonts.com/css/peristiwa" rel="stylesheet">
<title>eventList</title>
<style>
body {
background-color: #E5E2DB;
color: #222222;
font-family: 'Montserrat', sans-serif;
font-size: medium;
font-weight: normal;
margin: 0;
padding: 0 120px 60px; 
line-height: 1;
}
main {
margin-top: 0; 
padding: 0; 
}
.main-event-container {
display: flex; /* 자식 요소(텍스트, 포스터)를 가로로 배치 */
align-items: center; /* 세로 중앙 정렬 */
justify-content: space-between; /* 양쪽 끝으로 배치 */
padding: 0px 140px 0px 140px; /* 내부 여백 */
margin-bottom: 110px; /* 아래쪽 섹션과의 간격 */
}

/* 왼쪽 텍스트 영역 */
.main-event-content {
flex-basis: 60%; /* 전체 컨테이너 너비의 55% 할당 */
color: #222222;
}

.main-event-content h1 {
font-size: 80px;
font-weight: 900;
margin: 0;
line-height: 1;
}

.main-event-content h2 {
font-size: 50px;
font-weight: 900;
margin: 10px 0 20px;
line-height: 1;
}

.main-event-content p {
font-size: 20px;
margin: 8px 0;
line-height: 1.2;
font-weight: 900;
}

/* 오른쪽 포스터 영역 */
.main-event-poster {
flex-basis: 35%; /* 전체 컨테이너 너비의 35% 할당 */
display: flex;
justify-content: center; /* 포스터를 중앙 정렬 */
}

.main-event-poster img {
max-width: 52%; 
height: auto;
border: 32px solid #ff5733; 
display: block;
}
.hidden {
display: none;
}
.event-section{
margin-bottom: 100px;
}
.content-container {
max-width: 100%;
margin: 0 auto;
}

.section-header {
display: flex;
justify-content: space-between; 
align-items: center;
margin-bottom: 30px;
padding-top: 40px; 
}

.section-header h2{
font-size: 20px; 
font-weight: bold;
margin: 0 auto 0 0;
user-select: none;
}

.category-filter {
font-size: 16px;
display: flex;
align-items: center;
position: relative;
cursor: pointer;
padding-right: 20px;
caret-color: transparent;
margin-right: 20px;
}

.dropdown-arrow {
position: absolute;
right: 0;
top: 50%;
transform: translateY(-50%) rotate(45deg);
width: 3px;
height: 3px;
border-right: 2px solid #222222;
border-bottom: 2px solid #222222;
pointer-events: none;
transition: transform 0.2s ease;
}

.category-filter.active .dropdown-arrow {
transform: translateY(-50%) rotate(-135deg);
}

.category-dropdown-menu {
position: absolute;
top: 100%;
right: 0;
list-style: none;
padding: 5px 0 0 0;
margin: 0;
background-color: #ffffff; 
border: 1px solid #ccc; 
box-shadow: 0 2px 5px rgba(0,0,0,0.1);
min-width: 120px;
z-index: 1000;
opacity: 0;
visibility: hidden;
transform: translateY(10px);
transition: opacity 0.2s ease, transform 0.2s ease, visibility 0.2s;
}

.category-filter.active .category-dropdown-menu {
opacity: 1;
visibility: visible;
transform: translateY(0);
}

.category-dropdown-menu li {
padding: 0 21px;
margin-top: 10px;
cursor: pointer;
color: #222222;
white-space: nowrap;
text-decoration: underline;
}
.category-dropdown-menu li:first-child{
margin-top: 0;
}
.category-dropdown-menu li:last-child{
padding-bottom: 21px;
}

.category-dropdown-menu li:hover {
color: #08f;
background-color: transparent;
}

.horizontal-scroll-section.events-swiper {
margin-bottom: 110px;
}

.event-card {
text-align: center;
}

.event-card figure {
margin: 0;
width: 100%;
height: auto; 
line-height: 0;
overflow: hidden;
position: relative;
}

.event-card figure img {
width: 100%;
height: auto; 
display: block;
border: none;
user-select: none;
cursor: default;
caret-color: transparent;
}

.event-card .title {
margin-top: 15px;
font-size: 16px;
font-weight: 500;
line-height: 1.4;
}

.swiper-nav-controls {
display: flex;
align-items: center;
gap: 10px;
position: relative;
}

.swiper-button-next, .swiper-button-prev {
position: static !important;
transform: none !important;
margin: 0;
width: 20px;
height: 20px;
font-size: 10px;
color: #222222 !important;
}

.swiper-button-prev:after {
font-size: 10px;
}
.swiper-button-next:after {
font-size: 10px;
}

.event-info-overlay {
position: absolute;
top: 0;
left: 0;
width: 100%;
height: 100%;
background-color: rgba(34, 34, 34, 0.7);
color: #FAF9F6;
display: flex;
flex-direction: column;
justify-content: center;
align-items: center;
opacity: 0;
transition: opacity 0.3s ease;
text-align: center;
cursor: pointer;
padding: 20px; 
box-sizing: border-box;
text-decoration: none;
}

.event-card figure:hover .event-info-overlay {
opacity: 1; 
}

.event-card figure:hover img {
filter: brightness(0.6); 
}

.event-info-content {
max-width: 90%;
display: flex;
flex-direction: column;
gap: 10px; 
padding: 10px; 
}

.event-title {
font-size: 20px; 
font-weight: bold;
margin: 0;
line-height: 1.2;
}

.event-start-date, .event-location {
font-size: 16px;
margin: 0;
margin-top: 20px;
}

.detail-btn {
display: inline-block;
margin-top: 8px;
padding: 10px 4px;
background-color: #FAF9F6;
color: #222222;
text-decoration: none;
font-size: 14px;
border-radius: 3px;
transition: background-color 0.2s;
caret-color: transparent;
}

.detail-btn:hover {
background-color: rgba(255, 255, 255, 0.2);
}

/* ------------------ Next Event 섹션 수정된 CSS ------------------ */
.next-event-grid {
display: flex;
justify-content: center; /* 왼쪽 정렬 유지 */
text-align: left;
}

.next-event-card-container {
display: flex;
height: 350px; 
width: 800px; /* 카드의 전체 너비를 이미지에 맞춰 조정 */
background-color: #FAF9F6; /* 텍스트 영역 배경색 (이미지의 흰색 영역) */
color: #222222;
box-sizing: border-box;
overflow: hidden;
}

.next-event-text {
flex-grow: 1; 
padding: 60px 50px; 
display: flex;
flex-direction: column;
justify-content: flex-start;
}

.next-event-text .status-text {
font-size: 32px; 
font-weight: 700;
margin-bottom: 30px;
margin-top: 0;
}

.next-event-text .event-title {
font-size: 24px;
font-weight: 700;
margin: 0 0 10px 0;
}

.next-event-text .event-date {
font-size: 20px;
font-weight: 400;
color: #777; 
margin: 0;
}

.next-event-poster-placeholder {
width: 350px; /* 포스터 영역의 고정 너비 */
height: 100%;
background-color: #553333; 
/* 포스터가 있다면 아래 주석을 해제하고 경로를 지정하세요 */
/* background-image: url('/resources/img/poster-image.jpg'); 
background-size: cover;
background-position: center; */
position: relative;
}

/* COMING SOON 오버레이 */
.next-event-poster-placeholder::after {
content: "COMMING\A SOON"; /* \A는 강제 줄바꿈 */
white-space: pre;
position: absolute;
top: 0;
left: 0;
width: 100%;
height: 100%;
background-color: rgba(0, 0, 0, 0.4); 
color: #ffffff;
font-size: 40px;
font-weight: 900;
display: flex;
justify-content: center;
align-items: center;
text-align: center;
line-height: 1.1;
}

</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<main>
<div class="content-container">
<section class="event-section present-event horizontal-scroll-section events-swiper">

<div class="main-event-container">
<div class="main-event-section">
<h1>EVENT</h1>
<h2>Recommendation</h2>
<br>
<p>가을 밤, 음악에 물들다!</p>
<p>올림픽공원에서</p>
<p>특별한 페스티벌을 즐겨보세요!!</p>
</div>
<div class="main-event-poster">
<img src="/resources/img/event1.jpg" alt="가을 음악 페스티벌 포스터" />
</div>
</div>

<div class="section-header">
<h2>Present Events</h2>

<div class="category-filter">
Category <span class="dropdown-arrow"></span>
<ul class="category-dropdown-menu">
<li data-value="all" class="selected">Show</li>
<li data-value="workshop">Workshop</li>
<li data-value="speech">Speech</li>
<li data-value="market">Market</li>
</ul>
</div>

<div class="swiper-nav-controls">
<div class="swiper-button-prev"></div>
<div class="swiper-button-next"></div>
</div>

</div>

<div class="swiper mySwiper">
<div class="swiper-wrapper">
<!-- <c:choose> -->
<!-- <c:when test="${empty eventList}"> -->
<!-- <div class="swiper-slide" style="width: 100%; text-align: center; padding: 50px 0;">
<p>진행 중인 이벤트 게시글이 없습니다.</p>
</div> -->
<!-- </c:when> -->
<!-- <c:otherwise> -->
<!-- <c:forEach var="eventDTO" items="${eventList}"> -->
<!-- <c:if test="${eventDTO.visibility eq 'PUBLIC'}"> -->
<article class="event-card swiper-slide">
<figure class="event-card-figure">
<img src="/resources/img/event1.jpg" alt="가을 음악 페스티벌 포스터"/>
<figcaption class="hidden">포스터 이미지</figcaption>
<a href="#" class="event-info-overlay">
<div class="event-info-content">
<h3 class="event-title">가을 음악 페스티벌</h3>
<p class="event-start-date">2024-10-15</p>
<p class="event-location">서울숲</p>
<div class="detail-btn">더보기</div>
</div>
</a>
</figure>
</article>
<article class="event-card swiper-slide">
<figure class="event-card-figure">
<img src="/resources/img/event2.jpg" alt="사내 워크숍 포스터"/>
<figcaption class="hidden">포스터 이미지</figcaption>
<a href="#" class="event-info-overlay">
<div class="event-info-content">
<h3 class="event-title">사내 워크숍</h3>
<p class="event-start-date">2024-10-20</p>
<p class="event-location">양평 리조트</p>
<div class="detail-btn">더보기</div>
</div>
</a>
</figure>
</article>
<article class="event-card swiper-slide">
<figure class="event-card-figure">
<img src="/resources/img/event3.jpg" alt="개발자 컨퍼런스 포스터"/>
<figcaption class="hidden">포스터 이미지</figcaption>
<a href="#" class="event-info-overlay">
<div class="event-info-content">
<h3 class="event-title">개발자 컨퍼런스</h3>
<p class="event-start-date">2024-11-01</p>
<p class="event-location">COEX</p>
<div class="detail-btn">더보기</div>
</div>
</a>
</figure>
</article>
<article class="event-card swiper-slide">
<figure class="event-card-figure">
<img src="/resources/img/event4.jpg" alt="봄 플리마켓 포스터"/>
<figcaption class="hidden">포스터 이미지</figcaption>
<a href="#" class="event-info-overlay">
<div class="event-info-content">
<h3 class="event-title">봄 플리마켓</h3>
<p class="event-start-date">2025-04-05</p>
<p class="event-location">어반 스퀘어</p>
<div class="detail-btn">더보기</div>
</div>
</a>
</figure>
</article>
<article class="event-card swiper-slide">
<figure class="event-card-figure">
<img src="/resources/img/event1.jpg" alt="추가 이벤트 포스터"/>
<figcaption class="hidden">포스터 이미지</figcaption>
<a href="#" class="event-info-overlay">
<div class="event-info-content">
<h3 class="event-title">추가 이벤트</h3>
<p class="event-start-date">2025-05-01</p>
<p class="event-location">새로운 장소</p>
<div class="detail-btn">더보기</div>
</div>
</a>
</figure>
</article>
<article class="event-card swiper-slide">
<figure class="event-card-figure">
<img src="/resources/img/event2.jpg" alt="추가 이벤트 포스터"/>
<figcaption class="hidden">포스터 이미지</figcaption>
<a href="#" class="event-info-overlay">
<div class="event-info-content">
<h3 class="event-title">추가 이벤트</h3>
<p class="event-start-date">2025-05-01</p>
<p class="event-location">새로운 장소</p>
<div class="detail-btn">더보기</div>
</div>
</a>
</figure>
</article>
<!-- </c:if> -->
<!-- </c:forEach> -->
<!-- </c:otherwise> -->
<!-- </c:choose> -->
</div>
</div>

</section>

<section class="event-section next-event">
<div class="section-header">
<h2>Next Event</h2>
</div>
<div class="next-event-grid">
<div class="next-event-card next-event-card-container">
<div class="next-event-text">
<p class="event-title">Spring Flea Market</p>
<p class="event-date">2025/10/08</p>
</div>
<div class="next-event-poster-placeholder">
</div>
</div>
</div>
</section>
</div>
</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/swiper@12/swiper-bundle.min.js"></script>
<script>
$(document).ready(function() {
$('.category-filter').on('click', function(event) {
$(this).toggleClass('active');
event.stopPropagation();
});

$('.category-dropdown-menu li').on('click', function() {
var selectedValue = $(this).data('value');

$(this).closest('.category-dropdown-menu').find('li').removeClass('selected');
$(this).addClass('selected');

$('.category-filter').removeClass('active');

console.log("선택된 카테고리:", selectedValue);
});

$(document).on('click', function(event) {
if (!$(event.target).closest('.category-filter').length) {
$('.category-filter').removeClass('active');
}
});

var swiper = new Swiper(".mySwiper", {
slidesPerView: 5, 
centeredSlides: false, 
spaceBetween: 50, 
navigation: {
nextEl: ".swiper-nav-controls .swiper-button-next",
prevEl: ".swiper-nav-controls .swiper-button-prev",
},
breakpoints: {
768: {
slidesPerView: 4,
spaceBetween: 40,
},
1024: {
slidesPerView: 5,
spaceBetween: 50,
}
}
});
});
</script>
</body>
</html>