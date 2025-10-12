<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>포트원 결제 테스트</title>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script>
//초기화
IMP.init("imp06753075"); //고객사 식별코드

function requestPay() {
  IMP.request_pay(
    {
      pg: "html5_inicis",
      pay_method: "card",
      merchant_uid: "order-" + new Date().getTime(),
      name: "${event.title}",
      amount: ${price},
      buyer_email: "test@example.com",
      buyer_name: "홍길동",
      buyer_tel: "010-1234-5678",
      buyer_addr: "${event.location}",
      buyer_postcode: "00000"
    },
    function (rsp) {
      if (rsp.success) {
        alert("결제 성공! imp_uid=" + rsp.imp_uid);

        // 결제정보 서버로 전송
        fetch("/payment/complete", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            impUid: rsp.imp_uid,
            merchantUid: rsp.merchant_uid,
            paidAmount: rsp.paid_amount,
            payMethod: rsp.pay_method,  // 'card', 'kakao', 'naver' 등
            pgTid: rsp.pg_tid,
            status: rsp.status, // paid, failed 등
            paidAt: rsp.paid_at, // UNIX timestamp
            approveNo: rsp.apply_num,
            memo: rsp.name
          })
        })
          .then(res => res.json())
          .then(data => {
            if (data.result === "success") {
              alert("결제정보 저장 완료!");
            } else {
              alert("서버 저장 실패");
            }
          });
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
	${principal.name }
	<sec:authentication property="principal.name" />
	<button onclick="requestPay()">결제하기</button>
</body>
</html>
