<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700;900&display=swap"
	rel="stylesheet" />

<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/common.css'/>">
<title>MyPage</title>
<style>
body {
	background: #E5E2DB;
}

.section-header {
	display: flex;
	align-items: center;
	margin-bottom: 20px; /* 제목과 내용 사이 간격 */
}

.page-title {
	display: flex;
	align-items: center;
}

.page-title h2 {
	font-size: 30px;
	font-weight: 700;
	line-height: 40px;
}

/* --- 회원 정보 섹션 --- */
.member-info-box {
	width: 896px; /* 이미지에 따라 적절한 너비 설정 */
	background-color: #FFFFFF;
	padding: 32px 51px;
	border: 1px solid #D9D9D9;
	border-radius: 12px;
	position: relative;
	font-size: 14px;
	max-height: 163;
	margin: 0 auto 40 auto;
}

.info-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 39px;
}

.info-header p {
	font-weight: bold;
	margin: 0;
}

.modify-btn {
	background-color: #D9D9D9;
	color: #222222;
	padding: 5px 22px;
	border-radius: 3px;
	font-size: 14px;
	cursor: pointer;
	border: none;
	font-weight: 700;
}

.info-grid {
	display: grid;
	grid-template-columns: 1fr 2fr 2fr; /* 항목명 | 이메일 | 전화번호 */
	gap: 12px 0;
	font-size: 14px;
}

.info-label {
	font-weight: 700;
	color: #222222;
}

/* --- 나의 예약 섹션 (예약 없음 상태) --- */
.my-reservation-box {
	background-color: #FFFFFF;
	padding: 32px 51px;
	border: 1px solid #D9D9D9;
	border-radius: 12px;
	min-height: 218px;
	width: 896px;
	display: flex;
	align-items: center;
	margin: 40px 0px 140px 0px;
	flex-wrap: wrap;
	justify-content: center;
}

.my-reservation-box h3 {
	font-size: 14px;
	font-weight: bold;
	margin: 0 0 43px 0;
	width: 100%;
}

.no-reservation-content {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	width: 100%;
	flex-grow: 1; /* 중앙 정렬을 위해 남은 공간 차지 */
	text-align: center;
}

.no-reservation-content p {
	font-size: 14px;
	margin: 0 0 11px 0;
	color: #222222;
}

.event-button {
	text-decoration: none;
	background-color: #BFD4F9;
	color: #222222;
	padding: 10px;
	margin-top: 17px;
	border: 1px solid #8FAFED;
	border-radius: 3px;
	font-size: 14px;
	font-weight: 700;
	cursor: pointer;
	display: inline-block;
}

/* 나의 예약 정보용 임시 CSS */
.tmpWrap {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 72px;
	margin-left: 21px; /* 72px - 패딩값(51px) */
}

.tmp {
	width: 202px;
	height: 195px;
	border: 2px solid #D9D9D9;
	border-radius: 3px;
	cursor: pointer;
	padding: 16px 13px;
}

.tmp:hover {
	background-color: #D9D9D9;
}

.tmp-span {
	display: block;
}

.tmp-span-radius {
	border: 1px solid #8FAFED;
	border-radius: 12px;
	background-color: #8FAFED;
	display: inline-block;
	height: 25px;
	width: 68px;
	text-align: center;
	width: 68px;
}

.dashboard-container {
	/* 최대 너비 (max-w-4xl) 및 중앙 정렬 (mx-auto) */
	max-width: 56rem; /* 896px */
	margin-left: auto;
	margin-right: auto;
	/* 섹션 간 수직 간격 (space-y-8) */
	display: flex;
	flex-direction: column;
	gap: 2rem; /* 32px */
}

.card {
	background-color: #ffffff;
	border-radius: 0.75rem; /* rounded-xl */
	/* 기본 패딩 (p-6) */
	padding: 1.5rem; /* 24px */
	/* 그림자 (shadow-soft) */
	box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -2px
		rgba(0, 0, 0, 0.03);
}

/* 태블릿 이상에서의 큰 패딩 (sm:p-8) */
@media ( min-width : 640px) {
	.card {
		padding: 2rem; /* 32px */
	}
}

.card-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	/* 하단 구분선 (border-b) */
	border-bottom: 1px solid #F3F4F6; /* border-gray-100 */
	/* 구분선 아래 패딩 (pb-3) */
	padding-bottom: 0.75rem; /* 12px */
	/* 제목 아래 마진 (mb-6) */
	margin-bottom: 1.5rem; /* 24px */
}

.card-header h2 {
	font-size: 1.25rem; /* text-xl */
	font-weight: 700; /* font-bold */
	color: #333333; /* text-dark */
	margin: 0;
}

.card-header button {
	font-size: 0.875rem; /* text-sm */
	color: #6B7280; /* text-gray-500 */
	cursor: pointer;
	transition: color 0.15s ease-in-out;
	padding: 0.5rem 0.75rem; /* 버튼 패딩 추가 */
	border: 1px solid #D1D5DB;
	background-color: #F9FAFB;
	border-radius: 0.375rem;
}

.card-header button:hover {
	color: #3B82F6; /* primary-blue */
	border-color: #3B82F6;
}

.data-table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 1rem; /* mt-4 역할 */
	border-radius: 0.5rem; /* 전체 테이블에 둥근 모서리 적용 */
	overflow: hidden; /* 둥근 모서리를 위해 필수 */
	box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05); /* 테이블에 가벼운 그림자 */
}

.data-table thead tr {
	background-color: #F9FAFB; /* th 배경색, f9f9f9 대신 밝은 회색 */
	color: #333333;
	font-size: 0.875rem;
	font-weight: 600;
}

.data-table th, .data-table td {
	padding: 1rem 1.25rem; /* 충분한 패딩 */
	text-align: left;
	border-bottom: 1px solid #E5E7EB; /* border-gray-200 */
	font-size: 0.875rem; /* text-sm */
	line-height: 1.5;
}

.data-table td {
	color: #4B5563; /* text-gray-600 */
}

/* 마지막 행 하단선 제거 */
.data-table tbody tr:last-child td {
	border-bottom: none;
}

/* 테이블 내부 버튼 스타일 */
.data-table button, .data-table a {
	display: inline-block;
	background-color: #3B82F6; /* primary-blue */
	color: white;
	padding: 0.375rem 0.75rem;
	border-radius: 0.375rem; /* rounded-md */
	font-size: 0.875rem;
	border: none;
	cursor: pointer;
	text-decoration: none;
	transition: background-color 0.15s ease-in-out;
}

.data-table button:hover, .data-table a:hover {
	background-color: #2563EB;
}

.data-table .center {
	text-align: center;
	color: #9CA3AF; /* text-gray-400 */
}

.info-label {
	display: inline-block;
	width: 10rem; /* 96px, 기존 120px보다 약간 작게 조정 */
	font-weight: 700;
	color: #6B7280;
	margin-right: 0.5rem;
}

.info-row {
	margin: 0.6rem 0; /* 6px 0 역할 */
	font-size: 0.875rem;
	color: #333333;
}

.modal-backdrop {
	background-color: rgba(0, 0, 0, 0.85); /* 짙은 배경 */
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	display: flex;
	justify-content: center;
	align-items: center;
	z-index: 1000;
	display: none;
}

/* 모달 컨텐츠 박스 (하얀색 박스) */
.modal-content {
	background-color: #FAF9F6;
	border-radius: 12px;
	padding: 32px 31px;
	width: 455px;
	min-height: 355px;
}

/* 제목 스타일 */
.modal-title {
	font-size: 14px;
	font-weight: 700;
	color: #222222;
	margin-bottom: 10px;
}

/* 주의사항 박스 (빨간색 경고 박스) */
.warning-box {
	background-color: #FFE1DD; /* 연한 빨간색 배경 */
	border: 1px solid #FDBCB4; /* 경계선 */
	padding: 8px;
	border-radius: 3px;
	margin-bottom: 15px;
	width: 85%;
}

.warning-header {
	color: #C42006;
	font-weight: 900;
	margin-bottom: 18px;
	font-size: 14px;
}

.warning-icon {
	margin-right: 5px;
	font-size: 14px;
}

.warning-list {
	padding-left: 0;
	margin-top: 10px;
	margin-bottom: 0;
	font-weight: 700;
}

.warning-list li {
	color: #C42006; /* 진한 빨간색 리스트 텍스트 */
	font-size: 14px;
	line-height: 1.6;
}

/* 비밀번호 입력 안내 텍스트 */
.input-instruction {
	font-size: 14px;
	color: #222222;
	margin-bottom: 15px;
}

/* 레이블 텍스트 */
.label-text {
	display: block;
	font-weight: 700;
	font-size: 14px;
	color: #222222;
	margin-bottom: 8px;
}

/* 비밀번호 입력 필드 */
.password-input {
	width: 85%;
	padding: 9px;
	border: 1px solid #AFAFAF;
	border-radius: 4px;
	box-sizing: border-box;
	outline: none;
	background-color: #F2F0EF;
}

.password-input:focus {
	border: 1px solid #007FFF;
	outline: none;
}

.modal-hr {
	border: 1px solid #222222;
	margin-top: 12px;
}
/* 버튼 영역 */
.modal-actions {
	display: flex;
	justify-content: flex-end; /* 오른쪽 정렬 */
	gap: 14px; /* 버튼 사이 간격 */
	margin-top: 12px;
}

/* 공통 버튼 스타일 */
.btn {
	border: none;
	border-radius: 12px;
	cursor: pointer;
	font-size: 14px;
	font-weight: 700;
	transition: background-color 0.2s;
	width: 52px;
	height: 34px;
}

/* 탈퇴 버튼 (빨간색) */
.btn-withdraw {
	background-color: #ED2100; /* 진한 빨간색 */
	color: #222222;
}

.btn-withdraw:hover {
	background-color: #cc2900;
}

/* 취소 버튼 (옅은 회색) */
.btn-cancel {
	background-color: #F2F0EF; /* 옅은 회색 */
	color: #222222;
	border: 1px solid #AFAFAF;
}

.btn-cancel:hover {
	background-color: #e0e0e0;
}

.info-box {
	display: flex;
	flex-direction: column;
	align-items: center;
}

.password-modal-content {
	background-color: #FAF9F6;
	border-radius: 12px;
	padding: 32px 31px 12px 31px;
	width: 455px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
	border: none;
	box-sizing: border-box;
}
/* 비밀번호 확인 모달 제목 스타일 */
.password-modal-content .modal-title {
	font-size: 14px;
	font-weight: bold;
	color: #222222;
	margin-bottom: 16px;
}

/* 비밀번호 확인 입력 안내 문구 스타일 */
.password-modal-content .modal-instruction {
	font-size: 14px;
	color: #222222;
	margin-bottom: 17px;
}

/* 비밀번호 입력 필드 */
.password-modal-content .password-input {
	width: 85%;
	padding: 9px;
	background-color: #F2F0EF;
	border: 1px solid #AFAFAF;
	border-radius: 3px;
	box-sizing: border-box;
	margin-bottom: 12px;
	outline: none;
}

.password-modal-content .password-input:focus {
	border-color: #007bff;
	background-color: #F2F0EF;
}

/* 비밀번호 확인 버튼 스타일 */
.btn-confirm {
	background-color: #BFD4F9;
	border: 1px solid #8FAFED;
	color: #222222;
	width: 52px;
	height: 34px;
}

.btn-confirm:hover {
	background-color: #8da0e6;
}
/* 모달 액션 영역 (탈퇴 모달과 구분하기 위해 버튼 간격 등 조절 가능) */
.password-modal-content .modal-actions {
	display: flex;
	justify-content: flex-end;
	gap: 14px;
	border-top: 1px solid #222222;
	padding-top: 12px;
}

.container-box {
	display: flex;
	align-items: center;
	flex-direction: column;
}
/*비밀번호 확인모달창 에러 색상*/
.error-color {
	color: #ED2100 !important;
}
/* --- 이벤트 설문 조사 섹션 --- */
.survey-box {
	width: 896px;
	background-color: #FFFFFF;
	padding: 32px 51px;
	border: 1px solid #D9D9D9;
	border-radius: 12px;
	position: relative;
	font-size: 14px;
	margin: 40px 0;
}

.survey-box h3 {
	display: flex;
	align-items: left;
	margin-bottom: 22px;
	font-weight: 700;
}

.survey-list p {
	display: flex;
	align-items: left;
	margin-bottom: 45px;
}

.survey-item {
	display: flex;
	align-items: center;
}

.survey-info {
	font-size: 14px;
	width: 100%;
	display: flex;
	align-items: center;
	border: 1px solid #D9D9D9;
	padding: 18px 11px;
	text-align: left;
	border-radius: 3px;
}

.survey-text {
	display: flex;
	flex-direction: column; /* 수직 정렬 */
	margin-right: auto; /* 버튼을 오른쪽으로 밀어냄 */
}

.survey-info .event-title {
	font-weight: 700;
	margin-bottom: 12px;
}

.survey-info .event-date {
	color: #888888;
}

.survey-btn {
	background-color: #D9D9D9;
	color: #222222;
	padding: 5px 22px;
	border-radius: 3px;
	font-size: 14px;
	cursor: pointer;
	border: none;
	font-weight: 700;
	display: flex;
}

.survey-info {
	border: 1px solid #D9D9D9;
	padding: 18px 11px;
	text-align: left;
	border-radius: 3px;
}

.survey-info .event-date {
	color: #888888;
}
</style>
=======
<title>마이페이지</title>

<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/common.css'/>">
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@12/swiper-bundle.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/swiper@12/swiper-bundle.min.js"></script>
>>>>>>> Stashed changes
</head>

<body>
	<<<<<<< Updated upstream
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<main>
		<div class="container">

			<div class="section-header">
				<div class="page-title">
					<h2>MyPage</h2>
				</div>
			</div>
			<div class="info-box">
				<div class="container-box">
					<div class="member-info-box">
						<div class="info-header">
							<p>나의 정보</p>
							<!-- <button class="modify-btn"
                        onclick="location.href='/my-info/${userDTO.userId}/edit'">수정</button> -->
							<button type="button" class="modify-btn"
								onclick="openPasswordModal()">수정</button>
						</div>

						<div class="info-grid">
							<span class="info-label">이름</span> <span class="info-label">이메일</span>
							<span class="info-label">전화번호</span> <span>${userDTO.name}</span>
							<span>${userDTO.email}</span> <span>${userDTO.phone}</span>
						</div>
					</div>
				</div>

				<div class="my-reservation-box">
					<h3>나의 예약</h3>
					<c:if test="${not empty reservationList}">
						<div class="tmpWrap">

							<c:forEach var="rDTO" items="${reservationList}">
								<div class="tmp"
									onclick="location.href='/reservations/${rDTO.reservationId}'">
									<span class="tmp-span">${rDTO.eventTitle}</span> <span
										class="tmp-span">예약번호 : ${rDTO.reservationId}</span> <span
										class="tmp-span"><fmt:formatDate pattern="yyyy-MM-dd"
											value="${rDTO.reservationDate}" /> </span>
									<%-- <span>${rDTO.location}</span> --%>
									<span class="tmp-span">건물이름</span>

									<c:if test="${rDTO.reservationStatus eq 'CONFIRMED'}">
										<span class="tmp-span-radius">예약확정</span>
									</c:if>
									<c:if test="${rDTO.reservationStatus eq 'CANCELLED'}">
										<span class="tmp-span-radius"
											style="background-color: red; border: 1px solid red;">취소됨</span>
									</c:if>
									<c:if
										test="${rDTO.paymentAmount>0 || not empty rDTO.paymentAmount}">
										<span><fmt:formatNumber type="number"
												maxFractionDigits="3" value="${rDTO.paymentAmount}" />원</span>
									</c:if>
								</div>
							</c:forEach>

						</div>

					</c:if>
					<c:if test="${empty reservationList}">
						<div class="no-reservation-content">
							<p>예약 내역이 없습니다.</p>
							<p>새로운 이벤트를 예약해 보세요!</p>
							<a href="/events" class="event-button">이벤트 둘러보기</a>
						</div>
					</c:if>
				</div>

				<!--<div>
            이벤트 설문조사
            설문 작성 가능한 이벤트
         </div>-->
				<div class="survey-box">
					<h3>이벤트 설문조사</h3>

					<div class="survey-list">
						<p>설문 작성 가능한 이벤트</p>
						<!--이 부분은 아직 DB연결 안함-->
						<div class="survey-item">
							<div class="survey-info">
								<div class="survey-text">
									<div class="event-title">가을 음악 페스티벌 2025</div>
									<div class="event-date">이벤트 일시: 2025-09-28</div>
								</div>
								<button class="survey-btn">설문 작성</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<button type="button" onclick="" style="margin-bottom: 140px">회원탈퇴</button>
		</div>
	</main>
	<jsp:include page="../common/footer.jsp" />
	<div id="withdrawalModal" class="modal-backdrop"></div>
	<!--수정버튼 비번 확인창 모달-->
	<!--${passwordError}랑 ${!passwordError}는 프론트에서 임의로 넣어놓음-->
	<div id="passwordConfirmModal" class="modal-backdrop"
		<c:if test="${passwordError}">style="display: flex;"</c:if>
		<c:if test="${!passwordError}">style="display: none;"</c:if>>
		<div class="password-modal-content">
			<h3
				class="modal-title <c:if test="${passwordError}">error-color</c:if>">
				<c:choose>
					<c:when test="${passwordError}">
          ⚠️비밀번호 재확인
        </c:when>
					<c:otherwise>
          비밀번호 확인
        </c:otherwise>
				</c:choose>
			</h3>

			<p
				class="modal-instruction <c:if test="${passwordError}">error-color</c:if>">
				<c:choose>
					<c:when test="${passwordError}">
          회원님의 비밀번호와 일치하지 않습니다.
        </c:when>
					<c:otherwise>
          정보 수정을 위해 비밀번호를 입력해주세요.
        </c:otherwise>
				</c:choose>
			</p>

			<form id="passwordConfirmForm"
				action="/my-info/${userDTO.userId}/confirmPassword" method="POST">
				<label for="confirmPassword" class="label-text">비밀번호</label> <input
					type="password" id="confirmPassword" name="password"
					placeholder="비밀번호를 입력하세요." class="password-input" required>

				<div class="modal-actions">
					<button type="button" class="btn btn-cancel"
						onclick="closePasswordModal()">취소</button>
					<button type="submit" class="btn btn-confirm">확인</button>
				</div>
			</form>
		</div>
	</div>
	<!--회원탈퇴 모달-->
	<div id="withdrawalModal" class="modal-backdrop">
		<div class="modal-content">
			<h2 class="modal-title">회원탈퇴</h2>

			<div class="warning-box">
				<p class="warning-header">
					<span class="warning-icon">⚠️</span> 주의사항
				</p>
				<ul class="warning-list">
					<li>• 회원님의 모든 정보가 삭제됩니다.</li>
					<li>• 예약 내역이 모두 삭제됩니다.</li>
					<li>• 삭제된 정보는 복구할 수 없습니다.</li>
				</ul>
			</div>

			<p class="input-instruction">탈퇴를 진행하시려면 비밀번호를 입력해 주세요.</p>

			<form id="withdrawalForm" action="#" method="POST">
				<label for="password" class="label-text">비밀번호</label> <input
					type="password" id="password" name="password"
					placeholder="비밀번호를 입력하세요." class="password-input" required>
				<hr class="modal-hr">
				<div class="modal-actions">
					<button type="submit" class="btn btn-withdraw">탈퇴</button>
					<button type="button" class="btn btn-cancel" onclick="closeModal()">취소</button>
				</div>
			</form>
		</div>
	</div>
	<script>
		// 모달을 닫는 JavaScript 함수 (취소 버튼용)
		function closeModal() {
			document.getElementById('withdrawalModal').style.display = 'none';
		}
		// 새로운 비밀번호 확인 모달을 여는 함수
		function openPasswordModal() {
			// 모달을 보이게 설정
			document.getElementById('passwordConfirmModal').style.display = 'flex';
			// 입력 필드에 포커스
			document.getElementById('confirmPassword').focus();
			document.querySelector('main').classList.add('blurred');
		}

		// 새로운 비밀번호 확인 모달을 닫는 함수
		function closePasswordModal() {
			document.getElementById('passwordConfirmModal').style.display = 'none';
			// 입력 필드 초기화
			document.getElementById('confirmPassword').value = '';
			document.querySelector('main').classList.remove('blurred');
		}

		// window.onload = function() {
		//     document.getElementById('withdrawalModal').style.display = 'flex';
		// };
	</script>
	=======
	<jsp:include page="/WEB-INF/views/common/header.jsp" flush="true" />

	<c:if test="${not empty msg}">
		<div class="alert">${msg}</div>
	</c:if>


	<main id="main" class="container" role="main">
		<section class="mypage-section" aria-labelledby="mypage-heading">
			<h2 id="mypage-heading">마이페이지</h2>

			<article>
				<h4>회원 정보</h4>
				<p>
					이름:
					<c:out value="${user.name}" />
				</p>
				<p>
					이메일:
					<c:out value="${user.email}" />
				</p>
				<p>
					전화번호:
					<c:out value="${user.phone}" />
				</p>
			</article>

			<hr>

			<c:if test="${not empty unanswered}">
				<section class="survey-alert">
					<strong>📢 응답하지 않은 설문이 있습니다!</strong>
					<ul>
						<c:forEach var="s" items="${unanswered}">
							<li><a href="<c:url value='/my-info/survey/${s.event_id}'/>">
									[${s.event_title}] ${s.survey_title} </a> <span>(${s.open_at}
									~ ${s.close_at})</span></li>
						</c:forEach>
					</ul>
				</section>
			</c:if>

			<hr>

			<section class="survey-list">
				<h4>이벤트 설문 목록</h4>
				<c:forEach var="s" items="${SurveyList}">
					<c:if test="${not empty s.event_id}">
						<div class="survey-item">
							<p>${s.event_title}(${s.open_at}~ ${s.close_at})</p>
							<form action="<c:url value='/my-info/survey/${s.event_id}'/>"
								method="get">
								<button type="submit" class="btn">설문 작성</button>
							</form>
						</div>
					</c:if>
				</c:forEach>
			</section>
	</main>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	>>>>>>> Stashed changes
</body>
</html>
