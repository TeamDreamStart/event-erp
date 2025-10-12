<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 목록(관리자)</title>
<style>
  .paging a{padding:4px 8px; border:1px solid #ddd; margin:0 2px; text-decoration:none;}
  .paging a.on{font-weight:bold; border-color:#333;}
  .paging .dim{color:#aaa; pointer-events:none; border-color:#eee;}
  table{border-collapse:collapse; width:100%}
  th,td{border:1px solid #ddd; padding:8px; text-align:left}
  .hd{display:flex; justify-content:space-between; align-items:center; margin:12px 0;}
</style>
</head>
<body>
<div class="hd">
  <h2>이벤트 목록</h2>
  <a href="<c:url value='/admin/events/form'/>">+ 새 이벤트</a>
</div>

<p>
  총 <strong>${pageVO.total}</strong>건 /
  페이지 <strong>${pageVO.cri.page}</strong> /
  페이지당 <strong>${pageVO.cri.perPageNum}</strong>개 /
  총페이지 <strong>${pageVO.totalPage}</strong>
</p>

<c:choose>
  <c:when test="${empty list}">
    <p>데이터가 없습니다.</p>
  </c:when>
  <c:otherwise>
    <table>
      <thead>
        <tr>
          <th>ID</th>
          <th>제목</th>
          <th>상태</th>
          <th>공개범위</th>
          <th>시작</th>
          <th>종료</th>
          <th>정원</th>
          <th>작성자</th>
          <th>관리</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="e" items="${list}">
          <tr>
            <td>${e.eventId}</td>
            <td>
              <a href="<c:url value='/admin/events/${e.eventId}'/>">
                ${e.title}
              </a>
            </td>
            <td>${e.status}</td>
            <td>${e.visibility}</td>
            <td>${e.startDate}</td>
            <td>${e.endDate}</td>
            <td>${e.capacity}</td>
            <td>${e.createdBy}</td>
            <td>
              <a href="<c:url value='/admin/events/form?eventId=${e.eventId}'/>">수정</a>
              <!-- 삭제는 POST로 처리 권장 (폼/CSRF 포함) -->
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </c:otherwise>
</c:choose>

<!-- 페이징 -->
<div class="paging" style="margin-top:12px;">
  <!-- 이전 블록 -->
  <c:choose>
    <c:when test="${pageVO.prev}">
      <a href="<c:url value='/admin/events?page=${pageVO.startPage - 1}&perPageNum=${pageVO.cri.perPageNum}'/>">&laquo;</a>
    </c:when>
    <c:otherwise>
      <a class="dim">&laquo;</a>
    </c:otherwise>
  </c:choose>

  <!-- 페이지 번호 -->
  <c:forEach var="p" begin="${pageVO.startPage}" end="${pageVO.endPage}">
    <a href="<c:url value='/admin/events?page=${p}&perPageNum=${pageVO.cri.perPageNum}'/>"
       class="${pageVO.cri.page == p ? 'on' : ''}">${p}</a>
  </c:forEach>

  <!-- 다음 블록 -->
  <c:choose>
    <c:when test="${pageVO.next}">
      <a href="<c:url value='/admin/events?page=${pageVO.endPage + 1}&perPageNum=${pageVO.cri.perPageNum}'/>">&raquo;</a>
    </c:when>
    <c:otherwise>
      <a class="dim">&raquo;</a>
    </c:otherwise>
  </c:choose>
</div>

</body>
</html>
