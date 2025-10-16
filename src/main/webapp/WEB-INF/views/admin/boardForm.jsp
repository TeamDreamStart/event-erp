<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
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
				<c:if test="${boardType eq 'qna' }"> 문의
				</c:if>
				<c:if test="${boardType eq 'notices' }">공지
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
							action="/admin/${boardType}/form">
							<!-- hidden @@@@@@@@@@@@@@@@@@-->
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" /> <input type="hidden" name="category"
								value="${boardType eq 'qna' ? 'QNA' : 'NOTICE'}" />
							<!-- qna는 중요글 없음 -->
							<c:if test="${boardType eq 'qna' }">
								<input type="hidden" name="pinned" value="0">
								<input type="hidden" name="visibility" value="PUBLIC">
							</c:if>

							<!-- security에서 받아와용 -->
							<div class="form-group">
								<label>작성자</label> <input class="form-control" type="text"
									name="userId"
									value="<sec:authentication property='principal.userId' />"
									readonly />
							</div>


							<div class="form-group">
								<label>제목</label> <input type="text" name="title"
									class="form-control" value="${postDTO.title}">
							</div>

							<c:if test="${boardType eq 'notices' }">
								<div class="form-group">
									<div>
										<label class="btn btn-secondary" for="uploadFile">
											파일선택 <input style="display: none" type="file"
											name="uploadFile" id="uploadFile" accept="image/*" multiple>
										</label>
										<p>첨부파일 최대 크기는 5MB 입니다.</p>
									</div>
									<div id="preview"
										style="display: flex; gap: 10px; flex-wrap: wrap; margin-top: 10px;">

										<!-- 파일 미리보기 -->
									</div>
								</div>
							</c:if>
							<div class="form-group">
								<label>추가 내용</label>
								<textarea name="content" class="form-control" rows="8">${postDTO.content}</textarea>
							</div>
							<c:if test="${boardType eq 'notices' }">
								<div style="display: flex; justify-content: flex-end;">
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
								<a href="${pageContext.request.contextPath}/admin/${boardType}"
									class="btn btn-light btn-icon-split">취소</a>
								<button type="submit" class="btn btn-success">등록</button>
							</div>

						</form>
					</c:if>

					<!-- 수정 -->
					<c:if test="${formType eq 'UPDATE'}">
						<form method="post" enctype="multipart/form-data"
							action="/admin/${boardType }/${postDTO.postId}/update">
							<!-- hidden @@@@@@@@@@@@@@@@@@-->
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" /> <input type="hidden" name="category"
								value="<c:if test="${boardType eq 'qna' }">QNA</c:if>
				<c:if test="${boardType eq 'notices' }">NOTICE
				</c:if>">
							<!-- qna는 중요글 없음 -->
							<c:if test="${boardType eq 'notices' }">
								<select name="pinned">
									<option value="0"
										<c:if test="${postDTO.pinned == 0}">selected</c:if>>일반</option>
									<option value="1"
										<c:if test="${postDTO.pinned == 1}">selected</c:if>>고정</option>
								</select>
								<select name="visibility">
									<option value="PUBLIC"
										<c:if test="${postDTO.visibility eq 'PUBLIC'}">selected</c:if>>공개</option>
									<option value="PRIVATE"
										<c:if test="${postDTO.visibility eq 'PRIVATE'}">selected</c:if>>비공개</option>
								</select>
							</c:if>
							<c:if test="${boardType eq 'qna' }">
								<input type="hidden" name="pinned" value="0">
								<input type="hidden" name="visibility" value="PUBLIC">
							</c:if>

							<!-- security에서 받아와용 -->
							<div class="form-group">
								<label>작성자(수정시 기존 작성자 정보 삭제)</label> <input class="form-control"
									type="text" name="userId"
									value="<sec:authentication property='principal.userId' />"
									readonly />
							</div>


							<div class="form-group">
								<label>제목</label> <input type="text" name="title"
									class="form-control" value="${postDTO.title}">
							</div>

							<c:if test="${boardType eq 'notices' }">
								<!-- 파일 삭제 -->
								<c:if test="${fileList != null && !fileList.isEmpty()}">
									<div>
										<p>삭제</p>
										<c:forEach var="fileDTO" items="${fileList}">
											<label> <img
												src="${pageContext.request.contextPath}/resources/uploadTemp/${fileDTO.storedPath}/s_${fileDTO.uuid}_${fileDTO.originalName}"
												alt="${fileDTO.originalName}"> <input type="checkbox"
												name="deleteFileList" value="${fileDTO.fileId }">
											</label>
										</c:forEach>
									</div>
								</c:if>
								<div class="form-group">
									<div>
										<label class="btn btn-secondary" for="uploadFile">
											파일선택 <input style="display: none" type="file"
											name="uploadFile" id="uploadFile" accept="image/*" multiple>
										</label> <span>첨부파일 최대 크기는 5MB 입니다.</span>
									</div>
									<!-- 파일 미리보기 -->
									<div id="preview"
										style="display: flex; gap: 10px; flex-wrap: wrap; margin-top: 10px;">

									</div>
								</div>
							</c:if>

							<div class="form-group">
								<label>내용</label>
								<textarea name="content" class="form-control" rows="8">${postDTO.content}</textarea>
							</div>
							<div class="text-right">
								<a
									href="${pageContext.request.contextPath}/admin/${boardType }/${postDTO.postId}"
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
	<script>
									document.getElementById("uploadFile").addEventListener("change", function(event) {
										  const files = event.target.files;
										  const preview = document.getElementById("preview");

										  // 기존 미리보기 초기화
										  preview.innerHTML = "";

										  // 이미지가 아닌 파일 있으면 등록 막기
										  for (let file of files) {
										    if (!file.type.startsWith("image/")) {
										      alert("이미지 파일만 업로드할 수 있습니다.");
										      event.target.value = "";
										      preview.innerHTML = "<span>미리보기</span>";
										      return;
										    }
										  }

										  // 선택된 파일마다 미리보기 + 파일 이름 표시
										  Array.from(files).forEach(file => {
										    const container = document.createElement("div");
										    container.style.display = "flex";
										    container.style.flexDirection = "column";
										    container.style.alignItems = "center";
										    container.style.margin = "5px";

										    // 파일 이름
										    const nameSpan = document.createElement("span");
										    nameSpan.textContent = file.name;
										    nameSpan.style.fontSize = "12px";
										    nameSpan.style.textAlign = "center";

										    // 이미지 미리보기
										    const reader = new FileReader();
										    reader.onload = e => {
										      const img = document.createElement("img");
										      img.src = e.target.result;
										      img.style.maxWidth = "100px";
										      img.style.border = "1px solid #ccc";
										      container.appendChild(nameSpan);
										      container.appendChild(img);
										      preview.appendChild(container);
										    };
										    reader.readAsDataURL(file);
										  });
										});
									document.addEventListener('DOMContentLoaded', function() {
										  document.querySelectorAll('input, select, textarea').forEach(el => {
										    if (el.type === 'hidden' || el.type === 'file' || el.type === 'checkbox') {
										      el.removeAttribute('required'); // 🔥 이렇게 해야 진짜 비활성화됨
										    } else {
										      el.setAttribute('required', ''); // 필수 적용
										    }
										  });
										});

</script>
</body>
</html>