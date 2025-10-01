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

<title>Notice Detail</title>

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

	<!-- Page Wrapper -->
	<div id="wrapper">
		<!-- header -->
		<jsp:include page="../adminIncludes/header.jsp" />
		<!-- End of header -->

		<!-- Begin Page Content -->
		<div class="container-fluid">

			<!-- Page Heading -->
			<h1 class="h3 mb-2 text-gray-800">Notice Detail</h1>

			<!-- DataTales Example -->
			<div style="max-width: 900px" class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary">게시물 상세보기</h6>
				</div>
				<c:if test="${!empty postDTO}">

					<div class="card-body">
						<!-- 게시글 제목 -->

						<table class="table table-bordered">
							<tr>
								<th>제목</th>
								<th colspan="3">
									<h4 class="page-header">${postDTO.title }</h4>
								</th>
							</tr>
							<tr>
								<th style="width: 100px;">작성자</th>
								<td>${postDTO.userId}</td>
								<th style="width: 100px;">작성일</th>
								<td><fmt:formatDate value="${postDTO.createdAt}"
										pattern="yyyy-MM-dd HH:mm" /></td>
							</tr>
							<tr>
								<th>조회수</th>
								<td style="width: 100px;">${postDTO.viewCount}</td>
								<th style="width: 100px;">수정일</th>
								<td><fmt:formatDate value="${postDTO.updatedAt}"
										pattern="yyyy-MM-dd HH:mm" /></td>
							</tr>
							<tr>
								<th rowspan="2">내용</th>
								<td colspan="3"><c:forEach var="fileDTO"
										items="${fileList}">
										<img src="${pageContext.request.contextPath}/resources/uploadTemp/${fileDTO.storedPath}/${fileDTO.uuid}_${fileDTO.originalName}"
     alt="${fileDTO.originalName}">

									</c:forEach></td>
							</tr>
							<tr>
								<td colspan="3">${postDTO.content}</td>
							</tr>
						</table>

						<%-- 						<!-- 게시글 내용 -->
						<div class="well">
							<p style="white-space: pre-wrap;">${postDTO.content}</p>
						</div> --%>

						<!-- 이전글/다음글 -->
						<table class="table table-bordered">
							<tr>
								<th style="width: 80px;">이전글</th>
								<td><c:if test="${not empty prevDTO}">
										<a
											href="${pageContext.request.contextPath}/admin/notices/${prevDTO.postId}">
											${prevDTO.title} </a>
									</c:if></td>
							</tr>
							<tr>
								<th>다음글</th>
								<td><c:if test="${not empty nextDTO}">
										<a
											href="${pageContext.request.contextPath}/admin/notices/${nextDTO.postId}">
											${nextDTO.title} </a>
									</c:if></td>
							</tr>
						</table>

						<!-- 버튼 그룹 -->
						<div class="text-right">
							<a href="${pageContext.request.contextPath}/admin/notices"
								class="btn btn-default">목록</a> <a
								href="${pageContext.request.contextPath}/admin/notices/${postDTO.postId}/update"
								class="btn btn-primary">수정</a> <a
								href="${pageContext.request.contextPath}/admin/notices/${postDTO.postId}/delete"
								class="btn btn-danger" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
						</div>
						<!-- 미구현 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
						<!-- QNA 답변 ! -->
						<h4 class="page-header">댓글</h4>

						<!-- 댓글 입력 -->
						<form id="commentForm">
							<textarea id="commentContent" placeholder="댓글을 입력하세요."
								style="width: 100%"></textarea>
							<button type="submit" class="btn btn-default">작성</button>
						</form>

						<!-- 댓글 목록 -->
						<div id="commentListArea">
							<!-- 초기 렌더링용 JSP -->
							<c:forEach var="commentDTO" items="${commentList}">
								<div class="well">
									<b>${commentDTO.userId}</b><br> ${commentDTO.content}<br>
									<small>${commentDTO.createdAt}</small>
								</div>
							</c:forEach>
						</div>




					</div>
				</c:if>
				<c:if test="${empty postDTO }">
					<p>존재하지 않는 게시물입니다.</p>
				</c:if>
			</div>

		</div>
		<!-- /.container-fluid -->

	</div>
	<!-- End of Main Content -->

	<!-- Footer -->
	<jsp:include page="../adminIncludes/footer.jsp" />
	<!-- End of Footer -->

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

	<!-- Page level plugins -->
	<script src="/resources/vendor/datatables/jquery.dataTables.min.js"></script>
	<script src="/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>

	<!-- Page level custom scripts -->
	<script src="/resources/js/demo/datatables-demo.js"></script>

</body>
</html>