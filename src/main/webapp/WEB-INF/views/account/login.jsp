<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.security.SecureRandom"%>
<%@ page import="java.math.BigInteger"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Login</title>

<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/common.css'/>">
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">

<style>
	body {
	background: #E5E2DB;
}
h2 {
	display: flex;
	align-items: center;
	margin-bottom: 20px;
}
.tab-content {
    display: none;
}
.section-header {
	display: flex;
	align-items: center;
	margin-bottom: 20px;
}
.uid-section-content, .password-section-content{
        width: 40%;
        max-width: 400px;
        background-color: #FAF9F6;
    border: 1px solid #222222;
    border-radius: 12px;
    margin: 0 auto;
    margin-bottom: 60px;
    padding: 48px 104px;
		font-family: 'Montserrat', sans-serif;
        font-size: 14px;
        display: block;
        text-align: center;
    }
	/* active 클래스가 붙으면 보이도록 설정 */
	.tab-content.active {
		display: block;
    }
.tab-header {
	display: flex;
}
	.tab-btn {
		/* 버튼 기본 스타일 */
        padding: 12px 0;
    cursor: pointer;
    background-color: #CBD4C2;
    border: none;
    color: #888888;
    border-radius: 12px;
    width: 50%;
    font-family: 'Montserrat', sans-serif;
    font-size: 14px;
    text-align: center;
}
	.tab-btn.active {
        /* 활성화된 버튼 스타일 */
        background-color: #FAF9F6;
		border: 1px solid #222222;
		color: #222222;
        font-weight: bold;
		margin-bottom: -1px;
		font-family: 'Montserrat', sans-serif;
		font-size: 14px;
        
    }
.find-uid-form, .find-password-form{
    margin: 0 auto 16px auto; 
    display: block; 
    max-width: 400px; 
}
/* 유리언니 오류 후 머지 */
:root { --bg:#E5E2DB; --ink:#222; --card:#FAF9F6; }

body.login-page {
  background:var(--bg); color:var(--ink); font-family:"Montserrat",sans-serif;
  display:flex; flex-direction:column; min-height:100vh;
}
body.login-page main { flex:1; }

.login-page .container { max-width:1100px; margin:40px auto; padding:0 16px; }
.login-page .card {
  background:var(--card); border:1px solid #222; border-radius:12px;
  padding:32px 20px;
}
.login-page .title { margin:0 0 24px; text-align:center; }
.login-page .field { max-width:380px; margin:0 auto 14px; }
.login-page .label { display:block; font-weight:700; margin:0 0 6px; }
.login-page .input {
  width:100%; height:42px; border:1px solid #222; border-radius:6px;
  padding:0 10px; font-size:15px; line-height:42px;
}
.login-page .actions {
  display:flex; gap:12px; justify-content:center; margin-top:28px; flex-wrap:wrap;
}
.login-page .btn {
  min-width:140px; height:42px; border-radius:12px;
  border:1px solid #8FAFED; background:#BFD4F9;
  font-weight:700; font-size:15px; line-height:42px; color:#222;
  text-decoration:none; cursor:pointer; transition:background 0.15s ease;
}
.login-page .btn:hover { background:#A7C6FF; }
.login-page .btn-ghost { border:1px solid #AFAFAF; background:#F2F0EF; }
.login-page .btn-ghost:hover { background:#E8E6E4; }
.login-page .msg { text-align:center; font-size:13px; margin:8px 0 0; }
.login-page .msg.error { color:#d00; }
.login-page .msg.ok { color:#2a7; }
.login-page .tabs { display:flex; gap:8px; justify-content:center; margin-bottom:8px; }
.login-page .tab-btn {
  flex:1; height:40px; border-radius:12px; border:1px solid #222;
  background:#CBD4C2; color:#666; font-weight:700; cursor:pointer;
}
.login-page .tab-btn.active { background:#FAF9F6; color:#222; border-bottom:none; }
.login-page .tab-panel { display:none; }
.login-page .tab-panel.active { display:block; }
.login-page .sns {
  display:flex; flex-direction:column; gap:10px;
  max-width:380px; margin:16px auto 0;
}
.login-page .sns a {
  display:flex; align-items:center; justify-content:center;
  height:44px; border-radius:10px; border:1px solid #ddd;
  text-decoration:none; color:#222; font-size:15px;
}
.login-page .sns a.google{background:#fff;}
.login-page .sns a.kakao{background:#FEE500;}
.login-page .sns a.naver{background:#03C75A;color:#fff;}
.login-page .admin-wrap{min-height:100vh;display:grid;place-items:center;padding:24px;}
.login-page .admin-card{width:min(420px,92vw);}
</style>
</head>

<body class="login-page">
<c:if test="${not empty joinSuccess}">
  <script>
    alert("${joinSuccess}");
  </script>
</c:if>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="saved" value="${sessionScope.SPRING_SECURITY_SAVED_REQUEST}" />
<c:set var="adminBase" value="${ctx}/admin" />
<c:set var="savedIsAdmin"
	value="${not empty saved
           and ((not empty saved.requestURI and fn:startsWith(saved.requestURI, adminBase))
           or (not empty saved.redirectUrl and fn:contains(saved.redirectUrl, adminBase)))}" />
<c:set var="isAdminMode" value="${param.mode eq 'admin' or savedIsAdmin}" />

<c:choose>
<c:when test="${isAdminMode}">
  <div class="login-page admin-wrap">
    <div class="login-page card admin-card">
      <h2 class="login-page title">관리자 로그인</h2>
      <c:if test="${param.error ne null}">
        <div class="login-page msg error">아이디 또는 비밀번호가 올바르지 않습니다.</div>
      </c:if>
      <div id="admin-msg" class="login-page msg"></div>

      <form id="admin-form" action="<c:url value='/login'/>" method="post" autocomplete="on" novalidate>
        <div class="login-page field">
          <label class="login-page label" for="login_admin">아이디</label>
          <input class="login-page input" type="text" id="login_admin" name="login" required />
        </div>
        <div class="login-page field">
          <label class="login-page label" for="password_admin">비밀번호</label>
          <input class="login-page input" type="password" id="password_admin" name="password" required />
        </div>
        <sec:csrfInput />
        <div class="login-page actions">
          <button id="admin-submit" type="submit" class="login-page btn">로그인</button>
        </div>
      </form>
    </div>
  </div>
</c:when>

<c:otherwise>
  <jsp:include page="/WEB-INF/views/common/header.jsp" />
  <main class="login-page container">
    <h2 class="login-page title">Login</h2>

    <c:if test="${param.error ne null}">
      <div class="login-page msg error">이메일/아이디 또는 비밀번호가 올바르지 않아요.</div>
    </c:if>
    <c:if test="${param.logout ne null}">
      <div class="login-page msg ok">로그아웃 되었습니다.</div>
    </c:if>

    <div class="login-page tabs" style="max-width:520px;margin:0 auto 10px;">
      <button type="button" class="tab-btn active" data-tab="tab-member">회원 로그인</button>
      <button type="button" class="tab-btn" data-tab="tab-guest">비회원 예약조회</button>
    </div>

    <div class="login-page card" style="max-width:520px;margin:0 auto;">
      <section id="tab-member" class="tab-panel active">
        <div id="member-msg" class="msg"></div>
        <form id="member-form" action="<c:url value='/login'/>" method="post" autocomplete="on" novalidate>
          <div class="field">
            <label class="label" for="login_uid">이메일 또는 아이디</label>
            <input class="input" type="text" id="login_uid" name="login" required />
          </div>
          <div class="field">
            <label class="label" for="password_uid">비밀번호</label>
            <input class="input" type="password" id="password_uid" name="password" required />
          </div>
          <sec:csrfInput />
          <div class="actions">
            <button type="button" class="btn btn-ghost" onclick="history.back()">취소</button>
            <button id="member-submit" type="submit" class="btn">로그인</button>
            <a class="btn btn-ghost" href="<c:url value='/join'/>">회원가입</a>
          </div>
        </form>
        <div class="sns">
          <% String clientId = "9CN0AyXIHmflebLIalgz";
             String redirectURI = URLEncoder.encode("http://localhost:8080/login/naver/callback","UTF-8");
             SecureRandom random = new SecureRandom();
             String state = new BigInteger(130, random).toString();
             String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
             apiURL += "&client_id=" + clientId;
             apiURL += "&redirect_uri=" + redirectURI;
             apiURL += "&state=" + state;
             session.setAttribute("state", state);
          %>
          <%-- <a class="google" href="${empty googleAuthUrl ? '#' : googleAuthUrl}">Google로 로그인</a>
          <a class="kakao" href="${empty kakaoAuthUrl ? '#' : kakaoAuthUrl}">카카오로 로그인</a> --%>
          <a class="naver" href="<%=apiURL%>">네이버로 로그인</a>
        </div>
      </section>

      <section id="tab-guest" class="tab-panel">
        <div id="guest-msg" class="msg"></div>
        <form id="guest-form" action="<c:url value='/guest/reservation/find'/>" method="post" novalidate>
          <div class="field">
            <label class="label" for="email_pw">이메일</label>
            <input class="input" type="text" id="email_pw" name="userEmail" required />
          </div>
          <div class="field">
            <label class="label" for="reservation_no">예약번호</label>
            <input class="input" type="text" id="reservation_no" name="reservationNo" required />
          </div>
          <sec:csrfInput />
          <div class="actions">
            <button type="button" class="btn btn-ghost" onclick="history.back()">취소</button>
            <button id="guest-submit" type="submit" class="btn">조회</button>
          </div>
        </form>
      </section>
    </div>
  </main>
  <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</c:otherwise>
</c:choose>

<script>
(function(){
  var tabs=document.querySelectorAll('.tab-btn');
  if(!tabs.length)return;
  var panels=document.querySelectorAll('.tab-panel');
  tabs.forEach(btn=>{
    btn.addEventListener('click',function(){
      var id=this.dataset.tab;
      tabs.forEach(b=>b.classList.remove('active'));
      panels.forEach(p=>p.classList.remove('active'));
      this.classList.add('active');
      document.getElementById(id)?.classList.add('active');
    });
  });
})();
function trim(v){return(v||'').replace(/\s+/g,' ').trim();}
function showMsg(id,text,ok){
  var el=document.getElementById(id);
  if(!el)return;
  el.textContent=text||'';
  el.classList.remove('error','ok');
  if(text)el.classList.add(ok?'ok':'error');
}
function isEmail(s){return/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(s);}
function lock(btn,on,label){
  if(!btn)return;
  btn.disabled=!!on;
  if(on&&label){btn.dataset._label=btn.textContent;btn.textContent=label;}
  else if(!on&&btn.dataset._label){btn.textContent=btn.dataset._label;delete btn.dataset._label;}
}

(function(){
  var form=document.getElementById('member-form');
  if(!form)return;
  var loginEl=document.getElementById('login_uid');
  var passEl=document.getElementById('password_uid');
  var submit=document.getElementById('member-submit');
  form.addEventListener('submit',e=>{
    var login=trim(loginEl.value),pwd=passEl.value||'';
    if(!login){e.preventDefault();showMsg('member-msg','아이디 또는 이메일을 입력해 주세요.');return;}
    if(!pwd){e.preventDefault();showMsg('member-msg','비밀번호를 입력해 주세요.');return;}
    if(login.includes('@')&&!isEmail(login)){e.preventDefault();showMsg('member-msg','올바른 이메일 형식이 아닙니다.');return;}
    if(pwd.length<4){e.preventDefault();showMsg('member-msg','비밀번호는 4자 이상이어야 합니다.');return;}
    showMsg('member-msg','',true);lock(submit,true,'로그인 중…');
  });
})();

(function(){
  var form=document.getElementById('admin-form');
  if(!form)return;
  var loginEl=document.getElementById('login_admin');
  var passEl=document.getElementById('password_admin');
  var submit=document.getElementById('admin-submit');
  form.addEventListener('submit',e=>{
    var login=trim(loginEl.value),pwd=passEl.value||'';
    if(!login){e.preventDefault();showMsg('admin-msg','아이디를 입력해 주세요.');return;}
    if(!pwd){e.preventDefault();showMsg('admin-msg','비밀번호를 입력해 주세요.');return;}
    if(login.includes('@')&&!isEmail(login)){e.preventDefault();showMsg('admin-msg','올바른 이메일 형식이 아닙니다.');return;}
    if(pwd.length<4){e.preventDefault();showMsg('admin-msg','비밀번호는 4자 이상이어야 합니다.');return;}
    showMsg('admin-msg','',true);lock(submit,true,'로그인 중…');
  });
})();

(function(){
  var form=document.getElementById('guest-form');
  if(!form)return;
  var emailEl=document.getElementById('email_pw');
  var noEl=document.getElementById('reservation_no');
  var submit=document.getElementById('guest-submit');
  form.addEventListener('submit',e=>{
    var email=trim(emailEl.value),no=trim(noEl.value);
    if(!email){e.preventDefault();showMsg('guest-msg','이메일을 입력해 주세요.');return;}
    if(!isEmail(email)){e.preventDefault();showMsg('guest-msg','올바른 이메일 형식이 아닙니다.');return;}
    if(!no){e.preventDefault();showMsg('guest-msg','예약번호를 입력해 주세요.');return;}
    if(!/^[A-Za-z0-9-]{4,32}$/.test(no)){e.preventDefault();showMsg('guest-msg','예약번호 형식이 올바르지 않습니다. (영숫자/하이픈 4~32자)');return;}
    showMsg('guest-msg','',true);lock(submit,true,'조회 중…');
  });
})();
</script>
</body>
</html>
