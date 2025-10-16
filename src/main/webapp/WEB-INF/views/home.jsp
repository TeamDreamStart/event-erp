<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700;900&display=swap" rel="stylesheet"/>
<title>Reservation Check</title>
<style>
body {
    background-color: #E5E2DB;
    color: #222222;
    font-family: 'Montserrat', sans-serif;
    font-size: 16px;
    font-weight: normal;
    margin: 0;
    padding: 0 120px 60px;
    line-height: 1;
}

main {
    margin-top: 0;
    padding: 0;
}

.container {
    max-width: 896px;
    margin: 0 auto;
    padding: 0;
}

.section-header {
    display: flex;
    align-items: center;
    margin-bottom: 40px; /* 제목과 내용 사이 간격 */
}

.section-header h2 {
    font-size: 30px;
    font-weight: 700;
    line-height: 40px;
}

.reservation-title a {
    text-decoration: none;
    color: #222222;
    margin-right: 10px; /* 이미지의 화살표와 텍스트 사이 간격 */
    font-size: 24px;
}

/* 예약 현황 섹션 (상단 흰색 박스) */
.reservation-status-box {
    background-color: #FFFFFF;
    padding: 33px;
		border: 1px solid #D9D9D9;
    border-radius: 12px;
    margin-bottom: 69px;
		max-height: 254px;
}

.status-cards {
    display: flex;
    justify-content: space-between;
    gap: 26px;
    margin-bottom: 48px;
}

.card {
    flex: 1;
    height: 106px;
    border-radius: 12px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    font-size: 14px;
    font-weight: 700;
    color: #222222;
    padding: 10px;
    box-sizing: border-box;
}

.card h3 {
    font-size: 20px;
    margin: 0;
    line-height: 1;
}

.card.confirmed {
    background-color: #BFD4F9; /* 연한 파란색 */
}

.card.cancelled {
    background-color: #F2F0EF; /* 연한 회색 */
}

.card.future {
    background-color: #FAF9D9; /* 연한 노란색 */
}

.status-buttons {
    display: flex;
    justify-content: center;
    gap: 80px;
}

.status-buttons a {
    text-decoration: none;
    font-size: 14px;
    padding: 8px 15px;
    border-radius: 8px;
    font-weight: 700;
    cursor: pointer;
    transition: background-color 0.2s;
    line-height: 1;
}

.status-buttons .detail-view {
    background-color: #D9D9D9;
    color: #222222;
}

.status-buttons .unconfirmed-view {
    background-color: #BFD4F9;
    color: #222222;
}


/* 예약 조회 섹션 (하단 흰색 박스) */
.reservation-query-box {
    background-color: #FFFFFF;
		border: 1px solid #D9D9D9;
    padding: 30px;
    border-radius: 12px;
		margin-bottom: 140px;
}

.query-form label {
    display: block;
    font-size: 14px;
    font-weight: 700;
    margin-bottom: 8px;
    margin-top: 27px;
}

.query-form label:first-child {
    margin-top: 0;
}

.query-form input[type="text"] {
    width: 100%;
    padding: 8px;
    border-radius: 3px;
    border: 1px solid #AFAFAF;
    font-size: 14px;
    box-sizing: border-box;
}

.query-form .reservation-id {
    background-color: #F2F0EF;
    border: 1px solid #8FAFED; /* 이미지의 파란색 테두리 */
}

.query-form .phone-number {
    background-color: #F2F0EF; /* 이미지의 연한 회색 배경 */
}

.query-form button {
    margin-top: 26px;
    padding: 8px 10px;
    border: none;
    border-radius: 3px;
    background-color: #BFD4F9;
    color: #222222;
    font-weight:700;
    font-size: 14px;
    cursor: pointer;
    border: 1px solid #8FAFED;
}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<main>
<div class="container">
    <div class="section-header">
            <h2>Reservation Check</h2>
    </div>

    <div class="reservation-status-box">
        <div class="status-cards">
            <div class="card confirmed">
                <h3>0</h3>
                <span>확정된 예약</span>
            </div>
            <div class="card cancelled">
                <h3>0</h3>
                <span>취소된 예약</span>
            </div>
            <div class="card future">
                <h3>0</h3>
                <span>향후 예약 수</span>
            </div>
        </div>
        
        <div class="status-buttons">
            <a href="#" class="detail-view">상세 예약 내역 보기</a>
            <a href="#" class="unconfirmed-view">비회원 예약 조회</a>
        </div>
    </div>
    
    <div class="reservation-query-box">
        <form class="query-form" action="#" method="post">
            
            <label for="reservationId">예약번호*</label>
            <input type="text" id="reservationId" name="reservationId" class="reservation-id" placeholder="예약번호를 입력하세요. (예, C2024040100)">
            
            <label for="phoneNumber">전화번호*</label>
            <input type="text" id="phoneNumber" name="phoneNumber" class="phone-number" placeholder="">
            
            <button type="submit">예약 조회하기</button>
        </form>
    </div>
</div>
</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>