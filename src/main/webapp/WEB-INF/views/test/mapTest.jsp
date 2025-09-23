<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="https://bootswatch.com/3/paper/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<!-- services 라이브러리 불러오기 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services"></script>
<!-- Kakao Maps SDK (autoload=true 상태) -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7526ffde91bc93805d89c790abf0b705"></script>
</head>
<body>
	<div class="container">
		<!-- 지도 -->
		<h2>회원 위치 지도</h2>
		<div id="map"
			style="width: 100%; height: 400px; border: 1px solid #ccc;"></div>
	</div>

	<!-- 지도 생성 스크립트 -->
	<script type="text/javascript">
		// DOM이 준비된 후 실행 (안정성을 위해 jQuery 사용)
		$(document).ready(function() {
			var container = document.getElementById('map');
			var options = {
				center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도 중심
				level : 3
			// 지도 확대 레벨
			};
			var map = new kakao.maps.Map(container, options);

			// 예시: 마커 추가
			var markerPosition = new kakao.maps.LatLng(33.450701, 126.570667);
			var marker = new kakao.maps.Marker({
				position : markerPosition
			});
			marker.setMap(map);
		});
	</script>
</body>
</html>