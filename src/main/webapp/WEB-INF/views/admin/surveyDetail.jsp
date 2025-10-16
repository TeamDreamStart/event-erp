<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>설문 상세</title>

<!-- CSRF -->
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />

<!-- SB Admin 2 / fonts / icons -->
<link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
<link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">

<!-- SB Admin 2 core scripts -->
<script src="/resources/vendor/jquery/jquery.min.js"></script>
<script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="/resources/js/sb-admin-2.min.js"></script>

<style>
/* ================= Survey Detail (scoped) ================= */
.survey-detail {
  /* ✅ CSS 변수는 컨테이너에 선언 */
  --brand-600:#4e73df;
  --brand-700:#3a57c5;
  --border:#e5e7eb;
  --muted:#6b7280;
  --bg:#f8fafc;
}

/* 툴바 */
.survey-detail .toolbar{display:flex;align-items:center;gap:.75rem;}
.survey-detail h1{font-size:clamp(20px,2.1vw,26px);line-height:1.25;margin:0;word-break:keep-all;overflow-wrap:anywhere;}

/* 상태/익명 배지 */
.survey-detail .badges{display:flex;gap:.5rem;align-items:center;margin-left:.5rem;}
.survey-detail .badge-soft-primary{background:#eef2ff;color:var(--brand-700);border-radius:999px;font-weight:700;padding:.35rem .6rem;}
.survey-detail .badge-soft-muted{background:#f1f5f9;color:#334155;border-radius:999px;font-weight:700;padding:.35rem .6rem;}

/* ✅ 채움 버튼: 부트스트랩과 충돌 피하려고 sd-btn 접두사 사용 */
.survey-detail .sd-btn{
  display:inline-flex;align-items:center;justify-content:center;
  height:38px;padding:0 14px;border-radius:.65rem;
  border:1px solid var(--brand-600);
  background:var(--brand-600); color:#fff;
  font-weight:700;text-decoration:none;cursor:pointer;
  transition:.15s; box-shadow:0 1px 0 rgba(0,0,0,.03);
}
.survey-detail .sd-btn:hover{background:var(--brand-700);border-color:var(--brand-700);}
.survey-detail .sd-btn--ghost{background:#fff;color:var(--brand-700);border-color:#c7d2fe;}
.survey-detail .sd-btn--ghost:hover{background:#eef2ff;}

/* 정보 카드 */
.survey-detail .kv-grid{display:grid;gap:.75rem;grid-template-columns:repeat(4,minmax(0,1fr));}
@media (max-width:980px){.survey-detail .kv-grid{grid-template-columns:repeat(2,minmax(0,1fr));}}
.survey-detail .kv{border:1px solid var(--border);border-radius:.65rem;padding:.65rem .8rem;background:#fff;min-height:64px;}
.survey-detail .kv .k{color:var(--muted);font-size:.75rem;display:block;}
.survey-detail .kv .v{font-weight:700;margin-top:.25rem;white-space:normal;overflow-wrap:anywhere;font-size:clamp(12px,1.05vw,14px);}
.survey-detail .kv .v .sub{color:#9ca3af;font-weight:500;font-size:.75rem;margin-left:.35rem;}

/* 섹션 타이틀 */
.survey-detail .section-title{font-size:1.1rem;font-weight:800;margin:1rem 0 .5rem;color:var(--brand-600);}

/* 문항 카드 */
.survey-detail .q-card{border:1px solid var(--border);border-radius:.75rem;background:#fff;padding:1.1rem;margin-top:1rem;box-shadow:0 1px 0 rgba(0,0,0,.02);}
.survey-detail .q-card:first-child{margin-top:0;}
.survey-detail .q-head{display:flex;align-items:center;gap:.6rem;margin-bottom:.4rem;}
.survey-detail .q-no{display:inline-flex;align-items:center;justify-content:center;width:26px;height:26px;border-radius:999px;background:#eef2ff;color:var(--brand-700);font-weight:800;font-size:.8rem;flex:0 0 26px;}
.survey-detail .q-title{font-weight:800;line-height:1.35;}
.survey-detail .q-desc{color:var(--muted);font-size:.75rem;margin-left:.35rem;}

.survey-detail .bar-line{display:flex;align-items:center;gap:.75rem;margin:.6rem 0;}
.survey-detail .bar-label{min-width:110px;white-space:nowrap;}
.survey-detail .bar-track{flex:1;height:14px;background:#eef2ff;border-radius:999px;overflow:hidden;}
.survey-detail .bar-fill{height:100%;border-radius:999px;background:#1cc88a;}
.survey-detail .bar-right{min-width:120px;text-align:right;}
.survey-detail .bar-right .big{font-size:1.15rem;font-weight:800;margin-right:.35rem;}
.survey-detail .bar-right .small{color:#999;font-size:.9rem;}
.survey-detail .bottom-actions{display:flex;justify-content:flex-end;margin-top:1rem;}
</style>
</head>
<body id="page-top">
<div id="wrapper">

  <!-- 사이드바 + 상단바 -->
  <jsp:include page="../adminIncludes/header.jsp" />

  <!-- 본문 -->
  <div class="container-fluid survey-detail">

    <!-- 상단 툴바 -->
    <div class="d-flex align-items-center mb-3">
      <div class="toolbar flex-grow-1">
        <h1 class="ml-1 mb-0">설문 상세</h1>

        <div class="badges">
          <c:if test="${not empty survey.status}">
            <span class="badge-soft-primary text-uppercase"><c:out value="${survey.status}" /></span>
          </c:if>
          <span class="badge-soft-muted">익명:
            <c:out value="${survey != null && survey.isAnonymous == 1 ? 'Y' : 'N'}"/>
          </span>
        </div>

        <div class="ml-auto d-flex" style="gap:.5rem;">
          <c:if test="${isTemplate}">
            <a class="sd-btn" href="<c:url value='/admin/surveys/form?templateId=${survey.surveyId}'/>">템플릿 복제하기</a>
          </c:if>
          <c:if test="${not isTemplate}">
            <a class="sd-btn" href="<c:url value='/admin/surveys/form?surveyId=${survey.surveyId}&eventId=${survey.eventId}'/>">수정하기</a>
            <button type="button" class="sd-btn" onclick="deleteSurvey(${survey.surveyId})">삭제하기</button>
          </c:if>
          <a class="sd-btn" href="<c:url value='/admin/surveys'/>">목록</a>
        </div>
      </div>
    </div>

    <!-- 메타 카드 -->
    <div class="card shadow mb-3">
      <div class="card-body">
        <div class="kv-grid">
          <div class="kv"><span class="k">설문 제목</span><span class="v"><c:out value="${empty survey.title ? '-' : survey.title}"/></span></div>
          <div class="kv"><span class="k">이벤트명</span><span class="v"><c:out value="${empty eventTitle ? '-' : eventTitle}"/></span></div>
          <div class="kv"><span class="k">오픈 일시</span><span class="v"><c:out value="${empty openAtStr ? '-' : openAtStr}"/></span></div>
          <div class="kv"><span class="k">마감 일시</span><span class="v"><c:out value="${empty closeAtStr ? '-' : closeAtStr}"/></span></div>

          <div class="kv">
            <span class="k">생성자</span>
            <span class="v">
              <c:choose>
                <c:when test="${not empty createdName}"><c:out value="${createdName}"/></c:when>
                <c:otherwise><c:out value="${empty survey.createdBy ? '-' : survey.createdBy}"/></c:otherwise>
              </c:choose>
            </span>
          </div>
          <div class="kv">
            <span class="k">응답률</span>
            <span class="v">
              <c:out value="${top.rate_pct}"/>%
              <span class="sub">(<c:out value="${top.responders}"/>/<c:out value="${top.applicants}"/>)</span>
            </span>
          </div>
          <div class="kv"><span class="k">템플릿키</span><span class="v"><c:out value="${empty survey.templateKey ? '-' : survey.templateKey}"/></span></div>
          <div class="kv"><span class="k">복제 원본ID</span><span class="v"><c:out value="${empty survey.cloneFromSurveyId ? '-' : survey.cloneFromSurveyId}"/></span></div>
        </div>
      </div>
    </div>

    <!-- 문항 -->
    <div class="section-title">문항</div>
    <div class="card shadow">
      <div class="card-body">
        <c:choose>
          <c:when test="${empty rows}">
            문항이 없습니다.
          </c:when>
          <c:otherwise>
            <c:set var="curQ" value="-1"/>
            <c:set var="qIdx" value="0"/>
            <c:forEach var="row" items="${rows}" varStatus="st">
              <c:if test="${curQ ne row.question_id}">
                <c:if test="${!st.first}">
                  </div></div>
                </c:if>
                <c:set var="qIdx" value="${qIdx + 1}"/>
                <div class="q-card">
                  <div class="q-head">
                    <div class="q-no">${qIdx}</div>
                    <div class="q-title">
                      ${row.q_title}
                      <c:if test="${row.q_required or row.q_required eq 1 or row.q_required eq '1'}">
                        <span class="q-desc">(필수)</span>
                      </c:if>
                    </div>
                  </div>
                  <div class="q-body">
              </c:if>

              <div class="bar-line">
                <div class="bar-label">${row.label}</div>
                <div class="bar-track"><div class="bar-fill" style="width:${row.pct_applicants}%;"></div></div>
                <div class="bar-right"><span class="big">${row.pct_applicants}%</span><span class="small">(${row.cnt}/${row.denom})</span></div>
              </div>

              <c:set var="curQ" value="${row.question_id}"/>
              <c:if test="${st.last}"></div></div></c:if>
            </c:forEach>
          </c:otherwise>
        </c:choose>
      </div>
    </div>

    <div class="bottom-actions">
      <a class="sd-btn" href="<c:url value='/admin/surveys'/>">목록으로</a>
    </div>
  </div>
  <!-- /.container-fluid -->

  <!-- 푸터 -->
  <jsp:include page="../adminIncludes/footer.jsp" />
</div>
<!-- /#wrapper -->

<!-- Scroll Top, Logout Modal -->
<a class="scroll-to-top rounded" href="#page-top"><i class="fas fa-angle-up"></i></a>
<jsp:include page="../adminIncludes/logoutModal.jsp" />

<script>
  async function parseJsonSafe(res){
    const ct = res.headers.get('content-type') || '';
    const text = await res.text();
    if (ct.includes('application/json')) return JSON.parse(text);
    throw new Error(`HTTP ${res.status} (non-JSON): ${text.slice(0,200)}`);
  }

  function deleteSurvey(id){
    if(!confirm('정말 삭제할까요? (응답 없고 클론본만 삭제됩니다)')) return;
    const token  = document.querySelector('meta[name="_csrf"]')?.content;
    const header = document.querySelector('meta[name="_csrf_header"]')?.content || 'X-CSRF-TOKEN';
    const headers = {'Accept':'application/json'}; if (token) headers[header] = token;

    fetch('<c:url value="/admin/api/surveys"/>' + '/' + id, {
      method: 'DELETE', headers, credentials: 'same-origin'
    })
    .then(r => r.ok ? r.json() : r.json().then(e => Promise.reject(e)))
    .then(() => { alert('삭제되었습니다.'); location.href = '<c:url value="/admin/surveys"/>'; })
    .catch(e => alert((e && e.message) ? e.message : '삭제 실패'));
  }
</script>
</body>
</html>
