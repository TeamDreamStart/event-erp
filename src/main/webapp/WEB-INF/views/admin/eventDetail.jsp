<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 상세</title>
<style>
dl { display:grid; grid-template-columns:120px 1fr; gap:6px 12px }
dt { font-weight:700 }
.hd { display:flex; justify-content:space-between; align-items:center; margin:12px 0; }
</style>
</head>
<body>
  <div class="hd">
    <h2>이벤트 상세 #${event.eventId}</h2>
    <div>
      <a href="<c:url value='/admin/events'/>">목록</a>
      <a href="<c:url value='/admin/events/form?id=${event.eventId}'/>">수정</a>
    </div>
  </div>

  <dl>
    <dt>제목</dt><dd>${event.title}</dd>
    <dt>설명</dt><dd><pre style="white-space:pre-wrap">${event.description}</pre></dd>
    <dt>장소</dt><dd>${event.location}</dd>
    <dt>시작/종료</dt><dd>${startView} ~ ${endView}</dd>
    <dt>정원</dt><dd>${event.capacity}</dd>
    <dt>상태</dt><dd>${event.status}</dd>
    <dt>공개</dt><dd>${event.visibility}</dd>
    <dt>포스터</dt>
    <dd>
      <c:if test="${not empty event.posterUrl}">
        <img src="${event.posterUrl}" alt="poster" style="max-height:160px">
      </c:if>
    </dd>
    <dt>유료/가격</dt><dd>${event.paid ? '유료' : '무료'} / ${event.price} ${event.currency}</dd>
    <dt>카테고리</dt><dd>${event.category}</dd>
    <dt>작성자</dt><dd>${event.createdBy}</dd>
    <dt>생성/수정</dt><dd>${createdView} / ${updatedView}</dd>
  </dl>
</body>
</html>
