<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700;900&display=swap" rel="stylesheet"/>
<title>마이페이지 - 예약 상세</title>
<style>
body{
background-color: #E5E2DB;
color: #222222;
font-family: 'Montserrat', sans-serif;
font-size: 14px;
font-weight: normal;
margin: 0;
line-height: normal;
    padding: 0 120px 60px;
}
main {
margin-top: 0px;
padding: 0px;
}
.container {
width: 100%;
  margin: 0 auto;
  padding: 0;
}
.section-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}

.section-header h2 {
	font-size: 30px;
	font-weight: 700;
	line-height: 40px;
}
.content-area {
max-width: 893px;
margin: 0px auto;
display: flex;
gap: 22px;
}
.info-box {
	flex: 1;
	background-color: #FFFFFF;
	padding: 32px 40px;
border: 1px solid #D9D9D9;
border-radius: 12px;
margin-bottom: 140px;
}
.info-box h3 {
font-size: 14px;
font-weight: 700;
margin-top: 0;
margin-bottom: 42px;
}
.reservation-status .info-row:last-child{
	padding: 0;
	margin: 0;
}
.info-row {
display: flex;
justify-content: space-between;
padding: 0 0 13px 0;
margin-bottom: 28px;
border-bottom: 1px solid #AFAFAF;
font-size: 14px;
}
.info-row:last-child {
border-bottom: none;
margin-bottom: 0px;
padding-bottom: 0px;
}
.info-label {
color: #222222;
font-weight: 400;
}
.info-value {
font-weight: 500;
}
.status-button {
display: inline-block;
padding: 4px 10px;
border-radius: 15px;
font-size: 14px;
font-weight: 400;
color: #FFFFFF;
}
.status-reservation-complete {
background-color: #1E6CFB; /* 예약완료 버튼 색상 */
}
.status-payment-complete {
background-color: #1E6CFB; /* 결제완료 버튼 색상 */
}
.action-buttons {
margin-top: 110px;
text-align: center;
min-height: 34px;
}
.action-buttons button{
display: block;
width: 100%;
padding: 10px;
margin-bottom: 6px;
border: none;
border-radius: 12px;
font-size: 14px;
font-weight: 700;
cursor: pointer;
text-decoration: none;
text-align: center;
}
.btn-move {
background-color: #888888; /* 이전으로 버튼 색상 */
color: #222222; 
}
.btn-cancel {
background-color: #ED2100; /* 예약 취소 버튼 색상 */
color: #FFFFFF;

}
.cancel-notice {
font-size: 10px;
color: #000000;
margin-top: 13px;
text-align: right;
margin-bottom: 0px;
}

/* 모바일 대응 (필요시) */
@media (max-width: 768px) {
.content-area {
flex-direction: column;
}
}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<main>
<div class="container">
<div class="section-header">
<h2>예약취소</h2>
</div>

<div class="content-area">

<div class="info-box">
    <h3>예약 정보</h3>
    <div class="info-row">
        <span class="info-label">예약번호</span>
        <span class="info-value">CJ123456789</span>
    </div>
    <div class="info-row">
        <span class="info-label">이벤트명</span>
        <span class="info-value">가을 음악 페스티벌</span>
    </div>
    <div class="info-row">
        <span class="info-label">예약자</span>
        <span class="info-value">qwertyuiop</span>
    </div>
    <div class="info-row">
        <span class="info-label">연락처</span>
        <span class="info-value">010-1234-5678</span>
    </div>
    <div class="info-row">
        <span class="info-label">이메일</span>
        <span class="info-value">qwertyuiop@naver.com</span>
    </div>
    <div class="info-row">
        <span class="info-label">이벤트 일시</span>
        <span class="info-value">2025-09-28</span>
    </div>
    <div class="info-row">
        <span class="info-label">장소</span>
        <span class="info-value">서울 올림픽 공원</span>
    </div>
    <div class="info-row">
        <span class="info-label reservation-status">예약 상태</span>
        <span class="info-value">
            <span class="status-button status-reservation-complete">예약완료</span>
        </span>
    </div>
</div>

<div class="info-box">
    <h3>결제 정보</h3>
    <div class="info-row">
        <span class="info-label">결제 방법</span>
        <span class="info-value">카드결제</span>
    </div>
    <div class="info-row">
        <span class="info-label">결제 상태</span>
        <span class="info-value">
            <span class="status-button status-payment-complete">결제완료</span>
        </span>
    </div>
    <div class="info-row">
        <span class="info-label">결제 금액</span>
        <span class="info-value">15,000원</span>
    </div>
    <div class="info-row">
        <span class="info-label">결제 일시</span>
        <span class="info-value">2025-09-20</span>
    </div>

    <div class="action-buttons">
        <button onclick="history.back()" class="btn-move">이전으로</button>
        <button type="submit" class="btn-cancel">예약 취소</button>
        <p class="cancel-notice">※ PG결제 취소 시 2~3일 내 환불 처리됩니다.</p>
    </div>
</div>

</div>
</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>