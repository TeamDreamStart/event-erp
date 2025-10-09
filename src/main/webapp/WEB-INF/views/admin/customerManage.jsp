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
						style="font-size: 2rem;">
						<c:if test="${boardType eq 'notices' }">NOTICE</c:if>
						<c:if test="${boardType eq 'qna' }">Q&A</c:if>
					</h6>
				</div>
				<div class="card-body">
					<div style="display: flex; justify-content: flex-end;">
						<span>${totalCount}</span>
					</div>

					<div
						style="display: flex; height: 45px; justify-content: space-between">
						<form action="/admin/${boardType }" method="get">
							<input type="hidden" name="searchType" value="${searchType}">
							<input type="hidden" name="keyword" value="${keyword}"> <select
								name="visibility"
								class="custom-select custom-select-sm form-control form-control-sm"
								style="width: 135px">
								<option value="ALL">전체글 보기</option>
								<option value="PUBLIC">공개글만 보기</option>
								<option value="PRIVATE">비공개글만 보기</option>
							</select>
							<button class="btn btn-primary" type="submit">선택</button>
						</form>


						<form action="/admin/${boardType }" method="get">
							<input type="hidden" name="visibility" value="${visibility }">
							<select name="searchType"
								class="custom-select custom-select-sm form-control form-control-sm"
								style="width: 65px">
								<option value="all" selected>전체&nbsp;&nbsp;&nbsp;</option>
								<option value="title">제목</option>
								<option value="content">내용</option>
							</select> <input
								style="color: #6e707e; background-color: #fff; background-clip: padding-box; border: 1px solid #d1d3e2;"
								type="text" name="keyword" value="${param.keyword}"
								placeholder="검색어를 입력하세요.">
							<button class="btn btn-primary" type="submit">검색</button>
						</form>
					</div>
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable" width="100%"
							cellspacing="0">
							<thead>
								<tr>
									<th>회원 번호</th>
									<th>아이디</th>
									<th>가입일</th>
									<th>마지막 로그인</th>
									<th>활동여부</th>
								
								</tr>
							</thead>
							<tbody>
								<c:forEach var="userDTO" items="${userList }">
								<tr>
									<td>${userDTO.}</td>
									<td>${userDTO.}</td>
									<td>${userDTO.}</td>
									<td>${userDTO.}</td>
									<td>${userDTO.}</td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
						<!-- paging -->
						<div class="dataTables_paginate paging_simple_numbers">
							<ul class="pagination" style="justify-content: center">
								<c:if test="${pageVO.prev}">
									<li><a class="page-link"
										href="/admin/${boardType }?page=1&visibility=${visibility}&searchType=${searchType}&keyword=${keyword}">&laquo;&laquo;</a></li>
									<li><a class="paginate_button page-item previous"
										href="/admin/${boardType }?page=${pageVO.startPage - 1}&visibility=${visibility}&searchType=${searchType}&keyword=${keyword}">&laquo;</a></li>
								</c:if>

								<c:forEach begin="${pageVO.startPage}" end="${pageVO.endPage}"
									var="idx">
									<li class="${pageVO.cri.page == idx ? 'active' : ''}"><a
										class="page-link"
										href="/admin/${boardType }?page=${idx}&visibility=${visibility}&searchType=${searchType}&keyword=${keyword}">${idx}</a></li>
								</c:forEach>

								<c:if test="${pageVO.next}">
									<li><a class="paginate_button page-item next"
										href="/admin/${boardType }?page=${pageVO.endPage + 1}&visibility=${visibility}&searchType=${searchType}&keyword=${keyword}">&raquo;</a></li>
									<li><a class="page-link"
										href="/admin/${boardType }?page=${pageVO.totalPage}&visibility=${visibility}&searchType=${searchType}&keyword=${keyword}">&raquo;&raquo;</a></li>
								</c:if>
							</ul>
						</div>
						<!-- paging end -->
						<div style="display: flex; justify-content: flex-end;">
							<a type="button" href="/admin/${boardType }/form"
								class="btn btn-success">새로 작성</a>
							<div></div>
						</div>
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