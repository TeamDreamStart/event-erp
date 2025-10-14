<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카카오맵 테스트</title>

<!-- ✅ services 라이브러리 꼭 추가! -->
<script type="text/javascript"
   src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ee21816e3b6c14b1f71c1db0b4fbc881&libraries=services"></script>

</head>
<body>
   <div id="map" style="width: 100%; height: 350px;"></div>


   <script>
      var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
      mapOption = {
         center : new kakao.maps.LatLng(${latitude}, ${longitude}), // 지도의 중심좌표
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
                  '${location}}',
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
                                 content : '<div style="width:150px;text-align:center;padding:6px 0;">${title}</div>'
                              });
                        infowindow.open(map, marker);

                        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                        map.setCenter(coords);
                     }
                  });
   </script>

   <h1>주소검색</h1>
   <form action="/admin/event/insert" method="post">
      <div>
         <label>이벤트명</label> <input type="text" name="title" required>
      </div>

      <div>
         <label>주소</label><br> <input type="text" id="address"
            name="address" style="width: 400px;" readonly required>
         <button type="button" onclick="execDaumPostcode()">주소검색</button>
      </div>

      <div>
         <label>상세주소</label><br> <input type="text" id="detailAddress"
            name="detailAddress" style="width: 400px;">
      </div>

      <div>
         <label>위도</label><br> <input type="text" id="latitude"
            name="latitude" readonly>
      </div>
      <div>
         <label>경도</label><br> <input type="text" id="longitude"
            name="longitude" readonly>
      </div>

      <button type="submit">등록하기</button>
   </form>

   <!-- 카카오 주소검색 API -->
   <script
      src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

   <script>
      function execDaumPostcode() {
         new daum.Postcode(
               {
                  oncomplete : function(data) {
                     var addr = data.roadAddress ? data.roadAddress
                           : data.jibunAddress;
                     document.getElementById("address").value = addr;

                     // 주소를 좌표로 변환
                     var geocoder = new kakao.maps.services.Geocoder();
                     geocoder
                           .addressSearch(
                                 addr,
                                 function(result, status) {
                                    if (status === kakao.maps.services.Status.OK) {
                                       document
                                             .getElementById("latitude").value = result[0].y;
                                       document
                                             .getElementById("longitude").value = result[0].x;
                                    } else {
                                       alert("좌표 변환 실패: " + status);
                                    }
                                 });
                  }
               }).open();
      }
   </script>
   <!-- location 값은 그냥 지도에 표시되는 이름임, 사용자 직관성을 위해 location으로 넣었습니다 -->
   <a href="https://map.kakao.com/link/map/${location },${latitude},${longitude}">카카오맵보기</a>
</body>
</html>
