<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>포트원 결제 테스트</title>

<!-- ✅ jQuery 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
</head>

<body>
<script type="text/javascript">
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
			<td>${event.eventId}</td>
			<td>${event.title}</td>
			<td>${event.description}</td>
			<td>${event.location}</td>
			<td>${event.startDate}</td>
			<td>${event.endDate}</td>
			<td>${event.capacity}</td>
			<td>${event.status}</td>
			<td>${event.price}${event.currency}</td>
			<td>${event.category}</td>
		</tr>
	</tbody>
</table>

<br/>
<button onclick="requestPay()">결제하기</button>

<!-- ✅ form -->
<form id="paymentForm" action="${pageContext.request.contextPath}/payment/complete-pay" method="get">
	
	<!-- reservation -->
	<label>예약</label>
	<input type="number" value="1" min="1" max="10" name="headCount">
	<input type="text" name="eventId" value="${event.eventId }">
	<input type="text" name="userId"value="<sec:authentication property='principal.userId' />"readonly />
	
	<!-- payment -->
	<label>결제</label>
	<input type="hidden" id="impUid" name="impUid" />
	<input type="hidden" id="method" name="method" />
	<input type="hidden" id="status" name="status" />
	<input type="hidden" id="amount" name="amount" />
	<input type="hidden" id="approveNo" name="approveNo" />
	<input type="hidden" id="pgTid" name="pgTid" />
	<input type="hidden" id="memo" name="memo" />
</form>

<script>
IMP.init("imp06753075");

function requestPay() {
  IMP.request_pay({
    pg: "html5_inicis",
    pay_method: "card",
    merchant_uid: "order-" + new Date().getTime(),
    name: "${event.title}",
    amount: ${event.price},
    buyer_email: "test@example.com",
    buyer_name: "홍길동",
    buyer_tel: "010-1234-5678",
    buyer_addr: "${event.location}",
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
</body>
</html>
