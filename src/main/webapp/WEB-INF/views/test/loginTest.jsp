<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>Login</title>
<style>
  :root { --bg:#E5E2DB; --ink:#222; --card:#FAF9F6; }
  body{ background:var(--bg); color:var(--ink); font-family:Montserrat, sans-serif; margin:0; }
  .container{ max-width:1100px; margin:40px auto; padding:0 16px; }
  .card{ background:var(--card); border:1px solid #222; border-radius:12px; padding:32px 20px; }
  .title{ margin:0 0 24px; }
  .field{ max-width:380px; margin:0 auto 14px; }
  .label{ display:block; font-weight:700; margin:0 0 6px; }
  .input{ width:100%; height:36px; border:1px solid #222; border-radius:6px; padding:0 8px; }
  .actions{ display:flex; gap:12px; justify-content:center; margin-top:24px; flex-wrap:wrap; }
  .btn{ min-width:120px; height:36px; border-radius:12px; border:1px solid #8FAFED; background:#BFD4F9; font-weight:700; cursor:pointer; }
  .btn-ghost{ border:1px solid #AFAFAF; background:#F2F0EF; }
  .msg{ text-align:center; font-size:12px; min-height:16px; margin:6px 0 0; }
  .msg.error{ color:#d00; } .msg.ok{ color:#2a7; }
  .tabs{ display:flex; gap:8px; }
  .tab-btn{ flex:1; height:40px; border-radius:12px; border:1px solid #222; background:#CBD4C2; color:#666; font-weight:700; cursor:pointer; }
  .tab-btn.active{ background:#FAF9F6; color:#222; border-bottom:none; }
  .tab-panel{ display:none; }
  .tab-panel.active{ display:block; }
  .sns{ display:flex; flex-direction:column; gap:10px; max-width:380px; margin:16px auto 0; }
  .sns a{ display:flex; align-items:center; justify-content:center; height:40px; border-radius:10px; border:1px solid #ddd; text-decoration:none; color:#222; }
  .sns a.google{ background:#fff; }
  .sns a.kakao{ background:#FEE500; }
  .sns a.naver{ background:#03C75A; color:#fff; }
  .admin-wrap{ min-height:100vh; display:grid; place-items:center; padding:24px; }
  .admin-card{ width:min(420px, 92vw); }
</style>
</head>
<body>

<%-- ===== 모드 판정 ===== --%>
<c:set var="ctx"   value="${pageContext.request.contextPath}" />
<c:set var="saved" value="${sessionScope.SPRING_SECURITY_SAVED_REQUEST}" />
<c:set var="adminBase" value="${ctx}/admin" />
<c:set var="savedIsAdmin"
       value="${not empty saved
               and (
                   (not empty saved.requestURI  and fn:startsWith(saved.requestURI,  adminBase))
                or (not empty saved.redirectUrl and fn:contains(saved.redirectUrl, adminBase))
               )}" />
<c:set var="isAdminMode" value="${param.mode eq 'admin' or savedIsAdmin}" />

<c:choose>

  <%-- ===== 관리자 로그인 (헤더/푸터 없음) ===== --%>
  <c:when test="${isAdminMode}">
    <div class="admin-wrap">
      <div class="card admin-card">
        <h2 class="title" style="text-align:center;">관리자 로그인</h2>

        <c:if test="${param.error ne null}">
          <div class="msg error">아이디 또는 비밀번호가 올바르지 않습니다.</div>
        </c:if>
        <div id="admin-msg" class="msg"></div>

        <form id="admin-form" action="<c:url value='/login'/>" method="post" autocomplete="on" novalidate>
          <div class="field">
            <label class="label" for="login_admin">아이디</label>
            <input class="input" type="text" id="login_admin" name="login" required />
          </div>
          <div class="field">
            <label class="label" for="password_admin">비밀번호</label>
            <input class="input" type="password" id="password_admin" name="password" required />
          </div>
          <sec:csrfInput/>
          <div class="actions">
            <button id="admin-submit" type="submit" class="btn">로그인</button>
          </div>
        </form>
      </div>
    </div>
  </c:when>

  <%-- ===== 회원 로그인 (헤더/푸터 + SNS) ===== --%>
  <c:otherwise>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <main class="container">
      <h2 class="title">Login</h2>

      <c:if test="${param.error ne null}">
        <div class="msg error">이메일/아이디 또는 비밀번호가 올바르지 않아요.</div>
      </c:if>
      <c:if test="${param.logout ne null}">
        <div class="msg ok">로그아웃 되었습니다.</div>
      </c:if>

      <div class="tabs" style="max-width:520px;margin:0 auto 10px;">
        <button type="button" class="tab-btn active" data-tab="tab-member">회원 로그인</button>
        <button type="button" class="tab-btn" data-tab="tab-guest">비회원 예약조회</button>
      </div>

      <div class="card" style="max-width:520px;margin:0 auto;">
        <section id="tab-member" class="tab-panel active">
          <div id="member-msg" class="msg"></div>

          <form id="member-form" action="<c:url value='/login'/>" method="post" autocomplete="on" novalidate>
            <div class="field">
              <label class="label" for="login_uid">이메일 또는 아이디</label>
              <input class="input" type="text" id="login_uid" name="login" placeholder="이메일 또는 아이디" required />
            </div>
            <div class="field">
              <label class="label" for="password_uid">비밀번호</label>
              <input class="input" type="password" id="password_uid" name="password" placeholder="비밀번호" required />
            </div>
            <sec:csrfInput/>
            <div class="actions">
              <button type="button" class="btn btn-ghost" onclick="history.back()">취소</button>
              <button id="member-submit" type="submit" class="btn">로그인</button>
              <a class="btn btn-ghost" href="<c:url value='/join'/>" style="text-decoration:none;display:inline-grid;place-items:center;">회원가입</a>
            </div>
            <div class="msg"><a href="<c:url value='/find-password'/>">아이디 · 비밀번호 찾기</a></div>
          </form>

          <div class="sns">
            <a class="google" href="${empty googleAuthUrl ? '#' : googleAuthUrl}">Google로 로그인</a>
            <a class="kakao"  href="${empty kakaoAuthUrl  ? '#' : kakaoAuthUrl}">카카오로 로그인</a>
            <a class="naver"  href="${empty naverAuthUrl  ? '#' : naverAuthUrl}">네이버로 로그인</a>
          </div>
        </section>

        <section id="tab-guest" class="tab-panel">
          <div id="guest-msg" class="msg"></div>

          <form id="guest-form" action="<c:url value='/guest/reservation/find'/>" method="post" autocomplete="off" novalidate>
            <div class="field">
              <label class="label" for="email_pw">이메일</label>
              <input class="input" type="text" id="email_pw" name="userEmail" placeholder="이메일" required />
            </div>
            <div class="field">
              <label class="label" for="reservation_no">예약번호</label>
              <input class="input" type="text" id="reservation_no" name="reservationNo" placeholder="예약번호" required />
            </div>
            <sec:csrfInput/>
            <div class="actions">
              <button type="button" class="btn btn-ghost" onclick="history.back()">취소</button>
              <button id="guest-submit" type="submit" class="btn">조회</button>
            </div>
          </form>
        </section>
      </div>
    </main>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
  </c:otherwise>

</c:choose>

<script>
  // 탭 전환
  (function() {
    var tabs = document.querySelectorAll('.tab-btn');
    if (!tabs.length) return;
    var panels = document.querySelectorAll('.tab-panel');
    tabs.forEach(function(btn){
      btn.addEventListener('click', function(){
        var id = this.getAttribute('data-tab');
        tabs.forEach(function(b){ b.classList.remove('active'); });
        panels.forEach(function(p){ p.classList.remove('active'); });
        this.classList.add('active');
        var panel = document.getElementById(id);
        if (panel) panel.classList.add('active');
      });
    });
  })();

  // 공통 유틸
  function trim(v){ return (v || '').replace(/\s+/g,' ').trim(); }
  function showMsg(id, text, ok){
    var el = document.getElementById(id);
    if (!el) return;
    el.textContent = text || '';
    el.classList.remove('error','ok');
    if (!text) return;
    el.classList.add(ok ? 'ok' : 'error');
  }
  function isEmail(s){ return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(s); }
  function lock(btn, on, label){
    if (!btn) return;
    btn.disabled = !!on;
    if (on && label) { btn.dataset._label = btn.textContent; btn.textContent = label; }
    else if (!on && btn.dataset._label){ btn.textContent = btn.dataset._label; delete btn.dataset._label; }
  }

  // 회원 로그인 검증
  (function(){
    var form = document.getElementById('member-form');
    if (!form) return;
    var loginEl = document.getElementById('login_uid');
    var passEl  = document.getElementById('password_uid');
    var submit  = document.getElementById('member-submit');

    form.addEventListener('submit', function(e){
      var login = trim(loginEl.value);
      var pwd   = passEl.value || '';

      if (!login){ e.preventDefault(); showMsg('member-msg','아이디 또는 이메일을 입력해 주세요.'); loginEl.focus(); return; }
      if (!pwd){ e.preventDefault(); showMsg('member-msg','비밀번호를 입력해 주세요.'); passEl.focus(); return; }
      if (login.includes('@') && !isEmail(login)){ e.preventDefault(); showMsg('member-msg','올바른 이메일 형식이 아닙니다.'); loginEl.focus(); return; }
      if (pwd.length < 4){ e.preventDefault(); showMsg('member-msg','비밀번호는 4자 이상이어야 합니다.'); passEl.focus(); return; }

      showMsg('member-msg','',true);
      lock(submit, true, '로그인 중…');
    });
  })();

  // 관리자 로그인 검증
  (function(){
    var form = document.getElementById('admin-form');
    if (!form) return;
    var loginEl = document.getElementById('login_admin');
    var passEl  = document.getElementById('password_admin');
    var submit  = document.getElementById('admin-submit');

    form.addEventListener('submit', function(e){
      var login = trim(loginEl.value);
      var pwd   = passEl.value || '';

      if (!login){ e.preventDefault(); showMsg('admin-msg','아이디를 입력해 주세요.'); loginEl.focus(); return; }
      if (!pwd){ e.preventDefault(); showMsg('admin-msg','비밀번호를 입력해 주세요.'); passEl.focus(); return; }
      if (login.includes('@') && !isEmail(login)){ e.preventDefault(); showMsg('admin-msg','올바른 이메일 형식이 아닙니다.'); loginEl.focus(); return; }
      if (pwd.length < 4){ e.preventDefault(); showMsg('admin-msg','비밀번호는 4자 이상이어야 합니다.'); passEl.focus(); return; }

      showMsg('admin-msg','',true);
      lock(submit, true, '로그인 중…');
    });
  })();

  // 비회원 예약 조회 검증
  (function(){
    var form = document.getElementById('guest-form');
    if (!form) return;
    var emailEl = document.getElementById('email_pw');
    var noEl    = document.getElementById('reservation_no');
    var submit  = document.getElementById('guest-submit');

    form.addEventListener('submit', function(e){
      var email = trim(emailEl.value);
      var no    = trim(noEl.value);

      if (!email){ e.preventDefault(); showMsg('guest-msg','이메일을 입력해 주세요.'); emailEl.focus(); return; }
      if (!isEmail(email)){ e.preventDefault(); showMsg('guest-msg','올바른 이메일 형식이 아닙니다.'); emailEl.focus(); return; }
      if (!no){ e.preventDefault(); showMsg('guest-msg','예약번호를 입력해 주세요.'); noEl.focus(); return; }
      if (!/^[A-Za-z0-9-]{4,32}$/.test(no)){ e.preventDefault(); showMsg('guest-msg','예약번호 형식이 올바르지 않습니다. (영숫자/하이픈 4~32자)'); noEl.focus(); return; }

      showMsg('guest-msg','',true);
      lock(submit, true, '조회 중…');
    });
  })();
</script>
</body>
</html>
