<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@12/swiper-bundle.min.css"/>
<title>eventList</title>
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
font-size: 20px; /* 요청하신 20px로 변경 */
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
width: 8px;
height: 8px;
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
    margin-bottom: 60px;
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
    width: 30px;
    height: 30px;
    font-size: 16px;
    color: #222222 !important;
}

.swiper-button-prev:after {
    font-size: 16px;
}
.swiper-button-next:after {
    font-size: 16px;
}

.event-info-overlay {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(34, 34, 34, 0.7);
    color: #ffffff;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    opacity: 0;
    transition: opacity 0.3s ease;
    text-align: center;
    cursor: pointer;
    padding: 20px; /* 오버레이 전체 패딩은 유지 */
    box-sizing: border-box;
}

.event-card figure:hover .event-info-overlay {
    opacity: 1; 
}

.event-card figure:hover img {
    filter: brightness(0.6); 
}

.event-info-content {
    max-width: 90%;
    display: flex; /* 내부 요소들을 flex로 정렬하여 간격 조정 용이 */
    flex-direction: column;
    gap: 8px; /* 내부 요소들 간의 간격 (h3, p, p, div) */
    padding: 10px; /* content 자체의 내부 패딩 */
}

.event-title {
    font-size: 20px; /* 요청하신 20px로 변경 */
    font-weight: bold;
    margin: 0; /* flex 컨테이너 내부이므로 margin은 0으로 */
    line-height: 1.2;
}

.event-start-date, .event-location {
    font-size: 16px; /* 요청하신 16px로 변경 */
    margin: 0; /* flex 컨테이너 내부이므로 margin은 0으로 */
}

.detail-btn {
    display: inline-block;
    margin-top: 8px; /* 폰트 크기 변경에 따른 위쪽 마진 조정 */
    padding: 6px 16px;
    border: 1px solid #ffffff;
    color: #ffffff;
    text-decoration: none;
    font-size: 14px; /* 요청하신 14px로 변경 */
    border-radius: 3px;
    transition: background-color 0.2s;
    user-select: none;
}

.detail-btn:hover {
    background-color: rgba(255, 255, 255, 0.2);
}

.next-event-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 25px;
    text-align: left;
}

.next-event-card {
    color: #222222;
    height: 350px;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 24px;
    background-color: #FAF9F6;
		width: 70%;
}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<main>
<div class="content-container">
<section class="event-section present-event horizontal-scroll-section events-swiper">
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
    <%-- <c:choose> --%>
    <%-- <c:when test="${empty eventList}"> --%>
        <%-- <div class="swiper-slide" style="width: 100%; text-align: center; padding: 50px 0;">
            <p>진행 중인 이벤트 게시글이 없습니다.</p>
        </div> --%>
    <%-- </c:when> --%>
    <%-- <c:otherwise> --%>
        <%-- <c:forEach var="eventDTO" items="${eventList}"> --%>
            <%-- <c:if test="${eventDTO.visibility eq 'PUBLIC'}"> --%>
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
                    <p class="title">가을 음악 페스티벌</p>
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
                    <p class="title">사내 워크숍</p>
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
                    <p class="title">개발자 컨퍼런스</p>
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
                    <p class="title">봄 플리마켓</p>
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
                    <p class="title">추가 이벤트</p>
                </article>
            <%-- </c:if> --%>
        <%-- </c:forEach> --%>
    <%-- </c:otherwise> --%>
    <%-- </c:choose> --%>
    </div>
</div>

</section>

<section class="event-section next-event">
<div class="section-header">
<h2>Next Event</h2>
</div>
<div class="next-event-grid">
<div class="next-event-card">
To be continue . . .
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
        slidesPerView: 4, 
        centeredSlides: false, 
        spaceBetween: 25, 
        navigation: {
            nextEl: ".swiper-nav-controls .swiper-button-next",
            prevEl: ".swiper-nav-controls .swiper-button-prev",
        },
        breakpoints: {
            768: {
                slidesPerView: 3,
                spaceBetween: 20,
            },
            1024: {
                slidesPerView: 4,
                spaceBetween: 25,
            }
        }
    });
});
</script>
</body>
</html>