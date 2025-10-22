<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/common.css'/>">
<!-- CSRF for AJAX -->
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />

<!-- 공통 css reset/common -->
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/common.css'/>">

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet">

<title>join</title>
<link rel="stylesheet" type="text/css" href="/resources/css/join.css" />

<style>
/* =======================================================
   JOIN – WIDE (left aligned, 2-line email, no clipping)
   - 비반응형, 프로젝트 색(#568ef7) 유지
   - 카드 폭 키움(960px) · 오버플로우 보이게
   - HTML/JS 변경 없음
   ======================================================= */

/* 페이지 토큰 */
.membership-section{
  --line:#e9eaee;
  --muted:#747a86;
  --ok:#10b981;
  --warn:#e54848;
  --r:8px;
  --r-lg:10px;
  --h:44px;       /* input/버튼 높이 넉넉히 */
  --fz:15px;      /* 글자 살짝 키움 */
  --card-w:960px; /* 카드 폭 ↑ (짤림 방지) */
  --inner-x:24px;
}

/* 컨테이너/배경은 손대지 않음 */
main .container > h2{ font-weight:800; font-size:24px; margin:20px 0 10px; }

/* 카드: 좌측 정렬 + 넘침 보이기 */
.membership-section{
  width:var(--card-w);
  margin:0;
  background:#fff;
  border:1px solid var(--line);
  border-radius:var(--r-lg);
  box-shadow:0 1px 8px rgba(17,24,39,.04);
  overflow:visible; /* 짤림 방지 */
}
.membership-section::before{ content:none; }

/* 폼: 2열 고정 */
.membership-form{
  display:grid; grid-template-columns:1fr 1fr;
  gap:14px 18px;
  padding:20px var(--inner-x);
}
.membership-section .form-group{ margin:0; }

/* 전체폭 필드 */
.membership-form .form-group:nth-child(1),
.membership-form .form-group:nth-child(2),
.membership-form .form-group:nth-child(3),
.membership-form .birth-date-group,
.membership-form .form-group:nth-child(6){ grid-column:1 / -1; }

/* 라벨 */
.membership-section label,
.membership-section .form-label label{
  display:block; margin:0 0 6px;
  font-weight:700; font-size:14px; color:#222;
}

/* 인풋/셀렉트 공통 */
.membership-section input[type="text"],
.membership-section input[type="password"],
.membership-section input[type="tel"],
.membership-section select{
  width:100%; height:var(--h);
  box-sizing:border-box;
  background:#fff; border:1px solid var(--line);
  border-radius:var(--r); padding:0 12px;
  font-size:var(--fz); line-height:1;
  min-width:0;
}
.membership-section input::placeholder{ color:#b3b8c1; }
.membership-section input:focus,
.membership-section select:focus{
  outline:none; border-color:#568ef7;
  box-shadow:0 0 0 2px rgba(86,142,247,.15);
}

/* =========================
   이메일: 2줄 그리드 (넓게, 절대 안 짤림)
   1행: local @ domain domain-select 중복확인  [여백]
   2행: 발송 | 인증코드(넓게) | 인증확인       [여백]
   ========================= */
.input-with-button{
  display:grid;
  grid-template-columns:200px 24px 260px 140px 110px 1fr; /* 총 내부폭 960-48=912px 기준 */
  grid-template-areas:
    "local  at domain dsel dup  space"
    "send   code   code   code vfy  space";
  grid-auto-rows:var(--h);
  column-gap:10px; row-gap:10px;
  align-items:center; min-width:0;
}
#email-local     { grid-area:local; }
.input-with-button .golbang{ grid-area:at; text-align:center; color:var(--muted); user-select:none; height:var(--h); line-height:var(--h); }
#domain-txt      { grid-area:domain; }
#domain-list     { grid-area:dsel; }
#btn-check-email { grid-area:dup; }
#btn-send-code   { grid-area:send; }
#email-code      { grid-area:code; min-width:0; }
#btn-verify-code { grid-area:vfy; }

/* 작은 버튼(중복확인/코드/인증) */
.input-with-button button{
  height:var(--h); padding:0 12px;
  border:1px solid var(--line); border-radius:var(--r);
  background:#f6f7f9; color:#333; font-weight:700; font-size:13px;
}
.input-with-button button:hover{ background:#eef0f3; border-color:#dcdfe3; }

/* 메세지는 다음 줄 전체 폭 */
.input-with-button + .field-msg{ display:block; grid-column:1 / -1; margin-top:6px; }

/* 라디오 */
.form-radio{ display:inline-flex; gap:12px; align-items:center; }
.form-radio input[type="radio"]{ inline-size:16px; block-size:16px; accent-color:#568ef7; }

/* 생년월일 */
.birth-select-wrapper{ display:grid; grid-template-columns:1fr 1fr 1fr; gap:8px; }
.birth-select{
  height:var(--h); padding:0 10px;
  border:1px solid var(--line); border-radius:var(--r);
  font-size:var(--fz); background:#fff;
}

/* 검증 메시지 */
.field-msg{ margin-top:6px; font-size:12px; color:var(--muted); }
.field-msg.ok{ color:var(--ok); }
.field-msg.warn{ color:var(--warn); }

/* 전화번호: 360px로 확대(짤림 방지), 오른쪽은 비워둠 */
.membership-section > .form-group{ padding:0 var(--inner-x); margin-top:6px; }
.membership-section > .form-group label[for="phone"]{ display:block; margin-bottom:6px; font-weight:700; }
#phone{ width:360px; max-width:100%; }

/* 하단 버튼: 좌측 정렬 유지 + 동일 크기 */
.join-bottom-button{
  display:flex; justify-content:flex-start; align-items:center; gap:10px;
  padding:16px var(--inner-x) 20px; border-top:1px solid var(--line);
}
.membership-section .btn-cancel,
.membership-section .btn-next{
  height:var(--h); min-width:140px;
  border-radius:10px; font-weight:800; font-size:14px; cursor:pointer;
}
.membership-section .btn-cancel{ border:1px solid var(--line); background:#f5f6f7; color:#333; }
.membership-section .btn-cancel:hover{ background:#eef0f2; }
.membership-section .btn-next{ border:0; } /* 배경은 기존 정의(#568ef7) 사용 */

/* SNS */
.sns-login-section{
  border-top:1px solid var(--line);
  padding:14px var(--inner-x) 20px; margin:0; text-align:left;
}
.sns-login-section .sns-title{ font-size:12px; font-weight:700; color:#6b7280; margin-bottom:8px; }
.sns-buttons{ display:grid; grid-template-columns:1fr; gap:8px; width:calc(var(--card-w) - var(--inner-x)*2); }
.sns-buttons a{
  display:flex; align-items:center; justify-content:center;
  height:42px; border-radius:999px; background:#fff; border:1px solid var(--line);
}
.sns-buttons img{ height:20px; width:auto; display:block; }

/* 모달: 항상 화면 중앙 */
#join-success-modal.modal{
  position:fixed !important; inset:0 !important;
  display:flex !important; align-items:center !important; justify-content:center !important;
  background:rgba(0,0,0,.45) !important; z-index:2147483000 !important;
}
#join-success-modal.modal.hidden{ display:none !important; }
#join-success-modal .modal-content{
  width:380px; max-width:90vw; border-radius:10px; padding:18px 20px;
  background:#fff; box-shadow:0 10px 24px rgba(0,0,0,.12); text-align:center;
}
#join-success-modal .modal-content button{
  height:40px; border-radius:9px; background:#568ef7; color:#fff; border:0; font-weight:800; padding:0 16px;
}
</style>

</head>
<body>
  <jsp:include page="/WEB-INF/views/common/header.jsp" />

  <main>
    <div class="container">
      <h2>join membership</h2>
      <div class="membership-section">

        <!-- 회원가입 폼 -->
        <form:form id="joinForm" modelAttribute="user" action="/join" method="post" autocomplete="off">
          <!-- ✅ CSRF for form POST -->
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

          <div class="membership-form">
            <!-- 아이디 -->
            <div class="form-group">
              <label for="username">아이디</label>
              <div class="input-with-button">
                <input type="text" name="username" id="username" placeholder="아이디를 입력하세요." required autocomplete="off" autocapitalize="off" spellcheck="false" />
                <button type="button" id="btn-check-username">중복확인</button>
              </div>
              <small id="username-msg" class="field-msg"></small>
            </div>

            <!-- 비밀번호 -->
            <div class="form-group">
              <label for="password">비밀번호</label>
              <input type="password" name="password" id="password" placeholder="비밀번호를 입력하세요." required autocomplete="new-password" />
              <small id="password-msg" class="field-msg"></small>
            </div>

            <!-- 비밀번호 확인 -->
            <div class="form-group">
              <label for="password-check">비밀번호 확인</label>
              <input type="password" name="password-check" id="password-check" placeholder="비밀번호를 확인하세요." required autocomplete="new-password" />
              <small id="password2-msg" class="field-msg"></small>
            </div>

            <!-- 이름 -->
            <div class="form-group">
              <label for="name">이름</label>
              <input type="text" name="name" id="name" required />
            </div>

            <!-- 성별 -->
            <div class="form-group">
              <div class="form-label"><label for="gender">성별</label></div>
              <div class="form-radio">
                <form:radiobutton path="gender" id="male" value="0" />
                <label for="male">남</label>
                <form:radiobutton path="gender" id="female" value="1" />
                <label for="female">여</label>
                <form:errors path="gender" cssClass="field-msg warn" />
              </div>
            </div>

            <!-- 생년월일 -->
            <div class="form-group birth-date-group">
              <label for="birth_year">생년월일</label>
              <div class="birth-select-wrapper">
                <select class="birth-select" id="birth_year" name="birth_year">
                  <option value="" disabled selected>출생 연도</option>
                </select>
                <select class="birth-select" id="birth_month" name="birth_month">
                  <option value="" disabled selected>월</option>
                </select>
                <select class="birth-select" id="birth_day" name="birth_day">
                  <option value="" disabled selected>일</option>
                </select>
              </div>
            </div>

            <!-- 이메일 -->
            <div class="form-group">
              <label for="email">이메일</label>
              <div class="input-with-button">
                <input type="text" id="email-local" placeholder="아이디" required autocomplete="off" autocapitalize="off" spellcheck="false" />
                <span class="golbang">@</span>
                <input class="box" id="domain-txt" type="text" placeholder="도메인 입력" autocomplete="off" autocapitalize="off" spellcheck="false" />
                <select class="box" id="domain-list">
                  <option value="type">직접 입력</option>
                  <option value="naver.com">naver.com</option>
                  <option value="gmail.com">gmail.com</option>
                  <option value="hanmail.net">hanmail.net</option>
                  <option value="nate.com">nate.com</option>
                  <option value="kakao.com">kakao.com</option>
                </select>
                <button type="button" id="btn-check-email">중복확인</button>
              </div>
              <small id="email-msg" class="field-msg"></small>
            </div>

            <!-- ✅ 서버로 보낼 실제 email 바인딩 -->
            <form:hidden path="email" id="email-hidden" />

            <!-- 이메일 인증 -->
            <div class="form-group">
              <div class="input-with-button">
                <button type="button" id="btn-send-code">인증번호 발송</button>
                <input type="text" id="email-code" placeholder="인증번호 입력" autocomplete="one-time-code" inputmode="text" />
                <button type="button" id="btn-verify-code">인증 확인</button>
              </div>
              <small id="email-verify-msg" class="field-msg"></small>
            </div>
          </div>

          <!-- 전화번호 -->
          <div class="form-group">
            <label for="phone">전화번호</label>
            <form:input path="phone" id="phone" type="tel" required="required" />
          </div>

          <!-- 제출 -->
          <div class="join-bottom-button">
            <button type="button" class="btn-cancel">취소</button>
            <button type="submit" class="btn-next">가입하기</button>
          </div>
        </form:form>
        <!-- /회원가입 폼 -->

        <!-- ✅ SNS 로그인 (아이콘 경로 너가 올려둔 곳 사용) -->
        <div class="sns-login-section">
          <p class="sns-title">간편 로그인</p>
          <div class="sns-buttons">
            <a href="/oauth2/authorization/naver" class="sns-btn naver">
              <img src="/resources/img/naver/btnG_축약형.png" alt="네이버 로그인">
            </a>
            <a href="/oauth2/authorization/google" class="sns-btn google">
              <img src="/resources/img/naver/btnW_축약형.png" alt="구글 로그인">
            </a>
            <a href="/oauth2/authorization/kakao" class="sns-btn kakao">
              <img src="/resources/img/kakao.png" alt="카카오 로그인">
            </a>
          </div>
        </div>

        <!-- ✅ 가입 성공 모달 (기본 hidden) -->
        <div id="join-success-modal" class="modal hidden">
          <div class="modal-content">
            <h3>회원가입을 성공하셨습니다.</h3>
            <p>로그인 해주세요.</p>
            <button id="close-join-success" type="button">확인</button>
          </div>
        </div>

        <!-- 서버 플래그 전달: joinSuccess(권장) 또는 msg 둘 중 하나만 있어도 모달 오픈 -->
        <c:if test="${not empty joinSuccess or not empty msg}">
          <script>window.__JOIN_SUCCESS__ = true;</script>
        </c:if>

      </div>
    </div>
  </main>

  <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>

  <!-- =============================
       ↓↓↓ 네가 보낸 JS 그대로 삽입 ↓↓↓
       ============================= -->
  <script>
/* ============================
 * CSRF 헤더 (AJAX용)
 * ============================ */
(() => {
  const t = document.querySelector('meta[name="_csrf"]')?.content;
  const h = document.querySelector('meta[name="_csrf_header"]')?.content;
  if (t && h) window.csrfHeader = { [h]: t };
})();

/* ============================
 * 상태 플래그 & 유틸
 * ============================ */
let isUsernameChecked = false;
let isEmailChecked   = false;
let isEmailVerified  = false;
let verifiedEmail    = null;

let countdownId = null;
let expireAt    = 0;

const $ = sel => document.querySelector(sel);
const setMsg = (sel, text, ok) => {
  const el = $(sel);
  el.textContent = text || '';
  el.classList.remove('ok','warn');
  if (text) el.classList.add(ok ? 'ok' : 'warn');
};

/* ============================
 * 생년월일 옵션
 * ============================ */
const birthYearEl  = $('#birth_year');
const birthMonthEl = $('#birth_month');
const birthDayEl   = $('#birth_day');

function generateDateOptions() {
  if (!birthYearEl || !birthMonthEl || !birthDayEl) return;
  const currentYear = new Date().getFullYear();
  for (let y=currentYear; y>=1940; y--) {
    const o=document.createElement('option'); o.value=y; o.textContent=y+'년';
    birthYearEl.appendChild(o);
  }
  for (let m=1; m<=12; m++) {
    const o=document.createElement('option'); o.value=String(m).padStart(2,'0'); o.textContent=o.value+'월';
    birthMonthEl.appendChild(o);
  }
  setDayOptions();
}
function setDayOptions() {
  birthDayEl.innerHTML = '<option value="" disabled selected>일</option>';
  const y=birthYearEl.value, m=birthMonthEl.value;
  if (!y || !m) return;
  const maxDay = new Date(y, m, 0).getDate();
  for (let d=1; d<=maxDay; d++) {
    const o=document.createElement('option'); o.value=String(d).padStart(2,'0'); o.textContent=o.value+'일';
    birthDayEl.appendChild(o);
  }
}

/* ============================
 * 비밀번호 검증
 * ============================ */
const pwd  = $('#password');
const pwd2 = $('#password-check');
const PWD_RE = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,16}$/;

function validatePwd() {
  if (!pwd.value) { setMsg('#password-msg','비밀번호를 입력하세요.', false); return false; }
  if (!PWD_RE.test(pwd.value)) { setMsg('#password-msg','8~16자, 영문/숫자/특수문자 조합이어야 합니다.', false); return false; }
  setMsg('#password-msg','사용 가능한 비밀번호입니다. ✅', true); return true;
}
function validatePwd2() {
  const v1 = pwd.value || '';
  const v2 = pwd2.value || '';
  if (!v2) { setMsg('#password2-msg','', true); return false; }
  if (v1 !== v2) { setMsg('#password2-msg','비밀번호가 일치하지 않습니다.', false); return false; }
  setMsg('#password2-msg','비밀번호가 일치합니다. ✅', true); return true;
}
// 비밀번호/확인란 즉시 재검증 (확인란은 비우지 않음)
pwd.addEventListener('input', () => { validatePwd(); validatePwd2(); });
pwd2.addEventListener('input', validatePwd2);

/* ============================
 * 아이디 중복확인
 * ============================ */
function checkUsernameDuplicate() {
  const username = $('#username').value.trim();
  if (!username) { setMsg('#username-msg','아이디를 입력하세요.', false); isUsernameChecked=false; return; }
  fetch('/api/users/check-username?username='+encodeURIComponent(username))
    .then(r=>r.json()).then(d=>{
      if (d.exists) { setMsg('#username-msg','이미 사용 중인 아이디입니다.', false); isUsernameChecked=false; }
      else { setMsg('#username-msg','사용 가능한 아이디입니다. ✅', true); isUsernameChecked=true; }
    }).catch(()=>{ setMsg('#username-msg','중복 확인 중 오류가 발생했습니다.', false); isUsernameChecked=false; });
}

/* ============================
 * 이메일 중복/인증
 * ============================ */
const domainListEl  = $('#domain-list');
const domainInputEl = $('#domain-txt');
const btnSend       = $('#btn-send-code');
const btnVerify     = $('#btn-verify-code');
const inputCode     = $('#email-code');

btnSend.disabled   = true;
btnVerify.disabled = true;
inputCode.disabled = true;

function buildEmail() {
  const local = $('#email-local').value.trim();
  const domain = domainInputEl.value.trim();
  return (local && domain) ? (local+'@'+domain).toLowerCase() : '';
}
function resetEmailState(msg='') {
  isEmailChecked=false; isEmailVerified=false; verifiedEmail=null;
  btnSend.disabled=true; btnVerify.disabled=true; inputCode.value=''; inputCode.disabled=true;
  if (countdownId) { clearInterval(countdownId); countdownId=null; }
  expireAt=0; if (msg) setMsg('#email-verify-msg', msg, false);
}
domainListEl.addEventListener('change', e=>{
  if (e.target.value !== 'type') { domainInputEl.value=e.target.value; domainInputEl.disabled=true; }
  else { domainInputEl.value=''; domainInputEl.disabled=false; domainInputEl.focus(); }
  resetEmailState();
});
['#email-local','#domain-txt','#domain-list'].forEach(s=>{
  document.querySelector(s).addEventListener('input', resetEmailState);
  document.querySelector(s).addEventListener('change', resetEmailState);
});
function checkEmailDuplicate() {
  const email = buildEmail();
  if (!email) { setMsg('#email-msg','이메일 아이디/도메인을 모두 입력하세요.', false); isEmailChecked=false; btnSend.disabled=true; return; }
  fetch('/api/users/check-email?email='+encodeURIComponent(email))
    .then(r=>r.json()).then(d=>{
      if (d.exists) { setMsg('#email-msg','이미 사용 중인 이메일입니다.', false); isEmailChecked=false; btnSend.disabled=true; }
      else { setMsg('#email-msg','사용 가능한 이메일입니다. ✅', true); isEmailChecked=true; btnSend.disabled=false; }
    }).catch(()=>{ setMsg('#email-msg','중복 확인 중 오류가 발생했습니다.', false); isEmailChecked=false; btnSend.disabled=true; });
}
function startCountdown(ms) {
  if (countdownId) clearInterval(countdownId);
  expireAt = Date.now()+ms;
  const tick = () => {
    const remain = expireAt - Date.now();
    if (remain <= 0) { clearInterval(countdownId); countdownId=null;
      setMsg('#email-verify-msg','인증번호가 만료되었습니다. 다시 발송해 주세요.', false); btnVerify.disabled=true; return; }
    const s = Math.floor(remain/1000), mm=String(Math.floor(s/60)).padStart(2,'0'), ss=String(s%60).padStart(2,'0');
    setMsg('#email-verify-msg','인증번호를 보냈습니다. '+mm+':'+ss+' 내에 입력하세요. ✅', true);
  };
  tick(); countdownId=setInterval(tick,1000);
}
function currentEmail(){ const e=buildEmail(); return e?e.toLowerCase():''; }

btnSend.addEventListener('click', ()=>{
  const email=currentEmail();
  if (!email) { setMsg('#email-msg','유효한 이메일을 먼저 입력하세요.', false); return; }
  if (!isEmailChecked) { setMsg('#email-msg','먼저 이메일 중복확인을 해주세요.', false); return; }
  fetch('/api/users/email-code', {
    method:'POST',
    headers:{ 'Content-Type':'application/json', ...(window.csrfHeader||{}) },
    body:JSON.stringify({ email })
  }).then(r=>r.json()).then(d=>{
    if (d.ok) { inputCode.disabled=false; btnVerify.disabled=false; startCountdown(300000); }
    else { setMsg('#email-verify-msg','발송 실패: '+(d.reason||'ERROR'), false); btnVerify.disabled=true; inputCode.disabled=true; }
  }).catch(()=> setMsg('#email-verify-msg','네트워크 오류', false));
});
btnVerify.addEventListener('click', ()=>{
  const email=currentEmail(); const code=inputCode.value.trim();
  if (!email){ setMsg('#email-msg','유효한 이메일을 먼저 입력하세요.', false); return; }
  if (!code){ setMsg('#email-verify-msg','인증번호를 입력하세요.', false); return; }
  if (expireAt && Date.now()>expireAt){ setMsg('#email-verify-msg','인증번호가 만료되었습니다. 다시 발송해 주세요.', false); btnVerify.disabled=true; return; }
  fetch('/api/users/verify-email-code', {
    method:'POST',
    headers:{ 'Content-Type':'application/json', ...(window.csrfHeader||{}) },
    body:JSON.stringify({ email, code })
  }).then(r=>r.json()).then(d=>{
    if (d.ok){ isEmailVerified=true; verifiedEmail=email; setMsg('#email-verify-msg','이메일 인증 완료! ✅', true);
      if (countdownId){ clearInterval(countdownId); countdownId=null; } expireAt=0;
    } else { isEmailVerified=false; setMsg('#email-verify-msg','인증 실패: '+(d.reason||'ERROR'), false); }
  }).catch(()=> setMsg('#email-verify-msg','네트워크 오류', false));
});

/* ============================
 * 전화번호 자동 하이픈 (10~11자리만 대상)
 * ============================ */
(function(){
  const tel = document.getElementById('phone');
  if (!tel) return;
  function formatPhone(v){
    const d = v.replace(/\D/g,''); // 숫자만
    if (d.length <= 3) return d;
    if (d.length <= 7) return d.replace(/(\d{3})(\d+)/, '$1-$2');
    if (d.length === 10) return d.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3'); // 3-3-4
    return d.substring(0,11).replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');      // 3-4-4
  }
  tel.addEventListener('input', () => {
    tel.value = formatPhone(tel.value);
  });
})();

/* ============================
 * 제출 검증
 * ============================ */
const form = document.getElementById('joinForm');
form.addEventListener('submit', (e) => {
  const ok1 = validatePwd(), ok2 = validatePwd2();
  if (!ok1 || !ok2) { e.preventDefault(); return; }

  if (!isUsernameChecked || !isEmailChecked) {
    alert('아이디/이메일 중복확인을 완료해 주세요.');
    e.preventDefault();
    return;
  }

  const finalEmail = buildEmail();
  if (!finalEmail) {
    setMsg('#email-msg','유효한 이메일을 입력하세요.', false);
    e.preventDefault();
    return;
  }

  if (!isEmailVerified || finalEmail.toLowerCase() !== (verifiedEmail || '').toLowerCase()) {
    alert('이메일 인증을 완료해 주세요. (인증 후 이메일을 변경하면 다시 인증해야 합니다)');
    e.preventDefault();
    return;
  }

  // ✅ 스프링 form:hidden에 값 주입
  document.getElementById('email-hidden').value = finalEmail.toLowerCase();
});

/* ============================
 * 초기 바인딩 + BFCache 케어
 * ============================ */
document.addEventListener('DOMContentLoaded', ()=>{
  generateDateOptions();
  birthYearEl.addEventListener('change', setDayOptions);
  birthMonthEl.addEventListener('change', setDayOptions);
  $('#btn-check-username').addEventListener('click', checkUsernameDuplicate);
  $('#btn-check-email').addEventListener('click',  checkEmailDuplicate);

  // 가입 성공 모달 오픈 & 확인 시 /login 이동
  if (window.__JOIN_SUCCESS__) {
    const m = document.getElementById('join-success-modal');
    m.classList.remove('hidden');
    document.body.style.overflow='hidden';
    document.getElementById('close-join-success')?.addEventListener('click', ()=>{
      window.location.href = '/login';
    });
  }
});

// 뒤로가기 복원 시 민감값 초기화
(function(){
  function clearSensitive(){
    ['password','password-check','email-code'].forEach(id=>{
      const el=document.getElementById(id); if (el) el.value='';
    });
    if (countdownId){ clearInterval(countdownId); countdownId=null; }
    expireAt=0; isEmailVerified=false; verifiedEmail=null;
    ['#password-msg','#password2-msg','#email-msg','#email-verify-msg'].forEach(s=>{
      const el=document.querySelector(s); if (el) el.textContent='';
    });
    document.getElementById('email-hidden')?.setAttribute('value','');
  }
  window.addEventListener('pageshow', e=>{
    const navs = performance.getEntriesByType?.('navigation');
    if (e.persisted || (navs && navs[0] && navs[0].type==='back_forward')) clearSensitive();
  });
  window.addEventListener('pagehide', clearSensitive);
})();
  </script>
</body>
</html>
