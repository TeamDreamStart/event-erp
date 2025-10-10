<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<title>설문 목록 - 관리자</title>
	
	<!-- Pretendard -->
	<link href="https://cdn.jsdelivr.net/npm/pretendard@1.3.9/dist/web/static/pretendard.css" rel="stylesheet" />
	<style> 
	/* ===== Base ===== */ 
	:root{ 
		/* Responsive type scale */ 
		--fs-body: clamp(12px, calc(10px + 0.35vw), 14.5px); 
		--fs-sm: clamp(11px, calc(9px + 0.30vw), 13px); 
		--fs-xs: clamp(10px, calc(8px + 0.25vw), 12px); 
		--fs-h1: clamp(16px, calc(14px + 0.6vw), 20px); 
		/* 브랜드/행 하이라이트 토큰 */ 
		--brand-600:#4f46e5; 
		/* 기본 */ 
		--brand-700:#4338ca; 
		/* hover */ 
		--brand-800:#3730a3; 
		/* active */ 
		--brand-ring:rgba(79,70,229,.28); 
		--on-brand:#fff; --row-pin:#eef2ff; 
		/* 고정 템플릿(기존과 동일) */ 
		--row-hover:#e0e7ff; 
		/* 일반 hover (더 진하게) */ 
		--row-hover-strong:#dbe3ff;
		/* 고정 템플릿 hover (조금 더 진하게) */ 
	} 
	
	body{
		font-family:"Pretendard",sans-serif;
		background:#f8fafc;color:#1e293b;
		font-size:var(--fs-body);
		margin:0
	} 
	.wrap{
		width:100%;margin:40px auto;padding:0 16px
	} 
	.page-title{
		font-size:var(--fs-h1);font-weight:700;
		margin:0 0 6px
	} 
	.page-sub{
		font-size:var(--fs-sm);color:#64748b;
		margin:0 0 12px
	} 
	.card{
		background:#fff;
		border:1px solid #e2e8f0;border-radius:8px;
		padding:12px
	} 
	
	/* ===== Controls ===== */ 
	.controls{
		display:flex;gap:8px;align-items:center;
		margin-bottom:10px;
		flex-wrap:wrap
	} 
	.select,.input,.btn{
		height:38px;
		border:1px solid #cbd5e1;border-radius:8px;
		background:#fff
	} 
	.select{padding:0 10px} 
	.input{flex:0 0 260px;padding:0 12px} 
	.btn{
		display:inline-flex;align-items:center;justify-content:center;
		padding:0 14px;
		border-color:#4f46e5;
		color:#4f46e5;font-weight:700;
		cursor:pointer
	} 
	.btn--primary{
		background:#4f46e5;
		color:#fff;
		border-color:#4f46e5
	} 
	.btn:hover{filter:brightness(.97)} 
	.controls .spacer{margin-left:auto} 
	
	/* ===== Summary ===== */ 
	.total{
		font-size:var(--fs-body);color:#475569;
		margin:6px 0 10px
	} 
	.total strong{color:#4f46e5} 
	
	/* ===== Table ===== */ 
	.tbl{
		width:100%;
		border-collapse:collapse;
		table-layout:fixed
	} 
	.tbl th{
		background:#f1f5f9;
		border-bottom:1px solid #cbd5e1;
		padding:8px 6px;
		text-align:center;white-space:nowrap;
		font-weight:600;color:#1e293b;font-size:var(--fs-xs)
	} 
	.tbl td{
		border-bottom:1px solid #e2e8f0;
		padding:8px;
		text-align:center;vertical-align:middle;font-size:var(--fs-body)
	} 
	.row-pinned{background:var(--row-pin)} 
	
	/* --- Column widths (1920 기준 감각 유지) --- */ 
	.tbl th:nth-child(1), 
	.tbl td:nth-child(1){width:70px} 
	
	/* 설문ID */ 
	.tbl th:nth-child(2), 
	.tbl td:nth-child(2){width:90px} 
	
	/* 이벤트ID */ 
	.tbl th:nth-child(4), 
	.tbl td:nth-child(4){width:86px} 
	
	/* 상태 */ 
	.tbl th:nth-child(5), 
	.tbl td:nth-child(5){width:70px} 
	
	/* 익명 */ 
	.tbl th:nth-child(6), 
	.tbl td:nth-child(6){width:90px} 
	
	/* 복제원본ID */ 
	/* 제목/설명 – 왼쪽정렬 + 히든 말줄임 */ 
	.tbl td:nth-child(3){
		width:clamp(160px, 22vw, 200px);
		text-align:left;
		padding-left:12px
	} 
	.tbl td:nth-child(3) .title, 
	.tbl td:nth-child(3) .desc{overflow:hidden;text-overflow:ellipsis;white-space:nowrap} 
	
	/* 7~10열: 일시(항상 2줄) */ 
	.tbl th:nth-child(7), 
	.tbl td:nth-child(7), 
	.tbl th:nth-child(8), 
	.tbl td:nth-child(8), 
	.tbl th:nth-child(9), 
	.tbl td:nth-child(9), 
	.tbl th:nth-child(10), 
	.tbl td:nth-child(10){font-size:var(--fs-sm)} 
	.col-dt .date{
		display:block;
		font-weight:700;line-height:1.1;white-space:nowrap;
		overflow:hidden;text-overflow:ellipsis
	} 
	.col-dt .time{
		display:block;
		color:#6b7280;font-size:var(--fs-xs);line-height:1.1;
		white-space:nowrap;overflow:hidden;text-overflow:ellipsis
	} 
	.tbl td:nth-child(7) .date,
	.tbl td:nth-child(7) .time, 
	.tbl td:nth-child(8) .date,
	.tbl td:nth-child(8) .time, 
	.tbl td:nth-child(9) .date,
	.tbl td:nth-child(9) .time, 
	.tbl td:nth-child(10) .date,
	.tbl td:nth-child(10) .time{display:block;white-space:nowrap;overflow:hidden;text-overflow:ellipsis} 
	
	/* 11~13열 */ 
	.tbl th:nth-child(11), 
	.tbl td:nth-child(11){width:76px} 
	
	/* 템플릿 Y/N */ 
	.tbl th:nth-child(12), 
	.tbl td:nth-child(12){width:140px} 
	
	/* 템플릿키 */ 
	.col-tplkey{overflow:hidden;text-overflow:ellipsis;white-space:nowrap;text-align:left} 
	.tbl th:nth-child(13), 
	.tbl td:nth-child(13){width:70px} 
	
	/* 상세 버튼 */ 
	/* 상세 버튼: a / button 공통 리셋 */ 
	button.btn-detail, 
	a.btn-detail{ 
		-webkit-appearance:none; 
		appearance:none; 
		border:0; 
		text-decoration:none;    
		cursor:pointer; 
	} 
	
	/* 기본(원래 외곽선) — 아래 공통 채움 스타일이 오버라이드함 */ 
	.btn-detail{ 
		display:inline-flex; 
		align-items:center; justify-content:center; 
		height:32px; min-width:64px; padding:0 12px; 
		border:1px solid #4f46e5; 
		color:#1d4ed8; 
		background:#dbeafe; 
		border-radius:8px; 
		font-weight:700; font-size:12.5px; line-height:30px; 
		transition: background .15s ease, color .15s ease, box-shadow .15s ease, transform .03s ease; 
		box-shadow: 0 1px 0 rgba(0,0,0,.03); } 
	.btn-detail:hover{ background:#4f46e5; color:#fff; } 
	.btn-detail:active{ transform:translateY(1px); } 
	.btn-detail:focus-visible{ outline:0; box-shadow:0 0 0 3px rgba(79,70,229,.25); } 
	.btn-detail[disabled], 
	.btn-detail.is-disabled{ 
		opacity:.55; 
		cursor:not-allowed; 
		background:#f3f4f6; 
		color:#9ca3af; 
		border-color:#e5e7eb; 
	} 
	.tbl a.btn-detail{ text-decoration:none; } 
	
	/* 상태/YN */ 
	.badge{
		display:inline-block;
		min-width:36px;height:28px;
		line-height:28px;
		padding:0 10px;
		border-radius:999px;
		font-weight:700;font-size:var(--fs-sm)
	} 
	.b-open{background:#dbeafe;color:#1d4ed8} 
	.b-arch{background:#e2e8f0;color:#475569} 
	.b-closed{background:#fee2e2;color:#b91c1c} 
	.b-yn{min-width:28px} 
	
	/* 제목/설명 공통 */ 
	.col-title{text-align:left} 
	.col-title .title{
		display:block;
		font-weight:700;overflow:hidden;text-overflow:ellipsis;
		white-space:nowrap
	} 
	.col-title .desc{
		display:block;
		color:#64748b;font-size:var(--fs-sm);
		margin-top:4px;
		overflow:hidden;
		text-overflow:ellipsis;
		white-space:nowrap
	} 
	
	/* ===== 좁은 화면 단계 보정 (두 줄 유지) ===== */ 
	@media (max-width:1600px){ 
		.tbl th, 
		.tbl td{padding:7px 6px} 
		.tbl td{font-size:13.5px} 
		.tbl th:nth-child(7), 
		.tbl td:nth-child(7), 
		.tbl th:nth-child(8), 
		.tbl td:nth-child(8), 
		.tbl th:nth-child(9), 
		.tbl td:nth-child(9), 
		.tbl th:nth-child(10), 
		.tbl td:nth-child(10){width:110px} 
		.col-dt .date{font-size:14px;letter-spacing:-0.1px} 
		.col-dt .time{font-size:12.5px} 
		.tbl td:nth-child(3){width:clamp(155px, 23vw, 190px)} 
		.tbl th:nth-child(12), 
		.tbl td:nth-child(12){width:130px} 
	} 
	@media (max-width:1360px){ 
		.tbl th, 
		.tbl td{padding:6px} 
		.tbl th{font-size:11.5px} 
		.tbl td{font-size:13px} 
		.tbl th:nth-child(7), 
		.tbl td:nth-child(7), 
		.tbl th:nth-child(8), 
		.tbl td:nth-child(8), 
		.tbl th:nth-child(9), 
		.tbl td:nth-child(9), 
		.tbl th:nth-child(10), 
		.tbl td:nth-child(10){width:100px} 
		.col-dt .date{font-size:13px} 
		.col-dt .time{font-size:11.5px} 
		.tbl th:nth-child(12), 
		.tbl td:nth-child(12){width:120px} 
	} 
	@media (max-width:1200px){ 
		.tbl th{font-size:11px} 
		.tbl td{font-size:12.5px} 
		.tbl th:nth-child(7), 
		.tbl td:nth-child(7), 
		.tbl th:nth-child(8), 
		.tbl td:nth-child(8), 
		.tbl th:nth-child(9), 
		.tbl td:nth-child(9), 
		.tbl th:nth-child(10), 
		.tbl td:nth-child(10){width:96px} 
		.col-dt .date{font-size:12.5px} 
		.col-dt .time{font-size:11px} 
		.tbl th:nth-child(12), 
		.tbl td:nth-child(12){width:110px} 
		.input{flex:1 1 220px} 
	} 
	@media (max-width:1024px){ 
		.tbl th, 
		.tbl td{padding:5px} 
		.tbl td{font-size:12px} 
		.tbl th:nth-child(7), 
		.tbl td:nth-child(7), 
		.tbl th:nth-child(8), 
		.tbl td:nth-child(8), 
		.tbl th:nth-child(9), 
		.tbl td:nth-child(9), 
		.tbl th:nth-child(10), 
		.tbl td:nth-child(10){width:92px} 
		.col-dt .date{font-size:12px} 
		.col-dt .time{font-size:10.5px} 
		.badge, 
		.btn-detail{font-size:var(--fs-xs)} 
		.tbl th:nth-child(6), 
		.tbl td:nth-child(6){width:80px} } 
		
	/* ==== [오버라이드] 통일 버튼/페이지네이션 = 기본 '채움' + hover 진하게 ==== */
	/* ⬇ 기존 셀렉터에서 `.pagi a` 제거 (페이지네이션은 별도 규칙으로 관리) */
	.btn, .btn--primary{
	  background:var(--brand-600);
	  border:1px solid var(--brand-600);
	  color:var(--on-brand);
	  text-decoration:none;
	  transition:background .15s ease,border-color .15s ease,color .15s ease,box-shadow .15s ease,transform .03s ease;
	  border-radius:10px;
	  box-shadow:0 1px 0 rgba(0,0,0,.03);
	}
	.btn:hover, .btn--primary:hover, .btn-detail:hover{
	  background:var(--brand-700);
	  border-color:var(--brand-700);
	  color:var(--on-brand);
	}
	.btn:active, .btn--primary:active, .btn-detail:active{ transform:translateY(1px); }
	.btn:focus-visible, .btn--primary:focus-visible, .btn-detail:focus-visible{
	  outline:0; box-shadow:0 0 0 3px var(--brand-ring);
	}
	.btn[disabled], .btn-detail[disabled]{
	  opacity:.55; cursor:not-allowed;
	  background:#e5e7eb; border-color:#e5e7eb; color:#9ca3af;
	}
	
	/* ==== 행 hover 대비 강화 (템플릿 행보다 더 진함) ==== */ 
	.tbl tbody tr{ transition:background-color .12s ease; } 
	.tbl tbody tr:hover{ background:var(--row-hover); } 
	.tbl tbody tr.row-pinned{ background:var(--row-pin); } 
	.tbl tbody tr.row-pinned:hover{ background:var(--row-hover-strong); } 
	
	/* ==== 원형 페이지네이션(이전/다음 포함) - 추가/오버라이드 ==== */
	/* 기본은 '외곽선 + 흰배경', hover/활성 시 브랜드 채움 */
	.pagi{
	  display:flex; gap:10px; justify-content:center; margin-top:18px; /* 간격만 살짝 넓힘 */
	}
	/* 공통 모양 - 요소 타입(a/span) 무관하게 .btn-page만 스타일링 */
	.pagi .btn-page{
	  width:40px; min-width:40px;
	  height:40px; line-height:40px;
	  border-radius:9999px;
	  display:inline-block; text-align:center;
	  font-weight:700; font-size:14px;
	  border:1px solid #d1d5db;
	  background:#fff; color:var(--brand-600);
	  text-decoration:none; user-select:none;
	  transition:background .15s, border-color .15s, color .15s, box-shadow .15s;
	}
	
	/* 클릭 가능한 것만 손가락 포인터 */
	.pagi a.btn-page{ cursor:pointer; }
	
	/* 현재 페이지도 손가락 포인터(클릭 느낌 유지) */
	.pagi .btn-page.on,
	.pagi .btn-page[aria-current="page"]{
	  cursor: pointer;
	}
	
	/* 진짜 비활성만 기본 커서 */
	.pagi a.btn-page[aria-disabled="true"]{
	  cursor: default;
	}
	
	/* 호버 효과는 링크(a)만 */
	.pagi a.btn-page:hover{
	  background:var(--brand-600);
	  border-color:var(--brand-600);
	  color:#fff;
	}
	.pagi a.btn-page:focus-visible{
	  outline:0;
	  box-shadow:0 0 0 3px var(--brand-ring);
	}
	
	/* 화살표(이전/다음)만 살짝 크게 */
	.pagi a.btn-page.edge{
	  font-size:18px;
	  line-height:38px;
	}
	
	/* 활성(현재 페이지) 색상 */
	.pagi .btn-page.on{
	  background:var(--brand-700);
	  border-color:var(--brand-700);
	  color:#fff;
	}
	
</style>

</head>

<body>
<div class="wrap">
  <h1 class="page-title">설문 목록</h1>
  <p class="page-sub">템플릿과 이벤트 설문을 한눈에 볼 수 있습니다.</p>

  <div class="card">
    <!-- 검색/필터 라인: 세로 중앙정렬 + 버튼 높이 통일 -->
    <form class="controls" method="get" action="<c:url value='/admin/surveys'/>">
	  <div class="spacer"></div>
      
      <select name="field" class="select">
        <option value="all"   <c:if test="${param.field == 'all' || empty param.field}">selected</c:if>>전체</option>
        <option value="title" <c:if test="${param.field == 'title'}">selected</c:if>>제목/설명</option>
        <option value="status"<c:if test="${param.field == 'status'}">selected</c:if>>상태</option>
        <option value="anon"  <c:if test="${param.field == 'anon'}">selected</c:if>>익명</option>
      </select>

      <input type="text" name="keyword" class="input" placeholder="검색어 입력"
             value="${fn:escapeXml(param.keyword)}" />

      <button type="submit" class="btn btn--primary">검색</button>

      <a href="<c:url value='/admin/surveys/form'/>" class="btn btn--primary">템플릿 복제하기</a>
    </form>

    <!-- 총건수(템플릿 포함) -->
    <c:set var="totalAll" value="${pageVO.total + fn:length(templateList)}" />
    <div class="total">총 <strong>${totalAll}</strong>건</div>

    <table class="tbl">
      <colgroup>
        <col style="width:50px"/><!-- 설문ID (좁게) -->
        <col style="width:50px"/><!-- 이벤트ID (좁게) -->
        <col style="width:200px"/><!-- 제목/설명 (더 좁게 + 좌정렬) -->
        <col style="width:90px"/><!-- 상태 (좁게) -->
        <col style="width:80px"/><!-- 익명 (좁게) -->
        <col style="width:50px"/><!-- 복제원본ID (좁게) -->
        <col style="width:80px"/><!-- 오픈 일시 -->
        <col style="width:80px"/><!-- 마감 일시 -->
        <col style="width:80px"/><!-- 작성 일시 -->
        <col style="width:80px"/><!-- 수정 일시 -->
        <col style="width:90px"/><!-- 템플릿 (좁게) -->
        <col style="width:100px"/><!-- 템플릿키 (더 좁게) -->
        <col style="width:80px"/><!-- 상세 -->
      </colgroup>

      <thead>
        <tr>
          <th>설문ID</th>
          <th>이벤트ID</th>
          <th>제목 / 설명</th>
          <th>상태</th>
          <th>익명</th>
          <th>복제원본ID</th>
          <th>오픈 일시</th>
          <th>마감 일시</th>
          <th>작성 일시</th>
          <th>수정 일시</th>
          <th>템플릿</th>
          <th>템플릿키</th>
          <th>상세</th>
        </tr>
      </thead>

      <tbody>
        <!-- 고정 템플릿 -->
        <c:forEach var="s" items="${templateList}">
          <tr class="row-pinned">
            <td>${s.surveyId}</td>
            <td><c:out value="${s.eventId != null ? s.eventId : '-'}"/></td>

            <td class="col-title">
              <span class="title"><c:out value="${s.title}"/></span>
              <span class="desc"><c:out value="${s.description}"/></span>
            </td>

            <td>
              <c:choose>
                <c:when test="${s.status == 'OPEN'}"><span class="badge b-open">OPEN</span></c:when>
                <c:when test="${s.status == 'ARCHIVED'}"><span class="badge b-arch">ARCHIVED</span></c:when>
                <c:when test="${s.status == 'CLOSED'}"><span class="badge b-closed">CLOSED</span></c:when>
                <c:otherwise>-</c:otherwise>
              </c:choose>
            </td>

            <td><span class="badge b-arch b-yn"><c:out value="${s.isAnonymous == 1 ? 'Y' : 'N'}"/></span></td>
            <td><c:out value="${s.cloneFromSurveyId != null ? s.cloneFromSurveyId : '-'}"/></td>

            <td class="col-dt">
              <c:choose>
                <c:when test="${s.openAt != null}">
                  <span class="date"><c:out value="${s.openAt.toLocalDate()}"/></span>
                  <span class="time"><c:out value="${s.openAt.toLocalTime()}"/></span>
                </c:when>
                <c:otherwise>-</c:otherwise>
              </c:choose>
            </td>
            <td class="col-dt">
              <c:choose>
                <c:when test="${s.closeAt != null}">
                  <span class="date"><c:out value="${s.closeAt.toLocalDate()}"/></span>
                  <span class="time"><c:out value="${s.closeAt.toLocalTime()}"/></span>
                </c:when>
                <c:otherwise>-</c:otherwise>
              </c:choose>
            </td>

            <td class="col-dt">
              <c:choose>
                <c:when test="${s.createdAt != null}">
                  <span class="date"><c:out value="${s.createdAt.toLocalDate()}"/></span>
                  <span class="time"><c:out value="${s.createdAt.toLocalTime()}"/></span>
                </c:when>
                <c:otherwise>-</c:otherwise>
              </c:choose>
            </td>
            <td class="col-dt">
              <c:choose>
                <c:when test="${s.updateAt != null}">
                  <span class="date"><c:out value="${s.updateAt.toLocalDate()}"/></span>
                  <span class="time"><c:out value="${s.updateAt.toLocalTime()}"/></span>
                </c:when>
                <c:otherwise>-</c:otherwise>
              </c:choose>
            </td>

            <td><span class="badge b-open">Y</span></td>
            <td class="col-tplkey"><c:out value="${empty s.templateKey ? '-' : s.templateKey}"/></td>
            <td class="center">
			  <button type="button"
			          class="btn-detail"
			          onclick="location.href='<c:url value="/admin/surveys/${s.surveyId}"/>'">
			    상세
			  </button>
			</td>
          </tr>
        </c:forEach>

        <!-- 일반 설문 -->
        <c:forEach var="s" items="${surveyList}">
          <tr>
            <td>${s.surveyId}</td>
            <td><c:out value="${s.eventId != null ? s.eventId : '-'}"/></td>

            <td class="col-title">
              <span class="title"><c:out value="${s.title}"/></span>
              <span class="desc"><c:out value="${s.description}"/></span>
            </td>

            <td>
              <c:choose>
                <c:when test="${s.status == 'OPEN'}"><span class="badge b-open">OPEN</span></c:when>
                <c:when test="${s.status == 'ARCHIVED'}"><span class="badge b-arch">ARCHIVED</span></c:when>
                <c:when test="${s.status == 'CLOSED'}"><span class="badge b-closed">CLOSED</span></c:when>
                <c:otherwise>-</c:otherwise>
              </c:choose>
            </td>

            <td><span class="badge b-arch b-yn"><c:out value="${s.isAnonymous == 1 ? 'Y' : 'N'}"/></span></td>
            <td><c:out value="${s.cloneFromSurveyId != null ? s.cloneFromSurveyId : '-'}"/></td>

            <td class="col-dt">
              <c:choose>
                <c:when test="${s.openAt != null}">
                  <span class="date"><c:out value="${s.openAt.toLocalDate()}"/></span>
                  <span class="time"><c:out value="${s.openAt.toLocalTime()}"/></span>
                </c:when>
                <c:otherwise>-</c:otherwise>
              </c:choose>
            </td>
            <td class="col-dt">
              <c:choose>
                <c:when test="${s.closeAt != null}">
                  <span class="date"><c:out value="${s.closeAt.toLocalDate()}"/></span>
                  <span class="time"><c:out value="${s.closeAt.toLocalTime()}"/></span>
                </c:when>
                <c:otherwise>-</c:otherwise>
              </c:choose>
            </td>

            <td class="col-dt">
              <c:choose>
                <c:when test="${s.createdAt != null}">
                  <span class="date"><c:out value="${s.createdAt.toLocalDate()}"/></span>
                  <span class="time"><c:out value="${s.createdAt.toLocalTime()}"/></span>
                </c:when>
                <c:otherwise>-</c:otherwise>
              </c:choose>
            </td>
            <td class="col-dt">
              <c:choose>
                <c:when test="${s.updateAt != null}">
                  <span class="date"><c:out value="${s.updateAt.toLocalDate()}"/></span>
                  <span class="time"><c:out value="${s.updateAt.toLocalTime()}"/></span>
                </c:when>
                <c:otherwise>-</c:otherwise>
              </c:choose>
            </td>

            <td><span class="badge b-arch">N</span></td>
            <td class="col-tplkey"><c:out value="${empty s.templateKey ? '-' : s.templateKey}"/></td>
            <td class="center">
			  <button type="button"
			          class="btn-detail"
			          onclick="location.href='<c:url value="/admin/surveys/${s.surveyId}"/>'">
			    상세
			  </button>
			</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>

    <!-- 페이지네이션 -->
	<div class="pagi">
	  <!-- « 첫 페이지 -->
	  <c:if test="${pageVO.cri.page > 1}">
	    <a class="btn-page edge" href="<c:url value='/admin/surveys?page=1'/>" aria-label="첫 페이지">&laquo;</a>
	  </c:if>
	
	  <!-- ‹ 이전 1페이지 -->
	  <c:if test="${pageVO.cri.page > 1}">
	    <a class="btn-page edge" href="<c:url value='/admin/surveys?page=${pageVO.cri.page - 1}'/>" aria-label="이전 페이지">&lsaquo;</a>
	  </c:if>
	
	  <!-- 페이지 숫자 (현재 페이지도 a로 - 클릭 가능) -->
	  <c:forEach var="num" begin="${pageVO.startPage}" end="${pageVO.endPage}">
	    <a class="btn-page${pageVO.cri.page == num ? ' on' : ''}"
	       href="<c:url value='/admin/surveys?page=${num}'/>"
	       aria-current="${pageVO.cri.page == num ? 'page' : ''}">
	       ${num}
	    </a>
	  </c:forEach>
	
	  <!-- › 다음 1페이지 -->
	  <c:if test="${pageVO.cri.page < pageVO.totalPage}">
	    <a class="btn-page edge" href="<c:url value='/admin/surveys?page=${pageVO.cri.page + 1}'/>" aria-label="다음 페이지">&rsaquo;</a>
	  </c:if>
	
	  <!-- » 마지막 페이지 -->
	  <c:if test="${pageVO.cri.page < pageVO.totalPage}">
	    <a class="btn-page edge" href="<c:url value='/admin/surveys?page=${pageVO.totalPage}'/>" aria-label="마지막 페이지">&raquo;</a>
	  </c:if>
	</div>


  </div>
</div>

<script>
  // 엔터로 검색
  (function(){
    var kw = document.querySelector('input[name="keyword"]');
    if(kw){
      kw.addEventListener('keypress', function(e){
        if(e.key === 'Enter'){ e.target.form.submit(); }
      });
    }
  })();
</script>
</body>
</html>
