<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>이벤트 등록/수정</title>
<style>
body {
	font-family: system-ui, sans-serif;
}

main {
	max-width: 720px;
	margin: 24px auto;
	padding: 8px 16px;
}

.field {
	margin: 12px 0;
}

.field label {
	display: block;
	font-weight: 600;
	margin-bottom: 6px;
}

input[type="text"], input[type="url"], input[type="number"], textarea,
	select, input[type="datetime-local"] {
	width: 420px;
	max-width: 100%;
}

.actions {
	margin-top: 24px;
	display: flex;
	gap: 8px;
}

small.muted {
	color: #888
}
</style>
<!-- 카카오맵 라이브러리 -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoKey }&libraries=services"></script>
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
	<main>
		<c:set var="isNew" value="${empty event or empty event.eventId}" />

		<!-- LDT -> 'yyyy-MM-ddTHH:mm' -->
		<spring:eval var="__dtf"
			expression="T(java.time.format.DateTimeFormatter).ofPattern('yyyy-MM-dd''T''HH:mm')" />
		<spring:eval var="startVal"
			expression="event != null and event.startDate != null ? event.startDate.format(__dtf) : ''" />
		<spring:eval var="endVal"
			expression="event != null and event.endDate   != null ? event.endDate.format(__dtf)   : ''" />

		<h1>
			<c:choose>
				<c:when test="${isNew}">이벤트 등록</c:when>
				<c:otherwise>이벤트 수정</c:otherwise>
			</c:choose>
		</h1>

		<c:if test="${not empty msg}">
			<div class="alert alert-info">${msg}</div>
		</c:if>

		<!-- 파일 업로드도 고려: multipart/form-data -->
		<form id="eventForm" action="<c:url value='/admin/events/save'/>"
			method="post" enctype="multipart/form-data">
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />

			<c:if test="${!isNew}">
				<input type="hidden" name="eventId" value="${event.eventId}" />
			</c:if>
			<!-- 임시 -->
			<div class="field">
				<label>작성자 임시값</label> <input type="text" name="createdBy"
					value="278">
			</div> 
			<div class="field">
				<label>제목</label> <input type="text" name="title"
					value="${event.title}" required />
			</div>

			<div class="field">
				<label>설명</label>
				<textarea name="description" rows="5">${event.description}</textarea>
			</div>

			<div class="field">
				<label>장소</label> <input type="text" name="location"
					value="${event.location}" id="location" readonly>
				<button type="button" onclick="execDaumPostcode()">주소검색</button>
				<div id="map" style="width: 350px; height: 150px;"></div>
				<!-- 위도 경도 -->
				<input type="text" name="latitude" value="${event.latitude }"
					placeholder="위도" id="latitude" readonly> <input type="text"
					name="longitude" value="${event.longitude }" placeholder="경도"
					id="longitude" readonly>
			</div>

			<div class="field">
				<label>시작</label> <input id="startDate" type="datetime-local"
					name="startDate" value="${startVal}" />
			</div>

			<div class="field">
				<label>종료</label> <input id="endDate" type="datetime-local"
					name="endDate" value="${endVal}" />
			</div>

			<div class="field">
				<label>정원</label> <input type="number" name="capacity"
					value="${event.capacity}" min="0" />
			</div>

			<div class="field">
				<label>상태</label> <select name="status">
					<option value="OPEN" ${event.status == 'OPEN' ? 'selected' : ''}>OPEN</option>
					<option value="CLOSED"
						${event.status == 'CLOSED' ? 'selected' : ''}>CLOSED</option>
					<option value="CANCELLED"
						${event.status == 'CANCELLED' ? 'selected' : ''}>CANCELLED</option>
				</select>
			</div>

			<div class="field">
				<label>공개여부</label> <select name="visibility">
					<option value="PUBLIC"
						${event.visibility == 'PUBLIC' ? 'selected' : ''}>PUBLIC</option>
					<option value="PRIVATE"
						${event.visibility == 'PRIVATE' ? 'selected' : ''}>PRIVATE</option>
				</select>
			</div>

			<div class="field">
				<label>카테고리</label> <select name="category">
					<option value="SHOW"
						${isNew ? 'selected' : (event.category=='SHOW' ? 'selected' : '')}>SHOW</option>
					<option value="SPEECH"
						${event.category=='SPEECH'   ? 'selected' : ''}>SPEECH</option>
					<option value="WORKSHOP"
						${event.category=='WORKSHOP' ? 'selected' : ''}>WORKSHOP</option>
					<option value="MARKET"
						${event.category=='MARKET'   ? 'selected' : ''}>MARKET</option>
				</select>
			</div>

			<div class="field">
				<label>대표 이미지</label> <input type="file" name="image"
					accept=".jpg,.jpeg,.png,.webp,.pdf" />
				<c:if test="${not empty event.posterUrl}">
					<div style="margin-top: 8px">
						<img src="${event.posterUrl}" alt="poster"
							style="max-height: 160px" />
					</div>
				</c:if>
			</div>

			<div class="field">
				<label>첨부 파일(여러 개)</label> <input type="file" name="files" multiple
					accept=".jpg,.jpeg,.png,.webp,.pdf" /> <small class="muted">이미지는
					썸네일이 자동 생성됩니다.</small>
			</div>

			<div class="field">
				<label>유료 여부</label> <select id="paid" name="paid">
					<option value="false"
						<c:if test="${isNew or (not empty event and (event.paid == false))}">selected</c:if>>무료</option>
					<option value="true"
						<c:if test="${!isNew and event.paid == true}">selected</c:if>>유료</option>
				</select>
			</div>

			<div class="field">
				<label>가격</label> <input id="price" type="number" name="price"
					step="1" min="0"
					value="<c:out value='${empty event.price ? 0 : event.price}'/>" />
				<select id="currency" name="currency">
					<option value="KRW"
						<c:if test="${isNew or event.currency=='KRW' or empty event.currency}">selected</c:if>>KRW</option>
					<option value="USD"
						<c:if test="${event.currency=='USD'}">selected</c:if>>USD</option>
				</select>
			</div>

			<div class="actions">
				<button type="submit">저장</button>
				<a href="<c:url value='/admin/events'/>">목록</a>
				<c:if test="${!isNew}">
					<button type="button" id="btnDelete" style="color: #c00">삭제</button>
				</c:if>
			</div>
		</form>
	</main>

	<script>
		document
				.addEventListener(
						'DOMContentLoaded',
						function() {
							const startEl = document
									.getElementById('startDate');
							const endEl = document.getElementById('endDate');
							const paidEl = document.getElementById('paid');
							const priceEl = document.getElementById('price');
							const currEl = document.getElementById('currency');

							function togglePrice() {
								const isPaid = paidEl
										&& paidEl.value === 'true';
								if (!priceEl || !currEl)
									return;
								priceEl.disabled = !isPaid;
								currEl.disabled = !isPaid;
								if (!isPaid)
									priceEl.value = 0;
							}
							if (paidEl)
								paidEl.addEventListener('change', togglePrice);
							togglePrice();

							function isEndBeforeStart() {
								if (!startEl || !endEl || !startEl.value
										|| !endEl.value)
									return false;
								return endEl.value < startEl.value;
							}

							document.getElementById('eventForm')
									.addEventListener('submit', function(e) {
										if (isEndBeforeStart()) {
											e.preventDefault();
											alert('종료일시는 시작일시 이후여야 합니다.');
											endEl.focus();
											return;
										}
										if (paidEl && paidEl.value !== 'true') {
											priceEl.value = 0;
										}
									});

							const delBtn = document.getElementById('btnDelete');
							if (delBtn) {
								delBtn
										.addEventListener(
												'click',
												function() {
													if (!confirm('정말 삭제하시겠습니까? 삭제 후 되돌릴 수 없습니다.'))
														return;
													var f = document
															.createElement('form');
													f.method = 'post';
													f.action = '<c:url value="/admin/events/${event.eventId}/delete"/>';
													f.innerHTML = '<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">';
													document.body
															.appendChild(f);
													f.submit();
												});
							}
						});
	</script>

	<!-- 카카오 주소찾기 - 위도/경도변경 -> form에 값 입력 -->
	<script>
		// 지도와 마커, 인포윈도우 전역 선언
		var mapContainer = document.getElementById('map');
		var mapOption = {
			center : new kakao.maps.LatLng(33.450701, 126.570667),
			level : 3
		};
		var map = new kakao.maps.Map(mapContainer, mapOption);
		var geocoder = new kakao.maps.services.Geocoder();

		var marker = new kakao.maps.Marker({
			map : map
		});
		var infowindow = new kakao.maps.InfoWindow({
			content : ''
		});

		function execDaumPostcode() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							var addr = data.roadAddress || data.jibunAddress;
							document.getElementById("location").value = addr;

							// 주소 → 좌표 변환
							geocoder
									.addressSearch(
											addr,
											function(result, status) {
												if (status === kakao.maps.services.Status.OK) {
													var coords = new kakao.maps.LatLng(
															result[0].y,
															result[0].x);

													// 마커 이동
													marker.setPosition(coords);

													// 인포윈도우 내용 변경
													infowindow
															.setContent('<div style="padding:5px;">'
																	+ addr
																	+ '</div>');
													infowindow
															.open(map, marker);

													// 지도 중심 이동
													map.setCenter(coords);

													// 위도, 경도 입력창 값 갱신
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

</body>
</html>
