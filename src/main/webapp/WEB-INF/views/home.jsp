<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>home</title>

<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/common.css'/>">
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap"
	rel="stylesheet">

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@12/swiper-bundle.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/swiper@12/swiper-bundle.min.js"></script>

<style>
body {
	background: #E5E2DB;
}

.main-visual figure {
	margin: 0;
	line-height: 0;
}

.museum-status {
	text-align: right;
	margin: 20px 0 0 ;
	font-size: 20px;
	user-select: none;
}

.visual-hr {
	width: 100%;
	height: 1px;
	margin-top: 62px;
	background-color: #222;
}

.section-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 16px;
}

.section-header h2 {
	font-size: 30px;
	font-weight: 700;
	line-height: 40px;
}

/* ===== Event 캐러셀 ===== */
.swiper {
	width: 100%;
}

.swiper-wrapper {
	align-items: stretch;
}

.swiper-slide {
	width: 310px;
} /* 카드 폭 고정 */
.event-card {
	position: relative;
	background: transparent;
	height: 100%;
}

.event-card figure {
	margin: 0;
}

.event-card img {
	width: 310px;
	height: 438px;
	object-fit: cover;
	display: block;
}

.event-card .overlay {
	position: absolute;
	inset: 0;
	background: rgba(0, 0, 0, .55);
	color: #fff;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	gap: 10px;
	padding: 18px;
	text-align: center;
	opacity: 0;
	transition: opacity .18s;
}

.event-card:hover .overlay, .event-card:focus-within .overlay {
	opacity: 1;
}

.overlay .ov-title {
	font-size: 16px;
	font-weight: 700;
}

.overlay .ov-meta {
	font-size: 12px;
	opacity: .9;
}

.overlay .btn {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	height: 32px;
	padding: 0 14px;
	border: 1px solid #fff;
	color: #fff;
	background: transparent;
	font-size: 12px;
	cursor: pointer;
}

.overlay .btn:hover {
	background: #fff;
	color: #000;
}

/* 커스텀 내비게이션(important 없이) */
.events-prev, .events-next {
	appearance: none;
	background: none;
	border: 0;
	cursor: pointer;
	font-size: 30px;
	line-height: 40px;
	color: #222;
}

.events-prev[disabled], .events-next[disabled] {
	opacity: .35;
	cursor: default;
}

.nav-btns {
	display: flex;
	gap: 46px;
	align-items: center;
}

/* ===== Calendar & Notice  레이아웃 ===== */
/* 마지막 섹션 에서 푸터 밀기 140px */
.calendar-section {
	position: relative;
	margin-bottom: 140px;
}

.two-col {
	display: grid;
	grid-template-columns: 860px 480px; /* Calendar / Notice */
	gap: 94px;
	align-items: start;
}

.two-col < asid{
	width: 486px;
	position: absolute;
	top: 0; right: 0;
}

.notice-heading {
	
}

.notice-wrap .item {
	display: flex;
	align-items: center;
	gap: 10px;
	padding: 12px 0;
	border-top: 1px solid #ddd;
}

.notice-wrap .item:first-child {
	border-top: none;
}

.notice-wrap .thumb {
	width: 76px;
	height: 76px;
	background: #d9d9d9;
	flex: none;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 12px;
}

.notice-wrap .meta {
	font-size: 14px;
	line-height: 1.3;
}

.notice-wrap .meta .title {
	font-weight: 600;
	margin-bottom: 2px;
}

/* ============ 캘린더 (디자인1) ============ */
@font-face {
	font-family: 'Peristiwa';
	src: url('<c:url value="/resources/font/Peristiwa.otf"/>' )
		format('opentype');
	font-display: swap;
}

.s-cal {
	width: 860px;
	border: 1px solid #c7c7c7;
	background: #fff;
	padding: 24px 24px 28px;
	position: relative;
}

.s-cal__head {
	display: grid;
	grid-template-columns: 110px 100px 1fr;
	align-items: center;
	column-gap: 12px;
	margin-bottom: 14px;
}

.s-cal__mnum {
	font-weight: 800;
	font-size: 96px;
	line-height: 1;
	color: #111;
}

.s-cal__midnav {
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 10px;
}

.s-cal__midnav button {
	width: 28px;
	height: 28px;
	border: 1px solid #bdbdbd;
	background: #fff;
	border-radius: 6px;
	font-size: 18px;
	color: #222;
	cursor: pointer;
}

.s-cal__midnav .dots {
	font-size: 18px;
	color: #999;
}

.s-cal__mname span {
	font-family: 'Peristiwa', cursive;
	font-size: 56px;
	font-weight: 400;
	line-height: .95;
}

.s-cal__mname small {
	display: block;
	font-size: 18px;
	margin-top: 6px;
	color: #444;
}

.s-cal__grid {
	width: 100%;
	border: 1px solid #d1d1d1;
	border-collapse: collapse;
	table-layout: fixed;
}

.s-cal__grid th, .s-cal__grid td {
	border: 1px solid #d8d8d8;
	vertical-align: top;
}

.s-cal__grid th {
	height: 44px;
	font-weight: 700;
	color: #222;
}

.s-cal__grid td {
	height: 120px;
	padding: 8px 10px 6px;
}

.s-cal__num {
	font-size: 14px;
}

.s-cal__dots {
	display: flex;
	gap: 6px;
	margin-top: 6px;
	flex-wrap: wrap;
}

.s-cal__dot {
	width: 6px;
	height: 6px;
	border-radius: 50%;
}

/* 카테고리별 도트 색 */
.dot-SHOW {
	background: #d84b47;
} /* 공연/Show → 레드 */
.dot-SPEECH {
	background: #2b90d9;
} /* 강연/Speech → 블루 */
.dot-WORKSHOP {
	background: #3aa167;
} /* 워크숍 → 그린 */
.dot-MARKET {
	background: #666;
} /* 마켓 → 그레이 */

/* 상태 */
.is-today {
	background: rgba(255, 235, 59, .34);
}

.s-cal__cell.is-hover {
	background: #fff7cc;
}

/* 팝업 */
.s-cal__pop {
	position: absolute;
	min-width: 360px;
	background: #fff;
	border: 1px solid #2b2b2b;
	box-shadow: 0 8px 18px rgba(0, 0, 0, .12);
	padding: 16px 18px;
	font-size: 14px;
	color: #222;
	z-index: 5;
	pointer-events: auto;
}

.s-cal__pop .row {
	display: flex;
	align-items: center;
	gap: 10px;
	padding: 8px 0;
}

.s-cal__pop .dot {
	width: 10px;
	height: 10px;
	border-radius: 50%;
	display: inline-block;
}

.s-cal__pop .title {
	font-weight: 600;
}

.s-cal__pop .empty {
	color: #888;
	padding: 6px 0;
}

</style>
</head>

<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" flush="true" />

	<main id="main" class="container" role="main">
		<!-- 메인 비주얼 -->
		<section class="main-visual" aria-labelledby="mv-heading">
			<h2 id="mv-heading" class="sr-only">메인 소개</h2>
			<figure>
				<img src="<c:url value='/resources/img/grand.jpg'/>"
					alt="박물관 내부 전시관을 관람하는 모습 (운영시간 오전 10:30 ~ 오후 6:00)">
			</figure>
			<hr class="visual-hr" aria-hidden="true">
			<div class="museum-status" aria-label="운영 시간">
				<span aria-hidden="true">open 10:30 a.m.</span><br>
				<span aria-hidden="true">close 18:00 p.m.</span>
			</div>
		</section>

		<!-- Event -->
		<section id="events" class="horizontal-scroll-section exhibitions"
			aria-labelledby="events-heading">
			<div class="section-header title">
				<h2 id="events-heading">Event</h2>
				<div class="nav-btns" role="group" aria-label="이벤트 슬라이드 이동">
					<button type="button" class="events-prev"
						aria-controls="events-carousel" aria-label="이전 슬라이드">←</button>
					<button type="button" class="events-next"
						aria-controls="events-carousel" aria-label="다음 슬라이드">→</button>
				</div>
			</div>

			<div id="events-carousel" class="swiper mySwiper" role="region"
				aria-roledescription="carousel" aria-label="다가오는 이벤트"
				aria-live="polite">
				<div class="swiper-wrapper">
					<c:forEach var="e" items="${events}" varStatus="st">
						<c:set var="startStr" value="${e.startDate}" />
						<c:set var="dateYmd"
							value="${empty startStr ? '' : fn:substring(startStr,0,10)}" />
						<c:choose>
							<c:when test="${not empty e.posterUrl}">
								<c:set var="imgSrc" value="${e.posterUrl}" />
							</c:when>
							<c:when test="${e.category eq 'SHOW'}">
								<c:set var="imgSrc"
									value='${pageContext.request.contextPath}/resources/img/event1.jpg' />
							</c:when>
							<c:when test="${e.category eq 'WORKSHOP'}">
								<c:set var="imgSrc"
									value='${pageContext.request.contextPath}/resources/img/event2.jpg' />
							</c:when>
							<c:when test="${e.category eq 'SPEECH'}">
								<c:set var="imgSrc"
									value='${pageContext.request.contextPath}/resources/img/event3.jpg' />
							</c:when>
							<c:when test="${e.category eq 'MARKET'}">
								<c:set var="imgSrc"
									value='${pageContext.request.contextPath}/resources/img/event4.jpg' />
							</c:when>
							<c:otherwise>
								<c:set var="imgSrc"
									value='${pageContext.request.contextPath}/resources/img/event1.jpg' />
							</c:otherwise>
						</c:choose>

						<article class="event-card swiper-slide" role="group"
							aria-roledescription="slide"
							aria-label="${st.index + 1} / ${fn:length(events)} ${e.title}">
							<figure>
								<img src="${imgSrc}"
									alt="${e.title} — ${dateYmd}<c:if test='${not empty e.location}'> · ${e.location}</c:if> 포스터">
								<figcaption class="sr-only">${e.title}<c:if
										test="${not empty e.description}"> — ${e.description}</c:if>
								</figcaption>
							</figure>
							<div class="overlay">
								<div class="ov-title">
									<c:out value='${e.title}' />
								</div>
								<div class="ov-meta">
									<c:out value='${dateYmd}' />
									<c:if test="${not empty e.location}"> · <c:out
											value='${e.location}' />
									</c:if>
								</div>
								<a class="btn" href="<c:url value='/events/${e.eventId}'/>"
									aria-label="${e.title} 상세보기">자세히보기</a>
							</div>
						</article>
					</c:forEach>
				</div>
			</div>
		</section>

		<!-- Calendar & Notice -->
		<section class="calendar-section" aria-labelledby="cal-heading">
			<div class="section-header title">
				<h2 id="cal-heading">Calendar</h2>
			</div>

			<div class="two-col">
				<!-- 캘린더 (860px 고정) -->
				<div class="s-cal" id="sejongCal">
					<div class="s-cal__head">
						<div class="s-cal__mnum" id="mNum">09</div>
						<div class="s-cal__midnav">
							<button type="button" id="prevBtn" aria-label="이전 달">‹</button>
							<span aria-hidden="true" class="dots">· ·</span>
							<button type="button" id="nextBtn" aria-label="다음 달">›</button>
						</div>
						<div class="s-cal__mname">
							<span id="mName">September</span> <small id="mYear">2025</small>
						</div>
					</div>

					<table class="s-cal__grid" aria-label="월간 달력">
						<thead>
							<tr>
								<th scope="col">SUN</th>
								<th scope="col">MON</th>
								<th scope="col">TUE</th>
								<th scope="col">WED</th>
								<th scope="col">THU</th>
								<th scope="col">FRI</th>
								<th scope="col">SAT</th>
							</tr>
						</thead>
						<tbody id="calBody"></tbody>
					</table>

					<aside class="s-cal__pop" id="calPop" style="display: none;"></aside>
				</div>

				<!-- Notice -->
				<aside aria-labelledby="notice-heading">
					<div class="section-header">
						<h2 id="notice-heading">Notice</h2>
					</div>
					<div class="notice-wrap" aria-label="공지 목록">
						<div class="item">
							<div class="thumb" aria-hidden="true">9/28</div>
							<div class="meta">
								<div class="title">가을 음악 페스티벌</div>
								<div class="desc">올림픽공원</div>
							</div>
						</div>
						<div class="item">
							<div class="thumb" aria-hidden="true">9/25</div>
							<div class="meta">
								<div class="title">사내 워크숍</div>
								<div class="desc">오전 9시 (4시간)</div>
							</div>
						</div>
						<div class="item">
							<div class="thumb" aria-hidden="true">10/2</div>
							<div class="meta">
								<div class="title">개발자 컨퍼런스</div>
								<div class="desc">오후 2시 (4시간~)</div>
							</div>
						</div>
					</div>
				</aside>
			</div>
		</section>
	</main>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script>
    /* 이벤트 캐러셀: 카드 310px, 간격 65px */
    new Swiper(".mySwiper", {
      slidesPerView: 4,
      spaceBetween: 65,
      allowTouchMove: false,
      navigation: { nextEl: ".events-next", prevEl: ".events-prev" }
    });

    (function(){
      /* ===== 서버 이벤트(JSP → JS) : ENUM 카테고리 사용 ===== */
      var serverEvents = [];
      <c:forEach var="e" items="${events}">
        (function(){
          var d = "<c:out value='${fn:substring(e.startDate,0,10)}'/>";
          var t = "<c:out value='${e.title}'/>";
          var c = "<c:out value='${e.category}'/>"; // SHOW|SPEECH|WORKSHOP|MARKET
          serverEvents.push({ date:d, title:t, category:c });
        })();
      </c:forEach>

      var el = {
        mNum:  document.getElementById('mNum'),
        mName: document.getElementById('mName'),
        mYear: document.getElementById('mYear'),
        body:  document.getElementById('calBody'),
        pop:   document.getElementById('calPop'),
        wrap:  document.getElementById('sejongCal')
      };

      var MONTH_NAMES = ['January','February','March','April','May','June','July','August','September','October','November','December'];
      var DOT_CLASS = { SHOW:'dot-SHOW', SPEECH:'dot-SPEECH', WORKSHOP:'dot-WORKSHOP', MARKET:'dot-MARKET' };

      var viewDate = new Date();
      render(viewDate);

      document.getElementById('prevBtn').onclick = function(){ viewDate.setMonth(viewDate.getMonth()-1); render(viewDate,true); };
      document.getElementById('nextBtn').onclick = function(){ viewDate.setMonth(viewDate.getMonth()+1); render(viewDate,true); };

      var hideTimer = null;
      document.addEventListener('click', function(e){ if(!el.pop.contains(e.target)) el.pop.style.display='none'; });

      function render(d){
        var y = d.getFullYear(), m = d.getMonth();
        el.mNum.textContent  = String(m+1).padStart(2,'0');
        el.mName.textContent = MONTH_NAMES[m];
        el.mYear.textContent = y;

        var first = new Date(y,m,1);
        var last  = new Date(y,m+1,0);
        var startDay = first.getDay();
        var days = last.getDate();

        var monthEvents = serverEvents.filter(function(ev){
          var dt = new Date(ev.date);
          return dt.getFullYear()===y && dt.getMonth()===m;
        });

        var html = '', day = 1;
        for(var r=0;r<6;r++){
          html += '<tr>';
          for(var c=0;c<7;c++){
            var cellIndex = r*7 + c;
            if(cellIndex < startDay || day > days){
              html += '<td aria-hidden="true"></td>';
            }else{
              var key = y + '-' + String(m+1).padStart(2,'0') + '-' + String(day).padStart(2,'0');
              var isToday = isSameDate(new Date(), new Date(y,m,day));
              var dots = monthEvents
                .filter(function(ev){ return ev.date===key; })
                .map(function(ev){
                  var cls = DOT_CLASS[ev.category] || 'dot-MARKET';
                  return '<i class="s-cal__dot '+cls+'"></i>';
                }).join('');

              html += '<td class="s-cal__cell '+(isToday?'is-today':'')+'" data-date="'+key+'">'
                    +   '<div class="s-cal__num">'+day+'</div>'
                    +   '<div class="s-cal__dots">'+dots+'</div>'
                    + '</td>';
              day++;
            }
          }
          html += '</tr>';
        }
        el.body.innerHTML = html;

        /* 호버 → 팝업 & 하이라이트 */
        Array.prototype.forEach.call(el.body.querySelectorAll('td.s-cal__cell'), function(td){
          td.addEventListener('mouseenter', function(){
            clearTimeout(hideTimer);
            el.body.querySelectorAll('.s-cal__cell.is-hover').forEach(function(x){ x.classList.remove('is-hover'); });
            td.classList.add('is-hover');

            var dateKey = td.getAttribute('data-date');
            var list = monthEvents.filter(function(ev){ return ev.date===dateKey; });

            if(list.length===0){
              el.pop.innerHTML = '<div class="empty">등록된 이벤트가 없습니다</div>';
            }else{
              var inner = '';
              for(var i=0;i<list.length;i++){
                var ev = list[i];
                var dotCls = DOT_CLASS[ev.category] || 'dot-MARKET';
                inner += '<div class="row"><span class="dot '+dotCls+'"></span><span class="title">'+escapeHtml(ev.title)+'</span></div>';
              }
              el.pop.innerHTML = inner;
            }

            /* 팝업 위치: 셀 아래쪽 */
            var calRect = el.wrap.getBoundingClientRect();
            var rect = td.getBoundingClientRect();
            el.pop.style.left = (rect.left - calRect.left + 8) + 'px';
            el.pop.style.top  = (rect.bottom - calRect.top + 8) + 'px';
            el.pop.style.display = 'block';
          });

          td.addEventListener('mouseleave', function(){
            hideTimer = setTimeout(function(){ el.pop.style.display='none'; }, 120);
            td.classList.remove('is-hover');
          });
        });

        el.pop.addEventListener('mouseenter', function(){ clearTimeout(hideTimer); });
        el.pop.addEventListener('mouseleave', function(){ el.pop.style.display='none'; });
      }

      function isSameDate(a,b){ return a.getFullYear()===b.getFullYear() && a.getMonth()===b.getMonth() && a.getDate()===b.getDate(); }
      function escapeHtml(s){ return String(s).replace(/[&<>"']/g, function(m){ return ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'})[m]; }); }
    })();
  </script>
</body>
</html>
