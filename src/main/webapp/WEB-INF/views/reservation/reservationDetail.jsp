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
body {
	background-color: light brown;
}

#wrap {
	display: flex;
	justify-content: center;
	gap: 21px;
}

.box {
	width: 436px;
	height: 532px;
	border: 1px solid lightgray;
	border-radius: 15px;
}
</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
	</header>

	<!-- 	private Long reservationId;
    private String eventTitle;
    private Timestamp reservationDate;
    private String reservationStatus;
    private Integer headcount;
    private BigDecimal paymentAmount;
    private String paymentStatus;
    private String paymentMethod; -->
	<h3>예약 상세정보</h3>
	<div id="wrap">

		<div class="box">
			<div>
				<div>예약번호</div>
				<div>${reservationDTO.reservationId}</div>
			</div>
			<div>
				<div>이벤트명</div>
				<div>${reservationDTO.eventTitle}</div>
			</div>
			<div>
				<div>예약자명</div>
				<div>
					DTO수정필요
					<%-- ${reservationDTO.userName} --%>
				</div>
			</div>
			<div>
				<div>인원</div>
				<div>${reservationDTO.headcount}</div>
			</div>
			<div>
				<div>예약 상태</div>
				<div>${reservationDTO.reservationStatus}</div>
			</div>
		</div>
		<div class="box">
			<div>
				<div>결제방법</div>
				<div>${reservationDTO.paymentMethod}</div>
			</div>
			<div>
				<div>결제상태</div>
				<div>${reservationDTO.paymentStatus}</div>
			</div>
			<div>
				<div>결제금액</div>
				<div>
					<fmt:formatNumber value="${reservationDTO.paymentAmount}"
						pattern="###,###,###" />
					원
				</div>
			</div>
			<div>
				<div>예약/결제일</div>
				<div>
					<fmt:formatDate value="${reservationDTO.reservationDate}"
						pattern="yyyy-MM-dd HH:mm:ss" />
				</div>
			</div>

			<div>
				<button onclick="history.back()">이전으로</button>
				<button onclick="submit">예약취소</button>
			</div>
		</div>
	</div>

	<footer>
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</footer>

</body>
</html>