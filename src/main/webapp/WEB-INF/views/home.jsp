<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
<style>
  .header-top{display:flex;justify-content:space-between;align-items:center;padding:10px 16px;border-bottom:1px solid #eee}
  .user-actions{display:flex;gap:10px;align-items:center}
  .btn{appearance:none;border:1px solid #222;background:#fff;cursor:pointer;padding:6px 12px;text-decoration:none;display:inline-flex;align-items:center}
  .btn-primary{background:#e9efe6;border-color:#a5b49c}
</style>
</head>
<body>
<header class="header">
  <div class="header-top">
    <a href="<c:url value='/'/>">D</a>

    <div class="user-actions">
      <!-- 로그인 상태 -->
      <sec:authorize access="isAuthenticated()">
        <span><strong><sec:authentication property="principal.username" /></strong> 님 환영합니다 👋</span>
        <a class="btn" href="<c:url value='/myinfo'/>">my info</a>
        <form method="post" action="<c:url value='/logout'/>" style="margin:0">
  			<input type="hidden" name="from" value="member"/>
  	  <sec:csrfInput/>
  	  <button type="submit" class="btn btn-primary">logout</button>
		</form>

      </sec:authorize>

      <!-- 비로그인 상태 -->
      <sec:authorize access="isAnonymous()">
        <%-- 회원 로그인 강제: /login?mode=member --%>
        <a class="btn btn-primary" href="<c:url value='/login'><c:param name='mode' value='member'/></c:url>">login</a>
        <a class="btn" href="<c:url value='/join'/>">join</a>
      </sec:authorize>
    </div>
  </div>
</header>

<article>
  <a href="<c:url value='/list-test'/>">회원목록 테스트</a>
  <a href="<c:url value='/board-test'/>">게시판 테스트</a>
  <%-- 어드민 진입은 /admin 으로 두세요. 보안 필터가 SavedRequest 설정하고 관리자 로그인 뷰로 이동함 --%>
  <a href="<c:url value='/admin'/>">어드민페이지</a>
  <a href="<c:url value='/admin/surveys'/>">어드민용 설문조사 리스트</a>
</article>
</body>
</html>
