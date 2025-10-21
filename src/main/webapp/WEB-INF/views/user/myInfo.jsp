<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
	max-width: 896px; /* 이미지에 따라 적절한 너비 설정 */
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
	border-radius: 12px;
	font-size: 14px;
	cursor: pointer;
	border: none;
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
	max-width: 896px;
	display: flex;
	flex-direction: column;
	align-items: flex-start; /* '나의 예약' 제목 위치 */
	margin: 40px auto 140 auto;
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
	gap:72px;
	margin-left:21px;/* 72px - 패딩값(51px) */
}

.tmp {
	width: 202px;
	height: 173px;
	border: 1px solid #D9D9D9;
	border-radius: 5px;
	cursor: pointer
}
.tmp:hover{
	background-color:#D9D9D9
}
.tmp-span{
	display:block;
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
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -2px rgba(0, 0, 0, 0.03);
	}
	
	/* 태블릿 이상에서의 큰 패딩 (sm:p-8) */
	@media (min-width: 640px) {
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
	width: 6rem; /* 96px, 기존 120px보다 약간 작게 조정 */
	font-weight: 600;
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
}

/* 제목 스타일 */
.modal-title {
    font-size: 14px; 
    font-weight: bold;
    color: #222222;
    margin-bottom: 20px;
}

/* 주의사항 박스 (빨간색 경고 박스) */
.warning-box {
    background-color: #FFE1DD; /* 연한 빨간색 배경 */
    border: 1px solid #FDBCB4; /* 경계선 */
    padding: 8px;
    border-radius: 3px;
    margin-bottom: 18px;
}

.warning-header {
    color: #C42006; 
    font-weight: bold;
    margin-bottom: 18px;
    font-size: 14px;
}

.warning-icon {
    margin-right: 5px;
    font-size: 1.1em;
}

.warning-list {
    list-style-type: none; 
    padding-left: 0;
    margin-top: 10px;
    margin-bottom: 0;
}

.warning-list li {
    color: #C42006; /* 진한 빨간색 리스트 텍스트 */
    font-size: 14px;
    line-height: 1.2;
}

/* 비밀번호 입력 안내 텍스트 */
.input-instruction {
    font-size: 14px;
    color: #D9D9D9;
    margin-bottom: 15px;
}

/* 레이블 텍스트 */
.label-text {
    display: block;
    font-weight: bold;
    font-size: 14px;
    color: #222222;
    margin-bottom: 8px;
}

/* 비밀번호 입력 필드 */
.password-input {
    width: 100%;
    padding: 9px;
    border: 1px solid #AFAFAF;
    border-radius: 4px;
    box-sizing: border-box;
    outline: none;
}
.password-input:focus {
    border-color: #007FFF; /* 포커스 시 테두리 색상 */
    box-shadow: 0 0 0 1px #8c8c8c;
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
    padding: 10px 14px;
    border: none;
    border-radius: 12px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 700;
    transition: background-color 0.2s;
}

/* 탈퇴 버튼 (빨간색) */
.btn-withdraw {
    background-color: #ED2100; /* 진한 빨간색 */
    color: white;
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
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<main>
		<div class="container">
			<div class="section-header">
				<div class="page-title">
					<h2>MyPage</h2>
				</div>
			</div>
			<div class="info-box">

				<div class="member-info-box">
					<div class="info-header">
						<p>나의 정보</p>
						<button class="modify-btn"
						onclick="location.href='/my-info/${userDTO.userId}/edit'">수정</button>
					</div>
					
					<div class="info-grid">
						<span class="info-label">이름</span> <span class="info-label">이메일</span>
						<span class="info-label">전화번호</span> <span>${userDTO.name}</span> <span>${userDTO.email}</span>
						<span>${userDTO.phone}</span>
					</div>
				</div>
			</div>

			<div class="my-reservation-box">
				<h3>나의 예약</h3>
				<c:if test="${not empty reservationList}">
					<div class="tmpWrap">

						<c:forEach var="rDTO" items="${reservationList}">
							<div class="tmp" onclick="location.href='/reservations/${rDTO.reservationId}'">
								<span class="tmp-span">${rDTO.eventTitle}</span>
								<span class="tmp-span">${rDTO.reservationId}</span>
								<span  class="tmp-span">${rDTO.reservationDate}</span>
								<%-- <span>${rDTO.location}</span> --%>
								<span  class="tmp-span">건물이름</span>
								<span>${rDTO.reservationStatus}</span>
								<span>${rDTO.paymentAmount}</span>
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
		</div>
	</main>
	<jsp:include page="../common/footer.jsp" />
	<div id="withdrawalModal" class="modal-backdrop">
    <div class="modal-content">
        <h2 class="modal-title">회원탈퇴</h2>

        <div class="warning-box">
            <p class="warning-header">
                <span class="warning-icon">⚠️</span> 주의사항
            </p>
            <ul class="warning-list">
                <li>회원님의 모든 정보가 삭제됩니다.</li>
                <li>예약 내역이 모두 삭제됩니다.</li>
                <li>삭제된 정보는 복구할 수 없습니다.</li>
            </ul>
        </div>

        <p class="input-instruction">
            탈퇴를 진행하시려면 비밀번호를 입력해 주세요.
        </p>

        <form id="withdrawalForm" action="#" method="POST">
            <label for="password" class="label-text">비밀번호</label>
            <input type="password" id="password" name="password" 
                  placeholder="비밀번호를 입력하세요." class="password-input" required>
            
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
</script>
</body>
</html>
