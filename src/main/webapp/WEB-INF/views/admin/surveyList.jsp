<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<title>설문 목록 - 관리자</title>

<!-- SB Admin 2 / Bootstrap -->
<link href="/resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,300,400,600,700,800,900"
	rel="stylesheet">
<link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">

<style>
/* ===== 헤더/서브텍스트 (SB Admin 톤) ===== */
.page-title{font-size:1.25rem;font-weight:700;margin:0 0 .25rem;color:#4e73df}
.page-sub{color:#858796;margin-bottom:1rem}

/* ===== 컨트롤 라인 ===== */
.controls .form-control,.controls .btn{height:calc(1.5em + .75rem + 2px)}

/* ===== 테이블 기본 ===== */
.tbl{width:100%;table-layout:fixed;border-collapse:collapse}
.tbl th,.tbl td{padding:8px 10px;font-size:12.5px}
.row-pinned{background:#eef2ff}

/* 날짜 2줄 */
.col-dt .date{display:block;font-weight:700;line-height:1.1}
.col-dt .time{display:block;font-size:.85rem;color:#6c757d;line-height:1.1}

/* ===== 제목/설명: 한 줄 + 말줄임 ===== */
.tbl td:nth-child(3){width:auto}
.col-title{white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.col-title .title,.col-title .desc{display:inline;white-space:nowrap}
.col-title .desc::before{content:" · ";color:#94a3b8}
/* 1200px↓에선 설명 감춤(스크롤 예방) */
@media (max-width:1200px){ .col-title .desc{display:none} }

/* ===== 폭 재배치(스크롤 제거 핵심) ===== */
/* 번호/이벤트ID */
.tbl th:nth-child(1),.tbl td:nth-child(1){width:48px}   /* 설문 NO */
.tbl th:nth-child(2),.tbl td:nth-child(2){width:64px}   /* 이벤트ID */

/* 상태/익명/원본ID */
.tbl th:nth-child(4),.tbl td:nth-child(4){width:80px}   /* 상태 */
.tbl th:nth-child(5),.tbl td:nth-child(5){width:60px}   /* 익명 */
.tbl th:nth-child(6),.tbl td:nth-child(6){width:84px}   /* 원본ID(=복제원본ID) */

/* 날짜 4칸 */
.tbl th:nth-child(7), .tbl td:nth-child(7),
.tbl th:nth-child(8), .tbl td:nth-child(8),
.tbl th:nth-child(9), .tbl td:nth-child(9),
.tbl th:nth-child(10),.tbl td:nth-child(10){width:100px}

/* 템플릿(Y/N) 폭 더 타이트 */
.tbl th:nth-child(11),.tbl td:nth-child(11){width:54px;text-align:center}

/* 템플릿키: 좌정렬 + 말줄임 */
.tbl th:nth-child(12),.tbl td:nth-child(12){width:120px}
.col-tplkey{text-align:left;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}

/* 상세 버튼 칸 */
.tbl th:nth-child(13),.tbl td:nth-child(13){width:72px}

/* ===== 반응폭 보정 ===== */
@media (max-width:1360px){
  .tbl th:nth-child(7), .tbl td:nth-child(7),
  .tbl th:nth-child(8), .tbl td:nth-child(8),
  .tbl th:nth-child(9), .tbl td:nth-child(9),
  .tbl th:nth-child(10),.tbl td:nth-child(10){width:96px}
}

/* 페이지네이션(SB Admin 톤) */
.pagination .page-link{color:#4e73df}
.pagination .page-item.active .page-link{background:#4e73df;border-color:#4e73df}

/* 전체 화면 가로 스크롤 방지 */
html,body{max-width:100%;overflow-x:hidden}



</style>
</head>

<body id="page-top">
	<!-- Wrapper -->
	<div id="wrapper">

		<%@ include file="/WEB-INF/views/adminIncludes/header.jsp"%>

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<div class="container-fluid">

					<h1 class="page-title">설문 목록</h1>
					<p class="page-sub">템플릿과 이벤트 설문을 한눈에 볼 수 있습니다.</p>

					<div class="card shadow mb-4">
						<div class="card-body">

							<!-- ✅ 검색/필터: 기존 폼 그대로, 클래스만 Bootstrap화 -->
							<form class="controls form-inline mb-3 w-100" method="get"
								action="<c:url value='/admin/surveys'/>">
								<div class="ml-auto d-flex align-items-center flex-wrap gap-2">
									<select name="field" class="form-control mr-2">
										<option value="all"
											<c:if test="${param.field == 'all' || empty param.field}">selected</c:if>>전체</option>
										<option value="title"
											<c:if test="${param.field == 'title'}">selected</c:if>>제목/설명</option>
										<option value="status"
											<c:if test="${param.field == 'status'}">selected</c:if>>상태</option>
										<option value="anon"
											<c:if test="${param.field == 'anon'}">selected</c:if>>익명</option>
									</select> <input type="text" name="keyword" class="form-control mr-2"
										placeholder="검색어 입력" value="${fn:escapeXml(param.keyword)}" />

									<button type="submit" class="btn btn-primary mr-2">검색</button>
									<a href="<c:url value='/admin/surveys/form'/>"
										class="btn btn-primary"> <i class="fas fa-clone mr-1"></i>
										템플릿 복제하기
									</a>
								</div>
							</form>

							<!-- 총건수(템플릿 포함) -->
							<c:set var="totalAll"
								value="${pageVO.total + fn:length(templateList)}" />
							<div class="d-flex justify-content-end text-muted mb-2">
								총 <strong class="text-primary ml-1 mr-1">${totalAll}</strong>건
							</div>

							<!-- ✅ 테이블: 구조/EL 그대로, Bootstrap table만 적용 -->
							<div class="table-responsive">
								<table class="table table-bordered table-hover tbl">
									<colgroup>
										<col style="width: 50px" />
										<!-- 설문ID -->
										<col style="width: 50px" />
										<!-- 이벤트ID -->
										<col style="width: 200px" />
										<!-- 제목/설명 -->
										<col style="width: 90px" />
										<!-- 상태 -->
										<col style="width: 80px" />
										<!-- 익명 -->
										<col style="width: 50px" />
										<!-- 복제원본ID -->
										<col style="width: 80px" />
										<!-- 오픈 -->
										<col style="width: 80px" />
										<!-- 마감 -->
										<col style="width: 80px" />
										<!-- 작성 -->
										<col style="width: 80px" />
										<!-- 수정 -->
										<col style="width: 90px" />
										<!-- 템플릿 -->
										<col style="width: 100px" />
										<!-- 템플릿키 -->
										<col style="width: 80px" />
										<!-- 상세 -->
									</colgroup>

									<thead class="thead-light text-center">
										<tr>
											<th>NO</th>
											<th>이벤트</th>
											<th class="text-left">제목 / 설명</th>
											<th>상태</th>
											<th>익명</th>
											<th>원본</th>
											<th>오픈 일시</th>
											<th>마감 일시</th>
											<th>작성 일시</th>
											<th>수정 일시</th>
											<th>템플릿</th>
											<th class="text-left">템플릿키</th>
											<th>상세</th>
										</tr>
									</thead>

									<tbody>
										<!-- 고정 템플릿 -->
										<c:forEach var="s" items="${templateList}">
											<tr class="row-pinned text-center">
												<td>${s.surveyId}</td>
												<td><c:out
														value="${s.eventId != null ? s.eventId : '-'}" /></td>

												<td class="text-left"><span class="title"><c:out
															value="${s.title}" /></span> <span class="desc"><c:out
															value="${s.description}" /></span></td>

												<td><c:choose>
														<c:when test="${s.status == 'OPEN'}">
															<span class="badge badge-info">OPEN</span>
														</c:when>
														<c:when test="${s.status == 'ARCHIVED'}">
															<span class="badge badge-secondary">ARCHIVED</span>
														</c:when>
														<c:when test="${s.status == 'CLOSED'}">
															<span class="badge badge-danger">CLOSED</span>
														</c:when>
														<c:otherwise>-</c:otherwise>
													</c:choose></td>

												<td><span class="badge badge-light"> <c:out
															value="${s.isAnonymous == 1 ? 'Y' : 'N'}" />
												</span></td>

												<td><c:out
														value="${s.cloneFromSurveyId != null ? s.cloneFromSurveyId : '-'}" /></td>

												<td class="col-dt"><c:choose>
														<c:when test="${s.openAt != null}">
															<span class="date"><c:out
																	value="${s.openAt.toLocalDate()}" /></span>
															<span class="time"><c:out
																	value="${s.openAt.toLocalTime()}" /></span>
														</c:when>
														<c:otherwise>-</c:otherwise>
													</c:choose></td>
												<td class="col-dt"><c:choose>
														<c:when test="${s.closeAt != null}">
															<span class="date"><c:out
																	value="${s.closeAt.toLocalDate()}" /></span>
															<span class="time"><c:out
																	value="${s.closeAt.toLocalTime()}" /></span>
														</c:when>
														<c:otherwise>-</c:otherwise>
													</c:choose></td>

												<td class="col-dt"><c:choose>
														<c:when test="${s.createdAt != null}">
															<span class="date"><c:out
																	value="${s.createdAt.toLocalDate()}" /></span>
															<span class="time"><c:out
																	value="${s.createdAt.toLocalTime()}" /></span>
														</c:when>
														<c:otherwise>-</c:otherwise>
													</c:choose></td>
												<td class="col-dt"><c:choose>
														<c:when test="${s.updatedAt != null}">
															<span class="date"><c:out
																	value="${s.updatedAt.toLocalDate()}" /></span>
															<span class="time"><c:out
																	value="${s.updatedAt.toLocalTime()}" /></span>
														</c:when>
														<c:otherwise>-</c:otherwise>
													</c:choose></td>

												<td><span class="badge badge-primary">Y</span></td>
												<td class="text-left"><c:out
														value="${empty s.templateKey ? '-' : s.templateKey}" /></td>
												<td>
													<button type="button"
														class="btn btn-sm btn-outline-primary btn-detail"
														onclick="location.href='<c:url value="/admin/surveys/${s.surveyId}"/>'">
														상세</button>
												</td>
											</tr>
										</c:forEach>

										<!-- 일반 설문 -->
										<c:forEach var="s" items="${surveyList}">
											<tr class="text-center">
												<td>${s.surveyId}</td>
												<td><c:out
														value="${s.eventId != null ? s.eventId : '-'}" /></td>

												<td class="text-left"><span class="title"><c:out
															value="${s.title}" /></span> <span class="desc"><c:out
															value="${s.description}" /></span></td>

												<td><c:choose>
														<c:when test="${s.status == 'OPEN'}">
															<span class="badge badge-info">OPEN</span>
														</c:when>
														<c:when test="${s.status == 'ARCHIVED'}">
															<span class="badge badge-secondary">ARCHIVED</span>
														</c:when>
														<c:when test="${s.status == 'CLOSED'}">
															<span class="badge badge-danger">CLOSED</span>
														</c:when>
														<c:otherwise>-</c:otherwise>
													</c:choose></td>

												<td><span class="badge badge-light"> <c:out
															value="${s.isAnonymous == 1 ? 'Y' : 'N'}" />
												</span></td>
												<td><c:out
														value="${s.cloneFromSurveyId != null ? s.cloneFromSurveyId : '-'}" /></td>

												<td class="col-dt"><c:choose>
														<c:when test="${s.openAt != null}">
															<span class="date"><c:out
																	value="${s.openAt.toLocalDate()}" /></span>
															<span class="time"><c:out
																	value="${s.openAt.toLocalTime()}" /></span>
														</c:when>
														<c:otherwise>-</c:otherwise>
													</c:choose></td>
												<td class="col-dt"><c:choose>
														<c:when test="${s.closeAt != null}">
															<span class="date"><c:out
																	value="${s.closeAt.toLocalDate()}" /></span>
															<span class="time"><c:out
																	value="${s.closeAt.toLocalTime()}" /></span>
														</c:when>
														<c:otherwise>-</c:otherwise>
													</c:choose></td>

												<td class="col-dt"><c:choose>
														<c:when test="${s.createdAt != null}">
															<span class="date"><c:out
																	value="${s.createdAt.toLocalDate()}" /></span>
															<span class="time"><c:out
																	value="${s.createdAt.toLocalTime()}" /></span>
														</c:when>
														<c:otherwise>-</c:otherwise>
													</c:choose></td>
												<td class="col-dt"><c:choose>
														<c:when test="${s.updatedAt != null}">
															<span class="date"><c:out
																	value="${s.updatedAt.toLocalDate()}" /></span>
															<span class="time"><c:out
																	value="${s.updatedAt.toLocalTime()}" /></span>
														</c:when>
														<c:otherwise>-</c:otherwise>
													</c:choose></td>

												<td><span class="badge badge-light">N</span></td>
												<td class="text-left"><c:out
														value="${empty s.templateKey ? '-' : s.templateKey}" /></td>
												<td>
													<button type="button"
														class="btn btn-sm btn-outline-primary btn-detail"
														onclick="location.href='<c:url value="/admin/surveys/${s.surveyId}"/>'">
														상세</button>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>

							<!-- ✅ 페이지네이션: 변수/링크 그대로, Bootstrap 컴포넌트만 적용 -->
							<nav aria-label="페이지 이동">
								<ul class="pagination justify-content-center">
									<!-- « 첫 페이지 -->
									<c:if test="${pageVO.cri.page > 1}">
										<li class="page-item"><a class="page-link"
											href="<c:url value='/admin/surveys?page=1'/>"
											aria-label="첫 페이지">&laquo;</a></li>
									</c:if>

									<!-- ‹ 이전 -->
									<c:if test="${pageVO.cri.page > 1}">
										<li class="page-item"><a class="page-link"
											href="<c:url value='/admin/surveys?page=${pageVO.cri.page - 1}'/>"
											aria-label="이전 페이지">&lsaquo;</a></li>
									</c:if>

									<!-- 페이지 숫자 -->
									<c:forEach var="num" begin="${pageVO.startPage}"
										end="${pageVO.endPage}">
										<li
											class="page-item ${pageVO.cri.page == num ? 'active' : ''}">
											<a class="page-link"
											href="<c:url value='/admin/surveys?page=${num}'/>">${num}</a>
										</li>
									</c:forEach>

									<!-- › 다음 -->
									<c:if test="${pageVO.cri.page < pageVO.totalPage}">
										<li class="page-item"><a class="page-link"
											href="<c:url value='/admin/surveys?page=${pageVO.cri.page + 1}'/>"
											aria-label="다음 페이지">&rsaquo;</a></li>
									</c:if>

									<!-- » 마지막 -->
									<c:if test="${pageVO.cri.page < pageVO.totalPage}">
										<li class="page-item"><a class="page-link"
											href="<c:url value='/admin/surveys?page=${pageVO.totalPage}'/>"
											aria-label="마지막 페이지">&raquo;</a></li>
									</c:if>
								</ul>
							</nav>

						</div>
					</div>

				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- /#content -->

			<%@ include file="/WEB-INF/views/adminIncludes/footer.jsp"%>
		</div>
		<!-- /#content-wrapper -->

	</div>
	<!-- /#wrapper -->

	<%@ include file="/WEB-INF/views/adminIncludes/logoutModal.jsp"%>

	<!-- Bootstrap core JavaScript-->
	<script src="/resources/vendor/jquery/jquery.min.js"></script>
	<script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="/resources/js/sb-admin-2.min.js"></script>

	<script>
		// 엔터로 검색 (네 로직 그대로 유지)
		(function() {
			var kw = document.querySelector('input[name="keyword"]');
			if (kw) {
				kw.addEventListener('keypress', function(e) {
					if (e.key === 'Enter') {
						e.target.form.submit();
					}
				});
			}
		})();
	</script>
</body>
</html>
