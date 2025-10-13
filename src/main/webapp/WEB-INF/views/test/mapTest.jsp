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
	src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=ee21816e3b6c14b1f71c1db0b4fbc881"></script>

</head>
<body>
	<p>지도야</p>
	<div id="map" style="width: 100%; height: 350px;"></div>

	<script>
		var infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });

		var mapContainer = document.getElementById('map');
		var mapOption = {
			center: new kakao.maps.LatLng(37.566826, 126.9786567),
			level: 3
		};

		var map = new kakao.maps.Map(mapContainer, mapOption);

		// ✅ 장소 검색 객체 생성 (services 라이브러리 필수)
		var ps = new kakao.maps.services.Places();

		ps.keywordSearch('이태원 맛집', placesSearchCB);

		function placesSearchCB(data, status, pagination) {
			if (status === kakao.maps.services.Status.OK) {
				var bounds = new kakao.maps.LatLngBounds();

				for (var i = 0; i < data.length; i++) {
					displayMarker(data[i]);
					bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
				}
				map.setBounds(bounds);
			} else {
				console.log("검색 실패 상태:", status);
			}
		}

		function displayMarker(place) {
			var marker = new kakao.maps.Marker({
				map: map,
				position: new kakao.maps.LatLng(place.y, place.x)
			});

			kakao.maps.event.addListener(marker, 'click', function() {
				infowindow.setContent(
					'<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>'
				);
				infowindow.open(map, marker);
			});
		}
	</script>
</body>
</html>
