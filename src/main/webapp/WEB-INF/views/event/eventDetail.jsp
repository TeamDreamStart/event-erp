<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700;900&display=swap" rel="stylesheet"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@12/swiper-bundle.min.css"/>

<title>eventDetail</title>
<link rel="stylesheet" type="text/css" href="/resources/css/login.css">
<style>
    body {
    background-color: #E5E2DB;
    color: #222222;
    font-family: 'Montserrat', sans-serif;
    font-size: 16px;
        font-weight: normal;
    margin: 0;
    padding: 0 120px 60px; 
    line-height: 1.6;
  }
  main {
    margin-top: 0; 
    padding: 0; 
  }
    .content-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0;
    }

    .section-header {
        position: relative;
        padding-top: 40px;
        margin-bottom: 40px;
        text-align: left;
    }
    .section-header h2{
    font-size: 24px;
    font-weight: bold;
    user-select: none;
    cursor: default;
    margin: 0;
        padding: 0;
  }
    .section-header h2::before {
        content: '←';
        font-size: 24px;
        display: inline-block;
        margin-right: 15px;
    }

    .main-event-section {
        display: grid;
        grid-template-columns: 1fr 300px;
        gap: 60px;
        align-items: start;
        width: 100%;
        margin-bottom: 80px;
        text-align: left;
    }

    .event-detail-info {
        grid-column: 1 / 2;
    }

    .event-detail-info h3 {
        font-size: 24px;
        font-weight: 700;
        margin-top: 0;
        margin-bottom: 20px;
    }

    .event-detail-info p {
        font-size: 14px;
        margin-bottom: 10px;
        line-height: 1.8;
    }

    .event-detail-info .detail-during-date,
    .event-detail-info .detail-location,
    .event-detail-info .detail-capacity,
    .event-detail-info .detail-status {
        font-weight: bold;
        margin-top: 20px;
    }
    .event-detail-info p:not(.detail-during-date, .detail-location, .detail-capacity, .detail-status) {
        font-weight: normal;
        margin-top: 0;
    }

    .reserve-btn {
        display: inline-flex;
        align-items: center;
        padding: 8px 15px;
        background-color: #222222;
        color: #E5E2DB;
        text-decoration: none;
        font-size: 14px;
        font-weight: bold;
        border: none;
        border-radius: 4px;
        margin-top: 20px;
        cursor: pointer;
    }
    .reserve-btn::after {
        content: '→';
        margin-left: 8px;
        font-size: 16px;
    }

    .main-event-poster {
        grid-column: 2 / 3;
        grid-row: 1 / 2;
        text-align: right;
        width: 100%;
    }

    .main-event-poster img {
        width: 100%;
        height: auto;
        display: block;
        border: 1px solid #222222;
        box-sizing: border-box;
    }

    .add-more-detail {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
        margin-top: 40px;
    }
    .add-more-detail article {
        flex: 1 1 200px;
        min-width: 200px;
        border: 1px dashed #AFAFAF;
        padding: 20px;
    }

    @media (max-width: 1024px) {
        body {
            padding: 0 40px 40px;
        }
        .main-event-section {
            grid-template-columns: 1fr 250px;
            gap: 40px;
        }
    }

    @media (max-width: 768px) {
        .main-event-section {
            grid-template-columns: 1fr;
            gap: 20px;
        }
        .event-detail-info {
            grid-column: 1 / -1;
        }
        .main-event-poster {
            grid-column: 1 / -1;
            grid-row: auto;
            order: -1;
            text-align: center;
        }
        .main-event-poster img {
            max-width: 300px;
            width: 100%;
        }
    }
</style>
</head>
<body>
 <jsp:include page="/WEB-INF/views/common/header.jsp"/>
<main>
<div class="content-container">
 <div class="section-header">
 <h2>Present Event</h2> </div>

<div class="main-event-section">
 <div class="event-detail-info">

  <h3>가을 음악 페스티벌</h3>
  <br>
  <p>지역 아티스트들과 함께하는 가을 음악 페스티벌이 서울 올림픽 공원에서 열립니다. 다양한 장르의 음악 공연이 준비되어 있어 관객들에게 특별한 경험을 선사합니다. 야외 무대에서 펼쳐지는 생생한 사운드와 가을밤의 분위기가 어우러져 색다른 감동을 느낄 수 있습니다. 가족, 친구, 연인과 함께 즐기며 일상의 피로를 풀고 활력을 얻을 수 있는 자리입니다. 음악과 함께하는 가을 축제를 통해 새로운 추억을 만들어 보세요.</p>

  <p class="detail-during-date">공연기간: 2025년 9월 28일~2025년 10월 2일</p>
  <p class="detail-location">개최 장소: 서울 올림픽 공원</p>
  <p class="detail-capacity">수용 인원: 500</p>
  <p class="detail-status">관람가능 여부: OPEN</p>
  <a href="/reservations/form" class="reserve-btn">바로 예약하기</a>
  </div>
    
    <div class="main-event-poster">
   <img src="/resources/img/event1.jpg" alt="가을 음악 페스티벌 포스터" />
  </div>
</div>

<div class="add-more-detail">
 <article class="detail-1">
  <figure class="add-detail-1">
   <img src="#" alt="행사와 관련된 역사">
   <figcaption class="explain">어쩌구저쩌구</figcaption>
  </figure>
 </article>
 <article class="detail-2">
  <figure class="add-detail-2">
   <img src="#" alt="이 행사를 개최하게 된 목적">
   <figcaption class="explain">어쩌구저쩌구</figcaption>
  </figure>
 </article>
 <article class="detail-3">
  <figure class="add-detail-3">
   <img src="#" alt="자리를 빛내줄 게스트 관련">
   <figcaption class="explain">어쩌구저쩌구</figcaption>
  </figure>
 </article>
 <article class="detail-4">
  <figure class="add-detail-4">
   <img src="#" alt="후원명단 및 감사인물">
   <figcaption class="explain">어쩌구저쩌구</figcaption>
  </figure>
 </article>
</div>

</div>
</main>
 <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>