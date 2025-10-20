<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<%
    // Memo(JSON 문자열)을 Map 으로 변환
    java.util.Map<String, Object> memoMap = null;
    try {
        if (request.getAttribute("reservationDTO") != null) {
            String memoJson = ((kr.co.dreamstart.dto.ReservationJoinDTO)request.getAttribute("reservationDTO")).getMemo();
            if (memoJson != null && !memoJson.isEmpty()) {
                ObjectMapper mapper = new ObjectMapper();
                memoMap = mapper.readValue(memoJson, java.util.Map.class);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
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

.custom-label {
    font-weight: 600;
    color: #4e73df;
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

                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label class="custom-label">예약번호</label>
                            <input class="form-control" type="text" value="${reservationDTO.reservationId}" disabled>
                        </div>
                        <div class="col-md-4">
                            <label class="custom-label">예약일</label>
                            <span class="form-control">
                                <fmt:formatDate value="${reservationDTO.reservationDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </span>
                        </div>
                        <div class="col-md-4">
                            <label class="custom-label">예약상태</label>
                            <input class="form-control" type="text" value="${reservationDTO.reservationStatus}" disabled>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label class="custom-label">이벤트번호</label>
                            <input class="form-control" type="text" value="${reservationDTO.eventId}" disabled>
                        </div>
                        <div class="col-md-4">
                            <label class="custom-label">이벤트명</label>
                            <input class="form-control" type="text" value="${reservationDTO.eventTitle}" disabled>
                        </div>
                        <div class="col-md-4">
                            <label class="custom-label">이벤트 바로가기</label>
                            <button class="form-control btn btn-outline-primary"
                                onclick="location.href='/admin/event-manage/${reservationDTO.eventId}'">바로가기</button>
                        </div>
                    </div>

                    <!-- 사용자 정보 -->
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label class="custom-label">회원번호</label>
                            <input class="form-control" type="text" value="${reservationDTO.userId}" disabled>
                        </div>
                        <div class="col-md-4">
                            <label class="custom-label">회원명</label>
                            <input class="form-control" type="text" value="${reservationDTO.userName}" disabled>
                        </div>
                        <div class="col-md-4">
                            <label class="custom-label">인원</label>
                            <input class="form-control" type="text" value="${reservationDTO.headCount}" disabled>
                        </div>
                    </div>

                    <!-- 결제 정보 -->
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label class="custom-label">결제금액</label>
                            <input class="form-control" type="text" value="${reservationDTO.paymentAmount}" disabled>
                        </div>
                        <div class="col-md-4">
                            <label class="custom-label">결제상태</label>
                            <input class="form-control" type="text" value="${reservationDTO.paymentStatus}" disabled>
                        </div>
                        <div class="col-md-4">
                            <label class="custom-label">결제수단</label>
                            <input class="form-control" type="text" value="${reservationDTO.paymentMethod}" disabled>
                        </div>
                    </div>

                    <!-- ✅ MEMO (JSON) 아코디언 영역 -->
                    <div class="accordion" id="memoAccordion">
                        <div class="card mb-3">
                            <div class="card-header" id="headingOne">
                                <h2 class="mb-0">
                                    <button class="btn btn-link collapsed" type="button"
                                        data-toggle="collapse" data-target="#collapseOne"
                                        aria-expanded="false" aria-controls="collapseOne">
                                        추가 결제 정보 보기 (JSON데이터)
                                    </button>
                                </h2>
                            </div>

                            <div id="collapseOne" class="collapse" aria-labelledby="headingOne"
                                data-parent="#memoAccordion">
                                <div class="card-body">

                                    <c:if test="<%= memoMap != null %>">
                                        <table class="table table-bordered">
                                            <thead>
                                                <tr>
                                                    <th>Key</th>
                                                    <th>Value</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    if (memoMap != null) {
                                                        for (java.util.Map.Entry<String,Object> entry : memoMap.entrySet()) {
                                                %>
                                                <tr>
                                                    <td><%= entry.getKey() %></td>
                                                    <td><%= entry.getValue() %></td>
                                                </tr>
                                                <%
                                                        }
                                                    }
                                                %>
                                            </tbody>
                                        </table>
                                    </c:if>

                                    <c:if test="<%= memoMap == null %>">
                                        <p>메모 데이터가 없습니다.</p>
                                    </c:if>

                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="text-center mt-4">
                        <a href="/admin/reservation-manage" class="btn btn-secondary">목록</a>
                    </div>

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
