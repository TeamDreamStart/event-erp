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
body{
 background-color: #E5E2DB;
  color: #222222;
  font-family: 'Montserrat', sans-serif;
  font-size: 16px;
  font-weight: normal;
  margin: 0;
  padding: 0 120px 60px;
  line-height: 1;
}
main {
  margin-top: 0;
  padding: 0;
}
.content-container {
width: 100%;
  margin: 0 auto;
  padding: 0;
  margin-bottom: 140px;
}
.section-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}

.section-header h2 {
	font-size: 30px;
	font-weight: 700;
	line-height: 40px;
}
 .main-event-section {
  display: grid;
  grid-template-columns: 1fr 1fr; /* 설명과 포스터 반반씩 공간 차지 */
  gap: 60px;
  align-items: center; /* 세로 공간 중앙 정렬 */
  width: 80%;
  max-width: 888px; /* main 중앙에 오도록 너비를 제한 */
  margin: 0 auto 0px auto; /* 가운데 정렬 및 하단 마진 */
  text-align: left;
  background-color: #FAF9F6;
  padding: 60px 38px;
 }

 .event-detail-info {
  grid-column: 1 / 2;
 }

 .event-detail-info h3 {
  font-size: 20px;
  font-weight: 700;
  margin-top: 0;
  margin-bottom: 16px;
 }

 .event-detail-info p {
  font-size: 16px; /* 텍스트 줄바꿈을 위해 크기 약간 줄임 */
  line-height : normal; /* 가독성을 위해 줄 간격 조정 */
}
.main-info p {
   margin-bottom: 55px;

 }

 .event-detail-info .detail-during-date,
 .event-detail-info .detail-location,
 .event-detail-info .detail-capacity,
 .event-detail-info .detail-status {
  gap: 12px;
  font-weight: bold;
 }
 .event-detail-info p:not(.detail-during-date, .detail-location, .detail-capacity, .detail-status) {
  font-weight: normal;
  margin-top: 0;
 }

 .reserve-btn {
  display: inline-flex;
  align-items: center;
  padding: 10px 8px;
  background-color: #CBD4C2;
  color: #222222;
  text-decoration: none;
  font-size: 14px;
  font-weight: bold;
  border: 1px solid #222222;
  margin-top: 24px;
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
  align-self: center; /* 포스터가 세로 중앙에 오도록 */
 }

 .main-event-poster img {
  max-width: 100%;
    max-height: 484px; /* 포스터의 최대 높이를 제한하여 정비례로 약간 축소 */
  height: auto;
  display: block;
  box-sizing: border-box;
 }

 .add-more-detail {
  display: grid;
  flex-wrap: wrap;
  gap: 60px;
  width: 100%;
  background-color: #FAF9F6;
  padding: 60px 38px;
  align-items: center; /* 세로 공간 중앙 정렬 */
  width: 80%;
  align-items: center; /* 세로 공간 중앙 정렬 */
  max-width: 888px; /* main 중앙에 오도록 너비를 제한 */
  margin: 0 auto 0px auto; /* 가운데 정렬 및 하단 마진 */
  text-align: left;
 }
 .add-more-detail article {
  flex: 1 1 288px;
  min-width: 288px;
  padding: 20px;
  color: #222222;
  background-color: #D9D9D9;
  border-radius: 12px;
 }
.add-more-detail article > h4 { /* 새로운 제목 스타일 */
    font-size: 16px;
    font-weight: bold;
    margin-top: 0;
    margin-bottom: 10px;
    border-bottom: 1px solid #ccc;
    padding-bottom: 5px;
}
 .add-more-detail article > p { /* 새로운 내용 스타일 */
    font-size: 14px;
    line-height: 1.5;
    margin-bottom: 0;
}
 .content-container > .add-more-detail {
  max-width: 888px;
  margin: 0 auto;
 }
   @media (max-width: 1024px) {
  body {
   padding: 0 40px 40px;
  }
    .content-container > .add-more-detail {
      max-width: unset;
    }
  .main-event-section {
   grid-template-columns: 1fr 1fr;
   gap: 30px;
      max-width: 888px;
      padding: 40px 20px;
  }
    .main-event-poster img {
        max-height: 400px;
    }
 }

 @media (max-width: 768px) {
  .main-event-section {
   grid-template-columns: 1fr;
   gap: 20px;
   max-width: 100%;
   padding: 30px 15px;
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
   max-height: unset;
  }
  
  .reserve-btn {
   font-size: 16px;
  }
  
  .add-more-detail article {
   flex-basis: 100%;
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
<p class="main-info">지역 아티스트들과 함께하는 가을 음악 페스티벌이 서울 올림픽 공원에서 열립니다. 다양한 장르의 음악 공연이 준비되어 있어 관객들에게 특별한 경험을 선사합니다. 야외 무대에서 펼쳐지는 생생한 사운드와 가을밤의 분위기가 어우러져 색다른 감동을 느낄 수 있습니다. 가족, 친구, 연인과 함께 즐기며 일상의 피로를 풀고 활력을 얻을 수 있는 자리입니다. 음악과 함께하는 가을 축제를 통해 새로운 추억을 만들어 보세요.</p>

<p class="detail-during-date">공연기간: 2025년 9월 28일~2025년 10월 2일</p>
<p class="detail-location">개최 장소: 서울 올림픽 공원</p>
<p class="detail-capacity">수용 인원: 500</p>
<p class="detail-status">관람가능 여부: OPEN</p>
<a href="/reservations/form" class="reserve-btn">바로 예약하기</a>
</div>

<div class="main-event-poster">
<img src="/resources/img/events/event1.jpg" alt="가을 음악 페스티벌 포스터" />
</div>
</div>

<div class="add-more-detail">
<article class="detail-1">
  <h4>행사 역사</h4>
  <p>본 행사는 오랜 전통을 바탕으로 매년 지역 사회에 활력을 불어넣는 중요한 축제로 자리매김하고 있습니다. 과거의 성공적인 경험을 토대로 더욱 풍성한 프로그램으로 관람객을 맞이합니다.</p>
</article>
<article class="detail-2">
  <h4>개최 목적</h4>
  <p>음악과 예술을 통해 지역 주민들의 문화적 향유 기회를 확대하고, 숨겨진 신진 아티스트를 발굴하여 대중에게 소개하는 것을 주 목적으로 합니다.</p>
</article>
<article class="detail-3">
<!-- <figure class="add-detail-3">
<img src="#" alt="자리를 빛내줄 게스트 관련">
<figcaption class="explain">어쩌구저쩌구</figcaption>
</figure> -->
<h4>주요 게스트</h4>
<p>올해는 특히 국내외에서 활발하게 활동 중인 유명 밴드와 아티스트를 초청하여 더욱 수준 높은 공연을 제공할 예정입니다. 출연진 정보는 추후 공지됩니다.</p>
</article>
<article class="detail-4">
<h4>후원 및 감사</h4>
<p>본 행사는 다수의 기업과 개인 후원자 덕분에 성공적으로 개최될 수 있었습니다. 후원해주신 모든 분들께 진심으로 감사드립니다. 여러분의 성원에 보답하겠습니다.</p>
</article>
</div>

</div>
</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>