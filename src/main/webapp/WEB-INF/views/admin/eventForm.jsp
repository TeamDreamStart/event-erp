<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"       uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"      uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring"  uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>이벤트 등록/수정</title>
<style>
  body { font-family: system-ui, -apple-system, Segoe UI, Roboto, Helvetica, Arial, sans-serif; padding:24px; }
  main { max-width: 860px; margin: 0 auto; }
  .field { margin: 12px 0; }
  .field label { display:block; font-weight:600; margin-bottom:6px; }
  input[type="text"], input[type="url"], input[type="number"], textarea, select, input[type="datetime-local"] { width: 420px; max-width: 100%; }
  textarea { width: 640px; max-width: 100%; }
  .actions { margin-top: 24px; display:flex; gap:10px; align-items:center; }
  .alert { background:#eef6ff; border:1px solid #bcd4ff; color:#134; padding:10px 12px; border-radius:8px; }
  small.muted { color:#888 }
  img.preview { max-height:160px; border-radius:8px; border:1px solid #eee; }
</style>
</head>
<body>
<main>
  <c:set var="isNew" value="${empty event or empty event.eventId}"/>
  <c:set var="CATEGORIES" value="${fn:split('SHOW,SPEECH,WORKSHOP,MARKET', ',')}"/>

  <h1><c:choose><c:when test="${isNew}">이벤트 등록</c:when><c:otherwise>이벤트 수정</c:otherwise></c:choose></h1>

  <c:if test="${not empty msg}">
    <div class="alert">${msg}</div>
  </c:if>

  <!-- LocalDateTime -> 문자열 (yyyy-MM-dd'T'HH:mm) : JSTL/Date 미사용 -->
  <spring:eval var="__dtf"
               expression="T(java.time.format.DateTimeFormatter).ofPattern('yyyy-MM-dd''T''HH:mm')"/>
  <spring:eval var="startVal"
               expression="event != null and event.startDate != null ? event.startDate.format(__dtf) : ''"/>
  <spring:eval var="endVal"
               expression="event != null and event.endDate   != null ? event.endDate.format(__dtf)   : ''"/>

  <form id="eventForm" action="<c:url value='/admin/events/save'/>" method="post" enctype="multipart/form-data">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <c:if test="${!isNew}">
      <input type="hidden" name="eventId" value="${event.eventId}"/>
    </c:if>

    <!-- 제목 -->
    <div class="field">
      <label for="title">제목</label>
      <input id="title" type="text" name="title" value="<c:out value='${event.title}'/>" required />
    </div>

    <!-- 설명 -->
    <div class="field">
      <label for="description">설명</label>
      <textarea id="description" name="description" rows="6"><c:out value='${event.description}'/></textarea>
    </div>

    <!-- 장소 -->
    <div class="field">
      <label for="location">장소</label>
      <input id="location" type="text" name="location" value="<c:out value='${event.location}'/>" />
    </div>

    <!-- 시작/종료 -->
    <div class="field">
      <label for="startDate">시작</label>
      <input id="startDate" type="datetime-local" name="startDate" value="${startVal}" />
    </div>
    <div class="field">
      <label for="endDate">종료</label>
      <input id="endDate" type="datetime-local" name="endDate" value="${endVal}" />
    </div>

    <!-- 정원 -->
    <div class="field">
      <label for="capacity">정원</label>
      <input id="capacity" type="number" name="capacity" value="<c:out value='${event.capacity}'/>" min="0"/>
    </div>

    <!-- 상태 -->
    <div class="field">
      <label for="status">상태</label>
      <select id="status" name="status">
        <option value="OPEN"      ${event.status == 'OPEN' ? 'selected' : ''}>OPEN</option>
        <option value="CLOSED"    ${event.status == 'CLOSED' ? 'selected' : ''}>CLOSED</option>
        <option value="CANCELLED" ${event.status == 'CANCELLED' ? 'selected' : ''}>CANCELLED</option>
      </select>
    </div>

    <!-- 공개여부 -->
    <div class="field">
      <label for="visibility">공개여부</label>
      <select id="visibility" name="visibility">
        <option value="PUBLIC"  ${isNew or event.visibility == 'PUBLIC'  ? 'selected' : ''}>PUBLIC</option>
        <option value="PRIVATE" ${event.visibility == 'PRIVATE' ? 'selected' : ''}>PRIVATE</option>
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

    <!-- 대표 이미지 1개 -->
    <div class="field">
      <label for="image">대표 이미지</label>
      <input id="image" type="file" name="image" accept=".jpg,.jpeg,.png,.webp,.pdf" />
      <c:if test="${not empty event.posterUrl}">
        <div style="margin-top:8px">
          <img class="preview" src="${event.posterUrl}" alt="poster"/>
        </div>
      </c:if>
    </div>

    <!-- 첨부 파일 여러 개 -->
    <div class="field">
      <label for="files">첨부 파일(여러 개)</label>
      <input id="files" type="file" name="files" multiple accept=".jpg,.jpeg,.png,.webp,.pdf"/>
      <small class="muted">이미지는 썸네일이 자동 생성됩니다.</small>
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
      <input id="price" type="number" name="price" step="1" min="0" value="<c:out value='${empty event.price ? 0 : event.price}'/>" />
      <select id="currency" name="currency">
        <option value="KRW" <c:if test="${isNew or event.currency=='KRW' or empty event.currency}">selected</c:if>>KRW</option>
        <option value="USD" <c:if test="${event.currency=='USD'}">selected</c:if>>USD</option>
      </select>
    </div>

    <div class="actions">
      <button type="submit">저장</button>
      <a href="<c:url value='/admin/events'/>">목록</a>
      <c:if test="${!isNew}">
        <button type="button" id="btnDelete" style="color:#c00">삭제</button>
      </c:if>
    </div>
  </form>
</main>

<script>
document.addEventListener('DOMContentLoaded', function () {
  const startEl = document.getElementById('startDate');
  const endEl   = document.getElementById('endDate');
  const paidEl  = document.getElementById('paid');
  const priceEl = document.getElementById('price');
  const currEl  = document.getElementById('currency');

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

  const delBtn = document.getElementById('btnDelete');
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
