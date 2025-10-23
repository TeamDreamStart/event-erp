<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<header id="header" role="banner">
  <div class="header-container">
    <div class="logo">
      <a href="/" aria-label="DreamStart Home"></a>
    </div>

    <div class="user-section">
      <sec:authorize access="isAuthenticated()">
        <span class="welcome">
          <strong><sec:authentication property="principal.name"/></strong>님 환영합니다
        </span>
        <a href="/my-info/<sec:authentication property="principal.userId"/>" class="btn mypage">mypage</a>
        <form method="post" action="/logout" class="logout-form">
          <sec:csrfInput />
          <button type="submit" class="btn logout">logout</button>
        </form>
      </sec:authorize>

      <sec:authorize access="isAnonymous()">
        <a href="/join" class="btn join">join</a>
        <a href="/login" class="btn login">login</a>
      </sec:authorize>
    </div>
  </div>

  <jsp:include page="/WEB-INF/views/common/nav.jsp" />
</header>
