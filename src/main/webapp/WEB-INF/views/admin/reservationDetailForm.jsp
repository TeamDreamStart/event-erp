<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 상세보기</title>

<link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
<link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">

<style>
.section-title {
    font-weight: bold;
    font-size: 1.2rem;
    margin-top: 30px;
    margin-bottom: 15px;
    color: #4e73df;
    border-left: 4px solid #4e73df;
    padding-left: 10px;
}

.table th {
    white-space: nowrap;
}
</style>
</head>
<body id="page-top">

<div id="wrapper">
    <jsp:include page="../adminIncludes/header.jsp" />

    <div class="container-fluid">
        <h1 class="h3 mb-4 text-gray-800">예약 상세정보</h1>

        <!-- 예약 기본정보 -->
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">RESERVATION DETAIL</h6>
            </div>
            <div class="card-body">
                <form action="/admin/reservations/${reservationDTO.reservationId}" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label class="form-label fw-bold">예약번호</label>
                            <input class="form-control" type="text" value="${reservationDTO.reservationId}" disabled>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-bold">회원번호</label>
                            <input class="form-control" type="text" value="${reservationDTO.userId}" disabled>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-bold">이벤트번호</label>
                            <input class="form-control" type="text" value="${reservationDTO.eventId}" disabled>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label class="form-label fw-bold">예약일</label>
                            <fmt:formatDate value="${reservationDTO.reservationDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-bold">인원</label>
                            <input class="form-control" type="text" value="${reservationDTO.headCount}" disabled>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-bold">예약 상태</label>
                            <input class="form-control" type="text" value="${reservationDTO.status}" disabled>
                        </div>
                    </div>
<%-- 
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label class="form-label fw-bold">결제금액</label>
                            <input class="form-control" type="text" value="${reservationDTO.paymentAmount}" disabled>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-bold">결제상태</label>
                            <input class="form-control" type="text" value="${reservationDTO.paymentStatus}" disabled>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-bold">결제수단</label>
                            <input class="form-control" type="text" value="${reservationDTO.paymentMethod}" disabled>
                        </div>
                    </div> --%>

                    <div class="text-center">
                        <a href="/admin/reservations" class="btn btn-secondary">목록</a>
                    </div>
                </form>
            </div>
        </div>



    </div>

    <jsp:include page="../adminIncludes/footer.jsp" />
</div>

<script src="/resources/vendor/jquery/jquery.min.js"></script>
<script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/resources/js/sb-admin-2.min.js"></script>
</body>
</html>
