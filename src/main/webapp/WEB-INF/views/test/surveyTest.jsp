<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설문 목록</title>

<link href="https://bootswatch.com/3/paper/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<style>
:root { -
	-accent: #2196f3; -
	-accent-dark: #1e88e5; -
	-muted: #6b7280;
}

/* 타이틀 */
.hero {
	text-align: center;
	margin: 28px 0 8px;
}

.hero .page-title {
	font-size: 28px;
	font-weight: 600;
	color: #444;
}

/* 메타/필터 */
.meta-bar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin: 8px 0 14px;
}

.meta-total {
	color: var(- -muted);
	font-size: 14px;
}

.meta-total b {
	color: #333;
}

.chipbar {
	display: flex;
	gap: 10px;
	align-items: center;
}

/* 칩 셀렉트 + 아이콘 */
.select-pill {
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	border-radius: 9999px;
	border: 2px solid var(- -accent);
	background: #fff;
	padding: 6px 36px 6px 14px;
	font-size: 14px;
	color: #333;
	background-image:
		url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='14' height='14' viewBox='0 0 20 20' fill='%236b7280'%3E%3Cpath d='M5.23 7.21a.75.75 0 011.06.02L10 10.94l3.71-3.71a.75.75 0 111.06 1.06l-4.24 4.24a.75.75 0 01-1.06 0L5.25 8.29a.75.75 0 01-.02-1.08z'/%3E%3C/svg%3E");
	background-repeat: no-repeat;
	background-position: right 12px center;
	background-size: 12px 12px;
}

.select-pill:focus {
	outline: none;
	box-shadow: 0 0 0 3px rgba(33, 150, 243, .2);
}

select::-ms-expand {
	display: none;
}

.input-pill {
	border-radius: 9999px;
	border: 1px solid #e5e7eb;
	padding: 8px 14px;
	width: 240px;
}

.btn-primary {
	background: var(- -accent);
	border-color: var(- -accent);
}

.btn-primary:hover {
	background: var(- -accent-dark);
	border-color: var(- -accent-dark);
}

/* 표 */
.table-wrap {
	border-radius: 12px;
	overflow: hidden;
}

.table>thead>tr>th {
	background: #111827;
	color: #fff;
	border-color: #111827;
	font-weight: 600;
}

.section-title {
	background: #f7f7f9;
	padding: 8px 12px;
	font-weight: 600;
	color: #555;
	border: 1px solid #eee;
	border-bottom: none;
	border-radius: 12px 12px 0 0;
}

.row-template {
	background: linear-gradient(90deg, rgba(33, 150, 243, .10),
		rgba(33, 150, 243, .03));
}

.row-muted {
	color: #6b7280;
}

/* pagination */
.pagination>li>a, .pagination>li>span {
	border-radius: 8px;
	margin: 0 3px;
	border: 1px solid #e5e7eb;
	color: #374151;
}

.pagination>.active>a, .pagination>.active>span, .pagination>.active>a:hover,
	.pagination>.active>span:hover {
	background: var(- -accent);
	border-color: var(- -accent);
	color: #fff;
}

/* 긴 텍스트 줄임 */
.ellipsis {
	max-width: 420px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
</style>
</head>
<body>
	<div class="container">

		<!-- 타이틀 -->
		<div class="hero">
			<h2 class="page-title">설문 목록</h2>
		</div>

		<!-- 총건수 + 필터 -->
		<div class="meta-bar">
			<div class="meta-total">
				총 <b>${total}</b> 건
			</div>

			<form class="chipbar"
				action="${pageContext.request.contextPath}/survey-test" method="get">
				<!-- (예시) 카테고리/검색대상 -->
				<select class="select-pill" name="category">
					<option value="">전체</option>
					<option value="notice"
						${param.category == 'notice' ? 'selected' : ''}>안내사항</option>
					<option value="recruit"
						${param.category == 'recruit' ? 'selected' : ''}>공개모집</option>
					<option value="result"
						${param.category == 'result' ? 'selected' : ''}>결과발표</option>
				</select> <select class="select-pill" name="target">
					<option value="">전체</option>
					<option value="title"
						${param.target == 'title'   ? 'selected' : ''}>제목</option>
					<option value="content"
						${param.target == 'content' ? 'selected' : ''}>내용</option>
				</select> <select class="select-pill" name="perPageNum">
					<c:forTokens items="10,20,50" delims="," var="n">
						<option value="${n}"
							<c:if test="${param.perPageNum == n or (empty param.perPageNum and cri.perPageNum == n)}">selected</c:if>>${n}개</option>
					</c:forTokens>
				</select> <input type="text" name="keyword" class="input-pill"
					placeholder="검색어를 입력하세요" value="${fn:escapeXml(keyword)}">
				<input type="hidden" name="eventId" value="${eventId}"> <input
					type="hidden" name="page" value="1">
				<button type="submit" class="btn btn-primary">검색</button>
			</form>
		</div>

		<!-- ====== [Pinned] 템플릿 4개 고정 섹션 ====== -->
		<div class="section-title">템플릿 (고정)</div>
		<div class="table-wrap"
			style="border: 1px solid #eee; border-top: none;">
			<table class="table">
				<thead>
					<tr>
						<th>survey_id</th>
						<th>event_id</th>
						<th>title</th>
						<th>description</th>
						<th>status</th>
						<th>익명</th>
						<th>clone_from_survey_id</th>
						<th>open_at</th>
						<th>close_at</th>
						<th>created_by</th>
						<th>created_at</th>
						<th>update_at</th>
						<th>is_template</th>
						<th>template_key</th>
						<th style="width: 180px;">관리</th>
					</tr>
				</thead>
				<tbody>
					<!-- templateList가 있으면 그것을, 없으면 surveyList에서 is_template==true 상위 4개만 -->
					<c:set var="tplCount" value="0" />
					<c:forEach var="t"
						items="${empty templateList ? surveyList : templateList}">
						<c:if test="${(empty templateList and t.isTemplate == 1) or (not empty templateList)}">
							<c:if test="${tplCount lt 4}">
								<tr class="row-template">
									<td>${t.surveyId}</td>
									<td class="row-muted">${t.eventId}</td>
									<td class="ellipsis">${t.title}</td>
									<td class="ellipsis">${t.description}</td>
									<td>${t.status}</td>
									<td>
										<c:choose>
											<c:when test="${t.isAnonymous == 1}">Y</c:when>
											<c:otherwise>N</c:otherwise>
										</c:choose>
									</td>
									<td class="row-muted">${t.cloneFromSurveyId}</td>
									<td>${t.openAt}</td>
									<td>${t.closeAt}</td>
									<td>${t.createdBy}</td>
									<td>${t.createdAt}</td>
									<td>${t.updateAt}</td>
									<td>Y</td>
									<td>${t.templateKey}</td>
									<td>
										<!-- 복제 폼으로 이동 --> 
										<c:url var="cloneUrl"
											value="/survey-test/clone-form">
											<c:param name="templateId" value="${t.surveyId}" />
											<c:param name="eventId" value="${eventId}" />
											<c:param name="userId" value="258" />
										</c:url> <a href="${cloneUrl}" class="btn btn-xs btn-primary"
										style="background: #2196f3; border-color: #2196f3;">복제</a> <a
										class="btn btn-xs btn-default disabled" title="템플릿은 수정/삭제 불가">수정</a>
										<a class="btn btn-xs btn-default disabled"
										title="템플릿은 수정/삭제 불가">삭제</a>
									</td>
								</tr>
								<c:set var="tplCount" value="${tplCount + 1}" />
							</c:if>
						</c:if>
					</c:forEach>
					<c:if test="${tplCount == 0}">
						<tr>
							<td colspan="15" class="text-center" style="color: #6b7280;">고정
								템플릿이 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>

		<hr style="margin: 18px 0;">

		<!-- ====== 일반/클론 설문 목록 (템플릿 제외) ====== -->
		<div class="table-wrap">
			<table class="table table-hover">
				<thead>
					<tr>
						<th>survey_id</th>
						<th>event_id</th>
						<th>title</th>
						<th>description</th>
						<th>status</th>
						<th>익명</th>
						<th>clone_from_survey_id</th>
						<th>open_at</th>
						<th>close_at</th>
						<th>created_by</th>
						<th>created_at</th>
						<th>update_at</th>
						<th>is_template</th>
						<th>template_key</th>
						<th style="width: 220px;">액션</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty surveyList}">
							<tr>
								<td colspan="15" class="text-center" style="color: #6b7280;">데이터가
									없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="s" items="${surveyList}">
								<!-- 템플릿은 위 섹션에서 보여주므로 제외 -->
								<c:if test="${not s.isTemplate}">
									<tr>
										<td>${s.surveyId}</td>
										<td>${s.eventId}</td>
										<td class="ellipsis">${s.title}</td>
										<td class="ellipsis">${s.description}</td>
										<td>${s.status}</td>
										<td><c:choose>
												<c:when test="${s.isAnonymous}">Y</c:when>
												<c:otherwise>N</c:otherwise>
											</c:choose></td>
										<td>${s.cloneFromSurveyId}</td>
										<td>${s.openAt}</td>
										<td>${s.closeAt}</td>
										<td>${s.createdBy}</td>
										<td>${s.createdAt}</td>
										<td>${s.updateAt}</td>
										<td><c:choose>
												<c:when test="${s.isTemplate}">Y</c:when>
												<c:otherwise>N</c:otherwise>
											</c:choose></td>
										<td>${s.templateKey}</td>
										<td><c:url var="surveyDetailUrl"
												value="/surveys/${s.surveyId}" /> <c:url
												var="eventDetailUrl" value="/events/${s.eventId}" /> <a
											href="${surveyDetailUrl}" class="btn btn-xs btn-default">설문보기</a>
											<a href="${eventDetailUrl}" class="btn btn-xs btn-default">이벤트</a>

											<!-- 클론인 경우만 수정/삭제 허용 -->
											<c:choose>
												<c:when test="${s.cloneFromSurveyId != null}">
													<c:url var="editUrl"
														value="/admin/surveys/${s.surveyId}/update" />
													<c:url var="delUrl"
														value="/admin/surveys/${s.surveyId}/delete" />
													<a href="${editUrl}" class="btn btn-xs btn-primary"
														style="background: #2196f3; border-color: #2196f3;">수정</a>
													<a href="${delUrl}" class="btn btn-xs btn-danger"
														onclick="return confirm('삭제하시겠습니까?')">삭제</a>
												</c:when>
												<c:otherwise>
													<a class="btn btn-xs btn-default disabled"
														title="클론이 아닌 설문은 수정/삭제 불가">수정</a>
													<a class="btn btn-xs btn-default disabled"
														title="클론이 아닌 설문은 수정/삭제 불가">삭제</a>
												</c:otherwise>
											</c:choose></td>
									</tr>
								</c:if>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>

		<!-- lastPage 계산 -->
		<c:set var="lastPage"
			value="${(total + cri.perPageNum - 1) / cri.perPageNum}" />

		<!-- 페이지네이션 -->
		<div class="text-center" style="margin-top: 10px;">
			<ul class="pagination">
				<c:if test="${pageVO.prev}">
					<li><c:url var="firstUrl" value="/survey-test">
							<c:param name="eventId" value="${eventId}" />
							<c:param name="keyword" value="${keyword}" />
							<c:param name="page" value="1" />
							<c:param name="perPageNum" value="${cri.perPageNum}" />
						</c:url> <a href="${firstUrl}">&laquo;</a></li>
					<li><c:url var="prevUrl" value="/survey-test">
							<c:param name="eventId" value="${eventId}" />
							<c:param name="keyword" value="${keyword}" />
							<c:param name="page" value="${pageVO.startPage-1}" />
							<c:param name="perPageNum" value="${cri.perPageNum}" />
						</c:url> <a href="${prevUrl}">이전</a></li>
				</c:if>

				<c:forEach var="p" begin="${pageVO.startPage}"
					end="${pageVO.endPage}">
					<c:url var="pageUrl" value="/survey-test">
						<c:param name="eventId" value="${eventId}" />
						<c:param name="keyword" value="${keyword}" />
						<c:param name="page" value="${p}" />
						<c:param name="perPageNum" value="${cri.perPageNum}" />
					</c:url>
					<li class="<c:out value='${cri.page == p ? "active" : ""}'/>"><a
						href="${pageUrl}">${p}</a></li>
				</c:forEach>

				<c:if test="${pageVO.next}">
					<li><c:url var="nextUrl" value="/survey-test">
							<c:param name="eventId" value="${eventId}" />
							<c:param name="keyword" value="${keyword}" />
							<c:param name="page" value="${pageVO.endPage+1}" />
							<c:param name="perPageNum" value="${cri.perPageNum}" />
						</c:url> <a href="${nextUrl}">다음</a></li>
					<li><c:url var="lastUrl" value="/survey-test">
							<c:param name="eventId" value="${eventId}" />
							<c:param name="keyword" value="${keyword}" />
							<c:param name="page" value="${lastPage}" />
							<c:param name="perPageNum" value="${cri.perPageNum}" />
						</c:url> <a href="${lastUrl}">&raquo;</a></li>
				</c:if>
			</ul>
		</div>

	</div>
</body>
</html>
