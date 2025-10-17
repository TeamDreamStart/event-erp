<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>Event Manage · Form</title>

  <!-- SB Admin + Bootstrap -->
  <link href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">

  <style>
    .wrap-title{font-size:24px;font-weight:700;color:#1f2937;margin-bottom:14px}
    .card{border:1px solid #e5e7eb;border-radius:.5rem}
    .card-header{background:#f8fafc;border-bottom:1px solid #e5e7eb;color:#374151;font-weight:700}
    .form-section-title{font-size:14px;color:#6b7280;margin-bottom:6px}
    .badge-writer{font-size:14px;padding:.4rem .6rem}
    .desc-area{min-height:260px; resize:vertical;}
    .map-box{width:100%; height:420px; border:1px solid #e5e7eb; border-radius:.375rem}
    .thumb-card{position:relative; display:inline-block; margin:6px}
    /* 썸네일 높이 +10px */
	.thumb-card img{max-height:120px; border:1px solid #e5e7eb; border-radius:.375rem; display:block}
    .btn-x{position:absolute; top:-6px; left:-6px; width:22px; height:22px; border-radius:50%; border:none; background:#ef4444; color:#fff; font-size:12px; line-height:22px;}
    .preview-img{max-width:100%;height:auto;border-radius:8px;display:block;margin-bottom:8px}
    .row-tight {margin-left:-.25rem; margin-right:-.25rem}
    .row-tight>[class^="col-"]{padding-left:.25rem; padding-right:.25rem}
    #postcodeLayer {
      display:none; position:fixed; z-index:9999; left:50%; top:50%;
      width:480px; height:520px; transform:translate(-50%, -50%);
      border:1px solid #e5e7eb; border-radius:8px; background:#fff; box-shadow:0 10px 30px rgba(0,0,0,.2);
      overflow:hidden;
    }
    #postcodeLayerHeader{display:flex;justify-content:space-between;align-items:center;padding:8px 12px;border-bottom:1px solid #e5e7eb;background:#f8fafc}
    #postcodeClose{border:none;background:#ef4444;color:#fff;border-radius:6px;padding:4px 10px}
    #postcodeContainer{width:100%;height:calc(100% - 42px)}

    /* custom-file에서 라벨을 파일명으로 바꾸지 않고 고정 유지 */
    .custom-file-input:lang(ko) ~ .custom-file-label::after { content: "찾기"; }
    .custom-file-label { overflow: hidden; white-space: nowrap; text-overflow: ellipsis; }
    input[type="file"].form-control-file { display: none; } /* 기존 form-control-file 쓰지 않게 됨 */

    /* ---- 미리보기 카드 그리드 ---- */
    .kv-grid { margin:-.5rem; }
    .kv-grid > .col { padding:.5rem; }
    .kv { background:#fff; border:1px solid #e5e7eb; border-radius:.75rem; padding:14px; height:100%; }
    .kv .k { font-size:14px; color:#6b7280; margin-bottom:6px; }
    .kv .v { font-size:20px; font-weight:700; color:#111827; line-height:1.25; }
    .kv .v small { font-size:14px; font-weight:600; color:#6b7280; margin-left:.25rem; }
    
    /* ========== 미리보기(모달) 글자/레이아웃 축소 & 줄바꿈 ========== */
	#fullPreviewModal .kv { 
	  padding: 10px;              /* 카드 안 여백 줄임 */
	  border-radius: .5rem;
	}
	#fullPreviewModal .kv .k { 
	  font-size: 12px;            /* 라벨 더 작게 */
	  margin-bottom: 4px;
	  color: #aaa;
	}
	#fullPreviewModal .kv .v { 
	  font-size: 14px;            /* 값 텍스트 작게 */
	  line-height: 1.3;
	  white-space: normal;        /* 한 줄 고정 해제 */
	  word-break: break-word;     /* 긴 단어도 줄바꿈 */
	  overflow-wrap: anywhere;    /* URL/영문 연속도 강제 줄바꿈 */
	  font-weight: 500;
	}
	/* 그리드 여백도 살짝 압축 */
	#fullPreviewModal .kv-grid { margin: -0.35rem; }
	#fullPreviewModal .kv-grid > .col { padding: 0.35rem; }

	.input-group-file .custom-file{ flex:1 1 auto; }
	.input-group-file .custom-file-label{ overflow:hidden; text-overflow:ellipsis; white-space:nowrap; }
	
	/* 미리보기 타일 */
	/* ===== 업로드 UI ===== */
	#uploadBox{border:1px solid #e5e7eb;border-radius:10px;padding:14px;margin-top:8px}
	.upload-row{display:flex;gap:12px;flex-wrap:wrap}
	.upload-col{flex:1 1 420px}
	
	/* 교체본 (10px씩 키움: 가로 +20, 세로 +20) */
	.poster-slot{
	  width:160px;height:210px;padding: 10px; border:2px dashed #cbd5e1;border-radius:10px;
	  display:flex;align-items:center;justify-content:center;background:#fafafa
	}
	.poster-slot img{
	  max-width:calc(100%);
	  max-height:calc(100%);
	  object-fit:contain;border-radius:8px
	}
	.poster-slot.--filled{border-color:#60a5fa;background:#f0f7ff}
	
	.file-grid{display:flex;flex-wrap:wrap;gap:10px}
	.file-card{
	  position:relative;width:120px;height:160px;border:1px solid #e5e7eb;border-radius:10px;
	  background:#fff;display:flex;align-items:center;justify-content:center;overflow:hidden
	}
	.file-card.dragging{opacity:.4}
	.file-card img{max-width:100%;max-height:100%;object-fit:contain}
	.file-card .x{
	  position:absolute;left:-6px;top:-6px;width:22px;height:22px;border-radius:11px;
	  background:#ef4444;color:#fff;border:0;line-height:22px;font-weight:700
	}
	.file-card .label{
	  position:absolute;left:6px;right:6px;bottom:6px;font-size:12px;
	  white-space:nowrap;overflow:hidden;text-overflow:ellipsis;color:#374151
	}

	
	/* 무료 때 통화 셀렉트 잠금(전송은 되게) */
	.is-readonly { pointer-events:none; background:#eef1f6; }
	
	/* 라벨/버튼 너무 붙은 부분 간격 */
	.desc-toolbar{ display:flex; align-items:center; justify-content:space-between; margin-bottom:6px; }


    /* 무료일 때 select 잠금 비주얼(값은 전송됨) */
    .is-readonly { pointer-events:none; background:#eef2f7; color:#6b7280; }
  </style>

  <!-- Kakao Map / 우편번호 -->
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoKey}&libraries=services"></script>
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

  <!-- 날짜 포맷 (Spring EL) -->
  <spring:eval var="__dtf" expression="T(java.time.format.DateTimeFormatter).ofPattern('yyyy-MM-dd''T''HH:mm')" />
  <spring:eval var="startVal" expression="event != null and event.startDate != null ? event.startDate.format(__dtf) : ''" />
  <spring:eval var="endVal"   expression="event != null and event.endDate   != null ? event.endDate.format(__dtf)   : ''" />
</head>

<body id="page-top">
<sec:authorize access="isAuthenticated()">
  <sec:authentication property="principal.userId"  var="loginUserId"/>
  <sec:authentication property="principal.name"    var="loginUserName"/>
</sec:authorize>

<div id="wrapper">
  <jsp:include page="../adminIncludes/header.jsp"/>

  <div class="container-fluid">
    <div class="wrap-title">Event Manage</div>

    <div class="card shadow-sm mb-4">
      <div class="card-header d-flex justify-content-between align-items-center">
        <span>
          <c:choose>
            <c:when test="${empty event or empty event.eventId}">이벤트 등록</c:when>
            <c:otherwise>이벤트 수정</c:otherwise>
          </c:choose>
        </span>
        <div><a href="<c:url value='/admin/events'/>" class="btn btn-outline-secondary btn-sm">목록</a></div>
      </div>

      <div class="card-body">
        <c:if test="${not empty msg}">
          <div class="alert alert-info"><c:out value="${msg}"/></div>
        </c:if>

        <form id="eventForm" action="<c:url value='/admin/events/save'/>" method="post" enctype="multipart/form-data">
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
          <c:if test="${not empty event.eventId}">
            <input type="hidden" name="eventId" value="${event.eventId}">
          </c:if>

          <!-- 작성자 -->
          <div class="mb-3">
            <div class="form-section-title">작성자</div>
            <span class="badge badge-primary badge-writer"><c:out value="${loginUserName}"/></span>
            <input type="hidden" name="createdBy" value="${loginUserId}">
            <input type="hidden" name="createdByName" value="${loginUserName}">
          </div>

          <!-- 제목 / 설명 -->
          <div class="form-group">
            <label class="mb-1">제목 <span class="text-danger">*</span></label>
            <input type="text" name="title" class="form-control" value="${event.title}" required>
          </div>

          <div class="form-group">
            <div class="d-flex align-items-center justify-content-between mb-3">
			  <label class="mb-0">설명</label>
			  <button type="button" class="btn btn-sm btn-outline-secondary" id="btnFullPreview"
			          data-toggle="modal" data-target="#fullPreviewModal">본문 미리보기</button>
			</div>
            <textarea id="desc" name="description" class="form-control desc-area">${event.description}</textarea>
            <small class="help d-block">파일을 선택하면 이 칸에 바로 삽입됩니다. (이미지: <code>[[img:파일명]]</code>, 파일: <code>[[file:파일명]]</code>)</small>
          </div>

          <!-- 옵션 -->
          <!-- ===== 파일 업로드 박스(대표/첨부 한 줄) ===== -->
		<div id="uploadBox">
		  <div class="d-flex align-items-center mb-2">
		    <strong class="mr-2">파일 업로드</strong>
		    <small class="text-muted">선택 즉시 설명칸에 토큰으로 삽입됩니다. 등록 시 실제 URL로 자동 치환됩니다.</small>
		  </div>
		
		  <div class="upload-row">
		    <!-- 대표 이미지 -->
		    <div class="upload-col">
		      <label class="mb-1">대표 이미지</label>
		      <div class="input-group">
		        <input type="file" id="posterFile" name="image"
		               class="form-control" accept=".jpg,.jpeg,.png,.webp,.pdf">
		        <div class="input-group-append">
		          <button class="btn btn-outline-secondary" type="button"
		                  onclick="document.getElementById('posterFile').click()">찾기</button>
		        </div>
		      </div>
		      <div class="mt-2">
		        <div id="posterSlot" class="poster-slot">
		          <span class="text-muted">썸네일 미리보기</span>
		        </div>
		      </div>
		    </div>
		
		    <!-- 첨부 파일(여러 개) -->
		    <div class="upload-col">
		      <label class="mb-1">첨부 파일(여러 개)</label>
		      <div class="input-group">
		        <input type="file" id="filesInput" name="files" class="form-control"
		               multiple accept=".jpg,.jpeg,.png,.webp,.pdf">
		        <div class="input-group-append">
		          <button class="btn btn-outline-secondary" type="button"
		                  onclick="document.getElementById('filesInput').click()">찾기</button>
		        </div>
		      </div>
		      <small class="text-muted d-block mt-1">이미지는 [[img:파일명]], 그 외는 [[file:파일명]] 으로 삽입</small>
		    </div>
		  </div>
		
		  <!-- 미리보기 영역 -->
		  <div class="mt-3">
		    <div id="filesGrid" class="file-grid"></div>
		    <div class="d-flex justify-content-end mt-2">
		      <button id="btnSyncTokens" type="button" class="btn btn-sm btn-outline-secondary">
		        본문에 순서 반영
		      </button>
		    </div>
		  </div>
		</div>


          <!-- 유료/가격/통화 -->
          <div class="form-row align-items-end">
            <div class="form-group col-md-4">
              <label class="mb-1">유료 여부</label>
              <select id="paid" name="paid" class="form-control">
                <option value="false" ${empty event || !event.paid ? 'selected' : ''}>무료</option>
                <option value="true"  ${!empty event && event.paid ? 'selected' : ''}>유료</option>
              </select>
            </div>
            <div class="form-group col-md-4">
              <label class="mb-1">가격</label>
              <input id="price" name="price" type="number" step="1" min="0" class="form-control" value="<c:out value='${event.price}'/>">
            </div>
            <div class="form-group col-md-4">
              <label class="mb-1">통화</label>
              <select id="currency" name="currency" class="form-control">
                <option value="KRW" ${empty event || event.currency=='KRW' ? 'selected' : ''}>KRW</option>
                <option value="USD" ${event.currency=='USD' ? 'selected' : ''}>USD</option>
              </select>
            </div>
          </div>

          <div class="form-row">
            <div class="form-group col-md-6">
              <label class="mb-1">시작</label>
              <input id="startDate" type="datetime-local" name="startDate" class="form-control" value="${startVal}">
            </div>
            <div class="form-group col-md-6">
              <label class="mb-1">종료</label>
              <input id="endDate" type="datetime-local" name="endDate" class="form-control" value="${endVal}">
            </div>
          </div>

          <div class="form-row">
            <div class="form-group col-12 col-md-6 col-xl-3">
              <label class="mb-1">정원</label>
              <input type="number" min="0" name="capacity" class="form-control" value="${event.capacity}">
            </div>
            <div class="form-group col-12 col-md-6 col-xl-3">
              <label class="mb-1">카테고리</label>
              <select name="category" class="form-control">
                <option value="SHOW"     ${empty event || event.category=='SHOW'     ? 'selected' : ''}>SHOW</option>
                <option value="SPEECH"   ${event.category=='SPEECH'   ? 'selected' : ''}>SPEECH</option>
                <option value="WORKSHOP" ${event.category=='WORKSHOP' ? 'selected' : ''}>WORKSHOP</option>
                <option value="MARKET"   ${event.category=='MARKET'   ? 'selected' : ''}>MARKET</option>
              </select>
            </div>
            <div class="form-group col-12 col-md-6 col-xl-3">
              <label class="mb-1">상태</label>
              <select name="status" class="form-control">
                <option value="OPEN"      ${event.status == 'OPEN' ? 'selected' : ''}>OPEN</option>
                <option value="CLOSED"    ${event.status == 'CLOSED' ? 'selected' : ''}>CLOSED</option>
                <option value="CANCELLED" ${event.status == 'CANCELLED' ? 'selected' : ''}>CANCELLED</option>
              </select>
            </div>
            <div class="form-group col-12 col-md-6 col-xl-3">
              <label class="mb-1">공개여부</label>
              <select name="visibility" class="form-control">
                <option value="PUBLIC"  ${event.visibility == 'PUBLIC' ? 'selected' : ''}>PUBLIC</option>
                <option value="PRIVATE" ${event.visibility == 'PRIVATE' ? 'selected' : ''}>PRIVATE</option>
              </select>
            </div>
          </div>

          <!-- 2열: 지도 / 장소+좌표 -->
          <div class="row row-tight">
            <div class="col-lg-7">
              <div class="form-group">
                <label class="mb-1">지도</label>
                <div id="map" class="map-box"></div>
              </div>
            </div>

            <div class="col-lg-5">
              <div class="form-group">
                <label class="mb-1">장소</label>
                <div class="input-group">
                  <input type="text" id="location" name="location" class="form-control" value="${event.location}" readonly>
                  <div class="input-group-append">
                    <button class="btn btn-outline-secondary" type="button" onclick="execDaumPostcode()">주소검색</button>
                  </div>
                </div>
                <small class="help">주소 검색 후 지도와 좌표가 자동으로 채워집니다.</small>
              </div>

              <!-- 우편번호 레이어 -->
              <div id="postcodeLayer" aria-modal="true" role="dialog">
                <div id="postcodeLayerHeader">
                  <strong>주소 검색</strong>
                  <button id="postcodeClose" type="button">닫기</button>
                </div>
                <div id="postcodeContainer"></div>
              </div>

              <div class="form-row">
                <div class="form-group col-sm-6">
                  <label class="mb-1">위도</label>
                  <input type="text" id="latitude" name="latitude" class="form-control" value="${event.latitude}" readonly>
                </div>
                <div class="form-group col-sm-6">
                  <label class="mb-1">경도</label>
                  <input type="text" id="longitude" name="longitude" class="form-control" value="${event.longitude}" readonly>
                </div>
              </div>
            </div>
          </div>

          <div class="d-flex justify-content-end pt-2">
            <c:choose>
              <c:when test="${empty event or empty event.eventId}">
                <button type="submit" class="btn btn-primary">등록</button>
              </c:when>
              <c:otherwise>
                <button type="submit" class="btn btn-primary">수정</button>
              </c:otherwise>
            </c:choose>
            <a href="<c:url value='/admin/events'/>" class="btn btn-outline-secondary ml-2">목록</a>
            <c:if test="${not empty event.eventId}">
              <button type="button" id="btnDelete" class="btn btn-outline-danger ml-2">삭제</button>
            </c:if>
          </div>
        </form>
      </div>
    </div>
  </div>

  <jsp:include page="../adminIncludes/footer.jsp"/>
</div>

<!-- 전체 미리보기(상세 페이지 형태) -->
<div class="modal fade" id="fullPreviewModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-xl modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">이벤트 미리보기</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span>&times;</span></button>
      </div>
      <div class="modal-body"><div id="fullPreviewBody"></div></div>
      <div class="modal-footer"><button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button></div>
    </div>
  </div>
</div>

<script src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

<script>
document.addEventListener('DOMContentLoaded', function(){

  // ===== 로그인 정보 확인 =====
  var createdBy=document.querySelector('input[name="createdBy"]');
  var createdByName=document.querySelector('input[name="createdByName"]');
  if(!createdBy||!createdBy.value||!createdByName||!createdByName.value){
    window.location.href='<c:url value="/login"/>'+'?redirect='+encodeURIComponent(location.pathname+location.search);
    return;
  }

  // ===== 유료/무료 토글 (disabled 금지) =====
  const paidEl  = document.getElementById('paid');
  const priceEl = document.getElementById('price');
  const currEl  = document.getElementById('currency');

  function isPaidOn(v){ return v === true || v === 'true' || v === '1'; }
  function lockCurrency(lock){
    currEl.classList.toggle('is-readonly', lock);
    currEl.style.pointerEvents = lock ? 'none' : '';
    currEl.tabIndex = lock ? -1 : 0;
  }
  function togglePrice(){
    const paid = isPaidOn(paidEl.value);
    priceEl.readOnly = !paid;     // 전송엔 영향 없음
    lockCurrency(!paid);          // select는 UI만 잠금
    if (!paid && (priceEl.value === '' || priceEl.value == null)) priceEl.value = 0;
  }
  paidEl.addEventListener('change', togglePrice);
  togglePrice();

  // 제출 전 안전장치: 값 전송되게 보장
  document.getElementById('eventForm')?.addEventListener('submit', () => {
    priceEl.readOnly = false;
    lockCurrency(false);
  });

  // ===== 날짜 검증 =====
  const startEl=document.getElementById('startDate'), endEl=document.getElementById('endDate');
  document.getElementById('eventForm').addEventListener('submit',function(e){
    if(startEl&&endEl&&startEl.value&&endEl.value&&endEl.value<startEl.value){
      e.preventDefault(); alert('종료일시는 시작일시 이후여야 합니다.'); endEl.focus();
    }
  });

  // ===== 삭제 버튼 =====
  const delBtn=document.getElementById('btnDelete');
  if(delBtn){
    delBtn.addEventListener('click',function(){
      if(!confirm('정말 삭제하시겠습니까? 삭제 후 되돌릴 수 없습니다.')) return;
      var f=document.createElement('form');
      f.method='post';
      f.action='<c:url value="/admin/events/${event.eventId}/delete"/>';
      f.innerHTML='<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">';
      document.body.appendChild(f); f.submit();
    });
  }

  /* ===== 대표 이미지/첨부 파일 ===== */
  (function(){
    const desc        = document.getElementById('desc');
    const posterFile  = document.getElementById('posterFile');
    const posterSlot  = document.getElementById('posterSlot');
    const filesInput  = document.getElementById('filesInput');
    const filesGrid   = document.getElementById('filesGrid');
    const btnSync     = document.getElementById('btnSyncTokens');

    // 상태: 파일별 key -> { token, el, name }
    const state = {
      order: [],
      map: new Map(),
      keyOf(f){ return [f.name, f.size, f.type, f.lastModified].join('|'); }
    };

    const isImg = f => !!(f && f.type && f.type.indexOf('image/') === 0);
    const escRe = s => String(s).replace(/[-/\\^$*+?.()|[\]{}]/g,'\\$&');

    function insertTokenOnce(token){
      if(!token) return;
      if(desc.value.indexOf(token) !== -1) return; // 중복 방지
      const hasSel = Number.isInteger(desc.selectionStart);
      if(hasSel){
        const s = desc.selectionStart, e = desc.selectionEnd, v = desc.value;
        const nl = (v && s>0 && v[s-1] !== '\n') ? '\n' : '';
        desc.value = v.slice(0,s) + nl + token + '\n' + v.slice(e);
        const pos = s + nl.length + token.length + 1;
        desc.selectionStart = desc.selectionEnd = pos;
      }else{
        const tailNL = desc.value.endsWith('\n') ? '' : '\n';
        desc.value = desc.value + tailNL + token + '\n';
      }
      desc.dispatchEvent(new Event('input',{bubbles:true}));
    }

    function removeTokenEverywhere(token){
      if(!token) return;
      const re = new RegExp('(^|\\n)'+escRe(token)+'\\n?','g');
      desc.value = desc.value.replace(re,'$1').replace(/\n{3,}/g,'\n\n');
      desc.dispatchEvent(new Event('input',{bubbles:true}));
    }

    /* ---------- 대표 이미지(본문 토큰 삽입 없음, 미리보기만) ---------- */
    posterFile?.addEventListener('change', () => {
      posterSlot.classList.remove('--filled');
      posterSlot.innerHTML = '<span class="text-muted">썸네일 미리보기</span>';
      const f = posterFile.files && posterFile.files[0];
      if(!f) return;
      const box = document.createElement('div');
      if(isImg(f)){
        const img = document.createElement('img');
        img.src = URL.createObjectURL(f);
        img.onload = () => URL.revokeObjectURL(img.src);
        box.appendChild(img);
      }else{
        box.innerHTML = '<div class="text-muted small">이미지 아님</div>';
      }
      posterSlot.innerHTML = '';
      posterSlot.appendChild(box);
      posterSlot.classList.add('--filled');
    });

    /* ---------- 유틸: 파일명 안전 추출 ---------- */
    function _basename(p){ return String(p||'').split(/[\\/]/).pop(); }
    function _safeName(file, inputEl){
      return (file && file.name)
          || (file && file.webkitRelativePath && _basename(file.webkitRelativePath))
          || _basename(inputEl && inputEl.value)
          || '';
    }

    /* 같은 파일 다시 선택해도 change 트리거되게 */
    filesInput?.addEventListener('click', () => { filesInput.value = ''; });

    /* ---------- 첨부(여러개) change 핸들러 ---------- */
    filesInput?.addEventListener('change', function(){
      const inputEl = this;
      let list = Array.from(inputEl.files || []);

      // 드문 환경: files 비고 value만 있는 경우(C:\fakepath\xxx.jpg)
      if(list.length === 0 && inputEl.value){
        const n = _basename(inputEl.value);
        if(n) insertTokenOnce(`[[file:${n}]]`);
        return;
      }

      list.forEach(file=>{
        const name = _safeName(file, inputEl);
        if(!name) return;

        // 중복 방지 키
        const key = [name, file.size||0, file.type||'', file.lastModified||0].join('|');
        if(state.map.has(key)) return;

        // 토큰 생성
        const token = (file && file.type && file.type.indexOf('image/')===0)
          ? `[[img:${name}]]`
          : `[[file:${name}]]`;

        // 본문에 1회 삽입
        insertTokenOnce(token);

        // 카드 생성/등록
        const card = makeCard(file, key, name);
        state.map.set(key, {token, el:card, name});
        state.order.push(key);
        filesGrid.appendChild(card);
      });
    });

    /* ---------- 첨부 카드 ---------- */
    function makeCard(file, key, safeName){
      const card = document.createElement('div');
      card.className = 'file-card';
      card.draggable = true;
      card.dataset.key = key;
      card.dataset.name = safeName || (file && file.name) || '';

      const close = document.createElement('button');
      close.type = 'button';
      close.className = 'x';
      close.textContent = '×';

      let body;
      if(isImg(file)){
        body = document.createElement('img');
        body.src = URL.createObjectURL(file);
        body.onload = () => URL.revokeObjectURL(body.src);
      }else{
        body = document.createElement('div');
        body.className = 'p-2 text-center small text-muted';
        body.textContent = '파일';
      }

      const label = document.createElement('div');
      label.className = 'label';
      label.textContent = card.dataset.name || '(이름없음)';

      card.appendChild(body);
      card.appendChild(close);
      card.appendChild(label);

      // 삭제: 토큰 제거 + 상태/DOM + input.files 동기화
      close.addEventListener('click', () => {
        const info  = state.map.get(key);
        const name  = info?.name || card.dataset.name;
        const token = info?.token || (card.querySelector('img') ? `[[img:${name}]]` : `[[file:${name}]]`);

        removeTokenEverywhere(token);

        state.map.delete(key);
        state.order = state.order.filter(k => k !== key);

        // input.files에서도 제거
        const dt = new DataTransfer();
        Array.from(filesInput.files || []).forEach(f => {
          const k = [f.name, f.size, f.type, f.lastModified].join('|');
          if (k !== key) dt.items.add(f);
        });
        filesInput.files = dt.files;

        card.remove();
      });

      // 드래그 정렬
      card.addEventListener('dragstart', e => {
        card.classList.add('dragging');
        e.dataTransfer.setData('text/plain', key);
      });
      card.addEventListener('dragend', () => card.classList.remove('dragging'));

      filesGrid.addEventListener('dragover', e => {
        e.preventDefault();
        const dragging = filesGrid.querySelector('.file-card.dragging');
        if(!dragging) return;
        const after = getAfter(filesGrid, e.clientX, e.clientY);
        if(after) filesGrid.insertBefore(dragging, after);
        else filesGrid.appendChild(dragging);
      });
      filesGrid.addEventListener('drop', () => {
        state.order = Array.from(filesGrid.querySelectorAll('.file-card'))
                      .map(el => el.dataset.key);
      });

      return card;
    }

    function getAfter(container, x, y){
      const els = [...container.querySelectorAll('.file-card:not(.dragging)')];
      return els.reduce((closest, child) => {
        const r   = child.getBoundingClientRect();
        const off = y - r.top - r.height/2;
        return (off < 0 && off > closest.offset) ? {offset:off, el:child} : closest;
      }, {offset:-Infinity, el:null}).el;
    }

    /* ---------- 카드 순서를 본문 토큰 순서로 반영 ---------- */
    btnSync?.addEventListener('click', () => {
      if(!state.order.length) return;
      const tokens = state.order.map(k => state.map.get(k)?.token).filter(Boolean);
      const re = new RegExp('(^|\\n)(' + tokens.map(escRe).join('|') + ')\\n?','g');
      desc.value = desc.value.replace(re,'$1').replace(/\n{3,}/g,'\n\n');
      const tail = desc.value.endsWith('\n') ? '' : '\n';
      desc.value = desc.value + tail + tokens.join('\n') + '\n';
      desc.dispatchEvent(new Event('input',{bubbles:true}));
    });
  })();
  
  // ===== Kakao 지도(폼 영역) =====
  window.map = null; window.geocoder = null; window.marker = null; window.infowindow = null;
  function initMap(){
    const el=document.getElementById('map'); if(!el) return;
    const center=new kakao.maps.LatLng(37.5665,126.9780);
    map=new kakao.maps.Map(el,{center:center,level:3});
    geocoder=new kakao.maps.services.Geocoder();
    marker=new kakao.maps.Marker({map:map,position:center});
    infowindow=new kakao.maps.InfoWindow({content:''});
    setTimeout(function(){ map.relayout(); map.setCenter(center); },0);

    const latEl=document.getElementById('latitude'), lngEl=document.getElementById('longitude');
    if(latEl&&lngEl&&latEl.value&&lngEl.value){
      const pos=new kakao.maps.LatLng(parseFloat(latEl.value), parseFloat(lngEl.value));
      marker.setPosition(pos); map.setCenter(pos);
    }
  }
  kakao.maps.load(initMap);

  // ===== 주소 검색 레이어 =====
  function setAddressFields(addr, lat, lng){
    var loc=document.getElementById('location');
    var la =document.getElementById('latitude');
    var lo =document.getElementById('longitude');
    if(loc) loc.value = addr || '';
    if(la)  la.value  = (lat ?? '');
    if(lo)  lo.value  = (lng ?? '');
  }
  function ensureDaumPostcode(cb){
    if(window.daum && daum.Postcode){ cb(); return; }
    var s=document.querySelector('script[data-daum-postcode]');
    if(!s){
      s=document.createElement('script');
      s.src='https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js';
      s.setAttribute('data-daum-postcode','1');
      document.head.appendChild(s);
    }
    s.onload=cb;
  }
  function openPostcodeLayer(){ var layer=document.getElementById('postcodeLayer'); if(layer) layer.style.display='block'; }
  function closePostcodeLayer(){ var layer=document.getElementById('postcodeLayer'); if(layer) layer.style.display='none'; }
  document.getElementById('postcodeClose')?.addEventListener('click', closePostcodeLayer);

  window.execDaumPostcode = function(){
    ensureDaumPostcode(function(){
      var container=document.getElementById('postcodeContainer'); if(!container) return;
      container.innerHTML=''; openPostcodeLayer();

      var pc=new daum.Postcode({
        width:'100%', height:'100%',
        oncomplete:function(data){
          var addr=data.roadAddress||data.jibunAddress||'';
          if(!addr){ closePostcodeLayer(); return; }
          setAddressFields(addr,'','');
          try{
            if(!geocoder) geocoder=new kakao.maps.services.Geocoder();
            geocoder.addressSearch(addr,function(result,status){
              if(status===kakao.maps.services.Status.OK && result[0]){
                var lat=parseFloat(result[0].y), lng=parseFloat(result[0].x);
                setAddressFields(addr, lat, lng);
                if(map && marker){
                  var pos=new kakao.maps.LatLng(lat,lng);
                  marker.setPosition(pos);
                  if(infowindow){ infowindow.setContent('<div style="padding:5px;">'+addr+'</div>'); infowindow.open(map,marker); }
                  setTimeout(function(){ map.relayout(); map.setCenter(pos); },0);
                }
              }else{
                alert('좌표 변환 실패: 주소를 찾을 수 없습니다.');
              }
            });
          }catch(e){ console.error(e); alert('좌표 변환 중 오류가 발생했습니다.'); }
          closePostcodeLayer();
        }
      });
      pc.embed(container,{autoClose:false});
    });
  };

  // ===== 전체(상세) 미리보기 =====
  (function(){
    const btn    = document.getElementById('btnFullPreview');
    const bodyEl = document.getElementById('fullPreviewBody');
    if(!btn || !bodyEl) return;

    const filesInput = document.getElementById('filesInput');
    const baseUrl = '<c:url value="/uploads/events/"/>';

    function blobs(){ const m={}; if(!filesInput||!filesInput.files) return m; Array.from(filesInput.files).forEach(f=>m[f.name]=URL.createObjectURL(f)); return m; }
    function esc(s){return String(s).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');}
    function renderTokens(text){
      const bm = blobs(); let html = esc(text||'');
      html = html.replace(/\[\[img:([^\]\n]+)\]\]/g, (_,n) => {
        n=n.trim(); const src=bm[n] || (baseUrl+encodeURIComponent(n)); return '<img class="preview-img" alt="'+esc(n)+'" src="'+src+'">';
      });
      html = html.replace(/\[\[file:([^\]\n]+)\]\]/g, (_,n) => {
        n=n.trim(); const href=bm[n] || (baseUrl+encodeURIComponent(n)); return '<a target="_blank" rel="noopener" href="'+href+'">'+esc(n)+'</a>';
      });
      return html.replace(/\n/g,'<br>');
    }

    function buildHTML(){
      const title = document.querySelector('input[name="title"]')?.value || '';
      const description = document.getElementById('desc')?.value || '';
      const paid = document.getElementById('paid')?.value === 'true';
      const price = document.getElementById('price')?.value || 0;
      const currency = document.getElementById('currency')?.value || 'KRW';
      const start = document.getElementById('startDate')?.value || '';
      const end   = document.getElementById('endDate')?.value || '';
      const category   = document.querySelector('select[name="category"]')?.value || '';
      const writerName = document.querySelector('input[name="createdByName"]')?.value || '';
      const location   = document.getElementById('location')?.value || '';
      const lat  = document.getElementById('latitude')?.value || '';
      const lng  = document.getElementById('longitude')?.value || '';

      const pf = document.getElementById('posterFile');
      let poster = '';
      if (pf && pf.files && pf.files[0] && pf.files[0].type.indexOf('image/')===0){
        poster = URL.createObjectURL(pf.files[0]);
      } else {
        poster = '${empty event.posterUrl ? "" : event.posterUrl}';
      }
      const posterIsBlob = poster && poster.indexOf('blob:') === 0;

      const descHTML = renderTokens(description);
      const priceView = paid ? (price + ' <small>/ ' + currency + '</small>') : '무료';

      var html = ''
       + '<div class="container-fluid">'
       +   '<div class="row kv-grid">'
       +     '<div class="col col-12 col-md-6 col-xl-3"><div class="kv"><div class="k">설문 제목</div><div class="v">'+esc(title||'-')+'</div></div></div>'
       +     '<div class="col col-12 col-md-6 col-xl-3"><div class="kv"><div class="k">이벤트명</div><div class="v">'+esc(title||'-')+'</div></div></div>'
       +     '<div class="col col-12 col-md-6 col-xl-3"><div class="kv"><div class="k">오픈 일시</div><div class="v">'+esc(start||'-')+'</div></div></div>'
       +     '<div class="col col-12 col-md-6 col-xl-3"><div class="kv"><div class="k">마감 일시</div><div class="v">'+esc(end||'-')+'</div></div></div>'
       +     '<div class="col col-12 col-md-6 col-xl-3"><div class="kv"><div class="k">생성자</div><div class="v">'+esc(writerName||'-')+'</div></div></div>'
       +     '<div class="col col-12 col-md-6 col-xl-3"><div class="kv"><div class="k">유료/가격</div><div class="v">'+priceView+'</div></div></div>'
       +     '<div class="col col-12 col-md-6 col-xl-3"><div class="kv"><div class="k">템플릿키</div><div class="v">CUSTOMER_EVENT_ISANON</div></div></div>'
       +     '<div class="col col-12 col-md-6 col-xl-3"><div class="kv"><div class="k">카테고리</div><div class="v">'+esc(category||'-')+'</div></div></div>'
       +   '</div>'
       +   '<hr class="my-3">'
       +   '<h6 class="mb-2">포스터</h6>'
       +   (poster ? '<img src="'+poster+'" style="max-height:150px;border:1px solid #e5e7eb;border-radius:.375rem;margin-bottom:12px">' : '<div class="text-muted mb-2">-</div>')
       +   '<h6 class="mt-3 mb-2">본문</h6>'
       +   '<div style="white-space:normal; word-break:break-word;">' + (descHTML || '<span class="text-muted">-</span>') + '</div>'
       +   '<h6 class="mt-4 mb-2">장소 / 지도</h6>'
       +   '<div class="mb-2 text-muted">' + esc(location || '-') + '</div>'
       +   '<div id="fullPreviewMap" style="width:100%;height:360px;border:1px solid #e5e7eb;border-radius:.375rem"></div>'
       + '</div>';

      return { html, lat, lng, location, posterIsBlob };
    }

    function buildMap(lat, lng, addr){
      const el = document.getElementById('fullPreviewMap');
      if(!el || !window.kakao || !kakao.maps) return;

      const center = (lat && lng) ? new kakao.maps.LatLng(parseFloat(lat), parseFloat(lng))
                                  : new kakao.maps.LatLng(37.5665,126.9780);
      const map = new kakao.maps.Map(el, { center:center, level:3 });
      const marker = new kakao.maps.Marker({ map, position:center });
      const info = new kakao.maps.InfoWindow({ content: '<div style="padding:5px;">'+esc(addr||'')+'</div>' });
      if (addr) info.open(map, marker);

      if ((!lat || !lng) && addr){
        const geocoder = new kakao.maps.services.Geocoder();
        geocoder.addressSearch(addr, function(result, status){
          if(status === kakao.maps.services.Status.OK && result[0]){
            const p = new kakao.maps.LatLng(parseFloat(result[0].y), parseFloat(result[0].x));
            marker.setPosition(p); map.setCenter(p); info.open(map, marker);
          }
        });
      }
      setTimeout(()=>{ map.relayout(); }, 0);
    }

    btn.addEventListener('click', function(){
      const {html, lat, lng, location, posterIsBlob} = buildHTML();
      bodyEl.innerHTML = html;

      $('#fullPreviewModal').on('shown.bs.modal', function(){
        buildMap(lat, lng, location);
      }).on('hidden.bs.modal', function(){
        try{
          const pf = document.getElementById('posterFile');
          if (posterIsBlob && pf && pf.files && pf.files[0]) URL.revokeObjectURL(pf.files[0]);
          if (filesInput && filesInput.files){
            Array.from(filesInput.files).forEach(f=>{ try{ URL.revokeObjectURL(f); }catch(e){} });
          }
        }catch(e){}
        $(this).off('shown.bs.modal hidden.bs.modal');
      });
    });
  })();

});
</script>

<script src="${pageContext.request.contextPath}/resources/js/sb-admin-2.min.js"></script>
</body>
</html>
