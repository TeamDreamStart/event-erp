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
				<c:if test="${category eq 'qna' }"> 문의
				</c:if>
				<c:if test="${category eq 'notices' }">공지
				</c:if>
				<c:if test="${formType eq 'INSERT'}">작성</c:if>
				<c:if test="${formType eq 'UPDATE'}">수정</c:if>
			</h1>

			<!-- DataTales Example -->
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary">${formType}</h6>
				</div>
				<div class="card-body">

					<!-- category - notices/qna , formType - INSERT/UPDATE  -->
					<!-- 새로 입력  -->
					<c:if test="${formType eq 'INSERT'}">
						<form method="post" enctype="multipart/form-data"
							action="/admin/${category}/form">
							<!-- hidden @@@@@@@@@@@@@@@@@@-->
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" /> <input type="hidden" name="category"
								value="<c:if test="${category eq 'qna' }">QNA</c:if>
				<c:if test="${category eq 'notices' }">공지
				</c:if>">
							<!-- qna는 중요글 없음 -->
							<c:if test="${category eq 'qna' }">
								<input type="hidden" name="pinned" value="0">
								<input type="hidden" name="visibility" value="PUBLIC">
							</c:if>

							<!-- session에서 받아와용 ${session.getAttribute("username")}-->
							<input type="hidden" name="userId" value="1"
								readonly>


							<div class="form-group">
								<label>제목</label> <input type="text" name="title"
									class="form-control" value="${postDTO.title}">
							</div>

							<c:if test="${category eq 'notices' }">
								<div class="form-group">
									<div id="ajaxUpload">
										<label class="btn btn-secondary"> 사진찾기 <input
											style="display: none" type="file" name="uploadFile" multiple>
										</label>
										<p>첨부파일 최대 크기는 5MB 입니다.</p>
									</div>
								</div>
							</c:if>
							<div class="form-group">
								<label>추가 내용</label>
								<textarea name="content" class="form-control" rows="8">${postDTO.content}</textarea>
							</div>
							<c:if test="${category eq 'notices' }">
								<div style="display: flex; justify-content:flex-end;">
									 <select
										class="custom-select custom-select-sm form-control form-control-sm"
										style="width: 100px" name="pinned">
										<option value="0">일반</option>
										<option value="1">고정</option>
									</select> <select
										class="custom-select custom-select-sm form-control form-control-sm"
										style="width: 100px" name="visibility">
										<option value="PUBLIC">공개</option>
										<option value="PRIVATE">비공개</option>
									</select>
								</div>
							</c:if>
							<div class="text-right">
								<a href="${pageContext.request.contextPath}/admin/${category}"
									class="btn btn-light btn-icon-split">취소</a>
								<button type="submit" class="btn btn-success">등록</button>
							</div>

						</form>
					</c:if>

					<!-- 수정 -->
					<c:if test="${formType eq 'UPDATE'}">
						<form method="post" enctype="multipart/form-data"
							action="/admin/${category }/${postDTO.postId}/update">
							<!-- hidden @@@@@@@@@@@@@@@@@@-->
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" /> <input type="hidden" name="category"
								value="${category }">
							<!-- qna는 중요글 없음 -->
							<c:if test="${category eq 'notices' }">
								<select name="pinned">
									<option value="0">일반</option>
									<option value="1">고정</option>
								</select>
								<select name="visibility">
									<option value="PUBLIC">공개</option>
									<option value="PRIVATE">비공개</option>
								</select>
							</c:if>
							<c:if test="${category eq 'qna' }">
								<input type="hidden" name="pinned" value="0">
								<input type="hidden" name="visibility" value="PUBLIC">
							</c:if>

							<!-- session에서 받아와용 ${session.getAttribute("username")}-->
							<label>작성자</label><input type="text" name="userId" value="1"
								readonly>

							<div class="form-group">
								<label>제목</label> <input type="text" name="title"
									class="form-control" value="${postDTO.title}">
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
							<div class="text-right">
								<a
									href="${pageContext.request.contextPath}/admin/${category }/${postDTO.postId}"
									class="btn btn-light btn-icon-split">취소</a>
								<button type="submit" class="btn btn-success">수정</button>
							</div>
						</form>
					</c:if>
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