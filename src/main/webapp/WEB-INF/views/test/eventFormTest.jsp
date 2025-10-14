<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>이벤트 등록</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
.container {
	max-width: 900px;
	margin: 40px auto
}
</style>
</head>
<body>
	<div class="container">
		<h3 class="mb-3">이벤트 등록</h3>

		<form method="post"
			action="${pageContext.request.contextPath}/admin/events">
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" /> <input type="hidden" name="createdBy"
				value="${userId}" />

			<div class="mb-3">
				<label class="form-label">제목 *</label> <input type="text"
					name="title" class="form-control" required />
			</div>

			<div class="mb-3">
				<label class="form-label">설명</label>
				<textarea name="description" class="form-control" rows="3"></textarea>
			</div>

			<div class="mb-3">
				<label class="form-label">장소</label> <input type="text"
					name="location" class="form-control" />
			</div>

			<div class="row g-3">
				<div class="col-md-6">
					<label class="form-label">시작 일시 *</label> <input
						type="datetime-local" name="startDate" class="form-control"
						required />
				</div>
				<div class="col-md-6">
					<label class="form-label">종료 일시 *</label> <input
						type="datetime-local" name="endDate" class="form-control" required />
				</div>
			</div>

			<div class="row g-3 mt-1">
				<div class="col-md-4">
					<label class="form-label">정원</label> <input type="number"
						name="capacity" class="form-control" value="0" min="0" />
				</div>
				<div class="col-md-4">
					<label class="form-label">공개 여부</label> <select name="visibility"
						class="form-select">
						<option value="PUBLIC" selected>PUBLIC</option>
						<option value="PRIVATE">PRIVATE</option>
					</select>
				</div>
				<div class="col-md-4">
					<label class="form-label">상태</label> <select name="status"
						class="form-select">
						<option value="OPEN" selected>OPEN</option>
						<option value="DRAFT">DRAFT</option>
						<option value="CLOSED">CLOSED</option>
					</select>
				</div>
			</div>

			<div class="row g-3 mt-1">
				<div class="col-md-4">
					<label class="form-label">유료 여부</label> <select name="isPaid"
						class="form-select">
						<option value="0" selected>무료</option>
						<option value="1">유료</option>
					</select>
				</div>
				<div class="col-md-4">
					<label class="form-label">가격</label> <input type="number"
						name="price" class="form-control" step="1" min="0" />
				</div>
				<div class="col-md-4">
					<label class="form-label">통화</label> <input type="text"
						name="currency" class="form-control" value="KRW" />
				</div>
			</div>

			<div class="mb-3 mt-3">
				<label class="form-label">카테고리</label> <input type="text"
					name="category" class="form-control"
					placeholder="SHOW / SPEECH / WORKSHOP / MARKET ..." />
			</div>

			<div class="mb-3">
				<label class="form-label">포스터 URL</label> <input type="text"
					name="posterUrl" class="form-control" />
			</div>

			<div class="mt-3">
				<button type="submit" class="btn btn-dark">등록</button>
				<a href="${pageContext.request.contextPath}/survey-test/clone-form"
					class="btn btn-outline-secondary ms-2">취소</a>
			</div>
		</form>
	</div>
</body>
</html>
