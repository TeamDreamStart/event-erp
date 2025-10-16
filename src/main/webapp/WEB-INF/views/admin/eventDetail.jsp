<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 상세</title>
<style>
dl { display:grid; grid-template-columns:120px 1fr; gap:6px 12px }
dt { font-weight:700 }
.hd { display:flex; justify-content:space-between; align-items:center; margin:12px 0; }
</style>
<!-- 카카오맵 라이브러리 -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoKey }&libraries=services"></script>
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
  <div class="hd">
    <h2>이벤트 상세 #${event.eventId}</h2>
    <div>
      <a href="<c:url value='/admin/events'/>">목록</a>
      <a href="<c:url value='/admin/events/form?id=${event.eventId}'/>">수정</a>
    </div>
  </div>

  <dl>
    <dt>제목</dt><dd>${event.title}</dd>
    <dt>설명</dt><dd><pre style="white-space:pre-wrap">${event.description}</pre></dd>
    <dt>장소</dt><dd>${event.location}</dd>
    <dt>시작/종료</dt><dd>${event.startDate} ~ ${event.endDate}</dd>
    <dt>정원</dt><dd>${event.capacity}</dd>
    <dt>상태</dt><dd>${event.status}</dd>
    <dt>공개</dt><dd>${event.visibility}</dd>
    <dt>포스터</dt>
    <dd>
      <c:if test="${not empty event.posterUrl}">
        <img src="${event.posterUrl}" alt="poster" style="max-height:160px">
      </c:if>
    </dd>
    <dt>유료/가격</dt><dd>${event.paid ? '유료' : '무료'} / ${event.price} ${event.currency}</dd>
    <dt>카테고리</dt><dd>${event.category}</dd>
    <dt>작성자</dt><dd>${event.createdBy}</dd>
    <dt>생성/수정</dt><dd>${event.createdAt} / ${event.updatedAt}</dd>
  </dl>
  
  
  <!-- 카카오 맵 -->
     <div id="map" style="width: 400px; height: 350px;"></div>
	   <!-- location 값은 그냥 지도에 표시되는 이름임, 사용자 직관성을 위해 location으로 넣었습니다 -->
   <a href="https://map.kakao.com/link/map/${event.location },${event.latitude},${event.longitude}">카카오 길찾기</a>

   <script>
      var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
      mapOption = {
         center : new kakao.maps.LatLng(${event.latitude}, ${event.longitude}), // 지도의 중심좌표
         level : 3
      // 지도의 확대 레벨
      };

      // 지도를 생성합니다    
      var map = new kakao.maps.Map(mapContainer, mapOption);

      // 주소-좌표 변환 객체를 생성합니다
      var geocoder = new kakao.maps.services.Geocoder();

      // 주소로 좌표를 검색합니다
      geocoder
            .addressSearch(
                  '${event.location}',
                  function(result, status) {

                     // 정상적으로 검색이 완료됐으면 
                     if (status === kakao.maps.services.Status.OK) {

                        var coords = new kakao.maps.LatLng(result[0].y,
                              result[0].x);

                        // 결과값으로 받은 위치를 마커로 표시합니다
                        var marker = new kakao.maps.Marker({
                           map : map,
                           position : coords
                        });

                        // 인포윈도우로 장소에 대한 설명을 표시합니다
                        var infowindow = new kakao.maps.InfoWindow(
                              {
                                 content : '<div style="width:150px;text-align:center;padding:6px 0;">${event.title}</div>'
                              });
                        infowindow.open(map, marker);

                        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                        map.setCenter(coords);
                     }
                  });
   </script>
</body>
</html>
