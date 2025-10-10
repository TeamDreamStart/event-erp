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

<title>Admin-userDetail/Form</title>

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
			<h1 class="h3 mb-2 text-gray-800">UserDetail/Form</h1>

			<!-- DataTales Example -->
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary">userDetail/Form</h6>
				</div>
				<div class="card-body">
					<form action="/user-manage/${userDTO.userId }" method="post">
						<input type="hidden" name="userId" value="${userDTO.userId}" />

						<div class="row mb-3">
							<div class="col-md-6">
								<label class="form-label fw-bold">아이디 (username)</label> <input
									type="text" class="form-control" name="userName"
									value="${userDTO.userName}" readonly />
							</div>
							<div class="col-md-6">
								<label class="form-label fw-bold">이름</label> <input type="text"
									class="form-control" name="name" value="${userDTO.name}" />
							</div>
						</div>

						<div class="row mb-3">
							<div class="col-md-6">
								<label class="form-label fw-bold">이메일</label> <input
									type="email" class="form-control" name="email"
									value="${userDTO.email}" />
							</div>
							<div class="col-md-6">
								<label class="form-label fw-bold">전화번호</label> <input
									type="text" class="form-control" name="phone"
									value="${userDTO.phone}" />
							</div>
						</div>

						<div class="row mb-3">
							<div class="col-md-4">
								<label class="form-label fw-bold">성별</label> <select
									class="form-select" name="gender">
									<option value="0" ${userDTO.gender == 0 ? 'selected' : ''}>여성</option>
									<option value="1" ${userDTO.gender == 1 ? 'selected' : ''}>남성</option>
								</select>
							</div>
							<div class="col-md-4">
								<label class="form-label fw-bold">생년월일</label> <input
									type="date" class="form-control" name="birthDate"
									value="${userDTO.birthDate}" />
							</div>
							<div class="col-md-4">
								<label class="form-label fw-bold">상태</label> <select
									class="form-select" name="isActive">
									<option value="1" ${userDTO.isActive == 1 ? 'selected' : ''}>활동중</option>
									<option value="0" ${userDTO.isActive == 0 ? 'selected' : ''}>비활성화</option>
								</select>
							</div>
						</div>

						<div class="row mb-3">
							<div class="col-md-6">
								<label class="form-label fw-bold">가입일</label> <input type="text"
									class="form-control" value="${userDTO.createdAt}" readonly />
							</div>
							<div class="col-md-6">
								<label class="form-label fw-bold">최근 로그인</label> <input
									type="text" class="form-control" value="${userDTO.lastLoginAt}"
									readonly />
							</div>
						</div>

						<div class="row mb-3">
							<div class="col-md-6">
								<label class="form-label fw-bold">역할(Role)</label> <select
									class="form-select" name="roleName">
									<option value="ADMIN"
										${userDTO.roleName == 'ADMIN' ? 'selected' : ''}>관리자</option>
									<option value="MEMBER"
										${userDTO.roleName == 'MEMBER' ? 'selected' : ''}>일반회원</option>
								</select>
							</div>
						</div>

						<div class="text-center mt-4">
							<button type="submit" class="btn btn-primary">
								<i class="fas fa-save"></i> 수정 저장
							</button>
							<a href="/admin/user-manage" class="btn btn-light border ms-2">
								취소 </a>
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