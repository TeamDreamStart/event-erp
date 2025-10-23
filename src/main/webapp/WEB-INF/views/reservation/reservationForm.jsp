<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700;900&display=swap"
	rel="stylesheet" />

<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/common.css'/>">
<title>reservation Form</title>
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
	margin-bottom: 140px;
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
	right: 0;
	transform: translateY(-50%);
	width: 1px;
	height: 95%;
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

.event-info h4, .form-input h4 {
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
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
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

.form-group #name {
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

/* ---------------------------------------------------- */
/* 사용자 정의 체크박스 스타일 */
.agreement input[type="checkbox"] {
	position: absolute;
	opacity: 0;
	width: 0;
	height: 0;
}

.agreement label {
	display: block;
	position: relative;
	padding-left: 25px; /* 네모 공간 확보 */
	cursor: pointer;
	line-height: 17px;
	font-size: 12px;
	margin-bottom: 10px;
	font-weight: bold;
}

/* 네모 테두리 (체크 안 됨) */
.agreement label::before {
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
.agreement input[type="checkbox"]:checked+label::after {
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
	visibility: hidden;
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
	max-width: 450px;
	border-radius: 12px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
	position: relative;
	text-align: left;
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
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<main>
		<div class="container">
			<div class="section-header">
				<h2>Reservation</h2>
			</div>
			<div class="reservation-form">
				<div class="event-info">
					<h4>이벤트 정보</h4>
					<div class="event-poster">
						<img src="/resources/img/events/event1.jpg"
							alt="Autumn Music Festival Poster" />
					</div>

					<div class="event-details">
						<p class="event-title">${eventDTO.title }</p>
						<p>
							<i class="fas fa-calendar-alt"></i>• ${eventDTO.startDate } ~
							${eventDTO.endDate }
						</p>
						<p>
							<i class="fas fa-map-marker-alt"></i>• ${eventDTO.location }
						</p>
						<c:if test="${eventDTO.price >0}">
							<p>
								<i class="fas fa-won-sign"></i>•
								<fmt:formatNumber value="${eventDTO.price }"
									pattern="###,###,###" />
								원
							</p>
						</c:if>
					</div>
				</div>
				<div class="form-input">
					<h4>예약 정보 입력</h4>

					<div class="member-info-box">
						<p>회원 정보로 예약</p>
						<p>로그인된 회원 정보를 사용하여 예약합니다.</p>
					</div>

					<c:if test="${eventDTO.price >0  || not empty eventDTO.price}">
						<form action="/events/${eventDTO.eventId }/reservations/payment"
							method="get" id="paymentForm">
					</c:if>

					<c:if test="${eventDTO.price == 0  || empty eventDTO.price}">
						<form action="/events/${eventDTO.eventId }/reservations"
							method="post" id="paymentForm">
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
					</c:if>


					<div class="form-group">
						<label for="people">인원수*</label> <input type="number" id="people"
							min="1" max="10" value="1" name="headCount"
							style="margin-bottom: 20px;" required readonly>
					</div>
					<div class="form-group">
						<label for="name">이름*</label> <input type="text" id="name"
							value="${userDTO.name }" required readonly>
					</div>
					<div class="form-group">
						<label for="email">이메일*</label> <input type="text" id="email"
							value="${userDTO.email }" required readonly> <span
							id="email-message" class="error-message"></span>
					</div>
					<div class="form-group">
						<label for="phone">전화번호*</label> <input type="text" id="phone"
							value="${userDTO.phone }" required maxlength="13" readonly>
						<span id="phone-message" class="error-message"></span>
					</div>
					<c:if test="${eventDTO.price >0}">
						<div class="total-price">
							<span>총 결제 금액</span> <span id="totalAmount"><fmt:formatNumber
									value="${eventDTO.price }" pattern="###,###,###" />원</span>
						</div>
					</c:if>

					<div class="agreement">
						<input type="checkbox" id="agree1" required> <label
							for="agree1">개인정보 수집 및 이용에 동의합니다. (필수)</label> <input
							type="checkbox" id="agree2" required> <label for="agree2">예약
							취소 및 환불 정책에 동의합니다. (필수)</label>
					</div>
					<c:if test="${eventDTO.price >0}">
						<div class="submit-btn">
							<button type="button" onclick="requestPay()">결제하기</button>
						</div>
					</c:if>
					<c:if test="${eventDTO.price ==0 || empty eventDTO.price}">
						<div class="submit-btn">
							<button type="submit" id="reservationBtn">예약하기</button>
						</div>
						<script>
document.getElementById('reservationBtn').addEventListener('click', function(e){
    const proceed = confirm('해당 이벤트는 결제 없이 바로 예약됩니다.\n바로 예약하시겠습니까?'); //확인 -> 예약 / 취소 -> 이벤트디테일
    if(!proceed){
        e.preventDefault(); // 폼 제출 막기
        alert("예약이 취소되었습니다.");
        window.location.href = "/events/"+${eventDTO.eventId}; //이벤트 디테일 페이지로 이동
    }
});
</script>
					</c:if>


					<!-- 결제시 -->
					<c:if test="${eventDTO.price >0  || not empty eventDTO.price}">
						<input type="hidden" name="userId" value="${userDTO.userId }">
						<input type="hidden" id="impUid" name="impUid" />
						<input type="hidden" id="method" name="method" />
						<input type="hidden" id="status" name="status" />
						<input type="hidden" id="amount" name="amount" />
						<input type="hidden" id="approveNo" name="approveNo" />
						<input type="hidden" id="pgTid" name="pgTid" />
						<input type="hidden" id="memo" name="memo" />
					</c:if>
					</form>
					<script>
     const headCountInput = document.querySelector('input[name="headCount"]');
     const totalAmountSpan = document.getElementById('totalAmount');
     const pricePerPerson = ${eventDTO.price};

     // headCount가 바뀔 때 총 금액 계산
     function updateTotalAmount() {
       let headCount = parseInt(headCountInput.value) || 1;
       if (headCount < 1) headCount = 1;
       if (headCount > 10) headCount = 10;
       const total = pricePerPerson * headCount;
       totalAmountSpan.textContent = total.toLocaleString() + "원";
       return total;
     }

     // 초기값 반영
     let totalAmount = updateTotalAmount();

     // 입력 이벤트
     headCountInput.addEventListener('input', () => {
      totalAmount = updateTotalAmount();
     });
     
IMP.init("imp06753075");

function requestPay() {
    const agree1 = document.getElementById('agree1');
    const agree2 = document.getElementById('agree2');
    
    if (!agree1.checked || !agree2.checked) {
        alert("모든 필수 약관에 동의해야 합니다.");
        return;
    }

 IMP.request_pay({
  pg: "html5_inicis",
  pay_method: "card",
  merchant_uid: "order-" + new Date().getTime(),
  name: "${eventDTO.title}",
  amount: totalAmount,
  buyer_email: "${userDTO.email}",
  buyer_name: "${userDTO.name}",
  buyer_tel: "${userDTO.phone}",
  buyer_addr: "${eventDTO.location}",
  buyer_postcode: "00000"
 }, function(rsp) {
  if (rsp.success) {
   alert("결제 성공! imp_uid=" + rsp.imp_uid);
   console.log("결제 응답:", rsp);

   // ✅ PaymentDTO 필드 매핑
   $("#impUid").val(rsp.imp_uid);
   $("#method").val(rsp.pay_method.toUpperCase());
   $("#status").val("PAID");
   $("#amount").val(rsp.paid_amount);
   $("#approveNo").val(rsp.apply_num);
   $("#pgTid").val(rsp.pg_tid);

   // 기타 정보는 memo로 JSON 문자열 저장
   const memoObj = {
    buyer_name: rsp.buyer_name,
    buyer_email: rsp.buyer_email,
    buyer_tel: rsp.buyer_tel,
    buyer_addr: rsp.buyer_addr,
    buyer_postcode: rsp.buyer_postcode,
    card_name: rsp.card_name,
    card_number: rsp.card_number,
    card_quota: rsp.card_quota,
    currency: rsp.currency,
    pg_provider: rsp.pg_provider,
    pg_type: rsp.pg_type,
    receipt_url: rsp.receipt_url,
    name: rsp.name
   };
   $("#memo").val(JSON.stringify(memoObj));

   console.log("폼 submit 직전 실행됨");
   $("#paymentForm").submit();
  } else {
   alert("결제 실패: " + rsp.error_msg);
  }
 });
}
</script>
				</div>
			</div>
		</div>
	</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
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
  function isValidPhone(콜) {
    // 하이픈 포함/미포함 모두 검사
    const phoneRegex = /^01[016789]-?\d{3,4}-?\d{4}$/; 
    return phoneRegex.test(콜);
  }
  
  // 메시지 표시 함수
  function showMessage(element, message, isError) {
    element.textContent = message;
    element.style.color = isError ? 'red' : 'green';
    element.style.visibility = message ? 'visible' : 'hidden'; 
  }

  phoneInput.addEventListener('input', function(e) {
    const value = e.target.value.replace(/[^0-9]/g, '');
    let result = '';

    // 010-1234-5678 형식으로 자동 포맷팅
    if (value.length < 4) {
      result = value;
    } else if (value.length < 8) {
      result = value.substring(0, 3) + '-' + value.substring(3);
    } else if (value.length < 11) {
      result = value.substring(0, 3) + '-' + value.substring(3, 7) + '-' + value.substring(7);
    } else {
      result = value.substring(0, 3) + '-' + value.substring(3, 7) + '-' + value.substring(7, 11);
    }
    e.target.value = result;
    
    // 입력할 때마다 유효성 검사 실행
    validateField(phoneInput, phoneMessage, isValidPhone, '전화번호 형식이 올바르지 않습니다. (예: 010-1234-5678)');
  });
  
  function validateField(inputElement, messageElement, validationFn, errorMessage) {
    const value = inputElement.value.trim();
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

    // required 필드 확인
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
    modalName.textContent = nameInput.value.trim();
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
        
        // 복사 완료 후 버튼 텍스트 변경
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