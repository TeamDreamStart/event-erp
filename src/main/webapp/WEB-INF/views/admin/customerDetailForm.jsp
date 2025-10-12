<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 상세보기</title>

<link href="/resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet">
<link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">

<style>
.section-title {
	font-weight: bold;
	font-size: 1.2rem;
	margin-top: 30px;
	margin-bottom: 15px;
	color: #4e73df;
	border-left: 4px solid #4e73df;
	padding-left: 10px;
}

.table th {
	white-space: nowrap;
}
</style>
</head>
<body id="page-top">

	<div id="wrapper">
		<jsp:include page="../adminIncludes/header.jsp" />

		<div class="container-fluid">
			<h1 class="h3 mb-4 text-gray-800">회원 상세정보</h1>

			<!-- 회원 기본정보 -->
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary">USER DETAIL</h6>
				</div>
				<div class="card-body">
					<form action="/admin/customers/${userDTO.userId}" method="post">
						<input type="hidden" name="userId" value="${userDTO.userId}" />
						<div class="row mb-3">
							<div class="col-md-4">
								<label class="form-label fw-bold">아이디</label> <input type="text"
									class="form-control" name="userName"
									value="${userDTO.userName}" readonly>
							</div>
							<div class="col-md-4">
								<label class="form-label fw-bold">이름</label> <input type="text"
									class="form-control" name="name" value="${userDTO.name}">
							</div>
							<div class="col-md-4">
								<label class="form-label fw-bold">이메일</label> <input
									type="email" class="form-control" name="email"
									value="${userDTO.email}" readonly>
							</div>
						</div>

						<div class="row mb-3">
							<div class="col-md-4">
								<label class="form-label fw-bold">전화번호</label> <input
									type="text" class="form-control" name="phone"
									value="${userDTO.phone}">
							</div>
							<div class="col-md-4">
								<label class="form-label fw-bold">성별</label> <select
									class="form-select form-control" name="gender">
									<option value="0" ${userDTO.gender == 0 ? 'selected' : ''}>여성</option>
									<option value="1" ${userDTO.gender == 1 ? 'selected' : ''}>남성</option>
								</select>
							</div>
							<div class="col-md-4">
								<label class="form-label fw-bold">생년월일</label> <input
									type="date" class="form-control" name="birthDate"
									value="${userDTO.birthDate}">
							</div>
						</div>

						<div class="row mb-3">
							<div class="col-md-4">
								<label class="form-label fw-bold">상태</label> <select
									class="form-select form-control" name="isActive">
									<option value="1" ${userDTO.isActive == 1 ? 'selected' : ''}>활동중</option>
									<option value="0" ${userDTO.isActive == 0 ? 'selected' : ''}>비활성화</option>
								</select>
							</div>
							<div class="col-md-4">
								<label class="form-label fw-bold">가입일</label> <input type="text"
									class="form-control" value="${userDTO.createdAt}" readonly>
							</div>
							<div class="col-md-4">
								<label class="form-label fw-bold">최근 로그인</label> <input
									type="text" class="form-control" value="${userDTO.lastLoginAt}"
									readonly>
							</div>
						</div>
						<div class="row mb-3">
							<div class="col-md-4">
								<label class="form-label fw-bold">회원 유형</label> <input
									type="text" class="form-control" name="roleName"
									value="${userDTO.roleName == 'ADMIN' ? '관리자' : '일반회원'}"
									readonly disabled>
							</div>
							<div class="col-md-4">
								<label class="form-label fw-bold">SNS여부</label> <input
									type="email" class="form-control" name="snsId"
									value="${userDTO.snsId}" readonly>
							</div>
							<div class="col-md-4">
								<label class="form-label fw-bold">최근 수정일</label> <input
									type="email" class="form-control" name="updatedAt"
									value="${userDTO.updatedAt}" readonly>
							</div>
						</div>
						<div class="text-center">
							<button type="submit" class="btn btn-primary">수정</button>
							<a href="/admin/customers" class="btn btn-secondary ms-2">취소</a>
						</div>
					</form>
				</div>
			</div>

			<!-- 설문조사 정보 -->
			<h5 class="section-title">회원 설문조사 내역</h5>
			<div class="card shadow mb-4">
				<div class="card-body p-0">
					<table class="table table-hover mb-0">
						<thead class="table-light">
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
									<td colspan="3" class="text-center text-muted">할당된 설문이
										없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>

			<!-- 예약 및 결제 정보 -->
			<h5 class="section-title">예약 및 결제 정보</h5>
			<div class="card shadow mb-4">
				<div class="card-body p-0">
					<table class="table table-striped mb-0">
						<thead class="table-light">
							<tr>
								<th>예약번호</th>
								<th>이벤트명</th>
								<th>예약일</th>
								<th>상태</th>
								<th>인원</th>
								<th>결제금액</th>
								<th>결제상태</th>
								<th>결제수단</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="r" items="${reservationList}">
								<tr>
									<td>${r.reservationId}</td>
									<td>${r.eventTitle}</td>
									<td>${r.reservationDate}</td>
									<td>${r.status}</td>
									<td>${r.headcount}</td>
									<td>${r.payment.amount}</td>
									<td>${r.payment.status}</td>
									<td>${r.payment.method}</td>
								</tr>
							</c:forEach>
							<c:if test="${empty reservationList}">
								<tr>
									<td colspan="8" class="text-center text-muted">예약 내역이
										없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>

			<!-- QNA 정보 -->
			<h5 class="section-title">QNA 작성 내역</h5>
			<div class="card shadow mb-4">
				<div class="card-body p-0">
					<table class="table table-hover mb-0">
						<thead class="table-light">
							<tr>
								<th>제목</th>
								<th>작성일</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="qna" items="${qnaList}">
								<tr>
									<td>${qna.title}</td>
									<td>${qna.createdAt}</td>
									<td><a href="/admin/qna/${qna.postId}"
										class="btn btn-sm btn-outline-primary">이동</a></td>
								</tr>
							</c:forEach>
							<c:if test="${empty qnaList}">
								<tr>
									<td colspan="3" class="text-center text-muted">작성한 QNA가
										없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>
		</div>

		<jsp:include page="../adminIncludes/footer.jsp" />
	</div>

	<script src="/resources/vendor/jquery/jquery.min.js"></script>
	<script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="/resources/js/sb-admin-2.min.js"></script>
</body>
</html>
