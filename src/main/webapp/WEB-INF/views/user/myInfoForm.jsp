<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700;900&display=swap" rel="stylesheet"/>
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/common.css'/>">
<title>MyPage - 회원 정보 수정</title>
<style>
 body {
 background: #E5E2DB;
}
.section-header {
 display: flex;
 align-items: center;
 margin-bottom: 20px;
}

.page-title {
 display: flex;
 align-items: center;
}

.page-title h2 {
 font-size: 30px;
 font-weight: 700;
 line-height: 40px;
}

.page-title a {
 text-decoration: none;
 color: #222222;
 margin-right: 10px;
 font-size: 24px;
}

.info-box {
 background-color: #FFFFFF;
 border: 1px solid #D9D9D9;
 padding: 32px 23px;
 border-radius: 12px;
 max-width: 896px;
 margin: 0 auto 40px auto;
}
.info-box:last-child{
 margin-bottom: 0;
}

.form-section-title {
 font-size: 14px;
 font-weight: bold;
 margin-bottom: 40px;
}

.form-group {
 margin-bottom: 29px;
}

.form-group:last-of-type {
 margin-bottom: 0;
}

.form-label {
 display: block;
 font-size: 14px;
 font-weight: 700;
 margin-bottom: 9px;
}

.form-input-box {
 max-width: 100%;
 min-width: 434px;
 padding: 8px;
 border-radius: 3px;
 font-size: 14px;
 box-sizing: border-box;
 border: 1px solid #AFAFAF;
 background-color: #F2F0EF;
}

.form-input-box::placeholder {
 color: #AFAFAF;
}

.email-input {
 background-color: #D9D9D9;
 border: 1px solid #AFAFAF;
}

.help-text, .error-message {
 display: block;
 font-size: 12px;
 margin-top: 5px;
}
.form-group :last-child{
 margin-bottom: 0px;
}

.help-text {
 color: #888;
}

.error-message {
 color: #E53935;
 font-weight: 700;
 display: none;
}

.form-input-box:invalid:not(:placeholder-shown), .form-input-box.error {
 border-color: #AFAFAF;
}

.form-group.has-error .error-message {
 display: block;
}

.btn-area{
 width: 896px;
 display: flex;
 margin: 0 auto;
 justify-content: flex-end;
}

.action-btn {
 padding: 10px 10px;
 border-radius: 12px;
 font-weight: 700;
 font-size: 14px;
 cursor: pointer;
 border: none;
 height: 34px;
 display: flex;
 justify-content: center;
 align-items: center;
}

.cancel-btn {
 background-color: #F2F0EF;
 color: #222222;
 border: 1px solid #AFAFAF;
 right: 0;
}

.save-btn {
 background-color: #BFD4F9;
 color: #222222;
 border: 1px solid #8FAFED;
}
  option {
    font-size: 16px;
  }

  select.box{

  }
.birth-select {
  max-width: 100%;
  min-width: 135px;
  padding: 8px;
  border-radius: 3px;
  font-size: 14px;
  box-sizing: border-box;
  border-radius: 3px;
  border: 1px solid #AFAFAF;
  background-color: #F2F0EF;
  font-family: 'Montserrat', 'Pretendard', sans-serif;
}
.form-group.birth-date-group {
}
.birth-select-wrapper {
  display: flex;
  gap: 6px;
  width: 100%;
}
</style>
</head>

<body>
 <jsp:include page="/WEB-INF/views/common/header.jsp" />
 <main>
  <div class="container">
   <div class="section-header">
    <div class="page-title">
     <h2>MyPage</h2>
    </div>
   </div>

   <div class="info-box">
    <form onsubmit="return validateForm(event)"
     action="/my-info/${userDTO.userId}/edit/info" method="post">
     <input type="hidden" name="${_csrf.parameterName}"
      value="${_csrf.token}" />
     <div class="form-section-title">기본 정보</div>
     <input type="hidden" id="userId" name="userId"
      value="${userDTO.userId}">

     <div class="form-group">
      <label class="form-label" for="username">아이디 (변경 불가)</label> <input
       type="text" id="username" name="username"
       class="form-input-box email-input" value="${userDTO.username}"
       onblur="checkUserIdFormat(this)" readonly>
     </div>

     <div class="form-group">
      <label class="form-label" for="email">이메일 (변경 불가)</label> <input
       type="text" id="email" name="email"
       class="form-input-box email-input"
       style="caret-color: transparent;" value="${userDTO.email}"
       onblur="checkEmailFormat(this)">
     </div>

     <div class="form-group">
      <label class="form-label" for="name">이름*</label> <input
       type="text" id="name" name="name" class="form-input-box"
       value="${userDTO.name}" required>
     </div>

     <div class="form-group" id="phone-group">
      <label class="form-label" for="phone">전화번호*</label> <input
       type="text" id="phone" name="phone" value="${userDTO.phone}"
       class="form-input-box" style="caret-color: transparent;"
       placeholder="예) 010-1234-5678" required
       pattern="\d{3}-\d{4}-\d{4}" oninput="autoFormatPhone(this)"
       onblur="checkPhoneValidity(this)"> <span
       class="help-text">'-'를 포함하여 000-0000-0000 형식으로 입력해 주세요.</span> <span
       class="error-message" id="phone-error">전화번호 형식이 올바르지 않습니다.
       (예: 000-0000-0000)</span>
     </div>

     <div class="form-group" id="gender-section">
      <label class="form-label" for="gender">성별*</label>
      <input type="radio" id="male" name="gender" class="gender1">
      <label for="male">남</label>
      <input type="radio" id="female" name="gender" class="gender1">
      <label for="female">여</label>
     </div>
     <div class="form-group">
      <label class="form-label" for="birth_year">생년월일*</label>
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

     <div class="button-area" style="display: flex; justify-content: flex-end;">
      <button type="submit" class="action-btn save-btn">저장</button>
     </div>
    </form>
   </div>

   <div class="info-box">
    <form action="/my-info/${userDTO.userId }/edit/pass" method="post">
     <input type="hidden" name="${_csrf.parameterName}"
      value="${_csrf.token}" /> 
      <input type="hidden" id="userId"
      name="userId" value="${userDTO.userId}"> <input
      type="hidden" name="email" value="${userDTO.email }">
     <div class="form-section-title">비밀번호 변경</div>

     <div class="form-group">
      <label class="form-label" for="newPassword">새 비밀번호</label> <input
       type="password" id="newPassword" name="newPassword"
       class="form-input-box" placeholder="새 비밀번호를 입력하세요" required>
     </div>

     <div class="form-group">
      <label class="form-label" for="confirmPassword">새 비밀번호 확인</label>
      <input type="password" id="confirmPassword" name="confirmPassword"
       class="form-input-box" placeholder="새 비밀번호를 다시 입력하세요" required>
     </div>

     <div class="button-area" style="display: flex; justify-content: flex-end;">

      <button type="submit" class="action-btn save-btn">변경</button>
     </div>
    </form>
   </div>
   <div class="btn-area">
       <button type="button" onclick="history.back()" style="margin-bottom: 140px; padding: 10px 10px;
  border-radius: 12px;
  font-weight: 700;
  font-size: 14px;
  cursor: pointer;
  border: none;
  height: 34px; display: flex;
  color: #222222;
  background-color: #F2F0EF;
  border: 1px solid #AFAFAF; justify-content: center;
  align-items: center;">취소</button>
   </div>
  </div>
 </main>

 <script>
const birthYearEl = document.getElementById('birth_year');
const birthMonthEl = document.getElementById('birth_month');
const birthDayEl  = document.getElementById('birth_day');

function generateDateOptions() {
 if (!birthYearEl || !birthMonthEl || !birthDayEl) return;
 const currentYear = new Date().getFullYear();
 
 for (let y=currentYear; y>=1940; y--) {
  const o=document.createElement('option'); o.value=y; o.textContent=y+'년';
  birthYearEl.appendChild(o);
 }
 for (let m=1; m<=12; m++) {
  const val=String(m).padStart(2,'0');
  const o=document.createElement('option'); o.value=val; o.textContent=val+'월';
  birthMonthEl.appendChild(o);
 }
 setDayOptions();
}

function setDayOptions() {
 birthDayEl.innerHTML = '<option value="" disabled selected>일</option>';
 
 const y=birthYearEl.value;
 const m=birthMonthEl.value;
 
 if (!y || !m) return;
 
 const maxDay = new Date(y, m, 0).getDate();
 
 for (let d=1; d<=maxDay; d++) {
  const val=String(d).padStart(2,'0');
  const o=document.createElement('option'); o.value=val; o.textContent=val+'일';
  birthDayEl.appendChild(o);
 }
}

birthYearEl.addEventListener('change', setDayOptions);
birthMonthEl.addEventListener('change', setDayOptions);


  function checkEmailFormat(input) {
   const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;

   if (input.value.trim() !== "" && !emailPattern.test(input.value)) {
    alert("이메일 형식이 올바르지 않습니다.");
   }
  }

  function autoFormatPhone(input) {
   let value = input.value.replace(/[^0-9]/g, '');
   let formattedValue = '';

   if (value.length > 3 && value.length <= 7) {
    formattedValue = value.substring(0, 3) + '-'
      + value.substring(3);
   } else if (value.length > 7) {
    formattedValue = value.substring(0, 3) + '-'
      + value.substring(3, 7) + '-' + value.substring(7, 11);
   } else {
    formattedValue = value;
   }

   input.value = formattedValue;

   checkPhoneValidity(input);
  }

  function checkPhoneValidity(input) {
   const parentGroup = document.getElementById('phone-group');
   const pattern = new RegExp(input.pattern);

   if (input.value.trim() === "" || pattern.test(input.value)) {
    parentGroup.classList.remove('has-error');
    input.classList.remove('error');
   } else {
    parentGroup.classList.add('has-error');
    input.classList.add('error');
   }
  }

  function validateForm(event) {
   const phoneInput = document.getElementById('phone');

   checkPhoneValidity(phoneInput);

   if (!phoneInput.checkValidity()) {
    event.preventDefault();
    alert("필수 정보를 올바르게 입력해 주세요.");
    return false;
   }

   return true;
  }

  document.addEventListener('DOMContentLoaded', function() {
   generateDateOptions();
  });
  
 </script>
 <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>