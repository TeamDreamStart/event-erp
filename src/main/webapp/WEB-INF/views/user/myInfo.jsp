<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 상세보기</title>
<style>

/* 임시 */
body {
	 background-color: #E5E2DB;
	 font-family: Arial, sans-serif;
	 margin: 30px;
}

h2 {
	margin-top: 40px;
	border-bottom: 1px solid #ddd;
	padding-bottom: 5px;
}

.section {
	margin-top: 20px;
}

.label {
	display: inline-block;
	width: 120px;
	font-weight: bold;
}

.row {
	margin: 6px 0;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 10px;
}

th, td {
	border: 1px solid #ccc;
	padding: 8px;
	text-align: left;
}

th {
	background-color: #f9f9f9;
}

.center {
	text-align: center;
	color: #777;
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

</style>
</head>
<body id="page-top">

	<header>
		<jsp:include page="/WEB-INF/views/common/header.jsp" flush="true" />
	</header>

	<script>
		const result = '${empty result ? "" : result}';
		const resultType = '${empty resultType ? "" : resultType}';

		if (result === 'success') {
			alert(`성공적으로 ${resultType}되었습니다.`);
		} else if (result === 'fail') {
			alert(`${resultType}이(가) 실패하였습니다.`);
		}
	</script>
	<h1> 마이페이지</h1>
	<button type="button"
		onclick="location.href='/my-info/${userDTO.userId}/update'">내
		정보 수정</button>


	<!-- 설문조사 -->
	<h2>${userDTO.name }  님의 설문조사 내역</h2>
	<table>
		<thead>
			<tr>
				<th>설문 제목</th>
				<th>응답 여부</th>
				<th>응답일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="survey" items="${surveyList}">
				<tr>
					<td>${survey.title}</td>
					<td><c:choose>
							<c:when test="${survey.responded}">응답완료</c:when>
							<c:otherwise>미응답</c:otherwise>
						</c:choose></td>
					<td>${survey.respondedAt}</td>
				</tr>
			</c:forEach>

			<c:if test="${empty surveyList}">
				<tr>
					<td colspan="3" class="center">설문이 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>

	<!-- 예약 및 결제 -->
	<h2>${userDTO.name } 님의  예약 및 결제 정보</h2>
	<table>
		<thead>
			<tr>
				<th>예약번호</th>
				<th>이벤트명</th>
				<th>예약일</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="r" items="${reservationList}">
				<tr>
					<td>${r.reservationId}</td>
					<td>${r.eventTitle}</td>
					<td>${r.reservationDate}</td>
					<td><button type="button" onclick="location.href='/reservations/${r.reservationId}'">자세히보기</button></td>
				</tr>
			</c:forEach>
				
			<c:if test="${empty reservationList}">
				<tr>
					<td colspan="3" class="center">예약 내역이 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
		
	</table>

	<!-- QNA -->
	<h2>${userDTO.name } 님의 QNA 작성 내역</h2>
	<table>
		<thead>
			<tr>
				<th>제목</th>
				<th>작성일</th>
				<th>답변보기</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="qna" items="${postList}" >
				<tr>
					<td>${qna.title}</td>
					<td>${qna.createdAt}</td>
					<c:if test="${qna.commentCount > 0 }">
					<td><a href="/admin/qna/${qna.postId}">답변보기</a></td>
					</c:if>
				</tr>
			</c:forEach>

			<c:if test="${empty postList}">
				<tr>
					<td colspan="3" class="center">작성한 QNA가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<footer>
		<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="true" />
	</footer>

</body>
</html>
