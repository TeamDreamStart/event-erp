<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700;900&display=swap" rel="stylesheet"/>
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/common.css'/>">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@12/swiper-bundle.min.css"/>
<title>Event Detail</title>

<style>
body { background:#E5E2DB; }
.section-header { display:flex; align-items:center; margin-bottom:20px; }
.section-header h2 { font-size:30px; font-weight:700; line-height:40px; }

.main-event-section {
	display:grid;
	grid-template-columns:1fr 1fr;
	gap:60px;
	align-items:center;
	width:80%;
	max-width:888px;
	margin:0 auto;
	background-color:#FAF9F6;
	padding:60px 38px;
}

.event-detail-info h3 { font-size:22px; font-weight:700; margin:0 0 16px; }
.event-detail-info p { font-size:16px; line-height:1.6; margin:0 0 10px; }
.main-info { margin-bottom:30px; }

.reserve-btn {
	display:inline-flex; align-items:center;
	padding:10px 12px;
	background-color:#CBD4C2;
	color:#222; text-decoration:none;
	font-size:14px; font-weight:700;
	border:1px solid #222;
	margin-top:20px; cursor:pointer;
}
.reserve-btn::after { content:'→'; margin-left:8px; }

.main-event-poster { text-align:right; }
.main-event-poster img {
	max-width:100%; height:auto; border-radius:8px;
	box-shadow:0 2px 6px rgba(0,0,0,0.15);
}

.add-more-detail {
	display: grid;
	flex-wrap: wrap;
	gap: 60px;
	width: 100%;
	background-color: #FAF9F6;
	/* padding: 60px 38px;  포스터 샘플 이미지 넣어서 잠시 없앰*/
	align-items: center; /* 세로 공간 중앙 정렬 */
	width: 80%;
	align-items: center; /* 세로 공간 중앙 정렬 */
	max-width: 888px; /* main 중앙에 오도록 너비를 제한 */
	margin: 0 auto 0px auto; /* 가운데 정렬 및 하단 마진 */
	text-align: left;
}
.add-more-detail article {
	background:#D9D9D9; border-radius:12px; padding:20px;
}
.add-more-detail h4 { font-size:16px; font-weight:700; margin:0 0 10px; border-bottom:1px solid #ccc; padding-bottom:4px; }

.map-section {
	width:80%; max-width:888px;
	margin:60px auto 140px;
	background:#FAF9F6;
	padding:40px 38px;
	border-radius:12px;
}
.map-section h3 { font-size:20px; font-weight:700; margin-bottom:20px; }
</style>
</head>

<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<main>
		<div class="container">
			<div class="section-header">
				<h2>Present Event</h2>
			</div>

			<div class="main-event-section">
				<div class="event-detail-info">

					<h3>${event.title }</h3>
					<br>
					<p class="main-info">${event.description }</p>

					<p class="detail-during-date">공연기간: ${event.startDate }~${event.endDate }</p>
					<p class="detail-location">개최 장소: ${event.location }</p>
					<p class="detail-capacity">수용 인원: 500</p>
					<p class="detail-status">관람가능 여부: OPEN</p>
					<p class="detail-price">가격: 
					<c:if test="${event.paid ==true}">
						${event.price }
					</c:if>
					<c:if test="${event.paid==false}">
						무료
					</c:if>
						</p>
					<a href="/events/${event.eventId }/reservations" class="reserve-btn">바로 예약하기</a>
				</div>

				<div class="main-event-poster">
					<img src="/resources/img/events/event1.jpg" alt="가을 음악 페스티벌 포스터" />
				</div>
			</div>

			<div class="add-more-detail" style="margin-bottom: 140px;">
				<!-- <article class="detail-1">
					<h4>행사 역사</h4>
					<p>본 행사는 오랜 전통을 바탕으로 매년 지역 사회에 활력을 불어넣는 중요한 축제로 자리매김하고 있습니다.
						과거의 성공적인 경험을 토대로 더욱 풍성한 프로그램으로 관람객을 맞이합니다.</p>
				</article>
				<article class="detail-2">
					<h4>개최 목적</h4>
					<p>음악과 예술을 통해 지역 주민들의 문화적 향유 기회를 확대하고, 숨겨진 신진 아티스트를 발굴하여 대중에게
						소개하는 것을 주 목적으로 합니다.</p>
				</article>
				<article class="detail-3">
					<figure class="add-detail-3">
<img src="#" alt="자리를 빛내줄 게스트 관련">
<figcaption class="explain">어쩌구저쩌구</figcaption>
</figure>
					<h4>주요 게스트</h4>
					<p>올해는 특히 국내외에서 활발하게 활동 중인 유명 밴드와 아티스트를 초청하여 더욱 수준 높은 공연을 제공할
						예정입니다. 출연진 정보는 추후 공지됩니다.</p>
				</article>
				<article class="detail-4">
					<h4>후원 및 감사</h4>
					<p>본 행사는 다수의 기업과 개인 후원자 덕분에 성공적으로 개최될 수 있었습니다. 후원해주신 모든 분들께
						진심으로 감사드립니다. 여러분의 성원에 보답하겠습니다.</p>
				</article> -->
				<img src="/resources/img/events/event1_detail.jpg" alt="행사 상세 포스터">
			</div>

<main>
	<div class="container">
		<div class="section-header">
			<h2>Present Event</h2>
		</div>

		<div class="main-event-section">
			<div class="event-detail-info">
				<h3>${event.title}</h3>

				<p class="main-info">
					<c:out value="${fn:replace(event.description, '[[img:', '')}"/>
				</p>

				<p>공연기간: ${event.startDate} ~ ${event.endDate}</p>
				<p>개최 장소: ${event.location}</p>
				<p>수용 인원: ${event.capacity}</p>
				<p>관람 가능 여부: ${event.status}</p>
				<p>가격: 
					<c:choose>
						<c:when test="${event.paid}">${event.price} ${event.currency}</c:when>
						<c:otherwise>무료</c:otherwise>
					</c:choose>
				</p>

				<a href="/events/${event.eventId}/reservations" class="reserve-btn">바로 예약하기</a>
			</div>

			<!-- ✅ 포스터 (하드코딩 fallback 적용됨) -->
			<div class="main-event-poster">
				<c:choose>
					<c:when test="${not empty event.posterUrl}">
						<img src="${pageContext.request.contextPath}${event.posterUrl}"
							 alt="${event.title} 포스터"
							 onerror="
							 	const fallback = '${fn:substringAfter(event.posterUrl, '_')}';
							 	this.src='${pageContext.request.contextPath}/resources/img/' + fallback;
							 	this.onerror=null;
							 ">
					</c:when>
					<c:otherwise>
						<img src="${pageContext.request.contextPath}/resources/img/no_image.png" alt="기본 포스터">
					</c:otherwise>
				</c:choose>
			</div>
		</div>

		<!-- 추가 설명 -->
		<div class="add-more-detail">
			<article>
				<h4>행사 역사</h4>
				<p>본 행사는 오랜 전통을 바탕으로 매년 지역 사회에 활력을 불어넣는 중요한 축제로 자리매김하고 있습니다.</p>
			</article>
			<article>
				<h4>개최 목적</h4>
				<p>음악과 예술을 통해 지역 주민들의 문화적 향유 기회를 확대하고, 신진 아티스트를 발굴하는 것을 목표로 합니다.</p>
			</article>
			<article>
				<h4>주요 게스트</h4>
				<p>올해는 국내외 유명 아티스트들이 참여하며, 출연진 정보는 추후 공지됩니다.</p>
			</article>
			<article>
				<h4>후원 및 감사</h4>
				<p>본 행사는 여러 기업과 후원자 덕분에 성공적으로 개최됩니다. 감사합니다.</p>
			</article>
		</div>

		<!-- 지도 -->
		<div class="map-section">
			<h3>오시는 길</h3>
			<div id="map" style="width:100%;height:400px;border:1px solid #ccc;border-radius:8px;"></div>
			<div style="margin-top:10px;text-align:right;">
				<a href="https://map.kakao.com/link/map/${event.location},${event.latitude},${event.longitude}"
				   target="_blank" rel="noopener"
				   style="color:#222;font-weight:bold;text-decoration:underline;">
				   📍 카카오 지도에서 보기
				</a>
			</div>
		</div>
	</div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

<!-- Kakao Map SDK -->
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ee21816e3b6c14b1f71c1db0b4fbc881&libraries=services"></script>
<script>
(function(){
  const lat = parseFloat('${event.latitude}');
  const lng = parseFloat('${event.longitude}');
  const loc = '${event.location}';
  const hasLatLng = !isNaN(lat) && !isNaN(lng);

  if (!document.getElementById('map') || !window.kakao) return;

  const map = new kakao.maps.Map(document.getElementById('map'), {
    center: new kakao.maps.LatLng(hasLatLng ? lat : 37.5665, hasLatLng ? lng : 126.9780),
    level: 3
  });

  const geocoder = new kakao.maps.services.Geocoder();

  function mark(lat, lng){
    const pos = new kakao.maps.LatLng(lat, lng);
    const marker = new kakao.maps.Marker({ map: map, position: pos });
    const infowindow = new kakao.maps.InfoWindow({
      content: '<div style="width:160px;text-align:center;padding:6px 0;">${event.title}</div>'
    });
    infowindow.open(map, marker);
    map.setCenter(pos);
  }

  if (hasLatLng) {
    mark(lat, lng);
  } else if (loc) {
    geocoder.addressSearch(loc, function(res, status){
      if (status === kakao.maps.services.Status.OK && res[0]) {
        mark(parseFloat(res[0].y), parseFloat(res[0].x));
      }
    });
  }
})();
</script>
</body>
</html>
