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
