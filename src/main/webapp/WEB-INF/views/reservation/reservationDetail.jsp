<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.reservation-card {
    max-width: 600px;
    margin: 40px auto;
    padding: 25px 30px;
    border: 1px solid #ccc;
    border-radius: 8px;
    font-family: Arial, sans-serif;
    background-color: #f9f9f9;
}

.reservation-card h3 {
    text-align: center;
    margin-bottom: 25px;
    color: #333;
}

.info-row {
    display: flex;
    margin-bottom: 12px;
}

.info-label {
    width: 120px;
    font-weight: bold;
    color: #555;
}

.info-value {
    flex: 1;
    color: #333;
}

.button-row {
    text-align: center;
    margin-top: 25px;
}

.back-button {
    text-decoration: none;
    padding: 8px 16px;
    background-color: #4e73df;
    color: white;
    border-radius: 4px;
    transition: background-color 0.2s;
}

.back-button:hover {
    background-color: #2e59d9;
}
</style>
</head>
<body>
내 예약내역인거임
<!-- 	private Long reservationId;
    private String eventTitle;
    private Timestamp reservationDate;
    private String reservationStatus;
    private Integer headcount;
    private BigDecimal paymentAmount;
    private String paymentStatus;
    private String paymentMethod; -->
<div class="reservation-card">
    <h3>예약 상세정보</h3>

    <div class="info-row">
        <div class="info-label">예약번호</div>
        <div class="info-value">${reservationDTO.reservationId}</div>
    </div>
<%--     <div class="info-row">
        <div class="info-label">회원번호</div>
        <div class="info-value">${reservationDTO.userId}</div>
    </div> --%>
    <div class="info-row">
        <div class="info-label">이벤트명</div>
        <div class="info-value">${reservationDTO.eventTitle}</div>
    </div>

    <div class="info-row">
        <div class="info-label">예약일</div>
        <div class="info-value">
            <fmt:formatDate value="${reservationDTO.reservationDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
        </div>
    </div>
    <div class="info-row">
        <div class="info-label">인원</div>
        <div class="info-value">${reservationDTO.headcount}</div>
    </div>
    <div class="info-row">
        <div class="info-label">예약 상태</div>
        <div class="info-value">${reservationDTO.reservationStatus}</div>
    </div>

     <div class="info-row">
        <div class="info-label">결제금액</div>
        <div class="info-value">${reservationDTO.paymentAmount}</div>
    </div>
    <div class="info-row">
        <div class="info-label">결제상태</div>
        <div class="info-value">${reservationDTO.paymentStatus}</div>
    </div>
    <div class="info-row">
        <div class="info-label">결제수단</div>
        <div class="info-value">${reservationDTO.paymentMethod}</div>
    </div>

    <div class="button-row">
        <a href="/admin/reservations" class="back-button">목록으로 돌아가기</a>
    </div>
</div>



</body>
</html>