<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MyPage · DreamStart</title>

<!-- 공통 리소스 -->
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700;900&display=swap" rel="stylesheet"/>
<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/common.css'/>">

<style>
body {
  background: #E5E2DB;
  font-family: 'Montserrat', 'Pretendard', sans-serif;
  color: #222;
}

/* 레이아웃 */
.container {
  max-width: 896px;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  gap: 40px;
  padding: 40px 0 140px 0;
}

.section-header { margin-bottom: 12px; }
.page-title h2 {
  font-size: 30px; font-weight: 800; color: #1f1f1f;
}

/* 카드 공통 */
.member-info-box, .my-reservation-box, .survey-box {
  background: #fff; border: 1px solid #d9d9d9;
  border-radius: 12px; padding: 32px 48px;
}

/* 나의 정보 */
.info-header {
  display: flex; justify-content: space-between; align-items: center;
  margin-bottom: 24px;
}
.modify-btn {
  background: #d9d9d9; color: #222;
  padding: 6px 22px; border-radius: 6px;
  font-weight: 700; border: none; cursor: pointer;
  transition: 0.15s;
}
.modify-btn:hover { background: #cfcfcf; }
.withdraw-btn {
  background: #FFD8D8; color: #A03030;
  padding: 6px 22px; border-radius: 6px;
  font-weight: 700; border: 1px solid #E37A7A;
  cursor: pointer; transition: 0.15s;
}
.withdraw-btn:hover { background: #F8BFBF; }

.info-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  text-align: center;
  font-size: 15px; color: #333;
  row-gap: 12px;
}
.info-label { font-weight: 700; color: #555; }

/* 탈퇴 모달 */
.modal-overlay {
  position: fixed; top: 0; left: 0;
  width: 100%; height: 100%;
  background: rgba(0,0,0,0.4);
  display: flex; justify-content: center; align-items: center;
  z-index: 9999;
}
.modal-content {
  background: #fff;
  border-radius: 10px;
  padding: 30px 40px;
  text-align: center;
  max-width: 360px;
  width: 90%;
  box-shadow: 0 4px 10px rgba(0,0,0,0.15);
}
.modal-content h3 {
  font-size: 20px; font-weight: 800; margin-bottom: 14px;
}
.modal-content p {
  font-size: 14px; color: #444; margin-bottom: 24px;
  line-height: 1.6;
}
.modal-buttons {
  display: flex; justify-content: center; gap: 10px;
}
.withdraw-confirm {
  background: #FFD8D8; color: #A03030;
  border: 1px solid #E37A7A;
  padding: 8px 20px; border-radius: 6px;
  font-weight: 700; cursor: pointer; transition: 0.15s;
}
.withdraw-confirm:hover { background: #F8BFBF; }
.withdraw-cancel {
  background: #d9d9d9; color: #222;
  border: none; padding: 8px 20px;
  border-radius: 6px; font-weight: 700;
  cursor: pointer; transition: 0.15s;
}
.withdraw-cancel:hover { background: #cfcfcf; }

/* 예약 영역 */
.my-reservation-box h3 { font-size: 18px; font-weight: 700; margin-bottom: 20px; }
.no-reservation-content { text-align: center; padding: 40px 0; }
.no-reservation-content p { margin: 6px 0; font-size: 15px; }
.event-button {
  background: #BFD4F9; color: #222;
  padding: 5px 10px; height: 34px; border-radius: 4px;
  font-weight: 700; border: 1px solid #8FAFED;
  display: inline-block; margin-top: 12px;
  transition: 0.2s;
}
.event-button:hover { background: #AFC6F4; }

/* 예약 카드 */
.tmpWrap { display: grid; grid-template-columns: repeat(auto-fill, minmax(260px, 1fr)); gap: 28px; }
.tmp {
  border: 1px solid #d9d9d9; border-radius: 8px;
  padding: 18px 14px; cursor: pointer; transition: background 0.2s;
}
.tmp:hover { background: #f8f8f8; }
.tmp-span-title { font-weight: 700; display: block; margin-bottom: 6px; }
.tmp-span { display: block; font-size: 14px; color: #555; }
.tmp-span-radius {
  display: inline-block; padding: 4px 10px;
  border-radius: 12px; font-size: 13px;
  font-weight: 700; margin-top: 8px;
}
.tmp-span-radius.CONFIRMED { background: #BFD4F9; border: 1px solid #8FAFED; color: #222; }
.tmp-span-radius.CANCELLED { background: #FFD8D8; border: 1px solid #E37A7A; color: #A03030; }
.tmp-span-radius.PENDING_PAYMENT { background: #FFF4D1; border: 1px solid #EBC561; color: #8A6A00; }
.tmp.expired { opacity: 0.6; filter: grayscale(30%); cursor: default; }

/* 설문 */
.survey-box h3 { font-size: 18px; font-weight: 700; margin-bottom: 14px; }
.survey-list p { font-size: 15px; color: #666; margin-bottom: 24px; }
.survey-item {
  display: flex; justify-content: space-between; align-items: center;
  padding: 14px 18px; border: 1px solid #d9d9d9;
  border-radius: 8px; margin-bottom: 12px;
  background: #fff; transition: 0.2s;
}
.survey-item:hover { background: #f8f8f8; }
.survey-text .event-title { font-weight: 700; margin-bottom: 6px; }
.survey-text .event-date { font-size: 14px; color: #888; }
.survey-btn {
  background: #d9d9d9; color: #222;
  padding: 6px 16px; border-radius: 6px;
  font-size: 14px; font-weight: 700;
  border: none; cursor: pointer; transition: 0.2s;
}
.survey-btn:hover { background: #cfcfcf; }
.survey-status {
  padding: 4px 12px; border-radius: 10px;
  font-size: 13px; font-weight: 700;
}
.survey-status.done { background: #BFD4F9; color: #222; }
.survey-status.closed { background: #F2F0EF; color: #888; }
.survey-item.closed { opacity: 0.6; pointer-events: none; }
</style>
</head>

<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<main>
<div class="container">
  <div class="section-header">
    <div class="page-title"><h2>MyPage</h2></div>
  </div>

  <!-- 나의 정보 -->
  <div class="member-info-box">
    <div class="info-header">
      <p>나의 정보</p>
      <div style="display:flex; gap:10px;">
        <button type="button" class="modify-btn" onclick="location.href='/my-info/edit'">수정</button>
        <button type="button" class="withdraw-btn" onclick="openWithdrawModal()">탈퇴하기</button>
      </div>
    </div>
    <div class="info-grid">
      <span class="info-label">이름</span>
      <span class="info-label">이메일</span>
      <span class="info-label">전화번호</span>
      <span>${userDTO.name}</span>
      <span>${userDTO.email}</span>
      <span>${userDTO.phone}</span>
    </div>
  </div>

  <!-- 탈퇴 확인 모달 -->
  <div id="withdrawModal" class="modal-overlay" style="display:none;">
    <div class="modal-content">
      <h3>회원 탈퇴</h3>
      <p>정말 탈퇴하시겠습니까?<br>탈퇴 후에는 모든 정보가 영구 삭제됩니다.</p>
      <form id="withdrawForm" action="<c:url value='/my-info/withdraw'/>" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <div class="modal-buttons">
          <button type="submit" class="withdraw-confirm">탈퇴</button>
          <button type="button" class="withdraw-cancel" onclick="closeWithdrawModal()">취소</button>
        </div>
      </form>
    </div>
  </div>

  <!-- 예약 목록 -->
  <div class="my-reservation-box">
    <h3>나의 예약</h3>
    <c:if test="${empty reservationList}">
      <div class="no-reservation-content">
        <p>예약 내역이 없습니다.</p>
        <p>새로운 이벤트를 예약해 보세요!</p>
        <a href="/events" class="event-button">이벤트 둘러보기</a>
      </div>
    </c:if>

    <c:if test="${not empty reservationList}">
      <div class="tmpWrap">
        <c:forEach var="rDTO" items="${reservationList}">
          <div class="tmp ${rDTO.eventDate lt now ? 'expired' : ''}" onclick="location.href='/reservations/${rDTO.reservationId}'">
            <span class="tmp-span-title">${rDTO.eventTitle}</span>
            <span class="tmp-span">예약번호 : ${rDTO.reservationId}</span>
            <span class="tmp-span">
              <fmt:formatDate pattern="yyyy-MM-dd" value="${rDTO.reservationDate}" />
            </span>
            <span class="tmp-span-radius ${rDTO.reservationStatus}">
              <c:choose>
                <c:when test="${rDTO.reservationStatus eq 'CONFIRMED'}">예약확정</c:when>
                <c:when test="${rDTO.reservationStatus eq 'CANCELLED'}">취소됨</c:when>
                <c:when test="${rDTO.reservationStatus eq 'PENDING_PAYMENT'}">결제대기</c:when>
                <c:otherwise>기타</c:otherwise>
              </c:choose>
            </span>
            <c:if test="${rDTO.paymentAmount > 0}">
              <span style="display:block; margin-top:4px;">
                <fmt:formatNumber type="number" maxFractionDigits="3" value="${rDTO.paymentAmount}" />원
              </span>
            </c:if>
          </div>
        </c:forEach>
      </div>
    </c:if>
  </div>

  <!-- 설문 섹션 -->
  <div class="survey-box">
    <h3>이벤트 설문조사</h3>
    <div class="survey-list">
      <p>설문 작성 가능 또는 응답 완료한 이벤트</p>
      <c:forEach var="survey" items="${surveyList}">
        <div class="survey-item ${survey.openStatus eq 'CLOSED' ? 'closed' : ''}">
          <div class="survey-text">
            <div class="event-title">${survey.eventTitle}</div>
            <div class="event-date">이벤트 일시:
              <fmt:formatDate value="${survey.eventDate}" pattern="yyyy-MM-dd"/>
            </div>
          </div>
          <c:choose>
            <c:when test="${survey.responseStatus eq 'RESPONDED'}">
              <span class="survey-status done">응답 완료</span>
            </c:when>
            <c:when test="${survey.openStatus eq 'CLOSED'}">
              <span class="survey-status closed">마감됨</span>
            </c:when>
            <c:otherwise>
              <a href="/my-info/survey/${survey.eventId}" class="survey-btn">설문 작성</a>
            </c:otherwise>
          </c:choose>
        </div>
      </c:forEach>
    </div>
  </div>
</div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
function openWithdrawModal() {
  document.getElementById('withdrawModal').style.display = 'flex';
}
function closeWithdrawModal() {
  document.getElementById('withdrawModal').style.display = 'none';
}
</script>
</body>
</html>
