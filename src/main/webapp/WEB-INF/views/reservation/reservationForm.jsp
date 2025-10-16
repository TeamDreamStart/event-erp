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
  height: 95%; /* 원하는 높이 95% 설정 */
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
  margin-bottom: 12px;
}
.form-group#payment, #name{
    margin-bottom: 20px;
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
  padding: 8px 20px;
  font-size: 14px;
  line-height: 1.0;
  margin-bottom: 44px;
  caret-color: transparent;
  font-weight: bold;
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
/* 추가된 에러 메시지 스타일 */
.error-message {
    display: block;
    color: red;
    font-size: 11px;
    margin-top: 4px;
    height: 15px;
    text-align: left; 
    user-select: none;
    cursor: default;
    visibility: hidden; /* 초기에는 숨김 처리 */
}
.modal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
}
.modal-content {
    background-color: #FAF9F6; 
    margin: 20% auto;
    padding: 20px;
    width: 90%;
    max-width: 450px; /* 이미지와 유사한 폭으로 조정 */
    border-radius: 12px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
    position: relative;
    text-align: left; /* 텍스트는 좌측 정렬 */
}
.modal-body {
    padding: 10px 0;
}
.modal-body p {
    font-size: 16px;
    color: #222222;
    margin-bottom: 8px;
    line-height: 1.4;
}
.modal-btn {
    float: right;
    padding: 5px 10px;
    background-color: transparent;
    border: none; 
    color: #08f;
    font-weight: bold;
    cursor: pointer;
    border-radius: 4px;
    margin-top: 10px;
    font-size: 14px;
}
.modal-body::after {
    content: "";
    display: table;
    clear: both;
}
.close-btn {
    display: none;
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
          <img src="/resources/img/events/event1.jpg" alt="Autumn Music Festival Poster" />
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
                        <form>
          <div class="form-group">
            <label for="name">이름*</label>
            <input type="text" id="name" required>
                                  </div>
          <div class="form-group">
            <label for="email">이메일*</label>
            <input type="text" id="email" required>
                        <span id="email-message" class="error-message"></span>
          </div>
          <div class="form-group">
            <label for="phone">전화번호*</label>
            <input type="text" id="phone" required maxlength="13">
                        <span id="phone-message" class="error-message"></span>
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
 <div id="reservation-modal" class="modal">
    <div class="modal-content">
        <span class="close-btn">&times;</span>
        <div class="modal-body">
            <h4>예약이 완료되었습니다!</h4>
            <p>예약번호: G186194572605</p>
            <p>비회원 예약 조회 시 예약번호와 전화번호를 입력해 주세요.</p>
            <button id="modal-confirm-btn" class="modal-btn">닫기</button>
        </div>
    </div>
</div>
<script>
document.addEventListener('DOMContentLoaded', function() {
    const form = document.querySelector('.form-input form');
    const emailInput = document.getElementById('email');
    const phoneInput = document.getElementById('phone');
    const emailMessage = document.getElementById('email-message');
    const phoneMessage = document.getElementById('phone-message');

    // 이메일 유효성 검사
    function isValidEmail(email) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    }

    // 전화번호 유효성 검사 (000-0000-0000 형식 검사)
    function isValidPhone(phone) {
        // 하이픈 포함/미포함 모두 검사
        const phoneRegex = /^01[016789]-?\d{3,4}-?\d{4}$/; 
        return phoneRegex.test(phone);
    }
    
    // 메시지 표시 함수
    function showMessage(element, message, isError) {
        element.textContent = message;
        element.style.color = isError ? 'red' : 'green';
        element.style.visibility = message ? 'visible' : 'hidden'; 
    }

    phoneInput.addEventListener('input', function(e) {
        const value = e.target.value.replace(/[^0-9]/g, ''); // 숫자 외 모두 제거
        let result = '';

        // 010-1234-5678 형식으로 자동 포맷팅
        if (value.length < 4) {
            result = value;
        } else if (value.length < 8) {
            result = value.substring(0, 3) + '-' + value.substring(3);
        } else if (value.length < 11) {
             // 000-000-0000 (3자리, 3자리, 4자리) 또는 000-0000-0000 (3자리, 4자리, 4자리)
            result = value.substring(0, 3) + '-' + value.substring(3, 7) + '-' + value.substring(7);
        } else {
            // 11자리 (000-0000-0000)
            result = value.substring(0, 3) + '-' + value.substring(3, 7) + '-' + value.substring(7, 11);
        }
        e.target.value = result;
        
        // 입력할 때마다 유효성 검사 실행 (실시간 피드백)
        validateField(phoneInput, phoneMessage, isValidPhone, '전화번호 형식이 올바르지 않습니다. (예: 010-1234-5678)');
    });
    
    function validateField(inputElement, messageElement, validationFn, errorMessage) {
        const value = inputElement.value.trim();
        // required 속성이 있으므로 비어있는 것은 제출 시에만 경고
        if (value === "") {
            showMessage(messageElement, '', false); 
            return false;
        } else if (!validationFn(value)) {
            showMessage(messageElement, errorMessage, true);
            return false;
        } else {
            showMessage(messageElement, '', false); 
            return true;
        }
    }
    
    // 이메일 입력 필드에서 포커스를 잃었을 때 (blur) 유효성 검사
    emailInput.addEventListener('blur', function() {
        validateField(emailInput, emailMessage, isValidEmail, '올바른 이메일 형식이 아닙니다. 다시 확인해 주세요.');
    });

    // 전화번호 입력 필드에서 포커스를 잃었을 때 (blur) 유효성 검사
    phoneInput.addEventListener('blur', function() {
        validateField(phoneInput, phoneMessage, isValidPhone, '전화번호 형식이 올바르지 않습니다. (예: 010-1234-5678)');
    });


    // 폼 제출(submit) 시 최종 유효성 검사
    form.addEventListener('submit', function(e) {
        const isEmailValid = validateField(emailInput, emailMessage, isValidEmail, '이메일 형식이 올바르지 않습니다.');
        const isPhoneValid = validateField(phoneInput, phoneMessage, isValidPhone, '전화번호 형식이 올바르지 않습니다. (예: 010-1234-5678)');

        // required 필드 확인 (이메일과 전화번호가 비어있으면 required 메시지를 보여줌)
        const isEmailEmpty = emailInput.value.trim() === "";
        const isPhoneEmpty = phoneInput.value.trim() === "";
        
        if (isEmailEmpty) {
            showMessage(emailMessage, '이메일을 입력해 주세요.', true);
        }
         if (isPhoneEmpty) {
            showMessage(phoneMessage, '전화번호를 입력해 주세요.', true);
        }

        // 유효하지 않거나 비어있는 필드가 있으면 제출 막음
        if (!isEmailValid || !isPhoneValid || isEmailEmpty || isPhoneEmpty) {
            e.preventDefault(); 
        }
    });
// 모달 관련 변수 추가
    const modal = document.getElementById('reservation-modal');
    const closeBtn = document.querySelector('.close-btn');
    const confirmBtn = document.getElementById('modal-confirm-btn');
    const modalName = document.getElementById('modal-name');
    
    // 복사 관련 변수 추가
    const copyBtn = document.getElementById('copy-reservation-btn');
    const reservationNumberSpan = document.getElementById('reservation-number');

    // 모달 닫기 함수
    function closeModal() {
        modal.style.display = 'none';
    }

    // 모달 열기 함수 (예약 성공 시 호출)
    function showModal() {
        modalName.textContent = nameInput.value.trim(); // 예약자 이름 표시
        modal.style.display = 'block';
    }

    // =======================================================
    // 예약번호 복사 기능
    // =======================================================
    if (copyBtn) {
        copyBtn.addEventListener('click', function() {
            const reservationNumber = reservationNumberSpan.textContent;
            
            // 클립보드에 복사하는 최신 API 사용
            navigator.clipboard.writeText(reservationNumber).then(() => {
                alert('예약번호 (' + reservationNumber + ')가 클립보드에 복사되었습니다.');
                
                // 복사 완료 후 버튼 텍스트 변경 (선택 사항)
                copyBtn.textContent = '복사 완료!';
                setTimeout(() => {
                    copyBtn.textContent = '예약번호 복사';
                }, 2000);
            }).catch(err => {
                // 복사 실패 시
                console.error('클립보드 복사 실패:', err);
                alert('복사 중 오류가 발생했습니다.');
            });
        });
    }

    // 모달 닫기 이벤트 리스너
    closeBtn.addEventListener('click', closeModal);
    confirmBtn.addEventListener('click', closeModal);

    // 모달 외부 클릭 시 닫기
    window.addEventListener('click', function(event) {
        if (event.target === modal) {
            closeModal();
        }
    });
});
</script>
</body>
</html>