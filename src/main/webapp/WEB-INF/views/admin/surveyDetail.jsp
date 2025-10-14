<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>설문 상세</title>

  <!-- CSRF (삭제/버튼 등에서 사용) -->
  <meta name="_csrf" content="${_csrf.token}"/>
  <meta name="_csrf_header" content="${_csrf.headerName}"/>

  <style>
    :root{ --brand-600:#4f46e5; --brand-700:#4338ca; --border:#e5e7eb; --muted:#6b7280; --bg:#f8fafc; }
    body{font-family:system-ui,-apple-system,Segoe UI,Roboto,"Noto Sans KR",Arial,sans-serif;background:var(--bg);color:#111827;margin:0;}
    .wrap{max-width:1080px;margin:28px auto 60px;padding:0 16px;}

    .toolbar{display:flex;align-items:center;gap:12px;}
    h1{ font-size: clamp(20px, 2.4vw, 26px); line-height:1.25; word-break:keep-all; overflow-wrap:anywhere; margin:0; }
    .badges{display:flex;gap:10px;align-items:center;margin-left:12px;}
    .badge{display:inline-block;padding:6px 10px;border-radius:999px;font-weight:700;font-size:13px;background:#eef2ff;color:#3730a3;}
    .badge--muted{background:#f1f5f9;color:#334155;}
    .top-actions{margin-left:auto;display:flex;gap:10px;}
    .btn{display:inline-flex;align-items:center;justify-content:center;height:38px;padding:0 14px;border-radius:10px;border:1px solid var(--brand-600);background:var(--brand-600);color:#fff;font-weight:700;text-decoration:none;cursor:pointer;transition:.15s;box-shadow:0 1px 0 rgba(0,0,0,.03);}
    .btn:hover{background:var(--brand-700);border-color:var(--brand-700);}
    .btn--ghost{background:#fff;color:var(--brand-700);border-color:#c7d2fe;}
    .btn--ghost:hover{background:#eef2ff;}

    .card{background:#fff;border:1px solid var(--border);border-radius:12px;padding:20px;}
    .card .grid{ display:grid;gap:12px;grid-template-columns:repeat(4,minmax(0,1fr)); }
    @media (max-width: 980px){ .card .grid{grid-template-columns:repeat(2,minmax(0,1fr));} }

    .kv{border:1px solid var(--border);border-radius:10px;padding:10px 12px;min-height:64px;background:#fff;}
    .kv .k{color:var(--muted);font-size:12px;display:block;}
    .kv .v{font-weight:700;margin-top:4px;white-space:normal;overflow-wrap:anywhere;font-size: clamp(12px, 1.25vw, 14px);}
    .kv .v .sub{color:#9ca3af;font-weight:500;font-size:12px;margin-left:6px;}

    .section-title{font-size:18px;font-weight:800;margin:20px 0 10px;}

    .q-card{ border:1px solid var(--border);border-radius:12px;background:#fff;padding:20px;margin-top:20px; box-shadow:0 1px 0 rgba(0,0,0,.02); }
    .q-card:first-child{margin-top:0;}
    .q-head{display:flex;align-items:center;gap:10px;margin-bottom:10px;}
    .q-no{display:inline-flex;align-items:center;justify-content:center;width:26px;height:26px;border-radius:999px;background:#eef2ff;color:#4338ca;font-weight:800;font-size:13px;flex:0 0 26px;}
    .q-title{font-weight:800;line-height:1.35;}
    .q-desc{color:var(--muted);font-size:12px;margin-left:6px;}

    .q-body{margin-top:6px;}
    .bar-line{display:flex;align-items:center;gap:12px;margin:10px 0;}
    .bar-label{min-width:110px;white-space:nowrap;}
    .bar-track{flex:1;height:14px;background:#eee;border-radius:999px;overflow:hidden;}
    .bar-fill{height:100%;border-radius:999px;background:#ff2a2a;}
    .bar-right{min-width:120px;text-align:right;}
    .bar-right .big{font-size:1.2rem;font-weight:800;margin-right:6px;}
    .bar-right .small{color:#999;font-size:.9rem;}

    .bottom-actions{display:flex;justify-content:flex-end;margin-top:18px;}
  </style>
</head>
<body>
<div class="wrap">

  <!-- 상단 툴바 (뒤로가기 + 상태/익명 + 우측 액션) -->
  <div class="toolbar">
    <a href="<c:url value='/admin/surveys'/>" class="btn btn--ghost" style="height:34px">← 뒤로</a>
    <h1>설문 상세</h1>

    <div class="badges">
      <c:if test="${not empty survey.status}">
        <span class="badge"><c:out value="${survey.status}"/></span>
      </c:if>
      <span class="badge badge--muted">익명:
        <c:out value="${survey != null && survey.isAnonymous == 1 ? 'Y' : 'N'}"/>
      </span>
    </div>

    <div class="top-actions">
      <c:if test="${isTemplate}">
        <!-- 템플릿 상세 → 템플릿만 프리셋, 이벤트는 미선택 -->
        <a class="btn" href="<c:url value='/admin/surveys/form?templateId=${survey.surveyId}'/>">템플릿 복제하기</a>
      </c:if>
      <c:if test="${not isTemplate}">
        <!-- 복제본 상세 → 설문/이벤트 프리셋으로 폼 진입 -->
        <a class="btn" href="<c:url value='/admin/surveys/form?surveyId=${survey.surveyId}&eventId=${survey.eventId}'/>">수정하기</a>
        <button class="btn" onclick="deleteSurvey(${survey.surveyId})">삭제하기</button>
      </c:if>
      <a class="btn" href="<c:url value='/admin/surveys'/>">목록</a>
    </div>
  </div>

  <!-- 메타 카드 -->
  <div class="card" style="margin-top:14px;margin-bottom:14px;">
    <div class="grid">
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

  <!-- 문항 -->
  <div class="section-title">문항</div>
  <div class="card">
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
              </div></div> <!-- /.q-body /.q-card close -->
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

          <c:if test="${st.last}">
              </div></div>
          </c:if>
        </c:forEach>
      </c:otherwise>
    </c:choose>
  </div>

  <div class="bottom-actions"><a class="btn" href="<c:url value='/admin/surveys'/>">목록으로</a></div>
</div>

<script>
  // JSON 안전 파서 (서버가 에러로 HTML을 보내도 'Unexpected token <' 안 터지게)
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
	    method: 'DELETE',
	    headers,
	    credentials: 'same-origin'
	  })
	  .then(r => r.ok ? r.json() : r.json().then(e => Promise.reject(e)))
	  .then(() => { alert('삭제되었습니다.'); location.href = '<c:url value="/admin/surveys"/>'; })
	  .catch(e => alert((e && e.message) ? e.message : '삭제 실패'));
	}

</script>
</body>
</html>
