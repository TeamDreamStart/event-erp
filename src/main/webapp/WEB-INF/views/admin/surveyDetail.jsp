<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>설문 상세</title>
<style>
body {
	font-family: system-ui, -apple-system, Segoe UI, Roboto, "Noto Sans KR",
		Arial, sans-serif;
}

.wrap {
	max-width: 1000px;
	margin: 24px auto;
	padding: 0 16px;
}

.card {
	background: #fff;
	border: 1px solid #eee;
	border-radius: 12px;
	padding: 16px;
	margin-bottom: 12px;
}

.muted {
	color: #6b7280;
	font-size: 13px;
}

.q {
	padding: 12px 0;
	border-top: 1px dashed #e5e7eb;
}

.q:first-child {
	border-top: 0;
}

.opt {
	margin-left: 12px;
	color: #374151;
	font-size: 14px;
}
</style>
</head>
<body>
	<div class="wrap">
		<h2>설문 상세</h2>

		<div class="card">
			<div>
				<b>${survey.title}</b>
			</div>
			<div class="muted">${survey.description}</div>
			<div class="muted">
				상태: ${survey.status} · 익명:
				<c:out value="${survey.isAnonymous==1?'Y':'N'}" />
				· 오픈: ${empty survey.openAt ? '-' : survey.openAt} · 마감: ${empty survey.closeAt ? '-' : survey.closeAt}
			</div>
		</div>

		<div class="card">
			<h4 style="margin: 0 0 8px">문항</h4>
			<c:forEach var="q" items="${questions}" varStatus="st">
				<div class="q">
					<div>
						<b>${st.index+1}. ${q.question}</b> <span class="muted">(${q.type})</span>
					</div>
					<c:forEach var="op" items="${optionsByQ[q.questionId]}">
						<div class="opt">
							- ${op.label}
							<c:if test="${not empty op.optValue}">(${op.optValue})</c:if>
						</div>
					</c:forEach>
				</div>
			</c:forEach>
		</div>

		<div>
			<a href="${pageContext.request.contextPath}/admin/survey-list"
				style="text-decoration: none;">← 목록으로</a>
		</div>
	</div>
</body>
</html>
