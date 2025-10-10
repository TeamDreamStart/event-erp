<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>설문 상세</title>
  <style>
    :root{ --brand-600:#4f46e5; --brand-700:#4338ca; --border:#e5e7eb; --muted:#6b7280; --bg:#f8fafc; }
    body{font-family:system-ui,-apple-system,Segoe UI,Roboto,"Noto Sans KR",Arial,sans-serif;background:var(--bg);color:#111827;margin:0;}
    .wrap{max-width:1080px;margin:28px auto 60px;padding:0 16px;}
    .toolbar{display:flex;align-items:center;gap:12px;}
    h1{font-size:28px;margin:0;}
    .badges{display:flex;gap:10px;align-items:center;margin-left:12px;}
    .badge{display:inline-block;padding:6px 10px;border-radius:999px;font-weight:700;font-size:13px;background:#eef2ff;color:#3730a3;}
    .badge--muted{background:#f1f5f9;color:#334155;}
    .top-actions{margin-left:auto;display:flex;gap:10px;}
    .btn{display:inline-flex;align-items:center;justify-content:center;height:40px;padding:0 16px;border-radius:10px;border:1px solid var(--brand-600);background:var(--brand-600);color:#fff;font-weight:700;text-decoration:none;cursor:pointer;transition:.15s;box-shadow:0 1px 0 rgba(0,0,0,.03);}
    .btn:hover{background:var(--brand-700);border-color:var(--brand-700);}

    .card{background:#fff;border:1px solid var(--border);border-radius:12px;padding:14px;}
    .card .grid{display:grid;gap:12px;grid-template-columns:repeat(4,minmax(0,1fr));}
    .kv{border:1px solid var(--border);border-radius:10px;padding:12px;min-height:64px;background:#fff;}
    .kv .k{color:var(--muted);font-size:13px;display:block;}
    .kv .v{font-weight:700;margin-top:4px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;}

    .section-title{font-size:18px;font-weight:800;margin:20px 0 10px;}
    .q-list{display:flex;flex-direction:column;gap:10px;}
    .q-item{border:1px solid var(--border);border-radius:12px;padding:14px;background:#fff;}
    .q-head{font-weight:800;}
    .q-desc{color:var(--muted);font-size:13px;margin-left:4px;}
    .q-body{margin-top:10px;}
    .q-opt{display:flex;align-items:center;gap:8px;margin:6px 0;color:#374151;}
    .q-text{width:100%;height:38px;border:1px solid #cbd5e1;border-radius:8px;padding:0 12px;background:#f8fafc;}
    .bottom-actions{display:flex;justify-content:flex-end;margin-top:18px;}
  </style>
</head>
<body>
<div class="wrap">

  <!-- 상단 -->
  <div class="toolbar">
    <h1>설문 상세</h1>
    <div class="badges">
      <c:if test="${not empty survey.status}">
        <span class="badge"><c:out value="${survey.status}"/></span>
      </c:if>
      <span class="badge badge--muted">익명: <c:out value="${survey != null && survey.isAnonymous == 1 ? 'Y' : 'N'}"/></span>
    </div>

    <div class="top-actions">
      <c:if test="${isTemplate}">
        <a class="btn" href="${pageContext.request.contextPath}/admin/surveys/form?eventId=${survey.eventId}">템플릿 복제하기</a>
      </c:if>
      <c:if test="${not isTemplate}">
        <a class="btn" href="${pageContext.request.contextPath}/admin/surveys/form?surveyId=${survey.surveyId}">수정하기</a>
        <a class="btn" href="${pageContext.request.contextPath}/admin/surveys/delete?surveyId=${survey.surveyId}">삭제하기</a>
      </c:if>
    </div>
  </div>

  <!-- 메타 카드 -->
  <div class="card" style="margin-top:14px;margin-bottom:14px;">
    <div class="grid">
      <div class="kv">
        <span class="k">설문 제목</span>
        <span class="v"><c:out value="${empty survey.title ? '-' : survey.title}"/></span>
      </div>
      <div class="kv">
        <span class="k">이벤트명</span>
        <span class="v"><c:out value="${empty eventTitle ? '-' : eventTitle}"/></span>
      </div>
      <div class="kv">
        <span class="k">오픈 일시</span>
        <span class="v"><c:out value="${empty openAtStr ? '-' : openAtStr}"/></span>
      </div>
      <div class="kv">
        <span class="k">마감 일시</span>
        <span class="v"><c:out value="${empty closeAtStr ? '-' : closeAtStr}"/></span>
      </div>

      <div class="kv">
        <span class="k">생성자</span>
        <span class="v"><c:out value="${empty survey.createdBy ? '-' : survey.createdBy}"/></span>
      </div>
      <div class="kv">
        <span class="k">응답 횟수</span>
        <span class="v"><c:out value="${responses}"/></span>
      </div>
      <div class="kv">
        <span class="k">템플릿키</span>
        <span class="v"><c:out value="${empty survey.templateKey ? '-' : survey.templateKey}"/></span>
      </div>
      <div class="kv">
        <span class="k">복제 원본ID</span>
        <span class="v"><c:out value="${empty survey.cloneFromSurveyId ? '-' : survey.cloneFromSurveyId}"/></span>
      </div>
    </div>
  </div>

  <!-- 문항 -->
  <div class="section-title">문항</div>
  <div class="card">
    <c:choose>
      <c:when test="${empty questions}">
        문항이 없습니다.
      </c:when>
      <c:otherwise>
        <div class="q-list">
          <c:forEach var="q" items="${questions}" varStatus="st">
            <div class="q-item">
              <div class="q-head">
                <c:out value="${st.index + 1}"/>. <c:out value="${q.question}"/>
                <c:if test="${q.required}"><span class="q-desc">(필수)</span></c:if>
              </div>
              <div class="q-body">
                <c:choose>
                  <c:when test="${q.type == 'SINGLE'}">
                    <c:forEach var="op" items="${optionsByQ[q.questionId]}">
                      <label class="q-opt">
                        <input type="radio" disabled />
                        <span><c:out value="${op.label}"/></span>
                      </label>
                    </c:forEach>
                  </c:when>

                  <c:when test="${q.type == 'MULTI'}">
                    <c:forEach var="op" items="${optionsByQ[q.questionId]}">
                      <label class="q-opt">
                        <input type="checkbox" disabled />
                        <span><c:out value="${op.label}"/></span>
                      </label>
                    </c:forEach>
                  </c:when>

                  <c:when test="${q.type == 'SCALE_5'}">
                    <div class="q-opt">매우 나쁨(1) ~ 매우 좋음(5)</div>
                  </c:when>

                  <c:when test="${q.type == 'TEXT'}">
                    <input class="q-text" type="text" disabled placeholder="자유 입력" />
                  </c:when>

                  <c:otherwise>
                    <div class="q-opt">미리보기 불가한 형식</div>
                  </c:otherwise>
                </c:choose>
              </div>
            </div>
          </c:forEach>
        </div>
      </c:otherwise>
    </c:choose>
  </div>

  <!-- 하단: 목록 -->
  <div class="bottom-actions">
    <a class="btn" href="${pageContext.request.contextPath}/admin/surveys">목록으로</a>
  </div>

</div>
</body>
</html>
