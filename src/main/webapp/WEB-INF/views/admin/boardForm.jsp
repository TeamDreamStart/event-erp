<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>테이블</title>

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
			<h1 class="h3 mb-2 text-gray-800">
				${postDTO.category}
				<c:if test="${formType eq 'INSERT'}">작성</c:if>
				<c:if test="${formType eq 'UPDATE'}">수정</c:if>
			</h1>

			<!-- DataTales Example -->
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary">${formType}</h6>
				</div>
				<div class="card-body">

					<!-- insert/update action 분기 -->
					<form method="post" enctype="multipart/form-data"
						action="<c:choose>
							<c:when test='${formType eq "INSERT"}'>${pageContext.request.contextPath}/admin/notices/form</c:when>
							<c:when test='${formType eq "UPDATE"}'>${pageContext.request.contextPath}/admin/notices/${postDTO.postId}/update</c:when>
						</c:choose>">
						<div class="form-group">
							<label>제목</label> <input type="text" name="title"
								class="form-control" value="${postDTO.title}">ㄹ
						</div>
						<div class="form-group">
							<div id="ajaxUpload">
								<p>파일 업로드 최대 크기는 5MB 입니다.</p>
								<input type="file" name="uploadFile" multiple>
								<div class="uploadResult">
									<ul>
									</ul>
								</div>
							</div>
							<button id="uploadBtn">업로드</button>
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea name="content" class="form-control" rows="8">${postDTO.content}</textarea>
						</div>
						<%-- <div class="form-group">
					<label>카테고리</label>
					<select name="category" class="form-control">
						<option value="NOTICE" <c:if test="${postDTO.category eq 'NOTICE'}">selected</c:if>>공지사항</option>
						<option value="QNA" <c:if test="${postDTO.category eq 'QNA'}">selected</c:if>>Q&A</option>
					</select>
				</div> --%>
						<!-- 작성일,작성자,조회수,수정일은 hidden -->
						<input type="hidden" name="category" value="NOTICE">
						<div class="text-right">
							<c:if test="${formType eq 'INSERT'}">
								<a href="${pageContext.request.contextPath}/admin/notices"
									class="btn btn-light btn-icon-split">취소</a>
								<button type="submit" class="btn btn-success">등록</button>
							</c:if>
							<c:if test="${formType eq 'UPDATE'}">
								<a
									href="${pageContext.request.contextPath}/admin/notices/${postDTO.postId}"
									class="btn btn-light btn-icon-split">취소</a>
								<button type="submit" class="btn btn-success">수정</button>
							</c:if>
						</div>
					</form>


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

	<!-- Page level plugins -->
	<script src="/resources/vendor/datatables/jquery.dataTables.min.js"></script>
	<script src="/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>

	<!-- Page level custom scripts -->
	<script src="/resources/js/demo/datatables-demo.js"></script>

</body>
</html>