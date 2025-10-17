<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>관리자 - 예약 관리</title>

<!-- Custom fonts for this template-->
<link href="/resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<style>
.active>a.page-link {
	background-color: #4e73df !important;
	border-color: #4e73df !important;
	color: #fff !important;
}
</style>
</head>
<body id="page-top">
	<script>
		const result = '${empty result ? "" : result}';
		const resultType = '${empty resultType ? "" : resultType}';

		if (result === 'success') {
			alert(`성공적으로 ${resultType}되었습니다.`);
		} else if (result === 'fail') {
			alert(`${resultType}이(가) 실패하였습니다.`);
		}
	</script>

	<!-- Page Wrapper -->
	<div id="wrapper">
		<!-- header -->
		<jsp:include page="../adminIncludes/header.jsp" />
		<!-- End of header -->

		<!-- Begin Page Content -->
		<div class="container-fluid">

			<!-- Page Heading -->
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary" style="font-size: 2rem;">Reservation Manage</h6>
				</div>
				<div class="card-body">

					<div style="display: flex; justify-content: flex-end; margin-bottom: 10px;">
						<span>총 예약 수 : </span>
					</div>

					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
							<thead>
								<tr>
									<th>예약 번호</th>
									<th>회원 유형</th>
									<th>회원 ID</th>
									<th>이벤트 ID</th>
									<th>예약 날짜</th>
									<th>인원 수</th>
									<th>상태</th>
									<th>QR 코드</th>
									<th>취소 사유</th>
									<th>취소 일시</th>
									<th>상세</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="r" items="${reservationList}">
									<tr>
										<td>${r.reservationId}</td>
										<td>
											<c:choose>
												<c:when test="${r.userType eq 'USER'}">회원</c:when>
												<c:when test="${r.userType eq 'GUEST'}">비회원</c:when>
											</c:choose>
										</td>
										<td>${r.userId}</td>
										<td>${r.eventId}</td>
										<td><fmt:formatDate value="${r.reservationDate}" pattern="yyyy-MM-dd HH:mm"/></td>
										<td>${r.headCount}</td>
										<td>
											<c:choose>
												<c:when test="${r.status eq 'PENDING'}">대기</c:when>
												<c:when test="${r.status eq 'CONFIRMED'}">확정</c:when>
												<c:when test="${r.status eq 'CANCELLED'}">취소</c:when>
											</c:choose>
										</td>
										<td>
											<c:if test="${not empty r.qrCode}">
												<img src="${r.qrCode}" alt="QR코드" style="height: 40px;">
											</c:if>
										</td>
										<td>${r.cancelReason}</td>
										<td>${r.cancelledAt}</td>
										<td>
											<a class="btn btn-primary" href="/admin/reservation-manage/${r.reservationId}">상세</a>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>

						<!-- paging -->
						<div class="dataTables_paginate paging_simple_numbers">
							<ul class="pagination justify-content-center">
								<c:if test="${pageVO.prev}">
									<li><a class="page-link" href="/reservation-manage?page=1&perPageNum=${cri.perPageNum}">&laquo;&laquo;</a></li>
									<li><a class="page-link" href="/reservation-manage?page=${pageVO.startPage - 1}&perPageNum=${cri.perPageNum}">&laquo;</a></li>
								</c:if>

								<c:forEach begin="${pageVO.startPage}" end="${pageVO.endPage}" var="idx">
									<li class="page-item ${pageVO.cri.page == idx ? 'active' : ''}">
										<a class="page-link" href="/reservation-manage?page=${idx}&perPageNum=${cri.perPageNum}">${idx}</a>
									</li>
								</c:forEach>

								<c:if test="${pageVO.next}">
									<li><a class="page-link" href="/reservation-manage?page=${pageVO.endPage + 1}&perPageNum=${cri.perPageNum}">&raquo;</a></li>
									<li><a class="page-link" href="/reservation-manage?page=${pageVO.totalPage}&perPageNum=${cri.perPageNum}">&raquo;&raquo;</a></li>
								</c:if>
							</ul>
						</div>
						<!-- paging end -->

					</div>
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- End of Main Content -->

			<!-- Footer -->
			<jsp:include page="../adminIncludes/footer.jsp" />
			<!-- End of Footer -->

		</div>
		<!-- End of Content Wrapper -->
	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i class="fas fa-angle-up"></i> </a>

	<!-- Logout Modal-->
	<jsp:include page="../adminIncludes/logoutModal.jsp" />
	<!-- End of Logout Modal-->

	<!-- Bootstrap core JavaScript-->
	<script src="/resources/vendor/jquery/jquery.min.js"></script>
	<script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="/resources/js/sb-admin-2.min.js"></script>

	<!-- Page level custom scripts -->
	<script src="/resources/js/demo/datatables-demo.js"></script>

</body>
</html>
