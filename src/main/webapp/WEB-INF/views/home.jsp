<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<%@ taglib prefix="sec"
    uri="http://www.springframework.org/security/tags"%>
<head>
<meta charset="UTF-8">
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
        margin: 0;
        width: 100%;
        line-height: 0;
    }
    .visual-image {
        width: 100%;
        height: auto;
        display: block;
        margin: 0;
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
        user-select: none;
        cursor: default;
    }
    .hr2{
        border: none;
        border-top: 1px solid #222222;
        margin-bottom: 0;
        margin-top: 50px;
        width: 100%; 
        box-sizing: border-box;
    }

    .horizontal-scroll-section.exhibitions {
        margin-bottom: 60px;
    }

    .event-card {
        text-align: center;
    }

    .event-card figure {
        margin: 0;
        width: 100%;
        height: auto; 
    }

    .event-card figure img {
        width: 100%;
        height: auto; 
        display: block;
        border-radius: 8px;
        border: 1px solid #222222;
    }

    .event-card .title {
        margin-top: 15px;
        font-size: 16px;
        font-weight: 500;
    }

    .swiper-button-next, .swiper-button-prev {
        color: #222222 !important;
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
                
                                locale: 'ko',
                                initialView: 'dayGridMonth',
                                eventOrder: 'order',
                                eventOrderStrict: true,
                                fixedWeekCount: false, 
                                headerToolbar: {
                                        left: 'prev', 
                                        center: 'title',
                                        right: 'next',
                                },
                                height: 'auto',
                                dayCellContent: function(arg) {
                                        return {
                                        html: arg.date.getDate().toString()
                                        };
                                },
                events: rawEvents,
                                dateClick : function(info) {
                    alert("선택하신 날짜에 일정이 없습니다.");
                },
                eventClick : function(info) {
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