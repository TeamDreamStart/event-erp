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

<title>관리자 - 공지사항 목록</title>

<!-- Custom fonts for this template-->
<link href="/resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

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
			<!-- <h1 class="h3 mb-2 text-gray-800">
				
			</h1>
 -->
			<!-- DataTales Example -->
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary"
						style="font-size: 2rem;">USERLIST</h6>
				</div>
				<div class="card-body">
					<div style="display: flex; justify-content: flex-end;">
						<span>${totalCount}</span>
					</div>

					<div
						style="display: flex; height: 45px; justify-content: space-between">
						<!-- search -->
						<form action="/admin/customers" method="get" class="search-form">
							<!-- role -->
							<select name="role">
								<option value="">전체</option>
								<option value="0">관리자</option>
								<option value="1">일반회원</option>
							</select>

							<!-- searchType -->
							<select name="searchType" id="searchType">
								<option value="ALL">전체</option>
								<option value="userId">회원번호</option>
								<option value="userName">아이디</option>
								<option value="email">이메일</option>
								<option value="phone">전화번호</option>
								<option value="createdAt">가입일자</option>
							</select>

							<!-- keyword -->
							<input type="text" name="keyword" placeholder="검색어 입력"
								id="keywordInput" />

							<!-- startDate endDate -->
							<div id="dateRange" style="display: none;">
								<input type="date" name="startDate"> <input type="date"
									name="endDate">
							</div>
							<button type="submit">검색</button>
						</form>

						<script>
							const searchType = document
									.getElementById('searchType');
							const keyword = document
									.getElementById('keywordInput');
							const dateRange = document
									.getElementById('dateRange');

							searchType.addEventListener('change', function() {
								if (this.value === 'createdAt') {
									dateRange.style.display = 'inline-block';
									keyword.style.display = 'none';
								} else {
									dateRange.style.display = 'none';
									keyword.style.display = 'inline-block';
								}
							});
						</script>

					</div>
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable" width="100%"
							cellspacing="0">
							<thead>
								<tr>
									<th>회원 번호</th>
									<th>아이디</th>
									<th>이메일</th>
									<th>성함</th>
									<th>전화번호</th>
									<th>성별</th>
									<th>가입일</th>
									<th>마지막 로그인</th>
									<th>상태</th>
									<th>회원등급</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="userDTO" items="${userList }">
									<tr>
										<td>${userDTO.userId}</td>
										<c:if test="${not empty userDTO.userName}">
											<td>${userDTO.userName}</td>
										</c:if>
										<c:if
											test="${empty userDTO.userName || not empty userDTO.snsId}">
											<td><img style="width: 40px"
												src="/resources/img/naver/btnG_아이콘사각.png" alt="네이버로그인이미지"></td>
										</c:if>
										<td>${userDTO.email}</td>
										<td>${userDTO.name}</td>
										<td>${userDTO.phone}</td>
										<td><c:if test="${userDTO.gender eq '0'}">여성</c:if> <c:if
												test="${userDTO.gender eq '1'}">남성</c:if></td>
										<td>${userDTO.createdAt}</td>
										<td>${userDTO.lastLoginAt}</td>

										<c:if test="${userDTO.isActive eq '0'}">
											<td style="color: red">비활성화</td>
										</c:if>
										<c:if test="${userDTO.isActive eq '1'}">
											<td>활동중</td>
										</c:if>
										<c:if test="${userDTO.roleName eq 'admin'}">
											<td style="color: blue">관리자</td>
										</c:if>
										<c:if test="${userDTO.roleName eq 'member'}">
											<td>일반회원</td>
										</c:if>
										<td><a class="btn btn-primary"
											href="/admin/customers/${userDTO.userId }">수정/상세</a></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<!-- paging -->
						<div class="dataTables_paginate paging_simple_numbers">
							<ul class="pagination justify-content-center">
								<c:if test="${pageVO.prev}">
									<li><a class="page-link"
										href="/admin/customers?page=1&perPageNum=${cri.perPageNum}&searchType=${searchType}&keyword=${keyword}&role=${role}&startDate=${startDate}&endDate=${endDate}">&laquo;&laquo;</a></li>
									<li><a class="page-link"
										href="/admin/customers?page=${pageVO.startPage - 1}&perPageNum=${cri.perPageNum}&searchType=${searchType}&keyword=${keyword}&role=${role}&startDate=${startDate}&endDate=${endDate}">&laquo;</a></li>
								</c:if>

								<c:forEach begin="${pageVO.startPage}" end="${pageVO.endPage}"
									var="idx">
									<li class="page-item ${pageVO.cri.page == idx ? 'active' : ''}"><a
										class="page-link"
										href="/admin/customers?page=${idx}&perPageNum=${cri.perPageNum}&searchType=${searchType}&keyword=${keyword}&role=${role}&startDate=${startDate}&endDate=${endDate}">${idx}</a></li>
								</c:forEach>

								<c:if test="${pageVO.next}">
									<li><a class="page-link"
										href="/admin/customers?page=${pageVO.endPage + 1}&perPageNum=${cri.perPageNum}&searchType=${searchType}&keyword=${keyword}&role=${role}&startDate=${startDate}&endDate=${endDate}">&raquo;</a></li>
									<li><a class="page-link"
										href="/admin/customers?page=${pageVO.totalPage}&perPageNum=${cri.perPageNum}&searchType=${searchType}&keyword=${keyword}&role=${role}&startDate=${startDate}&endDate=${endDate}">&raquo;&raquo;</a></li>
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
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>

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