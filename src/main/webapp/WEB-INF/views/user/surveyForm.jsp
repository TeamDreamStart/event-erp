<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700;900&display=swap"
rel="stylesheet"/>
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/common.css'/>">
<title>surveyForm</title>
<style>
body {
background: #E5E2DB;
}
.section-header {
display: flex;
align-items: center;
margin-bottom: 20px;
}
.section-header h2 {
font-size: 30px;
font-weight: 700;
line-height: 40px;
}
.main-content{
margin: 0 auto;
background-color: #FFFFFF;
border: 1px solid #d9d9d9;
border-radius: 12px;
width: 896px;
min-height: 473px;
padding: 38px 51px;
}
.info-box {
 display: flex;
 flex-direction: column;
}

.info-header p {
 font-size: 14px;
 font-weight: 700;
 color: #222222;
 margin-bottom: 38px;
}

.survey-check-form {
 display: flex;
 flex-direction: column;
 gap: 29px; 
}

.question-group {
 display: flex;
 flex-direction: column;
 gap: 17px; 
}

.question-group label {
 font-size: 14px;
 font-weight: 700;
 color: #222222;
}

.radio-options {
 display: flex;
 gap: 37px; 
}

.radio-options label {
 display: flex;
 align-items: center;
 font-weight: normal; 
 font-size: 14px;
 cursor: pointer;
}

input[type="radio"] {
 appearance: none;
 -webkit-appearance: none;
 -moz-appearance: none;
 
 width: 17px; 
 height: 17px;
 
 border: 1px solid #222222; 
 border-radius: 2px; 
 background-color: #ffffff;
 position: relative;
 margin: 0 9px 0 0; 
 cursor: pointer;
 padding: none;
}

input[type="radio"]:checked::before {
 content: '';
 display: block;
 width: 9px; 
 height: 9px;
 background-color: #CBCBCB; 
 border-radius: 2px;
 position: absolute;
 top: 50%;
 left: 50%;
 transform: translate(-50%, -50%);
}

.button-group {
 display: flex;
 justify-content:center;
 gap: 28px;
 margin-top: 40px;
}

.button-group button {
 height: 32px;
 padding: auto 40px;
 border-radius: 12px;
 font-size: 14px;
 cursor: pointer;
 font-weight: 700;
 margin-bottom: 140px;
}

.btn-cancel {
 border: 1px solid #AFAFAF;
 background-color: #F2F0EF;
 color: #222222;
}

.btn-submit {
 background-color: #BFD4F9; 
 color: #222222;
 border: 1px solid#8FAFED;
}

.modal-backdrop {
 background-color: rgba(0, 0, 0, 0.85);
 position: fixed;
 top: 0;
 left: 0;
 width: 100%;
 height: 100%;
 display: flex;
 justify-content: center;
 align-items: center;
 z-index: 1000;
 display: none;
}

.modal-content {
 background-color: #FAF9F6;
 border-radius: 12px;
 padding: 36px 32px;
 width: 455px;
 min-height: 179px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}

.say-thx {
    font-size: 14px;
    font-weight: 700;
    text-align: left;
    line-height: 1.5;
}

.modal-divider {
    border-top: 1px solid #AFAFAF;
    margin: 20px 0;
}

.modal-button-container {
    display: flex;
    justify-content: flex-end;
}

.modal-close-btn {
    padding: 8px 15px;
    background: transparent;
    border: none;
    color: #0088FF;
    font-size: 14px;
    cursor: pointer;
    font-weight: 700;
}
</style>
</head>

<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" flush="true" />
<main class="container">
<div class="section-header">
 <h2>설문조사</h2>
</div>

<form action="#" method="post" id="surveyForm">
 <div class="main-content">
 <div class="info-box">
  <article class="info-header">
  <p>프로그램 만족도 조사</p>
  </article>
  <article class="survey-check-form">
  
      <c:set var="questions" value='
          1. 본 프로그램에 대해 전반적으로 만족하셨습니까?, 
          2. 본 프로그램 교육 장소 및 기타시설에 대해 만족하셨습니까?, 
          3. 본 프로그램을 통해 알게 된 교육내용과 정보가 향후 자기개발에 도움이 되겠습니까?,
          4. 본 프로그램의 교육내용이 본인의 진로계획에 도움이 되겠습니까?,
          5. 본 프로그램 참여 후 학교에서 제공하는 다른 현장 실습이나 교육프로그램에 참여할 의사가 있으십니까?
        '/>
      <c:forEach var="questionText" items="${questions}" varStatus="status">
        <div class="question-group">
          <label>${questionText}</label>
          <div class="radio-options" aria-required="true">
            <label><input type="radio" name="q${status.index + 1}" value="1">매우 나쁨</label>
            <label><input type="radio" name="q${status.index + 1}" value="2">나쁨</label>
            <label><input type="radio" name="q${status.index + 1}" value="3" checked>보통</label>
            <label><input type="radio" name="q${status.index + 1}" value="4">좋음</label>
            <label><input type="radio" name="q${status.index + 1}" value="5">매우 좋음</label>
          </div>
        </div>
      </c:forEach>
      
  </article>
 </div>
 </div>
 
  <div class="button-group">
 <button type="button" class="btn-cancel" onclick="history.back()">취소</button>
 <button type="button" class="btn-submit" id="submitSurvey">설문 제출</button>
 </div>
</form>
</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

<div id="ThankyouModal" class="modal-backdrop">
 <div class="modal-content">
  <div>
   <p class="say-thx">설문이 제출되었습니다.</p>
   <p class="say-thx">소중한 의견 감사합니다!</p>
  </div>
  <div class="modal-divider"></div>
  <div class="modal-button-container">
   <button type="button" class="modal-close-btn" onclick="closeModal()">닫기</button>
  </div>
 </div>
</div>

<script>
    document.getElementById('submitSurvey').addEventListener('click', function() {
        document.getElementById('ThankyouModal').style.display = 'flex';
    });

    function closeModal() {
        document.getElementById('ThankyouModal').style.display = 'none';
    }
</script>

</body>
</html>
