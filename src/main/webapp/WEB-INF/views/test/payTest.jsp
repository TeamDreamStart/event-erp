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

</head>
<body>
<script>
    const result = '${empty result ? "" : result}';
    const resultType = '${empty resultType ? "" : resultType}';

    if (result === 'success') {
        alert(`성공적으로 ${resultType}되었습니다.`);
    } else if (result === 'fail') {
        alert(`${resultType}이(가) 실패하였습니다.`);
    }
</script>
	<h1>결제 테스트</h1>
	<table border="1" cellpadding="5" cellspacing="0">
		<thead>
			<tr>
				<th>ID</th>
				<th>제목</th>
				<th>설명</th>
				<th>위치</th>
				<th>시작일</th>
				<th>종료일</th>
				<th>정원</th>
				<th>상태</th>
				<th>가격</th>
				<th>카테고리</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>${eventDTO.eventId}</td>
				<td>${eventDTO.title}</td>
				<td>${eventDTO.description}</td>
				<td>${eventDTO.location}</td>
				<td>${eventDTO.startDate}</td>
				<td>${eventDTO.endDate}</td>
				<td>${eventDTO.capacity}</td>
				<td>${eventDTO.status}</td>
				<td>${eventDTO.price}${eventDTO.currency}</td>
				<td>${eventDTO.category}</td>
			</tr>
		</tbody>
	</table>
	<button onclick="requestPay()">결제하기</button>
	<p>form</p>
<form id="paymentForm" action="${pageContext.request.contextPath}/payment/complete" method="post">
    <input type="text" id="impUid" name="impUid" />
    <input type="hidden" id="merchantUid" name="pgTid" />
    <input type="hidden" id="amount" name="amount" />
    <input type="hidden" id="method" name="method" />
    <input type="hidden" id="status" name="status" />
    <input type="hidden" id="approveNo" name="approveNo" />
    <input type="hidden" id="memo" name="memo" />
</form>

<script>
IMP.init("imp06753075");

function requestPay() {
    IMP.request_pay({
        pg: "html5_inicis",
        pay_method: "card",
        merchant_uid: "order-" + new Date().getTime(),
        name: "${eventDTO.title}",
        amount: ${eventDTO.price},
        buyer_email: "test@example.com",
        buyer_name: "홍길동",
        buyer_tel: "010-1234-5678",
        buyer_addr: "${eventDTO.location}",
        buyer_postcode: "00000"
    }, function(rsp) {
        if(rsp.success){
            alert("결제 성공! imp_uid=" + rsp.imp_uid);

            // hidden input에 값 세팅 후 form submit
            $("#impUid").val(rsp.imp_uid);
            $("#merchantUid").val(rsp.merchant_uid);
            $("#amount").val(rsp.paid_amount);
            $("#method").val(rsp.pay_method.toUpperCase());
            $("#status").val(rsp.success ? "PAID" : "FAILED");
            $("#approveNo").val(rsp.apply_num);
            $("#pgTid").val(rsp.pg_tid);

            // 나머지는 memo로
            var memoObj = {
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

            $("#paymentForm").submit();
        } else {
            alert("결제 실패: " + rsp.error_msg);
        }
    });
}
</script>
	<!-- <script>
//초기화
IMP.init("imp06753075"); //고객사 식별코드

function requestPay() {
	  IMP.request_pay(
	    {
	      pg: "html5_inicis",
	      pay_method: "card",
	      merchant_uid: "order-" + new Date().getTime(),
	      name: "${eventDTO.title}",
	      amount: ${eventDTO.price},
	      buyer_email: "test@example.com",
	      buyer_name: "홍길동",
	      buyer_tel: "010-1234-5678",
	      buyer_addr: "${eventDTO.location}",
	      buyer_postcode: "00000"
	    },
	    function (rsp) {
	      if (rsp.success) {
	        alert("결제 성공! imp_uid=" + rsp.imp_uid);

	        // Ajax로 결제정보 전송
	        $.ajax({
	          url: "${pageContext.request.contextPath}/payment/complete",
	          type: "POST",
	          contentType: "application/json",
	          data: JSON.stringify({
	            impUid: rsp.imp_uid,
	            merchantUid: rsp.merchant_uid,
	            paidAmount: rsp.paid_amount,
	            payMethod: rsp.pay_method,
	            pgTid: rsp.pg_tid,
	            status: rsp.success ? "paid" : "failed",
	            approveNo: rsp.apply_num,
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
	          }),
	          dataType: "json",
	          success: function(data) {
	            if (data.result === "success") {
	              alert("결제정보 저장 완료!");
	            } else {
	              alert("서버 저장 실패");
	            }
	          },
	          error: function(xhr, status, error) {
	            console.error(error);
	            alert("Ajax 호출 실패");
	          }
	        });

	      } else {
	        alert("결제 실패: " + rsp.error_msg);
	      }
	    }
	  );
	}
</script> -->
</body>
</html>
