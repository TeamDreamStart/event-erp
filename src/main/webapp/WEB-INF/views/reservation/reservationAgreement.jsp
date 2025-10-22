<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0"><link
 href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700;900&display=swap"
 rel="stylesheet" />

<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/common.css'/>">
<title>reservation agreement</title>
<style>
body {
 background: #E5E2DB;
}
.section-header {
 display: flex;
 align-items: center;
 margin-bottom: 20px;
}
.main-cancle {
  margin: 0 auto;
  background-color: #E5E2DB;
  max-width: 888px;
  display: flex;
  flex-direction: column;
  gap: 38px; 
}
h2{
 font-size: 30px;
 font-weight: 700;
 line-height: 40px;
}

.cancle-scroll{
max-width: 888px;
margin: 0 auto;
width: 100%;
}
.cancle-reason{
background-color: #FAF9F6;
color: #222222;
padding: 30px;
box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
flex-grow: 1;
overflow-y: auto;
height: 367px; 
font-size: 14px;
}

.cancle-checkbox-wrap {
  max-width: 888px;
  margin: -22px auto 0 auto;
  width: 100%;
  display: flex;
  justify-content: flex-end;
  gap: 21px; 
}
.cancle-checkbox-wrap label {
  font-size: 14px;
}

/* ---------------------------------------------------- */
/* 사용자 정의 라디오 버튼 스타일 */
input[type="radio"].custom-radio {
    position: absolute;
    opacity: 0;
    width: 0;
    height: 0;
}

input[type="radio"].custom-radio + label {
    position: relative;
    padding-left: 25px; 
    cursor: pointer;
    line-height: 17px; 
    display: inline-block;
}

input[type="radio"].custom-radio + label::before {
    content: "";
    position: absolute;
    left: 0;
    top: 0;
    width: 17px; 
    height: 17px; 
    border: 1px solid #222222;
    border-radius: 2px; 
    background-color: #FFFFFF; 
    box-sizing: border-box;
}

input[type="radio"].custom-radio:checked + label::after {
    content: "";
    position: absolute;
    left: 4px; 
    top: 4px; 
    width: 9px; 
    height: 9px;
    background-color: #AFAFAF; 
    border-radius: 1px; 
    z-index: 1;
}

/* 체크박스 스타일도 라디오 버튼과 동일하게 적용 (전체 동의용) */
.agree-all input[type="checkbox"] {
    position: absolute;
    opacity: 0;
    width: 0;
    height: 0;
}

.agree-all label {
    position: relative;
    padding-left: 25px;
    cursor: pointer;
    line-height: 17px;
    display: inline-block;
}

.agree-all label::before {
    content: "";
    position: absolute;
    left: 0;
    top: 0;
    width: 17px; 
    height: 17px; 
    border: 1px solid #222222;
    border-radius: 2px; 
    background-color: #FFFFFF; 
    box-sizing: border-box;
}

.agree-all input[type="checkbox"]:checked + label::after {
    content: "";
    position: absolute;
    left: 4px; 
    top: 4px; 
    width: 9px; 
    height: 9px;
    background-color: #AFAFAF; 
    border-radius: 1px; 
    z-index: 1;
}
/* ---------------------------------------------------- */


.end-btn{
margin: 58px auto 0 auto;
display: grid;
grid-template-columns: 1fr 1fr;
width: fit-content;
margin-bottom: 140px;
}
#btn-back{
 border: 1px solid #AFAFAF;
 background-color: #F2F0EF;
 margin-right: 16px;
 padding: 8px 2px;
 width: 80px;
 border-radius: 12px;
 font-weight: bold;
 cursor: pointer;
 font-size: 14px;
}
#reservation-cancle{
 display: block;
border: 1px solid #8FAFED;
background-color: #BFD4F9;
padding: 8px 2px;
border-radius: 12px;
font-size: 14px;
width: 80px;
text-decoration: none;
font-weight: bold;
cursor: pointer;
color: #222222;
}
.reservation-info h4,
.cancle-reason h4 {
margin-top: 4px;
font-size: 14px;
font-weight: bold;
margin-bottom: 0;
}

.agree-all{
font-size: 14px;
text-align: right;
margin-top: 0; 
}
.agree-all label input {
  margin: 3px 9px 3px 4px;
}

.reservation-info p {
margin-bottom: 25px;
font-size: 14px;
}
.cancle-reason label {
font-size: 14px;
};
.cancle-reason p {
margin-top: 0;
font-weight: normal; 
font-size: 14px;
line-height: normal; 
}
</style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<main>
<div class="container">
<div class="section-header">
<h2>개인정보 활용 동의서</h2>
</div>
<div class="main-cancle">

  <div style="overflow: scroll;" class="cancle-scroll">
  <article class="cancle-reason" aria-required="true">
    <h4>D의 회원가입,이벤트참여,예약 등을 위해 아래와 같이 개인정보를 수집,이용합니다. (필수)</h4>
  </article>
  </div>
  <div class="cancle-checkbox-wrap">
    <input type="radio" name="agreement1" value="Y" id="agree1_Y" class="custom-radio" required>
        <label for="agree1_Y">예</label>
    <input type="radio" name="agreement1" value="N" id="agree1_N" class="custom-radio" required>
        <label for="agree1_N">아니오</label>
  </div>

  <div style="overflow: scroll;" class="cancle-scroll">
  <article class="cancle-reason" aria-required="true">
    <h4>D의 회원가입,이벤트참여,예약 등을 위해 아래와 같이 개인정보를 수집,이용합니다. (필수)</h4>
  </article>
  </div>
  <div class="cancle-checkbox-wrap">
    <input type="radio" name="agreement2" value="Y" id="agree2_Y" class="custom-radio" required>
        <label for="agree2_Y">예</label>
    <input type="radio" name="agreement2" value="N" id="agree2_N" class="custom-radio" required>
        <label for="agree2_N">아니오</label>
  </div>

  <div style="overflow: scroll;" class="cancle-scroll">
  <article class="cancle-reason" aria-required="true">
    <h4>D의 회원가입,이벤트참여,예약 등을 위해 아래와 같이 개인정보를 수집,이용합니다. (필수)</h4>
  </article>
  </div>
  <div class="cancle-checkbox-wrap">
    <input type="radio" name="agreement3" value="Y" id="agree3_Y" class="custom-radio" required>
        <label for="agree3_Y">예</label>
    <input type="radio" name="agreement3" value="N" id="agree3_N" class="custom-radio" required>
        <label for="agree3_N">아니오</label>
  </div>

  <div style="overflow: scroll;" class="cancle-scroll">
  <article class="cancle-reason" aria-required="true">
    <h4>D의 회원가입,이벤트참여,예약 등을 위해 아래와 같이 개인정보를 수집,이용합니다. (선택)</h4>
  </article>
  </div>
  <div class="cancle-checkbox-wrap">
    <input type="radio" name="agreement4" value="Y" id="agree4_Y" class="custom-radio">
        <label for="agree4_Y">예</label>
    <input type="radio" name="agreement4" value="N" id="agree4_N" class="custom-radio" checked>
        <label for="agree4_N">아니오</label>
  </div>

  <div style="overflow: scroll;" class="cancle-scroll">
  <article class="cancle-reason" aria-required="true">
    <h4>D의 회원가입,이벤트참여,예약 등을 위해 아래와 같이 개인정보를 수집,이용합니다. (선택)</h4>
  </article>
  </div>
  <div class="cancle-checkbox-wrap">
    <input type="radio" name="agreement5" value="Y" id="agree5_Y" class="custom-radio">
        <label for="agree5_Y">예</label>
    <input type="radio" name="agreement5" value="N" id="agree5_N" class="custom-radio" checked>
        <label for="agree5_N">아니오</label>
  </div>
  
  <div class="agree-all">
    <input type="checkbox" id="checkAll">
        <label for="checkAll">전체 동의</label>
  </div>
  
  <div class="end-btn">
  <button onclick="history.back()" id="btn-back">취소</button>
  <div style="display: block; text-align: center;">
   <a href="#" id="reservation-cancle">다음</a>
  </div>       
  </div>
</div>
</div>
</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
<script>
document.addEventListener('DOMContentLoaded', function() {
    const checkAll = document.getElementById('checkAll');
    
    const requiredAgreements = document.querySelectorAll('input[name="agreement1"][value="Y"], input[name="agreement2"][value="Y"], input[name="agreement3"][value="Y"]');
    const optionalAgreements = document.querySelectorAll('input[name="agreement4"][value="Y"], input[name="agreement5"][value="Y"]');

    checkAll.addEventListener('change', function() {
        const isChecked = this.checked;

        requiredAgreements.forEach(radio => {
            radio.checked = isChecked;
        });

        optionalAgreements.forEach(radio => {
            radio.checked = isChecked;
        });
    });

    const allRadios = document.querySelectorAll('input[type="radio"]');
    allRadios.forEach(radio => {
        radio.addEventListener('change', function() {
            const allRequiredAgreed = Array.from(requiredAgreements).every(radio => radio.checked);
            const allOptionalAgreed = Array.from(optionalAgreements).every(radio => radio.checked);
            
            checkAll.checked = allRequiredAgreed && allOptionalAgreed;
        });
    });

    document.getElementById('reservation-cancle').addEventListener('click', function(e) {
        let allRequiredSelected = true;
        
        for(let i = 1; i <= 3; i++) {
            const requiredY = document.querySelector('input[name="agreement' + i + '"][value="Y"]');
            const requiredN = document.querySelector('input[name="agreement' + i + '"][value="N"]');
            
            if (!(requiredY.checked || requiredN.checked)) {
                allRequiredSelected = false;
                break;
            }
        }
        
        if (!allRequiredSelected) {
            e.preventDefault();
            alert('모든 필수 약관에 동의해야 합니다.');
        } else {
            // 여기에 다음 페이지로 이동하거나 폼 제출하는 로직 추가
        }
    });

});
</script>
</body>
</html>