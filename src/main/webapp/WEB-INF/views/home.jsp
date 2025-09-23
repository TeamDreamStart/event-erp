<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<title>Home</title>
</head>
<body>
	<header> </header>

	<nav></nav>

	<article>
		<h1>Hello world!</h1>

		<P>The time on the server is ${serverTime}.</P>
		<img
			src="${pageContext.request.contextPath}/resources/img/cute-hamtaro.gif">


		<p>헤헤헤헤!!!</p>

		<p>유리언니 바보</p>
		<script type="text/javascript"
			src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7526ffde91bc93805d89c790abf0b705"></script>
		<div id="map" style="width: 500px; height: 400px;">지도</div>
		<script type="text/javascript">
			var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
			var options = { //지도를 생성할 때 필요한 기본 옵션
				center : new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
				level : 3
			//지도의 레벨(확대, 축소 정도)
			};

			var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
		</script>

<a href="/list-test">회원목록 테스트</a>
<a href="/board-test">게시판 테스트</a>
<a href="/pay-test">결제 테스트</a>
	</article>

	<footer> </footer>
</body>
</html>
