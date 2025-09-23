<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>포트원 결제 테스트</title>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script>
  // SDK 초기화
  IMP.init("imp06753075"); // 포트원 고객사 식별코드

  function requestPay() {
	    IMP.request_pay(
	      {
	        pg: "html5_inicis",
	        pay_method: "card",
	        merchant_uid: "order-" + new Date().getTime(),
	        name: "${event.title}",     // 이벤트 제목
	        amount: ${price},           // 만원
	        buyer_email: "test@example.com",   // 임시 값
	        buyer_name: "홍길동",               // 임시 값
	        buyer_tel: "010-1234-5678",        // 임시 값
	        buyer_addr: "${event.location}",   // 이벤트 장소를 주소로
	        buyer_postcode: "00000"            // 임시 우편번호
	      },
	      function (rsp) {
	        if (rsp.success) {
	          alert("결제 성공! imp_uid=" + rsp.imp_uid);
	        } else {
	          alert("결제 실패: " + rsp.error_msg);
	        }
	      }
	    );
	  }
</script>
</head>
<body>
	<h1>결제 테스트</h1>
	<p>이벤트명: ${event.title}</p>
	<p>장소: ${event.location}</p>
	<p>가격: ${price}원</p>
	<button onclick="requestPay()">결제하기</button>
</body>
</html>
