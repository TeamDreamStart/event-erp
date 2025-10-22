<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!-- CSRF -->
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />

<!-- Reset & Common -->
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/common.css'/>">

<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700;900&display=swap" rel="stylesheet"/>

<title>회원가입</title>

<style>
body {
  background: #f9fafb;
  font-family: 'Pretendard', 'Montserrat', sans-serif;
  color: #222;
}

/* 메인 영역 */
.memberArea {
  width: 100%;
  display: flex;
  justify-content: center;
  padding: 60px 0 140px;
}

/* 가운데 컨테이너 */
.memberArea .contents {
  width: 100%;
  max-width: 900px;
  background: #fff;
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  padding: 50px 70px;
  box-shadow: 0 2px 6px rgba(0,0,0,0.05);
}

/* 타이틀 */
.contents h2 {
  font-size: 28px;
  font-weight: 700;
  text-align: center;
  color: #1f2937;
  margin-bottom: 40px;
}

/* 섹션 헤더 */
.section-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
  margin-bottom: 8px;
}
.section-header h3 {
  font-size: 16px;
  font-weight: 700;
  color: #111;
}
.section-header .required-note {
  font-size: 13px;
  color: #568ef7;
}
.section-divider {
  border: none;
  border-top: 1px solid #ccc;
  margin-bottom: 24px;
}

/* 필드 그룹 */
.form-group {
  display: flex;
  align-items: center;
  margin-bottom: 20px;
}
.form-group label {
  width: 140px;
  font-weight: 600;
  color: #111;
  font-size: 15px;
}
.form-group input,
.form-group select {
  flex: 1;
  height: 46px;
  border: 1px solid #ccc;
  border-radius: 4px;
  padding: 0 12px;
  font-size: 15px;
  background: #fff;
  box-sizing: border-box;
}
.form-group input:focus,
.form-group select:focus {
  border-color: #568ef7;
  outline: none;
}

/* 이메일 */
.email-wrap {
  flex: 1;
  display: flex;
  flex-direction: column;
}

.email-inputs {
  display: flex;
  align-items: center;
  gap: 6px;
}

.email-inputs input[type="text"],
.email-inputs select {
  height: 46px;
  padding: 0 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
  font-size: 15px;
  flex: none;
}

.email-inputs input#email-local { width: 175px; }
.email-inputs input#domain-txt { width: 175px; }
.email-inputs select { width: 140px; }

.email-inputs span {
  font-weight: 600;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 0 4px;
}

.email-inputs button {
  height: 46px;
  padding: 0 14px;
  border: 1px solid #ccc;
  border-radius: 4px;
  background: #f6f7f9;
  font-weight: 600;
  cursor: pointer;
}

.email-inputs button:hover {
  background: #eef0f3;
}

#email-msg {
  margin-top: 4px;
  margin-left: 0;
}


/* 필수표시 */
label.required::after {
  content: " *";
  color: #568ef7;
  font-weight: 600;
}

/* 버튼 있는 입력 */
.input-with-button {
  display: flex;
  align-items: center;
  gap: 8px;
}
.input-with-button button {
  height: 46px;
  padding: 0 16px;
  background: #f6f7f9;
  border: 1px solid #ccc;
  border-radius: 4px;
  font-weight: 600;
  cursor: pointer;
}
.input-with-button button:hover {
  background: #eef0f3;
}

/* 비밀번호 */
/* 비밀번호 구역 전용 */
.password-group {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
}

.password-group .field-msg {
  order: 3;
  flex-basis: 100%;
  margin-left: 140px;
  margin-top: 4px;
  color: #e54848;
  font-size: 13px;
  line-height: 1.4;
}

/* 성별 */
.form-radio {
  display: flex;
  gap: 24px;
  align-items: center;
}
.form-radio label {
  width: auto;
  font-weight: 500;
  color: #333;
}

/* 생년월일 */
.birth-select-wrapper {
  display: flex;
  gap: 8px;
}
.birth-select-wrapper select {
  flex: 1;
}

/* 메시지 */
.field-msg {
  font-size: 12px;
  margin-left: 140px;
  margin-bottom: 20px;
  color: #888;
  height: 0;              /* 높이 0으로 기본 줄 맞춤 */
  overflow: hidden;       /* 내용 숨기기 */
  transition: all .2s ease;
}
.field-msg.show {
  height: auto;           /* 메시지가 생기면 높이 복원 */
  margin-top: 4px;
  overflow: visible;
}
.field-msg.ok { color: #0e7a4a; }
.field-msg.warn { color: #c62828; }

/* 버튼 라인 */
.join-bottom-button {
  display: flex;
  justify-content: center;
  gap: 12px;
  margin-top: 50px;
}
.btn-cancel,
.btn-next {
  width: 220px;
  height: 48px;
  border: none;
  border-radius: 4px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
}
.btn-cancel {
  background: #f3f4f6;
  border: 1px solid #d1d5db;
  color: #333;
}
.btn-cancel:hover { background: #e5e7eb; }
.btn-next {
  background: #568ef7;
  color: #fff;
}
.btn-next:hover { background: #4177e6; }

/* 전화번호 */
.phone-inputs {
  display: flex;
  align-items: center;
  gap: 8px;
}
.phone-inputs select,
.phone-inputs input {
  width: 120px;
  height: 46px;
  border: 1px solid #ccc;
  border-radius: 4px;
  padding: 0 10px;
  font-size: 15px;
}

/* SNS */
.sns-join-section {
  margin-top: 60px;
  text-align: center;
}
.sns-join-buttons {
  display: flex;
  justify-content: center;
  gap: 18px;
}
.sns-btn {
  display: flex;
  align-items: center;
  justify-content: flex-start;
  width: 360px;
  height: 70px;
  border: 1px solid #d1d5db;
  border-radius: 6px;
  background: #fff;
  padding: 0 20px;
  transition: background 0.2s ease, transform 0.1s;
  text-decoration: none;
}
.sns-btn:hover {
  background: #f3f4f6;
  transform: scale(1.02);
}
.sns-btn img {
  width: 52px;
  height: 52px;
  object-fit: contain;
  border-radius: 50%;
  margin-right: 18px;
}
.sns-btn span {
  color: #444;
  font-size: 16px;
  font-weight: 600;
}
.sns-info {
  margin-top: 16px;
  color: #e54848;
  font-size: 13.5px;
  line-height: 1.6;
}
.sns-info i {
  font-style: normal;
  font-weight: 700;
  color: #e54848;
  margin-right: 4px;
}
</style>
</head>

<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<main class="memberArea">
  <div class="contents">
    <h2>회원가입</h2>

    <div class="section-header">
      <h3>회원 정보</h3>
      <span class="required-note">*필수입력사항</span>
    </div>
    <hr class="section-divider">

    <form:form id="joinForm" modelAttribute="user" action="/join" method="post" autocomplete="off">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

      <!-- 아이디 -->
      <div class="form-group">
        <label for="username" class="required">아이디</label>
        <div class="input-with-button">
          <input type="text" id="username" name="username" placeholder="아이디를 입력하세요." required />
          <button type="button" id="btn-check-username">중복확인</button>
        </div>
      </div>
      <!-- 아이디 중복 메시지 -->
	  <div id="username-msg" class="field-msg"></div>
      

      <!-- 비밀번호 -->
	  <div class="form-group password-group">
	    <label for="password" class="required">비밀번호</label>
	    <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요." required>
	    <div id="password-msg" class="field-msg warn">
	    	(영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10자~16자)
	    </div>
	  </div>

	
	  <!-- 비밀번호 확인 -->
	  <div class="form-group">
	    <label for="password-check" class="required">비밀번호 확인</label>
	    <input type="password" id="password-check" name="password-check" placeholder="비밀번호를 확인하세요." required />
	  </div>
	  <div id="password2-msg" class="field-msg"></div>

      <!-- 이름 -->
      <div class="form-group">
        <label for="name" class="required">이름</label>
        <input type="text" id="name" name="name" required />
      </div>

      <!-- 성별 -->
      <div class="form-group">
        <label class="required">성별</label>
        <div class="form-radio">
          <form:radiobutton path="gender" id="male" value="1" />
          <label for="male">남</label>
          <form:radiobutton path="gender" id="female" value="0" />
          <label for="female">여</label>
        </div>
      </div>

      <!-- 생년월일 -->
      <div class="form-group">
        <label for="birth_year" class="required">생년월일</label>
        <div class="birth-select-wrapper">
          <select id="birth_year" name="birth_year"><option value="" disabled selected>연도</option></select>
          <select id="birth_month" name="birth_month"><option value="" disabled selected>월</option></select>
          <select id="birth_day" name="birth_day"><option value="" disabled selected>일</option></select>
        </div>
      </div>
      <input type="hidden" id="birthDate" name="birthDate">

      <!-- 이메일 -->
	  <div class="form-group">
	    <label for="email-local" class="required">이메일</label>
	    <div class="email-wrap">
	      <div class="email-inputs">
	        <input type="text" id="email-local" placeholder="이메일 아이디" required>
	        <span>@</span>
	        <input type="text" id="domain-txt" placeholder="직접입력" required>
	        <select id="domain-list">
	          <option value="type">직접입력</option>
	          <option value="gmail.com">gmail.com</option>
	          <option value="naver.com">naver.com</option>
	          <option value="daum.net">daum.net</option>
	          <option value="kakao.com">kakao.com</option>
	        </select>
	        <button type="button" id="btn-check-email">중복확인</button>
	      </div>
	      <div id="email-msg" class="field-msg"></div>
	    </div>
	  </div>
	
	  <!-- 이메일 인증 -->
	  <div class="form-group">
	    <label for="email-code" class="required">이메일 인증</label>
	    <div class="input-with-button">
	      <button type="button" id="btn-send-code">인증번호 발송</button>
	      <input type="text" id="email-code" placeholder="인증번호 입력" />
	      <button type="button" id="btn-verify-code">인증 확인</button>
	    </div>
	  </div>
	  <div id="email-verify-msg" class="field-msg"></div>
	
	  <!-- 실제 전송용 hidden -->
	  <input type="hidden" id="email-hidden" name="email">

      <!-- 전화번호 -->
      <div class="form-group">
	    <label for="phone1" class="required">휴대전화</label>
	    <div class="phone-inputs">
	      <select id="phone1" name="phone1" required>
	        <option value="010" selected>010</option>
	        <option value="011">011</option>
	        <option value="016">016</option>
	        <option value="017">017</option>
	        <option value="018">018</option>
	        <option value="019">019</option>
	      </select>
	      <input type="text" id="phone2" maxlength="4" required>
	      <input type="text" id="phone3" maxlength="4" required>
	      <!-- 실제 전송용 hidden -->
	      <input type="hidden" id="phone-hidden" name="phone">
	    </div>
	  </div>
	  <div id="phone-msg" class="field-msg"></div>

      <!-- 버튼 -->
      <div class="join-bottom-button">
        <button type="button" class="btn-cancel" onclick="history.back()">취소하기</button>
        <button type="submit" class="btn-next">가입하기</button>
      </div>
    </form:form>

    <!-- SNS 회원가입 -->
	<div class="sns-join-section">
	  <h3 style="font-size:18px; font-weight:700; margin-bottom:18px;">SNS 간편회원가입</h3>
	  
	  <div class="sns-join-buttons">
	    <!-- 네이버 로그인/가입 -->
	    <a href="${pageContext.request.contextPath}/login/naver" class="sns-btn naver">
	      <img src="<c:url value='/resources/img/naver/btnW_아이콘원형.png'/>" alt="네이버 아이디 회원가입">
	      <span>네이버 아이디로 가입하기</span>
	    </a>
	    
	    <!-- 카카오 로그인/가입 (추후 연결 예정) -->
	    <a href="${pageContext.request.contextPath}/login/kakao" class="sns-btn kakao">
	      <img src="<c:url value='/resources/img/kakao_round_logo.png'/>" alt="카카오 아이디 회원가입">
	      <span>카카오 아이디로 가입하기</span>
	    </a>
	  </div>
	
	  <p class="sns-info">
	    <i>!</i> SNS 계정을 통해 안전하게 회원가입 후, 자동으로 회원정보가 연동됩니다.<br/>
	    인증 절차는 기존 회원가입과 동일하게 보호됩니다.
	  </p>
	</div>


  </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

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
	  const el = document.querySelector(sel);
	  el.textContent = text || '';
	  el.classList.remove('ok', 'warn', 'show');
	  if (text) {
	    el.classList.add(ok ? 'ok' : 'warn', 'show');
	  }
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
/*(function(){
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
*/

/* ============================
 * 제출 검증
 * ============================ */
 const form = document.getElementById('joinForm');

 form.addEventListener('submit', (e) => {
   e.preventDefault(); // ✅ 일단 전송 멈추고 모든 값 검증 후 수동 전송

   // 비밀번호 검증
   const ok1 = validatePwd(), ok2 = validatePwd2();
   if (!ok1 || !ok2) return;

   // 아이디 / 이메일 중복 체크
   if (!isUsernameChecked || !isEmailChecked) {
     alert('아이디/이메일 중복확인을 완료해 주세요.');
     return;
   }

   // 이메일 최종 검증
   const finalEmail = buildEmail();
   if (!finalEmail) {
     setMsg('#email-msg','유효한 이메일을 입력하세요.', false);
     return;
   }
   if (!isEmailVerified || finalEmail.toLowerCase() !== (verifiedEmail || '').toLowerCase()) {
     alert('이메일 인증을 완료해 주세요. (인증 후 이메일을 변경하면 다시 인증해야 합니다)');
     return;
   }

   // 성별 체크
   const genderChecked = document.querySelector('input[name="gender"]:checked');
   if (!genderChecked) {
     alert('성별을 선택해주세요.');
     return;
   }

   // 생년월일 병합
   const year  = document.getElementById('birth_year').value;
   const month = document.getElementById('birth_month').value;
   const day   = document.getElementById('birth_day').value;

   let fullBirth = null;

   if (year && month && day) {
     fullBirth = `${year}-${month.padStart(2, '0')}-${day.padStart(2, '0')}`;
   } else {
     fullBirth = ''; // null처럼 처리되어 DB insert 시 오류 안남
   }

   document.querySelector('input[name="birthDate"]').value = fullBirth;


   // 전화번호 병합
   const p1 = $('#phone1').value.trim();
   const p2 = $('#phone2').value.trim();
   const p3 = $('#phone3').value.trim();
   if (!(p1 && p2 && p3)) {
     alert('전화번호를 모두 입력해주세요.');
     return;
   }
   const fullPhone = `${p1}-${p2}-${p3}`;
   document.getElementById('phone-hidden').value = fullPhone;

   // 이메일 hidden 세팅
   document.getElementById('email-hidden').value = buildEmail().toLowerCase();

   form.submit();
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



