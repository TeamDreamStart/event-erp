<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>이벤트 등록/수정</title>
<link rel="icon" href="data:,">
<style>
  body { font-family: system-ui, sans-serif; }
  .field { margin: 12px 0; }
  .field label { display:block; font-weight:600; margin-bottom:6px; }
  .actions { margin-top: 24px; display:flex; gap:8px; }
  input[type="text"], input[type="url"], input[type="number"], textarea, select, input[type="datetime-local"] { width: 420px; max-width: 100%; }
  small.muted { color:#888 }
</style>
</head>
<body>
<main>
  <c:set var="isNew" value="${empty event or empty event.eventId}"/>

  <!-- 선택지 -->
  <c:set var="STATUSES"   value="${fn:split('OPEN,CLOSED,CANCELLED', ',')}"/>
  <c:set var="VIS"        value="${fn:split('PUBLIC,PRIVATE', ',')}"/>
  <c:set var="CATEGORIES" value="${fn:split('SHOW,SPEECH,WORKSHOP,MARKET', ',')}"/>

  <form id="eventForm" method="post" action="<c:url value='/admin/events/save'/>">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
    <c:if test="${!isNew}">
      <input type="hidden" name="eventId" value="${event.eventId}"/>
    </c:if>

    <h1>
      <c:choose>
        <c:when test="${isNew}">이벤트 등록</c:when>
        <c:otherwise>이벤트 수정 (#${event.eventId})</c:otherwise>
      </c:choose>
    </h1>

    <!-- 제목 -->
    <div class="field">
      <label for="title">제목</label>
      <input type="text" id="title" name="title" value="${event.title}" required maxlength="200" />
    </div>

    <!-- 설명 -->
    <div class="field">
      <label for="description">설명</label>
      <textarea id="description" name="description" rows="6">${event.description}</textarea>
    </div>

    <!-- 장소 -->
    <div class="field">
      <label for="location">장소</label>
      <input type="text" id="location" name="location" value="${event.location}" maxlength="200"/>
    </div>

    <!-- 시작/종료 -->
    <div class="field">
      <label>시작일시</label>
      <input type="datetime-local" id="startDate" name="startDate" value="${startHtml}" step="60"/>
      <label>종료일시</label>
      <input type="datetime-local" id="endDate" name="endDate" value="${endHtml}" step="60"/>
      <small class="muted">※ 종료가 시작보다 빠르면 경고됩니다.</small>
    </div>

    <!-- 정원 -->
    <div class="field">
      <label for="capacity">정원</label>
      <input type="number" id="capacity" name="capacity" value="${event.capacity}" min="0" />
    </div>

    <!-- 상태 -->
    <div class="field">
      <label for="status">상태</label>
      <select id="status" name="status">
        <c:forEach var="s" items="${STATUSES}">
          <option value="${s}" <c:if test="${(isNew and s=='OPEN') or (!isNew and event.status==s)}">selected</c:if>>${s}</option>
        </c:forEach>
      </select>
    </div>

    <!-- 공개범위 -->
    <div class="field">
      <label for="visibility">공개범위</label>
      <select id="visibility" name="visibility">
        <c:forEach var="v" items="${VIS}">
          <option value="${v}" <c:if test="${(isNew and v=='PUBLIC') or (!isNew and event.visibility==v)}">selected</c:if>>${v}</option>
        </c:forEach>
      </select>
    </div>

    <!-- 카테고리 -->
    <div class="field">
      <label for="category">카테고리</label>
      <select id="category" name="category">
        <c:forEach var="c1" items="${CATEGORIES}">
          <option value="${c1}" <c:if test="${(isNew and c1=='SHOW') or (!isNew and event.category==c1)}">selected</c:if>>${c1}</option>
        </c:forEach>
      </select>
    </div>

    <!-- 포스터 -->
    <div class="field">
      <label for="posterUrl">포스터 URL</label>
      <input type="url" id="posterUrl" name="posterUrl" value="${event.posterUrl}" />
      <c:if test="${not empty event.posterUrl}">
        <div style="margin-top:8px"><img src="${event.posterUrl}" alt="poster" style="max-height:160px"/></div>
      </c:if>
    </div>

    <!-- 유료/가격 -->
    <div class="field">
      <label for="paid">유료 여부</label>
      <select id="paid" name="paid">
        <option value="false" <c:if test="${isNew or (not empty event and (event.paid == false or event.paid == null))}">selected</c:if>>무료</option>
        <option value="true"  <c:if test="${!isNew and event.paid == true}">selected</c:if>>유료</option>
      </select>
    </div>

    <div class="field">
      <label for="price">가격</label>
      <input type="number" id="price" name="price" step="1" min="0"
             value="<c:out value='${empty event.price ? 0 : event.price}'/>" />
      <select id="currency" name="currency">
        <option value="KRW" <c:if test="${isNew or event.currency=='KRW' or empty event.currency}">selected</c:if>>KRW</option>
        <option value="USD" <c:if test="${event.currency=='USD'}">selected</c:if>>USD</option>
      </select>
    </div>

    <!-- 표기용 메타 -->
    <div class="field">
      <small class="muted">
        작성자: <c:out value="${event.createdByName}"/> /
        최종수정자: <c:out value="${event.updatedByName}"/><br/>
        등록: ${createdView} / 수정: ${updatedView}
      </small>
    </div>

    <div class="actions">
      <button type="submit">저장</button>
      <button type="button" id="btn-cancel">취소</button>
      <c:if test="${!isNew}">
        <button type="button" id="btnDelete" style="color:#c00">삭제</button>
      </c:if>
    </div>
  </form>
</main>

<script>
document.addEventListener('DOMContentLoaded', function () {
  const startEl  = document.getElementById('startDate');
  const endEl    = document.getElementById('endDate');
  const paidEl   = document.getElementById('paid');
  const priceEl  = document.getElementById('price');
  const currEl   = document.getElementById('currency');
  const cancelBtn= document.getElementById('btn-cancel');
  const delBtn   = document.getElementById('btnDelete');

  function togglePrice(){
    const isPaid = paidEl && paidEl.value === 'true';
    if (!priceEl || !currEl) return;
    priceEl.disabled = !isPaid;
    currEl.disabled  = !isPaid;
    if (!isPaid) priceEl.value = 0;
  }
  if (paidEl) paidEl.addEventListener('change', togglePrice);
  togglePrice();

  function isEndBeforeStart(){
    if (!startEl || !endEl || !startEl.value || !endEl.value) return false;
    return endEl.value < startEl.value;
  }

  document.getElementById('eventForm').addEventListener('submit', function(e){
    if (isEndBeforeStart()){
      e.preventDefault();
      alert('종료일시는 시작일시 이후여야 합니다.');
      endEl.focus();
      return;
    }
    if (paidEl && paidEl.value !== 'true') { priceEl.value = 0; }
  });

  if (cancelBtn){
    cancelBtn.addEventListener('click', function(e){
      e.preventDefault();
      const page = '${param.page}' || '1';
      location.href = '${pageContext.request.contextPath}/admin/events?page=' + page;
    });
  }

  if (delBtn){
    delBtn.addEventListener('click', function(){
      if (!confirm('정말 삭제하시겠습니까? 삭제 후 되돌릴 수 없습니다.')) return;
      var f = document.createElement('form');
      f.method = 'post';
      f.action = '<c:url value="/admin/events/${event.eventId}/delete"/>';
      f.innerHTML = '<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">';
      document.body.appendChild(f);
      f.submit();
    });
  }
});
</script>
</body>
</html>
