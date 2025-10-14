<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>설문 목록</title>
<style>
:root { -
	-bg: #f7f8fb; -
	-ink: #111827; -
	-muted: #6b7280; -
	-brand: #2563eb; -
	-brand-ink: #fff; -
	-row: #ffffff; -
	-row-alt: #fafafa; -
	-chip: #e5edff; -
	-chip-ink: #2643a5; -
	-chip-gray: #e5e7eb;
}

* {
	box-sizing: border-box
}

body {
	background: var(- -bg);
	color: var(- -ink);
	font-family: system-ui, -apple-system, Segoe UI, Roboto, "Noto Sans KR",
		Arial, sans-serif;
}

.page {
	padding: 20px 24px
}

.title {
	font-size: 22px;
	font-weight: 800;
	margin: 6px 0 4px
}

.subtitle {
	font-size: 13px;
	color: var(- -muted);
	margin-bottom: 16px
}

/* filters */
.filters {
	display: flex;
	gap: 10px;
	align-items: center;
	margin-bottom: 10px;
	flex-wrap: wrap
}

.select, .input, .btn {
	height: 38px;
	border-radius: 10px;
	border: 1px solid #e5e7eb;
	background: #fff;
	padding: 0 12px;
	font-size: 14px
}

.select {
	padding-right: 32px
}

.input {
	flex: 1;
	min-width: 240px
}

.btn {
	background: var(- -brand);
	color: var(- -brand-ink);
	border: none;
	padding: 0 14px;
	font-weight: 600;
	cursor: pointer
}

.btn:disabled {
	opacity: .5;
	cursor: not-allowed
}

.count {
	font-size: 13px;
	color: var(- -muted);
	margin: 10px 0
}

/* table */
.table-wrap {
	overflow: visible
}

table {
	width: 100%;
	border-collapse: separate;
	border-spacing: 0;
	table-layout: fixed;
	min-width: 0
}

thead th {
	position: sticky;
	top: 0;
	z-index: 1;
	background: #0e1320;
	color: #fff;
	font-weight: 700;
	font-size: 13px;
	text-align: left;
	padding: 12px 14px;
	white-space: nowrap
}

tbody td {
	padding: 12px 14px;
	font-size: 13px;
	color: var(- -ink);
	border-top: 1px solid #eef2ff;
	background: var(- -row);
	vertical-align: middle
}

tbody tr:nth-child(even) td {
	background: var(- -row-alt)
}

tbody tr:hover td {
	background: #eef2ff !important
}

td {
	transition: background-color .15s ease-out
}

td.ellip {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis
}

.center {
	text-align: center
}

.pinned-row td {
	background: #f5f8ff
}

.pinned-row:hover td {
	background: #eaf1ff !important
}

th, td {
	vertical-align: middle
}

th.col-id, td.col-id {
	width: 72px
}

th.col-small, td.col-small {
	width: 86px
}

th.col-mid, td.col-mid {
	width: 120px
}

th.col-wide, td.col-wide {
	width: 260px
}

td.col-date {
	font-variant-numeric: tabular-nums
}

/* badge */
.badge {
	display: inline-block;
	padding: 3px 8px;
	border-radius: 999px;
	font-size: 12px;
	font-weight: 700;
	background: var(- -chip-gray)
}

.badge.blue {
	background: var(- -chip);
	color: var(- -chip-ink)
}

.badge.gray {
	background: var(- -chip-gray);
	color: #374151
}

.badge.ghost {
	background: #f1f5f9;
	color: #0f172a
}

.anon {
	display: inline-flex;
	align-items: center;
	gap: 6px
}

.pill {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	width: 22px;
	height: 22px;
	border-radius: 999px;
	font-size: 12px
}

.pill.y {
	background: #e6f6ff
}

.pill.n {
	background: #ffe9e9
}

.pill.y span {
	color: #0369a1;
	font-weight: 700
}

.pill.n span {
	color: #b91c1c;
	font-weight: 700
}

/* pager */
.pager {
	display: flex;
	justify-content: center;
	gap: 8px;
	padding: 14px 4px 8px
}

.page-btn {
	min-width: 38px;
	height: 36px;
	padding: 0 12px;
	border-radius: 10px;
	border: 1px solid #e5e7eb;
	background: #fff;
	color: #111827;
	font-weight: 600;
	display: inline-flex;
	align-items: center;
	justify-content: center
}

.page-btn.active {
	background: var(- -brand);
	color: var(- -brand-ink);
	border-color: transparent
}

.page-btn[hidden] {
	display: none
}

.page-btn:disabled {
	opacity: .45;
	cursor: not-allowed
}

/* ───── 반응형: 가로 스크롤 없이 열 접기 ─────
   중요도 낮은 열부터 단계적으로 숨김  */
@media ( max-width :1400px) {
	.col-template-key {
		display: none
	}
}

@media ( max-width :1280px) {
	.col-updated-at, .col-created-by {
		display: none
	}
}

@media ( max-width :1120px) {
	.col-clone-from {
		display: none
	}
}

@media ( max-width :992px) {
	.col-open-at, .col-close-at {
		display: none
	}
}

@media ( max-width :860px) {
	.col-desc {
		display: none
	}
}

@media ( max-width :768px) {
	.col-event-id {
		display: none
	}
}

@media ( max-width :640px) {
	.col-created-at {
		display: none
	}
}

/* 살짝 더 촘촘하게 */
@media ( max-width :992px) {
	thead th, tbody td {
		padding: 10px 10px
	}
}
</style>
</head>
<body>
	<div class="page">
		<div class="title">설문 목록</div>
		<div
			style="display: flex; justify-content: space-between; align-items: center; gap: 12px; margin: 6px 0 16px;">
			<div class="subtitle">템플릿과 이벤트용 설문을 한 눈에 확인하세요.</div>

			<a
				href="${pageContext.request.contextPath}/survey-test/clone-form?eventId=${param.eventId}&userId=${empty sessionScope.loginUser ? 0 : sessionScope.loginUser.userId}"
				class="btn"
				style="background: #111827; color: #fff; border: 0; border-radius: 10px; height: 38px; display: inline-flex; align-items: center; padding: 0 14px; font-weight: 700;">
				템플릿 복제하기 </a>
		</div>


		<!-- filters -->
		<form id="searchForm" method="get" class="filters">
			<select name="field" id="fieldSel" class="select">
				<option value="all"
					${param.field == 'all'   || empty param.field ? 'selected' : ''}>전체</option>
				<option value="title" ${param.field == 'title' ? 'selected' : ''}>제목</option>
				<option value="status" ${param.field == 'status'? 'selected' : ''}>상태</option>
				<option value="anon" ${param.field == 'anon'  ? 'selected' : ''}>익명/실명</option>
			</select>

			<!-- 상태(필드가 status일 때만) -->
			<select id="statusSel" class="select"
				${param.field != 'status' ? 'style="display:none"' : ''}>
				<option value="">상태(전체)</option>
				<c:set var="kw" value="${param.keyword}" />
				<option value="DRAFT" ${kw == 'DRAFT'    ? 'selected' : ''}>DRAFT</option>
				<option value="OPEN" ${kw == 'OPEN'     ? 'selected' : ''}>OPEN</option>
				<option value="CLOSED" ${kw == 'CLOSED'   ? 'selected' : ''}>CLOSED</option>
				<option value="ARCHIVED" ${kw == 'ARCHIVED' ? 'selected' : ''}>ARCHIVED</option>
			</select>

			<!-- 익명/실명(필드가 anon일 때만) -->
			<select id="anonSel" class="select"
				${param.field != 'anon' ? 'style="display:none"' : ''}>
				<option value="">익명/실명(전체)</option>
				<option value="1" ${param.anon == '1' ? 'selected' : ''}>익명</option>
				<option value="0" ${param.anon == '0' ? 'selected' : ''}>실명</option>
			</select>

			<!-- 텍스트 검색 -->
			<input id="kwInput" type="text" class="input" name="keyword"
				placeholder="검색어를 입력하세요" value="${fn:escapeXml(param.keyword)}"
				${param.field == 'status' || param.field == 'anon' ? 'style="display:none"' : ''} />

			<!-- 페이지 크기 -->
			<select name="perPageNum" class="select"
				onchange="document.getElementById('searchForm').submit()">
				<c:set var="pp" value="${cri.perPageNum}" />
				<c:forEach var="n" begin="10" end="50" step="10">
					<option value="${n}" ${pp == n ? 'selected' : ''}>${n}개</option>
				</c:forEach>
			</select>

			<button type="submit" class="btn">검색</button>

			<!-- 유지 파라미터 -->
			<input type="hidden" name="page" value="1" />
			<c:if test="${not empty eventId}">
				<input type="hidden" name="eventId" value="${eventId}" />
			</c:if>

			<!-- 동기화 hidden -->
			<input type="hidden" name="anon" id="anonHidden"
				value="${param.anon}" /> <input type="hidden" name="keyword"
				id="statusHidden"
				value="${param.field=='status' ? param.keyword : ''}" />
		</form>

		<div class="count">총 ${total}건</div>

		<div class="table-wrap">
			<table id="tbl">
				<thead>
					<tr>
						<th class="center col-id">설문ID</th>
						<th class="center col-small col-event-id">이벤트ID</th>
						<th class="col-wide">제목</th>
						<th class="col-wide col-desc">설명</th>
						<th class="center col-mid">상태</th>
						<th class="center col-mid">익명/실명</th>
						<th class="center col-mid col-clone-from">원본 설문ID</th>
						<th class="center col-date col-open-at">오픈 시각</th>
						<th class="center col-date col-close-at">마감 시각</th>
						<th class="center col-small col-created-by">생성자</th>
						<th class="center col-date col-created-at">생성 일시</th>
						<th class="center col-date col-updated-at">수정 일시</th>
						<th class="center col-small">템플릿</th>
						<th class="col-mid col-template-key">템플릿 키</th>
						<th class="center col-small">상세</th>
					</tr>
				</thead>

				<!-- 고정 템플릿 -->
				<tbody>
					<c:forEach var="s" items="${fixedList}">
						<tr class="pinned-row">
							<td class="center col-id" data-value="${s.surveyId}">${s.surveyId}</td>
							<td class="center col-small col-event-id"
								data-value="${s.eventId}">-</td>
							<td class="ellip col-wide" title="${fn:escapeXml(s.title)}"
								data-value="${s.title}">📌 <strong>[고정]</strong> ${s.title}
							</td>
							<td class="ellip col-wide col-desc"
								title="${fn:escapeXml(s.description)}"
								data-value="${s.description}">${s.description}</td>
							<td class="center col-mid" data-value="${s.status}"><span
								class="badge blue">${s.status}</span></td>
							<td class="center col-mid" data-value="${s.isAnonymous}"><span
								class="anon"> <span
									class="pill ${s.isAnonymous == 1 ? 'y':'n'}"><span>${s.isAnonymous == 1 ? '익명':'실명'}</span></span>
									<span class="badge ghost">${s.isAnonymous == 1 ? 'Y':'N'}</span>
							</span></td>
							<td class="center col-mid col-clone-from"
								data-value="${s.cloneFromSurveyId}">-</td>
							<td class="center col-date col-open-at" title="${s.openAt}"
								data-value="${s.openAt}">-</td>
							<td class="center col-date col-close-at" title="${s.closeAt}"
								data-value="${s.closeAt}">-</td>
							<td class="center col-small col-created-by"
								data-value="${s.createdBy}">${s.createdBy}</td>
							<td class="center col-date col-created-at" title="${s.createdAt}"
								data-value="${s.createdAt}">${s.createdAt}</td>
							<td class="center col-date col-updated-at" title="${s.updateAt}"
								data-value="${s.updateAt}">${s.updateAt}</td>
							<td class="center col-small" data-value="${s.isTemplate}"><span
								class="badge gray">Y</span></td>
							<td class="ellip col-mid col-template-key"
								title="${s.templateKey}" data-value="${s.templateKey}">${s.templateKey}</td>
							<td class="center col-small"><a class="page-btn"
								href="${pageContext.request.contextPath}/survey-test/detail?surveyId=${s.surveyId}">상세</a></td>
						</tr>
					</c:forEach>
				</tbody>

				<!-- 일반 설문 -->
				<tbody>
					<c:forEach var="s" items="${surveyList}">
						<tr>
							<td class="center col-id" data-value="${s.surveyId}">${s.surveyId}</td>
							<td class="center col-small col-event-id"
								data-value="${s.eventId}">${empty s.eventId ? '-' : s.eventId}</td>
							<td class="ellip col-wide" title="${fn:escapeXml(s.title)}"
								data-value="${s.title}">${s.title}</td>
							<td class="ellip col-wide col-desc"
								title="${fn:escapeXml(s.description)}"
								data-value="${s.description}">${s.description}</td>
							<td class="center col-mid" data-value="${s.status}"><span
								class="badge blue">${s.status}</span></td>
							<td class="center col-mid" data-value="${s.isAnonymous}"><span
								class="anon"> <span
									class="pill ${s.isAnonymous == 1 ? 'y':'n'}"><span>${s.isAnonymous == 1 ? '익명':'실명'}</span></span>
									<span class="badge ghost">${s.isAnonymous == 1 ? 'Y':'N'}</span>
							</span></td>
							<td class="center col-mid col-clone-from"
								data-value="${s.cloneFromSurveyId}">${empty s.cloneFromSurveyId ? '-' : s.cloneFromSurveyId}</td>
							<td class="center col-date col-open-at" title="${s.openAt}"
								data-value="${s.openAt}">${empty s.openAt ? '-' : s.openAt}</td>
							<td class="center col-date col-close-at" title="${s.closeAt}"
								data-value="${s.closeAt}">${empty s.closeAt ? '-' : s.closeAt}</td>
							<td class="center col-small col-created-by"
								data-value="${s.createdBy}">${s.createdBy}</td>
							<td class="center col-date col-created-at" title="${s.createdAt}"
								data-value="${s.createdAt}">${s.createdAt}</td>
							<td class="center col-date col-updated-at" title="${s.updateAt}"
								data-value="${s.updateAt}">${s.updateAt}</td>
							<td class="center col-small" data-value="${s.isTemplate}"><span
								class="badge gray">${s.isTemplate == 1 ? 'Y':'N'}</span></td>
							<td class="ellip col-mid col-template-key"
								title="${s.templateKey}" data-value="${s.templateKey}">${empty s.templateKey ? '-' : s.templateKey}</td>
							<td class="center col-small"><a class="page-btn"
								href="${pageContext.request.contextPath}/survey-test/view?surveyId=${s.surveyId}">상세</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

		<!-- paging -->
		<c:if test="${total > 0}">
			<div class="pager">
				<a class="page-btn"
					href="?page=${pageVO.startPage-1}&perPageNum=${cri.perPageNum}&field=${param.field}&keyword=${fn:escapeXml(param.keyword)}&anon=${param.anon}&eventId=${param.eventId}"
					<c:if test="${!pageVO.prev}">hidden</c:if>>Prev</a>

				<c:forEach var="p" begin="${pageVO.startPage}"
					end="${pageVO.endPage}">
					<a class="page-btn ${p == cri.page ? 'active':''}"
						href="?page=${p}&perPageNum=${cri.perPageNum}&field=${param.field}&keyword=${fn:escapeXml(param.keyword)}&anon=${param.anon}&eventId=${param.eventId}">${p}</a>
				</c:forEach>

				<a class="page-btn"
					href="?page=${pageVO.endPage+1}&perPageNum=${cri.perPageNum}&field=${param.field}&keyword=${fn:escapeXml(param.keyword)}&anon=${param.anon}&eventId=${param.eventId}"
					<c:if test="${!pageVO.next}">hidden</c:if>>Next</a>
			</div>
		</c:if>
	</div>

	<script>
		(function() {
			const fieldSel = document.getElementById('fieldSel');
			const statusSel = document.getElementById('statusSel');
			const anonSel = document.getElementById('anonSel');
			const kwInput = document.getElementById('kwInput');
			const statusHid = document.getElementById('statusHidden');
			const anonHid = document.getElementById('anonHidden');

			function syncUI() {
				const f = fieldSel.value;
				statusSel.style.display = (f === 'status') ? '' : 'none';
				anonSel.style.display = (f === 'anon') ? '' : 'none';
				kwInput.style.display = (f === 'all' || f === 'title') ? ''
						: 'none';

				// 충돌 방지: 사용 안 하는 hidden은 disable
				statusHid.disabled = !(f === 'status');
				anonHid.disabled = !(f === 'anon');
				kwInput.disabled = !(f === 'all' || f === 'title');

				statusHid.value = (f === 'status') ? (statusSel.value || '')
						: '';
				anonHid.value = (f === 'anon') ? (anonSel.value || '') : '';
			}
			fieldSel.addEventListener('change', syncUI);
			statusSel.addEventListener('change', syncUI);
			anonSel.addEventListener('change', syncUI);
			syncUI();
		})();
	</script>
</body>
</html>
