<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>Event Manage</title>

  <!-- SB Admin + Bootstrap -->
  <link href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">

  <style>
    .wrap-title{font-size:24px;font-weight:700;color:#1f2937;margin-bottom:14px}
    .toolbar{display:flex;justify-content:flex-end;align-items:center;gap:8px;margin-bottom:10px}
    .toolbar .sum{color:#6b7280;font-size:12px;margin-left:8px}
    .card{border:1px solid #e5e7eb;border-radius:.5rem}
    .card-body{padding:16px}
    .table thead th{background:#f8fafc;color:#6b7280;font-weight:700;border-top:1px solid #e5e7eb;border-bottom:1px solid #e5e7eb}
    .table tbody td{vertical-align:middle}
    .table a.row-title{color:#2563eb;font-weight:600;text-decoration:none}
    .table a.row-title:hover{text-decoration:underline}
    .badge-pill{border-radius:9999px;padding:.35rem .6rem;font-weight:600;font-size:.75rem}
    .pagination .page-link{border-radius:0}
  </style>
</head>
<body id="page-top">
<div id="wrapper">

  <jsp:include page="../adminIncludes/header.jsp"/>

  <div class="container-fluid">
    <!-- 제목 -->
    <div class="wrap-title">Event Manage</div>

    <div class="card shadow-sm">
      <div class="card-body">

        <!-- 고객관리 화면과 동일 포맷의 우측 툴바 -->
        <div class="toolbar">
		  <span class="sum">총 이벤트수 : ${total}</span>
		
		  <select name="type" class="form-control form-control-sm" style="width:110px">
		    <option value="">정렬</option>
		    <option value="OPEN">OPEN</option>
		    <option value="CLOSED">CLOSED</option>
		  </select>
		
		  <select name="visibility" class="form-control form-control-sm" style="width:90px">
		    <option value="">전체</option>
		    <option value="PUBLIC">PUBLIC</option>
		    <option value="PRIVATE">PRIVATE</option>
		  </select>
		
		  <input name="keyword" class="form-control form-control-sm" placeholder="검색어 입력"
		         style="width:180px" value="${param.keyword}">
		  <button class="btn btn-primary btn-sm" onclick="doSearch()">검색</button>
		  <button class="btn btn-outline-secondary btn-sm"
		          onclick="location.href='${pageContext.request.contextPath}/admin/events'">검색 초기화</button>
		
		  <!-- 여기 추가 -->
		  <c:if test="${isAdmin}">
		    <a href="<c:url value='/admin/events/form'/>"
		       class="btn btn-primary btn-sm" style="margin-left:8px;">+ New Event</a>
		  </c:if>
		</div>


        <!-- 표 -->
        <div class="table-responsive">
          <table class="table table-bordered table-hover mb-2">
            <thead>
            <tr>
              <th style="width:72px;">ID</th>
              <th>제목</th>
              <th style="width:110px;">상태</th>
              <th style="width:110px;">공개</th>
              <th style="width:160px;">시작</th>
              <th style="width:160px;">종료</th>
              <th style="width:90px;">정원</th>
              <th style="width:90px;">작성자</th>
              <th style="width:108px;" class="text-center"><!-- intentionally blank --></th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
              <c:when test="${empty list}">
                <tr><td colspan="9" class="text-center text-muted py-5">데이터가 없습니다.</td></tr>
              </c:when>
              <c:otherwise>
                <c:forEach var="e" items="${list}">
                  <tr>
                    <td>${e.eventId}</td>

                    <td>
                      <a href="<c:url value='/admin/events/${e.eventId}'/>" class="row-title">${e.title}</a>
                    </td>

                    <!-- 상태 뱃지 -->
                    <td>
                      <c:choose>
                        <c:when test="${e.status == 'OPEN'}">
                          <span class="badge badge-info badge-pill">OPEN</span>
                        </c:when>
                        <c:when test="${e.status == 'CLOSED'}">
                          <span class="badge badge-secondary badge-pill">CLOSED</span>
                        </c:when>
                        <c:otherwise>
                          <span class="badge badge-light badge-pill">${e.status}</span>
                        </c:otherwise>
                      </c:choose>
                    </td>

                    <!-- 공개여부 뱃지 (설문과 동일 톤) -->
                    <td>
                      <c:choose>
                        <c:when test="${e.visibility == 'PUBLIC'}">
                          <span class="badge badge-primary badge-pill">PUBLIC</span>
                        </c:when>
                        <c:when test="${e.visibility == 'PRIVATE'}">
                          <span class="badge badge-warning badge-pill">PRIVATE</span>
                        </c:when>
                        <c:otherwise>
                          <span class="badge badge-light badge-pill">${e.visibility}</span>
                        </c:otherwise>
                      </c:choose>
                    </td>

                    <td>${e.startDate  != null ? fn:substring(fn:replace(e.startDate, 'T', ' '), 0, 16) : ''}</td>
					<td>${e.endDate    != null ? fn:substring(fn:replace(e.endDate,   'T', ' '), 0, 16) : ''}</td>
                    <td>${e.capacity}</td>
                    <td>${e.createdBy}</td>

                    <td class="text-center">
                      <a href="<c:url value='/admin/events/form?id=${e.eventId}'/>"
                         class="btn btn-outline-secondary btn-sm">상세/수정</a>
                    </td>
                  </tr>
                </c:forEach>
              </c:otherwise>
            </c:choose>
            </tbody>
          </table>
        </div>

        <!-- 페이징 -->
        <nav aria-label="pagination" class="d-flex justify-content-center">
          <ul class="pagination mb-0">
            <li class="page-item ${pageVO.prev ? '' : 'disabled'}">
              <a class="page-link"
                 href="<c:url value='/admin/events?page=${pageVO.startPage - 1}&perPageNum=${pageVO.cri.perPageNum}'/>">&laquo;</a>
            </li>

            <c:forEach var="p" begin="${pageVO.startPage}" end="${pageVO.endPage}">
              <li class="page-item ${pageVO.cri.page == p ? 'active' : ''}">
                <a class="page-link"
                   href="<c:url value='/admin/events?page=${p}&perPageNum=${pageVO.cri.perPageNum}'/>">${p}</a>
              </li>
            </c:forEach>

            <li class="page-item ${pageVO.next ? '' : 'disabled'}">
              <a class="page-link"
                 href="<c:url value='/admin/events?page=${pageVO.endPage + 1}&perPageNum=${pageVO.cri.perPageNum}'/>">&raquo;</a>
            </li>
          </ul>
        </nav>

      </div>
    </div>
  </div>

  <jsp:include page="../adminIncludes/footer.jsp"/>
</div>

<script>
  function doSearch(){
    const base = '${pageContext.request.contextPath}/admin/events';
    const type = document.querySelector('select[name="type"]').value;
    const visibility = document.querySelector('select[name="visibility"]').value;
    const kw = document.querySelector('input[name="keyword"]').value;

    const qs = new URLSearchParams();
    if (type) { qs.append('field','status'); qs.append('keyword', type); }
    if (visibility) qs.append('visibility', visibility);
    if (kw) qs.set('keyword', kw);

    location.href = base + (qs.toString() ? ('?' + qs.toString()) : '');
  }
</script>

<script src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/sb-admin-2.min.js"></script>
</body>
</html>
