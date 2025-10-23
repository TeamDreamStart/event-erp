<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700;900&display=swap" rel="stylesheet"/>

<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/common.css'/>">
<title>reservation cancle</title>
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

.main-cancle {
 max-width: 800px;
 margin: 0 auto;
 background-color: #FAF9F6;
 color: #222222;
 padding: 30px;
 box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
 flex-grow: 1;
 max-height: 600px;
 caret-color: transparent;
 margin-bottom: 140px;
}

.cancle-scroll {
 width: 100%;
 height: 300px;
 border: none;
 padding: 0;
 background-color: #FAF9F6;
 color: #222222;
 overflow: scroll;
}

.end-btn {
 margin: 58px auto 0 auto;
 display: block;
 width: fit-content;
 text-align: center;
}

#btn-back {
 border: 1px solid #AFAFAF;
 background-color: #F2F0EF;
 margin-right: 16px;
 padding: 8px 2px;
 width: 80px;
 border-radius: 12px;
 font-weight: bold;
 cursor: pointer;
}

.reservation-cancle {
 border: 1px solid #8FAFED;
 background-color: #BFD4F9;
 padding: 8px 2px;
 border-radius: 12px;
 width: 80px;
 font-weight: bold;
 cursor: pointer;
}

.reservation-info h3, .cancle-reason h4 {
 margin-top: 4px;
 font-weight: bold;
 margin-bottom: 15px;
 font-size: 14px;
}

.reservation-info p {
 margin-bottom: 25px;
 font-size: 14px;
}

.cancle-reason label {
 margin-right: 20px;
 font-size: 14px;
}

/* 기존 라디오 버튼 마진 제거 및 커스텀 스타일링을 위한 설정 */
.cancle-reason input[type="radio"] {
 margin-right: 0;
}

.cancle-reason p {
 margin-top: 30px;
 font-weight: bold;
 font-size: 14px;
}

.btn-box {
 display: flex;
 justify-content: center;
 margin-top: 80px;
}

/* ---------------------------------------------------- */
/* 사용자 정의 라디오 버튼 스타일 */
input[type="radio"].custom-radio {
    position: absolute;
    opacity: 0;
    width: 0;
    height: 0;
}

/* label 스타일링 */
input[type="radio"].custom-radio + label {
    position: relative;
    padding-left: 25px; /* 네모 공간 확보 */
    cursor: pointer;
    line-height: 17px; 
    display: inline-block;
    vertical-align: middle;
}

/* 네모 테두리 (체크 안 됨) */
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

/* 체크되었을 때 내부 채우기 (회색 사각형) */
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

/* ---------------------------------------------------- */
</style>
</head>
<body>

 <jsp:include page="/WEB-INF/views/common/header.jsp" />
 <main>
  <div class="container">
   <div class="section-header">
    <h2>예약취소</h2>
    </div>
   <div class="main-cancle">


    <div class="cancle-scroll">
     <article class="reservation-info">
      <h3>예약정보</h3>
      <p>이벤트명 : ${reservationDTO.eventTitle }</p>
      <p>예약일자 : ${reservationDTO.reservationDate }</p>
      <p>상태 : <span style="font-weight: 700;">${reservationDTO.reservationStatus }</span></p>
     </article>
     <article class="cancle-reason" aria-required="true" style="font-size: 14px;">
     <c:if test="${reservationDTO.reservationStatus eq 'CANCELLED'}">
      이미 취소된 예약입니다.
     </c:if>
     <c:if test="${reservationDTO.reservationStatus ne 'CANCELLED'}">
      <form action="/reservations/${reservationDTO.reservationId }/cancel"
       method="post">
       <h4>예약취소사유</h4>

       <input type="radio" id="mind" name="cancleReason" value="단순변심" class="custom-radio">
       <label for="mind">단순변심</label>
              
              <input type="radio" id="disaster" name="cancleReason" value="천재지변" class="custom-radio">
              <label for="disaster">천재지변</label>
              
              <input type="radio" id="moved" name="cancleReason" value="이벤트일정 변동" class="custom-radio">
              <label for="moved">이벤트일정 변동</label>
              
              <input type="radio" id="disease" name="cancleReason" value="기타사유" class="custom-radio">
              <label for="disease">기타</label>
              
       <p>
        환불 금액 :
        <fmt:setLocale value="ko_KR" />
        <fmt:formatNumber type="currency"
         value="${reservationDTO.paymentAmount }" />

       </p>
       <div class="btn-box">
        <button onclick="history.back()" type="button" id="btn-back">뒤로가기</button>
        <button type="submit" class="reservation-cancle">예약취소</button>
       </div>
      </form>
     </c:if>
     </article>

     <div class="end-btn"></div>
    </div>
   </div>
  </div>
 </main>
 <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>