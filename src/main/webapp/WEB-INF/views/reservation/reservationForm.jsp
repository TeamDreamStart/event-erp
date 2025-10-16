<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700;900&display=swap" rel="stylesheet"/>
<title>reservation Form</title>
<style>
 body{
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
width: 100%;
    margin: 0 auto;
    padding: 0;
}
.section-header {
  position: relative;
  padding-top: 40px;
  margin-bottom: 40px;
  text-align: left;
}
.section-header h2{
  font-size: 20px;
  font-weight: bold;
  user-select: none;
  cursor: default;
  margin: 0;
  padding: 0;
}

.reservation-form {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 1px;
    max-width: 1000px;
    margin: 0 auto;
    background-color: #FAF9F6;
		border: 1px solid #D9D9D9;
		color: #222222;
    overflow: hidden;
}

.event-info {
    padding: 30px;
    min-height: 600px;
    display: flex;
    flex-direction: column;
		position: relative;
		caret-color: transparent;
}
.event-info::after {
    content: '';
    position: absolute;
		top: 50%;
    right: 0; /* 오른쪽 경계에 위치 */
    transform: translateY(-50%); /* 정확한 수직 중앙 정렬 */
    width: 1px;
    height: 95%; /* 원하는 높이 80% 설정 */
    background-color: #222222;
    z-index: 1;
}
.form-input {
    padding: 30px;
    background-color: #FAF9F6;
    min-height: 600px;
    display: flex;
    flex-direction: column;
}

.event-info h4,
.form-input h4 {
    font-size: 16px;
    font-weight: bold;
    margin-top: 0;
    margin-bottom: 32px;
    caret-color: transparent;
}

.event-poster {
    width: 100%;
    text-align: left;
    margin-bottom: 20px;
}
.event-poster img {
    max-width: 200px;
    height: auto;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.event-details {
    margin-bottom: 20px;
}
.event-details p {
    font-size: 14px;
    line-height: 1.4;
    margin-bottom: 8px;
    display: flex;
    align-items: center;
}
.event-details p i {
    margin-right: 8px;
    font-size: 14px;
}
.event-details .event-title {
    font-size: 14px;
    font-weight: bold;
    margin-top: 10px;
    margin-bottom: 15px;
}

.form-group {
    margin-bottom: 25px;
}
.form-group label {
    display: block;
    font-size: 14px;
    font-weight: bold;
    margin-bottom: 4px;
    caret-color: transparent;
}
.form-group input, .form-group select {
    width: 100%;
    padding: 8px 10px;
    box-sizing: border-box;
    font-size: 14px;
		border-radius: 3px;
		border: 1px solid #D9D9D9;
    background-color: #D9D9D9;
}

.member-info-box {
    background-color: #BFD4F9;
		border: 1px solid #8FAFED;
		border-radius: 12px;
    padding: 8px 8px;
    font-size: 14px;
    line-height: 1.0;
    margin-bottom: 44px;
    caret-color: transparent;
}
.member-info-box2 {
    background-color: #FFFFC5;
		border: 1px solid #FAFA8B;
		border-radius: 12px;
    padding: 8px 8px;
    font-size: 14px;
    line-height: 1.0;
    margin-bottom: 44px;
    caret-color: transparent;
}

.total-price {
    display: flex;
    justify-content: space-between;
    font-weight: bold;
    margin-top: 20px;
    padding-top: 20px;
    border-top: 1px dashed #ccc;
    font-size: 14px;
    caret-color: transparent;
}

.agreement {
    margin-top: 30px;
    caret-color: transparent;
}
.agreement label {
    display: block;
    font-size: 12px;
    margin-bottom: 10px;
}

.submit-btn {
    text-align: right;
    margin-top: 20px;
}
.submit-btn button {
    padding: 8px 8px;
    background-color: #BFD4F9;
    border: 1px solid #8FAFED;
    color: #222222;
    font-weight: bold;
    cursor: pointer;
    border-radius: 3px;
}
</style>
</head>

<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
  <main>
  <div class="container">
   <div class="section-header">
    <h2>Reservation</h2>
   </div>
      <div class="reservation-form">
       <div class="event-info">
        <h4>이벤트 정보</h4>
                <div class="event-poster">
                    <img src="/resources/img/event1.jpg" alt="Autumn Music Festival Poster" />
                </div>
                
                <div class="event-details">
                    <p class="event-title">가을 음악 페스티벌</p>
                    <p><i class="fas fa-calendar-alt"></i>• 2025-09-28</p>
                    <p><i class="fas fa-map-marker-alt"></i>• 서울 올림픽 공원</p>
                    <p><i class="fas fa-won-sign"></i>• 15,000원</p>
                </div>
       </div>
       <div class="form-input">
        <h4>예약 정보 입력</h4>
                
                <div class="member-info-box">
                    <p>회원 정보로 예약</p>
                    <p>로그인된 회원 정보를 사용하여 예약합니다.</p>
                </div>
                <!--비회원일 경우-->
                <!-- <div class="member-info-box2">
                    <p>비회원 예약</p>
                    <p>회원가입 후 예약하시면 더 편리하게 이용하실 수 있습니다.</p>
                </div> -->
                <form>
                    <div class="form-group">
                        <label for="name">이름*</label>
                        <input type="text" id="name" required>
                    </div>
                    <div class="form-group">
                        <label for="email">이메일*</label>
                        <input type="email" id="email" required>
                    </div>
                    <div class="form-group">
                        <label for="phone">전화번호*</label>
                        <input type="tel" id="phone" required>
                    </div>
                    <div class="form-group">
                        <label for="payment">결제 방법*</label>
                        <select id="payment" required>
                            <option value="">선택</option>
                            <option value="card">신용카드</option>
                            <option value="transfer">계좌이체</option>
                        </select>
                    </div>

                    <div class="total-price">
                        <span>총 결제 금액</span>
                        <span>15,000원</span>
                    </div>

                    <div class="agreement">
                        <label>
                            <input type="checkbox" required> 개인정보 수집 및 이용에 동의합니다. (필수)
                        </label>
                        <label>
                            <input type="checkbox" required> 예약 취소 및 환불 정책에 동의합니다. (필수)
                        </label>
                    </div>

                    <div class="submit-btn">
                        <button type="submit">예약 완료하기</button>
                    </div>
                </form>
       </div>
    </div>
  </div>
  </main>
  <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>