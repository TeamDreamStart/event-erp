<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <title>Event Detail</title>

  <!-- SB Admin 2 / fonts / icons -->
  <link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
  <link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">

  <!-- (선택) CSRF 메타 -->
  <meta name="_csrf" content="${_csrf.token}" />
  <meta name="_csrf_header" content="${_csrf.headerName}" />

  <style>
    /* ===== Scoped styles for Event Detail ===== */
    .event-detail { --brand:#4e73df; --muted:#6b7280; --border:#e5e7eb; --bg:#f8fafc; }
    .event-detail h1.page-title{font-size:clamp(20px,2.1vw,26px);line-height:1.25;margin:0;word-break:keep-all;}
    .event-detail .toolbar .badge-soft{border-radius:999px;padding:.35rem .6rem;font-weight:700;}
    .event-detail .badge-soft-primary{background:#eef2ff;color:#3a57c5;}
    .event-detail .badge-soft-muted{background:#f1f5f9;color:#334155;}
    .event-detail .kv-grid{display:grid;gap:.75rem;grid-template-columns:repeat(4,minmax(0,1fr));}
    @media (max-width:980px){.event-detail .kv-grid{grid-template-columns:repeat(2,minmax(0,1fr));}}
    .event-detail .kv{border:1px solid var(--border);border-radius:.65rem;padding:.65rem .8rem;background:#fff;min-height:64px;}
    .event-detail .kv .k{color:var(--muted);font-size:.78rem;display:block;}
    .event-detail .kv .v{font-weight:700;margin-top:.25rem;overflow-wrap:anywhere;font-size:.95rem;}
    .event-detail .kv .sub{color:#9ca3af;font-weight:500;font-size:.75rem;margin-left:.35rem;}
    .event-detail .poster{border:1px solid var(--border);border-radius:.75rem;overflow:hidden;background:#fff}
    .event-detail .poster img{width:100%;height:auto;display:block;}
    .event-detail .desc{white-space:pre-wrap;border:1px solid var(--border);border-radius:.75rem;background:#fff;padding:1rem;}
    .event-detail .map-card{border:1px solid var(--border);border-radius:.75rem;background:#fff;overflow:hidden;}
    .event-detail .map-head{padding:.75rem .9rem;border-bottom:1px solid var(--border);display:flex;align-items:center;justify-content:space-between;gap:.5rem;}
    .event-detail #map{width:100%;height:clamp(280px,40vw,420px);}
    .event-detail .post-nav{border:1px solid var(--border);border-radius:.75rem;background:#fff;overflow:hidden;}
    .event-detail .post-nav .row{display:grid;grid-template-columns:120px 1fr;border-bottom:1px solid var(--border);}
    .event-detail .post-nav .row:last-child{border-bottom:none;}
    .event-detail .post-nav .cell{padding:.75rem .9rem;}
    .event-detail .post-nav .label{font-weight:700;color:#6b7a90;background:#f8fbff;}
    .event-detail .muted{color:#98a4b3;}
    .event-detail .btn-slim{height:38px;padding:0 14px;border-radius:.65rem;font-weight:700;}
  </style>
</head>

<body id="page-top">
  <!-- Page Wrapper -->
  <div id="wrapper">
    <!-- 헤더(사이드바+탑바) -->
    <jsp:include page="../adminIncludes/header.jsp" />

    <!-- Main Content -->
    <div class="container-fluid event-detail">

      <!-- 상단 타이틀/툴바 -->
      <div class="d-flex align-items-center justify-content-between mb-3 toolbar">
        <div class="d-flex align-items-center gap-2">
          <h1 class="page-title mb-0">이벤트 상세</h1>
          <span class="badge-soft badge-soft-primary text-uppercase">
            <c:out value="${empty event.status ? 'UNKNOWN' : event.status}"/>
          </span>
          <span class="badge-soft badge-soft-muted">
            공개: <c:out value="${empty event.visibility ? '-':event.visibility}"/>
          </span>
        </div>
        <div class="d-flex" style="gap:.5rem;">
          <a class="btn btn-outline-secondary btn-slim" href="<c:url value='/admin/events'/>">목록</a>
          <a class="btn btn-primary btn-slim" href="<c:url value='/admin/events/form?id=${event.eventId}'/>">수정</a>
          <a class="btn btn-danger btn-slim"
             href="<c:url value='/admin/events/delete?id=${event.eventId}'/>"
             onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
        </div>
      </div>

      <!-- 카드: 메타 정보 -->
      <div class="card shadow mb-3">
        <div class="card-header py-3">
          <h6 class="m-0 font-weight-bold text-primary">메타 정보</h6>
        </div>
        <div class="card-body">
          <div class="kv-grid">
            <div class="kv"><span class="k">제목</span><span class="v"><c:out value="${empty event.title ? '-' : event.title}"/></span></div>
            <div class="kv"><span class="k">장소</span><span class="v"><c:out value="${empty event.location ? '-' : event.location}"/></span></div>
            <div class="kv"><span class="k">시작</span><span class="v"><c:out value="${empty event.startDate ? '-' : event.startDate}"/></span></div>
            <div class="kv"><span class="k">종료</span><span class="v"><c:out value="${empty event.endDate ? '-' : event.endDate}"/></span></div>

            <div class="kv"><span class="k">정원</span><span class="v"><c:out value="${event.capacity}"/></span></div>
            <div class="kv">
              <span class="k">유료/가격</span>
              <span class="v">
                <c:choose>
                  <c:when test="${event.paid}">유료 · <c:out value="${event.price}"/> <c:out value="${event.currency}"/></c:when>
                  <c:otherwise>무료</c:otherwise>
                </c:choose>
              </span>
            </div>
            <div class="kv"><span class="k">카테고리</span><span class="v"><c:out value="${empty event.category ? '-' : event.category}"/></span></div>
            <div class="kv">
              <span class="k">작성자 / 생성·수정</span>
              <span class="v">
                <c:out value="${empty event.createdBy ? '-' : event.createdBy}"/>
                <span class="sub">
                  (<c:out value="${empty event.createdAt ? '-' : event.createdAt}"/> /
                   <c:out value="${empty event.updatedAt ? '-' : event.updatedAt}"/>)
                </span>
              </span>
            </div>
          </div>
        </div>
      </div>

      <!-- 카드: 포스터 -->
      <c:if test="${not empty event.posterUrl}">
        <div class="card shadow mb-3">
          <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">포스터</h6>
          </div>
          <div class="card-body">
            <div class="poster">
              <img src="${event.posterUrl}" alt="이벤트 포스터: ${event.title}">
            </div>
          </div>
        </div>
      </c:if>

      <!-- 카드: 지도 -->
      <c:if test="${not empty event.location}">
        <div class="card shadow mb-3">
          <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">오시는 길</h6>
          </div>
          <div class="card-body">
            <div class="map-card">
              <div class="map-head">
                <div><strong>장소</strong> · <c:out value="${event.location}"/></div>
                <a class="btn btn-link p-0" target="_blank" rel="noopener"
                   href="https://map.kakao.com/link/map/${event.location},${event.latitude},${event.longitude}">
                  카카오 길찾기 <i class="fas fa-external-link-alt ml-1"></i>
                </a>
              </div>
              <div id="map" aria-label="카카오 지도"></div>
            </div>
          </div>
        </div>
      </c:if>

      <!-- 카드: 설명 -->
      <div class="card shadow mb-3">
        <div class="card-header py-3">
          <h6 class="m-0 font-weight-bold text-primary">설명</h6>
        </div>
        <div class="card-body">
          <div class="desc"><c:out value="${empty event.description ? '-' : event.description}"/></div>
        </div>
      </div>

      <!-- 카드: 이전/다음 -->
      <div class="card shadow mb-4">
        <div class="card-header py-3">
          <h6 class="m-0 font-weight-bold text-primary">이전/다음</h6>
        </div>
        <div class="card-body">
          <div class="post-nav">
            <div class="row">
              <div class="cell label">이전글</div>
              <div class="cell">
                <c:choose>
                  <c:when test="${not empty prevEvent || not empty prevId}">
                    <a href="<c:url value='/admin/events/detail?id=${not empty prevEvent ? prevEvent.eventId : prevId}'/>">
                      <c:out value="${not empty prevEvent ? prevEvent.title : prevTitle}"/>
                    </a>
                  </c:when>
                  <c:otherwise><span class="muted">이전 글이 없습니다.</span></c:otherwise>
                </c:choose>
              </div>
            </div>
            <div class="row">
              <div class="cell label">다음글</div>
              <div class="cell">
                <c:choose>
                  <c:when test="${not empty nextEvent || not empty nextId}">
                    <a href="<c:url value='/admin/events/detail?id=${not empty nextEvent ? nextEvent.eventId : nextId}'/>">
                      <c:out value="${not empty nextEvent ? nextEvent.title : nextTitle}"/>
                    </a>
                  </c:when>
                  <c:otherwise><span class="muted">다음 글이 없습니다.</span></c:otherwise>
                </c:choose>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 하단 버튼 -->
      <div class="text-right mb-5">
        <a href="<c:url value='/admin/events'/>" class="btn btn-outline-secondary btn-slim">목록</a>
        <a href="<c:url value='/admin/events/form?id=${event.eventId}'/>" class="btn btn-primary btn-slim">수정</a>
        <a href="<c:url value='/admin/events/delete?id=${event.eventId}'/>"
           class="btn btn-danger btn-slim" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
      </div>

    </div>
    <!-- /.container-fluid -->

    <!-- 푸터 -->
    <jsp:include page="../adminIncludes/footer.jsp" />
  </div>
  <!-- /#wrapper -->

  <!-- Scroll to Top -->
  <a class="scroll-to-top rounded" href="#page-top"><i class="fas fa-angle-up"></i></a>

  <!-- Logout Modal -->
  <jsp:include page="../adminIncludes/logoutModal.jsp" />

  <!-- Kakao Map SDK (공통에 없으면 유지) -->
  <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoKey}&libraries=services"></script>

  <!-- SB Admin 2 core scripts -->
  <script src="/resources/vendor/jquery/jquery.min.js"></script>
  <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>
  <script src="/resources/js/sb-admin-2.min.js"></script>

  <script>
    // Kakao Map init
    (function(){
      var hasLat = Number.isFinite(Number('${event.latitude}'));
      var hasLng = Number.isFinite(Number('${event.longitude}'));
      var hasLoc = '${event.location}' && '${event.location}'.trim().length > 0;
      if (!document.getElementById('map') || !hasLoc || !window.kakao) return;

      var map = new kakao.maps.Map(document.getElementById('map'), {
        center: new kakao.maps.LatLng(
          hasLat ? Number('${event.latitude}') : 37.5665,
          hasLng ? Number('${event.longitude}') : 126.9780
        ),
        level: 3
      });
      var geocoder = new kakao.maps.services.Geocoder();

      function mark(lat, lng){
        var pos = new kakao.maps.LatLng(lat, lng);
        var marker = new kakao.maps.Marker({ map: map, position: pos });
        new kakao.maps.InfoWindow({
          content:'<div style="width:160px;text-align:center;padding:6px 0;"><c:out value="${event.title}"/></div>'
        }).open(map, marker);
        map.setCenter(pos);
      }

      if (hasLat && hasLng) {
        mark(Number('${event.latitude}'), Number('${event.longitude}'));
      } else {
        geocoder.addressSearch('${event.location}', function(res, status){
          if (status === kakao.maps.services.Status.OK && res[0]) {
            mark(parseFloat(res[0].y), parseFloat(res[0].x));
          }
        });
      }
    })();
  </script>
</body>
</html>
