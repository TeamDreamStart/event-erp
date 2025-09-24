<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설문 템플릿 클론</title>

<link rel="stylesheet"
	href="https://bootswatch.com/3/paper/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<style>
.page-title {
	font-weight: 600;
	font-size: 26px;
	color: #444;
	margin-top: 20px;
}

.btn-primary, .label-primary {
	background: #2196f3;
	border-color: #2196f3;
}

.help {
	color: #777;
	font-size: 13px;
}
</style>
</head>
<body>
	<div class="container">
		<div class="page-header">
			<h2 class="page-title">설문 템플릿 클론</h2>
			<p class="help">템플릿을 이벤트용 설문으로 복제합니다. (이벤트 종료 즉시 오픈, 7일 뒤 자동 종료)</p>
		</div>

		<c:if test="${not empty error}">
			<div class="alert alert-danger">${error}</div>
		</c:if>
		<c:if test="${not empty msg}">
			<div class="alert alert-success">${msg}</div>
		</c:if>

		<form class="form-horizontal" method="post"
			action="${pageContext.request.contextPath}/survey-test/clone">
			<div class="form-group">
				<label class="col-sm-2 control-label">템플릿 ID</label>
				<div class="col-sm-6">
					<input type="number" name="templateId" class="form-control"
						value="${param.templateId != null ? param.templateId : 2}"
						required>
					<p class="help">
						예:
						<code>2</code>
						(템플릿 PK)
					</p>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-2 control-label">이벤트 ID</label>
				<div class="col-sm-6">
					<input type="number" name="eventId" class="form-control"
						value="${param.eventId != null ? param.eventId : 1}" required>
					<p class="help">
						예:
						<code>1</code>
						(클론을 붙일 이벤트 PK)
					</p>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-2 control-label">작성자(관리자) ID</label>
				<div class="col-sm-6">
					<input type="number" name="userId" class="form-control"
						value="${param.userId != null ? param.userId : 258}" required>
					<p class="help">
						예:
						<code>258</code>
					</p>
				</div>
			</div>

			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-6">
					<button type="submit" class="btn btn-primary">
						<span class="glyphicon glyphicon-duplicate"></span> 클론 실행
					</button>
					<a
						href="${pageContext.request.contextPath}/survey-test?eventId=${param.eventId}"
						class="btn btn-default">목록으로</a>
				</div>
			</div>
		</form>

		<hr>

		<p class="help">
			* 트리거 정책 상
			<code>is_template=1</code>
			원본은 수정/삭제 불가입니다. 이 폼으로 생성되는 클론은 수정/삭제 가능.<br> * 현재 설정: 이벤트 종료 시각
			=
			<code>open_at</code>
			, 종료 + 7일 =
			<code>close_at</code>
			.
		</p>
	</div>
</body>
</html>
