<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>DreamStart Admin · Dashboard</title>

<!-- SB Admin / Bootstrap -->
<link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
<link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">

<!-- Chart.js -->
<script src="/resources/vendor/jquery/jquery.min.js"></script>
<script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/resources/vendor/chart.js/Chart.min.js"></script>

<style>
/* ============ Layout ============ */
#wrapper {
  width: 100%;
}

.dashboard-container {
  max-width: 1800px;
  margin: 0 auto;
  padding: 0 24px;
}

/* 카드 스타일 */
.summary-card {
  border-radius: .8rem;
  transition: transform 0.2s ease;
}
.summary-card:hover {
  transform: translateY(-4px);
}

/* 카드 내 텍스트 */
.card-body .text-xs {
  letter-spacing: .5px;
}
.h5 {
  font-weight: 700;
}

/* 차트 높이 */
.chart-area canvas,
.chart-pie canvas {
  min-height: 300px;
  width: 100% !important;
}

/* placeholder 텍스트 */
.text-muted-small {
  font-size: .9rem;
  color: #9ca3af;
}

.list-group-item {
  font-size: 0.95rem;
  border: none;
  border-bottom: 1px solid #f1f3f5;
}
.list-group-item:last-child {
  border-bottom: none;
}
.text-muted-small {
  font-size: .9rem;
  color: #9ca3af;
}

</style>
</head>

<body id="page-top">
<div id="wrapper">
  <jsp:include page="../adminIncludes/header.jsp"/>

  <!-- 메인 컨텐츠 -->
  <div class="container-fluid dashboard-container py-4">

    <div class="d-sm-flex align-items-center justify-content-between mb-4">
      <h1 class="h3 mb-0 text-gray-800 font-weight-bold">관리자 대시보드</h1>
    </div>

    <!-- Summary 카드 3개 -->
    <div class="row text-center justify-content-space-between">
      <div class="col-xl-3 col-lg-4 col-md-6 mb-4">
        <div class="card border-left-primary shadow h-100 py-2 summary-card">
          <div class="card-body">
            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">오늘 예약자 수</div>
            <div class="h5 mb-0 font-weight-bold text-gray-800">
              <c:out value="${todayReserveCount != null ? todayReserveCount : 0}"/> 명
            </div>
          </div>
        </div>
      </div>
      <div class="col-xl-3 col-lg-4 col-md-6 mb-4">
        <div class="card border-left-success shadow h-100 py-2 summary-card">
          <div class="card-body">
            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">총 예약 건수</div>
            <div class="h5 mb-0 font-weight-bold text-gray-800">
              <c:out value="${totalReserveCount != null ? totalReserveCount : 0}"/> 건
            </div>
          </div>
        </div>
      </div>
      <div class="col-xl-3 col-lg-4 col-md-6 mb-4">
        <div class="card border-left-info shadow h-100 py-2 summary-card">
          <div class="card-body">
            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">진행 중 설문</div>
            <div class="h5 mb-0 font-weight-bold text-gray-800">
              <c:out value="${activeSurveyCount != null ? activeSurveyCount : 0}"/> 개
            </div>
          </div>
        </div>
      </div>
      <div class="col-xl-3 col-lg-4 col-md-6 mb-4">
        <div class="card border-left-info shadow h-100 py-2 summary-card">
          <div class="card-body">
            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">총 회원 수</div>
			<div class="h5 mb-0 font-weight-bold text-gray-800">
			  <c:out value="${totalUserCount != null ? totalUserCount : 0}"/> 명
			</div>
          </div>
        </div>
      </div>
    </div>

    <!-- 차트 섹션 -->
    <div class="row justify-content-center">
      <!-- 이벤트별 예약 현황 -->
      <div class="col-xl-8 col-md-12 mb-4">
        <div class="card shadow h-100">
          <div class="card-header py-3 d-flex justify-content-between align-items-center">
            <h6 class="m-0 font-weight-bold text-primary">이벤트별 예약 현황</h6>
          </div>
          <div class="card-body">
            <c:choose>
              <c:when test="${not empty eventNamesJson}">
                <div class="chart-area">
                  <canvas id="reservationChart"></canvas>
                </div>
              </c:when>
              <c:otherwise>
                <div class="text-center py-5 text-muted-small">예약 데이터가 없습니다.</div>
              </c:otherwise>
            </c:choose>
          </div>
        </div>
      </div>

      <!-- 설문 참여율 -->
      <div class="col-xl-4 col-md-12 mb-4">
        <div class="card shadow h-100">
          <div class="card-header py-3 d-flex justify-content-between align-items-center">
            <h6 class="m-0 font-weight-bold text-primary">설문 참여율</h6>
          </div>
          <div class="card-body">
            <c:choose>
              <c:when test="${surveyParticipation > 0 || surveyNonParticipation > 0}">
                <div class="chart-pie">
                  <canvas id="surveyChart"></canvas>
                </div>
                <div class="mt-4 text-center small">
                  <span class="mr-2"><i class="fas fa-circle text-success"></i> 참여</span>
                  <span class="mr-2"><i class="fas fa-circle text-gray-400"></i> 미참여</span>
                </div>
              </c:when>
              <c:otherwise>
                <div class="text-center py-5 text-muted-small">진행 중 설문이 없습니다.</div>
              </c:otherwise>
            </c:choose>
          </div>
        </div>
      </div>
    </div>
    
    <!-- 공지사항 & 고객문의글 -->
	<div class="row justify-content-center mt-4">
	  
	  <!-- 공지사항 -->
	  <div class="col-xl-6 col-md-12 mb-4">
	    <div class="card shadow h-100">
	      <div class="card-header py-3 d-flex justify-content-between align-items-center">
	        <h6 class="m-0 font-weight-bold text-primary">📢 최신 공지사항</h6>
	        <a href="/admin/board/notice" class="text-sm text-gray-600">전체보기 →</a>
	      </div>
	      <div class="card-body">
	        <c:choose>
	          <c:when test="${not empty recentNotices}">
	            <ul class="list-group list-group-flush">
	              <c:forEach var="n" items="${recentNotices}">
	                <li class="list-group-item d-flex justify-content-between align-items-center">
	                  <a href="/board/notice/detail/${n.boardId}" class="text-gray-800 text-truncate" style="max-width: 80%;">
	                    <c:out value="${n.title}"/>
	                  </a>
	                  <span class="small text-gray-500"><fmt:formatDate value="${n.createdAt}" pattern="MM.dd"/></span>
	                </li>
	              </c:forEach>
	            </ul>
	          </c:when>
	          <c:otherwise>
	            <div class="text-center py-4 text-muted-small">등록된 공지사항이 없습니다.</div>
	          </c:otherwise>
	        </c:choose>
	      </div>
	    </div>
	  </div>
	
	  <!-- 고객 문의글 -->
	  <div class="col-xl-6 col-md-12 mb-4">
	    <div class="card shadow h-100">
	      <div class="card-header py-3 d-flex justify-content-between align-items-center">
	        <h6 class="m-0 font-weight-bold text-primary">💬 최근 고객 문의</h6>
	        <a href="/admin/board/qna" class="text-sm text-gray-600">전체보기 →</a>
	      </div>
	      <div class="card-body">
	        <c:choose>
	          <c:when test="${not empty recentQna}">
	            <ul class="list-group list-group-flush">
	              <c:forEach var="q" items="${recentQna}">
	                <li class="list-group-item d-flex justify-content-between align-items-center">
	                  <a href="/board/qna/detail/${q.boardId}" class="text-gray-800 text-truncate" style="max-width: 80%;">
	                    <c:out value="${q.title}"/>
	                  </a>
	                  <span class="badge ${q.replyYn == 'Y' ? 'badge-success' : 'badge-secondary'}">
	                    ${q.replyYn == 'Y' ? '답변완료' : '미답변'}
	                  </span>
	                </li>
	              </c:forEach>
	            </ul>
	          </c:when>
	          <c:otherwise>
	            <div class="text-center py-4 text-muted-small">최근 문의글이 없습니다.</div>
	          </c:otherwise>
	        </c:choose>
	      </div>
	    </div>
	  </div>
	</div>
  </div>

  <jsp:include page="../adminIncludes/footer.jsp"/>
</div>

<!-- 차트 스크립트 -->
<script>
/* === 예약 현황 === */
<c:if test="${not empty eventNamesJson}">
const ctx1 = document.getElementById('reservationChart');
new Chart(ctx1, {
  type: 'line',
  data: {
    labels: ${eventNamesJson},
    datasets: [{
      label: '예약자 수',
      data: ${reservationCountsJson},
      borderColor: '#4e73df',
      backgroundColor: 'rgba(78, 115, 223, 0.1)',
      tension: 0.4,
      pointRadius: 4,
      fill: true
    }]
  },
  options: {
    responsive: true,
    maintainAspectRatio: false,
    plugins: { legend: { display: false } },
    scales: { y: { beginAtZero: true } }
  }
});
</c:if>

/* === 설문 참여율 === */
<c:if test="${surveyParticipation > 0 || surveyNonParticipation > 0}">
const ctx2 = document.getElementById('surveyChart');
new Chart(ctx2, {
  type: 'doughnut',
  data: {
    labels: ['참여', '미참여'],
    datasets: [{
      data: [${surveyParticipation}, ${surveyNonParticipation}],
      backgroundColor: ['#1cc88a', '#e5e7eb'],
      hoverBackgroundColor: ['#17a673', '#d1d5db']
    }]
  },
  options: {
    responsive: true,
    maintainAspectRatio: false,
    cutout: '70%',
    plugins: { legend: { display: false } }
  }
});
</c:if>
</script>
</body>
</html>
