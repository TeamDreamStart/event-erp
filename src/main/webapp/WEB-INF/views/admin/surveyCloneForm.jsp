<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />

<!-- CSRF -->
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<meta name="current-user-id" content="${loginUser.userId}" />

<title>설문 템플릿 클론</title>

<!-- SB Admin + Bootstrap (프로젝트 기준경로 맞추세요) -->
<link href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">

<style>
/* === 회원 상세 폼 톤으로 정렬 === */
:root{
  --pri:#4e73df; --text:#5a5c69; --muted:#858796;
  --bd:#e3e6f0; --bg:#f8f9fc; --white:#fff;
}
body{background:var(--bg); color:var(--text);}
.page-h1{font-weight:700; font-size:1.25rem; color:var(--text);}
.block-title{
  display:flex; align-items:center; gap:.5rem;
  background:var(--bg); border:1px solid var(--bd);
  border-left:4px solid var(--pri);
  border-radius:.35rem; padding:.5rem .75rem; color:var(--text);
  font-weight:700; font-size:.95rem; margin-bottom:.5rem;
}
.card{border:1px solid var(--bd);}
.card-header{background:var(--white);}

/* 네 폼의 기존 클래스들 유지 + 톤만 맞춤 */
.container-fluid .radio-item{
  border:1px solid var(--bd); border-radius:.35rem; padding:12px 14px; background:var(--white);
  transition:box-shadow .15s,border-color .15s;
}
.container-fluid .radio-item:hover{box-shadow:0 6px 16px rgba(0,0,0,.06); border-color:#d1d3e2}
.section-title{font-weight:700;margin:.5rem 0 .25rem;}
.badge-hint{background:#eef2ff;color:#1e3a8a;}
.editor-card{background:var(--white); border:1px solid var(--bd); border-radius:.35rem; padding:1rem}
.q-row{border-top:1px dashed var(--bd); padding-top:10px; margin-top:10px}
.q-row:first-child{border-top:0; padding-top:0; margin-top:0}
.q-row .head{display:flex; align-items:center; gap:8px; flex-wrap:nowrap}
.q-row .q-title{min-width:0; flex:1 1 auto}
.q-row .actions{flex:0 0 auto; white-space:nowrap}
.q-row .q-type{max-width:200px}
.icon-btn{border:1px solid var(--bd); background:var(--white); border-radius:.35rem; padding:2px 8px}
.opt-row{display:flex; gap:8px; margin:6px 0; align-items:center}
.opt-row .opt-preview{flex:0 0 auto; display:inline-flex; align-items:center}
.opt-label{flex:1}
.opt-value{width:160px}

/* 반응형(회원 상세 폼 느낌 유지) */
@media (max-width:992px){
  .q-row .head{flex-wrap:wrap}
  .q-row .q-title{flex:1 1 100%}
  .q-row .actions{width:100%; display:flex; gap:6px; margin-top:6px}
  .opt-row{flex-wrap:wrap}
  .opt-label{flex:1 1 100%}
  .opt-value{flex:1 1 120px}
}

/* 상단/하단 버튼 영역 간격 */
.actions-bar{gap:.5rem}

/* 하단 스티키 액션바 */
.sticky-actions{
  position: sticky; bottom: 0; z-index: 10;
  background:#fff; border-top:1px solid #e9ecef;
  padding:.75rem 0;
}
@media (max-width:576px){ .sticky-actions{ padding:.75rem .25rem; } }

/* 복제중 스피너 */
.btn-loading{pointer-events:none; opacity:.85}
.btn-loading .spinner-border{width:1rem; height:1rem; border-width:.2rem}
</style>
</head>

<body id="page-top">
<div id="wrapper">

  <!-- SB Admin 헤더/사이드바/탑바 -->
  <jsp:include page="../adminIncludes/header.jsp" />

  <div class="container-fluid">

    <!-- 타이틀 -->
    <div class="d-flex align-items-center mb-3">
      <a class="btn btn-outline-secondary btn-sm mr-2" href="<c:url value='/admin/surveys'/>">← 뒤로가기</a>
      <h1 class="page-h1 mb-0">설문 템플릿 클론</h1>
      <span class="ml-2 small text-muted">템플릿을 골라 이벤트용 설문으로 복제합니다.</span>
    </div>

    <!-- 템플릿/이벤트/스케줄/상태 -->
    <div class="row">
      <!-- 템플릿 -->
      <div class="col-12 col-lg-7 mb-3">
        <div class="block-title"><i class="fas fa-list text-primary"></i> 템플릿 선택</div>
        <div class="card shadow-sm">
          <div class="card-body">
            <div id="tmplList">
              <c:forEach var="t" items="${templates}">
                <label class="radio-item w-100 d-block mb-2">
                  <input type="radio" name="templateId" value="${t.surveyId}"
                         class="form-check-input mr-2"
                         data-title="${t.title}" data-desc="${t.description}"
                         <c:if test="${t.surveyId eq selectedTemplateId}">checked</c:if>>
                  [${t.templateKey}] ${t.title}
                  <div class="text-muted mt-1 small">${t.description}</div>
                </label>
              </c:forEach>
            </div>
            <div class="small text-muted mt-2">선택 후 오른쪽 카드에서 이벤트/스케줄/상태를 지정하세요.</div>
          </div>
        </div>
      </div>

      <!-- 우측 카드 스택 -->
      <div class="col-12 col-lg-5 mb-3">
        <div class="block-title"><i class="far fa-calendar-alt text-primary"></i> 이벤트 / 스케줄 / 상태</div>

        <div class="card shadow-sm mb-3">
          <div class="card-header py-2"><strong>이벤트 선택</strong></div>
          <div class="card-body">
            <select id="eventSel" class="form-control">
              <option value="">- 이벤트 선택 -</option>
              <c:forEach var="e" items="${eventList}">
                <option value="${e.eventId}" <c:if test="${e.eventId eq selectedEventId}">selected</c:if>>
                  ${e.title} (${e.startDate} ~ ${e.endDate})
                </option>
              </c:forEach>
            </select>
          </div>
        </div>

        <div class="card shadow-sm mb-3">
          <div class="card-header py-2 d-flex align-items-center justify-content-between">
            <strong>스케줄</strong>
            <span class="badge badge-hint badge-pill">open/close 자동 계산</span>
          </div>
          <div class="card-body">
            <div class="form-group mb-2">
              <select id="scheduleMode" class="form-control">
                <option value="default">기본 (종료 즉시 오픈, 7일 후 종료)</option>
                <option value="offset">오프셋 지정 (종료 +N시간 후 오픈, M일 후 마감)</option>
              </select>
            </div>
            <div class="form-row">
              <div class="form-group col-6">
                <input id="openDelayHours" type="number" class="form-control" value="0" disabled placeholder="오픈 지연 (N시간)">
              </div>
              <div class="form-group col-6">
                <input id="closeAfterDays" type="number" class="form-control" value="7" disabled placeholder="마감 (오픈 후 M일)">
              </div>
            </div>
            <div class="small text-muted">※ open_at / close_at 은 서버에서 자동 계산됩니다.</div>
          </div>
        </div>

        <div class="card shadow-sm">
          <div class="card-header py-2"><strong>생성 상태</strong></div>
          <div class="card-body">
            <select id="statusSel" class="form-control">
              <option value="DRAFT">작성중 (DRAFT)</option>
              <option value="OPEN">배포 (OPEN)</option>
              <option value="CLOSED">종료 (CLOSED)</option>
              <option value="ARCHIVED">보관 (ARCHIVED)</option>
            </select>
            <div class="small text-muted mt-2">기본값은 <b>DRAFT</b>. 필요 시 바로 <b>OPEN</b>으로 생성 가능.</div>
          </div>
        </div>
      </div>
    </div>

    <!-- 복제될 설문 정보 -->
    <div class="block-title"><i class="fas fa-pen text-primary"></i> 복제될 설문 정보</div>
    <div class="card shadow-sm mb-3">
      <div class="card-body">
        <div class="section-title">📝 복제될 설문 제목</div>
        <input id="surveyTitle" class="form-control" placeholder="설문 제목을 입력하세요" value="${prefillTitle}">
        <div class="form-text">템플릿 제목을 기본값으로 채우되, 여기서 변경 가능합니다.</div>

        <div class="section-title mt-3">🗒️ 복제될 설문 설명</div>
        <textarea id="surveyDesc" rows="3" class="form-control" placeholder="설문 설명을 입력하세요">${prefillDesc}</textarea>
      </div>
    </div>

    <!-- 에디터 -->
    <div class="block-title"><i class="fas fa-tools text-primary"></i> 문항/보기 에디터</div>
    <div class="card shadow-sm mb-2">
      <div class="card-header py-2 d-flex align-items-center flex-wrap actions-bar">
        <span class="small text-muted">템플릿 선택 + 이벤트 선택 시 자동 로드</span>
        <div class="ml-auto d-flex align-items-center" style="gap:.5rem;">
          <div class="custom-control custom-checkbox">
            <input id="chkAll" type="checkbox" class="custom-control-input">
            <label for="chkAll" class="custom-control-label font-weight-bold">전체 선택</label>
          </div>
          <div class="vr d-none d-lg-inline mx-2"></div>
          <select id="bulkType" class="form-control form-control-sm" style="max-width:200px">
            <option value="">보기 유형 일괄변경…</option>
            <option value="single">단일선택</option>
            <option value="multi">복수선택</option>
            <option value="scale_5">5점 척도</option>
            <option value="text">주관식(텍스트)</option>
          </select>
          <button id="btnBulkType" class="btn btn-sm btn-outline-secondary">적용</button>
          <button id="btnBulkDel" class="btn btn-sm btn-outline-danger">선택 삭제</button>
        </div>
      </div>
      <div class="card-body">
        <div class="editor-card" id="qaEditor">
          <div class="text-muted">템플릿과 이벤트를 선택하면 문항을 자동으로 가져옵니다.</div>
        </div>
      </div>
    </div>

    <!-- 하단 액션 (스티키) -->
	<div class="d-flex flex-wrap align-items-center justify-content-between actions-bar mb-4">
	  <div>
	    <button id="btnAddQ" class="btn btn-outline-secondary">문항 추가</button>
	  </div>
	
	  <!-- 고정 템플릿: 복제만 -->
	  <c:if test="${isTemplate}">
	    <div>
	      <button id="btnClone" class="btn btn-primary" data-loading-label="복제중…">템플릿 복제</button>
	      <a href="<c:url value='/admin/surveys'/>" class="btn btn-outline-secondary">목록으로</a>
	    </div>
	  </c:if>
	
	  <!-- 일반 설문(복제된 설문): 수정/삭제 -->
	  <c:if test="${!isTemplate}">
	    <div>
	      <a href="<c:url value='/admin/surveys/${surveyId}/edit'/>" class="btn btn-primary">수정</a>
	      <a href="<c:url value='/admin/surveys/${surveyId}/delete'/>" class="btn btn-danger"
	         onclick="return confirm('삭제하시겠습니까?');">삭제</a>
	      <a href="<c:url value='/admin/surveys'/>" class="btn btn-outline-secondary">목록으로</a>
	    </div>
	  </c:if>
	</div>



  </div><!-- /.container-fluid -->

  <!-- SB Admin 푸터 -->
  <jsp:include page="../adminIncludes/footer.jsp" />
</div><!-- /#wrapper -->

<!-- Scroll to Top / Logout Modal -->
<a class="scroll-to-top rounded" href="#page-top"><i class="fas fa-angle-up"></i></a>
<jsp:include page="../adminIncludes/logoutModal.jsp" />

<!-- SB Admin 스크립트 -->
<script src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/sb-admin-2.min.js"></script>

<script>
/* ======== 스피너 토글 ======== */
function setLoading(btn, on){
  if(!btn) return;
  if(on){
    btn.dataset._orig = btn.innerHTML;
    const label = btn.dataset.loadingLabel || '처리중…';
    btn.innerHTML = '<span class="spinner-border spinner-border-sm mr-1"></span>'+label;
    btn.classList.add('btn-loading'); btn.disabled = true;
  }else{
    btn.innerHTML = btn.dataset._orig || btn.innerText || '완료';
    btn.classList.remove('btn-loading'); btn.disabled = false;
  }
}

/* ===== 공통 ===== */
const CSRF_TOKEN  = document.querySelector('meta[name="_csrf"]')?.content;
const CSRF_HEADER = document.querySelector('meta[name="_csrf_header"]')?.content || 'X-CSRF-TOKEN';
const CSRF_HEADERS = CSRF_TOKEN ? { [CSRF_HEADER]: CSRF_TOKEN } : {};
const $  = (sel, ctx=document) => ctx.querySelector(sel);
const $$ = (sel, ctx=document) => Array.from(ctx.querySelectorAll(sel));
const CTX  = '${pageContext.request.contextPath}';
const BASE = location.origin + CTX;

function showModal(msg, onClose){
  const id='resultModal';
  if(!document.getElementById(id)){
    document.body.insertAdjacentHTML('beforeend',
      '<div class="modal fade" id="'+id+'" tabindex="-1" aria-hidden="true"><div class="modal-dialog"><div class="modal-content"><div class="modal-header"><h5 class="modal-title">알림</h5></div><div class="modal-body" id="modalMsg">처리 결과</div><div class="modal-footer"><button type="button" class="btn btn-primary" id="modalOk">확인</button></div></div></div></div>');
  }
  document.getElementById('modalMsg').textContent = msg;
  const m = new bootstrap.Modal(document.getElementById(id));
  document.getElementById('modalOk').onclick = ()=>{ m.hide(); onClose && onClose(); };
  m.show();
}

/* ===== 스케줄 ===== */
function toggleScheduleInputs(){
  const mode = $("#scheduleMode").value;
  $("#openDelayHours").disabled = (mode !== 'offset');
  $("#closeAfterDays").disabled = (mode !== 'offset');
}
$("#scheduleMode").addEventListener('change', toggleScheduleInputs);
toggleScheduleInputs();

/* ===== 템플릿/이벤트 선택 → 자동 로드 ===== */
function tryAutoLoad(){
  const tid = $('input[name="templateId"]:checked')?.value;
  const eid = $('#eventSel')?.value;
  if (tid && eid) { loadTemplateQA(tid); }
}
function setIfEmpty(el, val){
  if (!el) return;
  if (String(el.value||'').trim()) return;
  if (val != null && String(val).trim()) el.value = String(val).trim();
}
function prefillFromSelectedTemplate(){
  const r = document.querySelector('input[name="templateId"]:checked');
  if (!r) return;
  setIfEmpty(document.getElementById('surveyTitle'), r.dataset.title || '');
  setIfEmpty(document.getElementById('surveyDesc'),  r.dataset.desc  || '');
}
document.getElementById('tmplList')?.addEventListener('change', (e)=>{
  if (e.target.name === 'templateId') prefillFromSelectedTemplate();
});
$("#eventSel").addEventListener('change', tryAutoLoad);
document.addEventListener('DOMContentLoaded', prefillFromSelectedTemplate);

/* ===== 템플릿 QA 로드 ===== */
async function loadTemplateQA(templateId){
  try{
    const res  = await fetch(BASE + '/admin/api/surveys/template-qa?templateId=' + templateId,
      {credentials:'same-origin', headers:{'Accept':'application/json'}});
    const data = await res.json();
    const byQ = data.optionsByQ || {};
    const qs = (data.questions || []).map(q => ({
      type: normalizeType(q.type),
      question: q.question || '',
      options: (byQ[q.questionId] || []).map(o => ({ label:o.label||'', optValue:o.optValue }))
    }));
    renderEditor(qs.slice(0,20));
    if (!$('#surveyTitle').value.trim()) $('#surveyTitle').value = data.header?.title || data.title || '';
    if (!$('#surveyDesc').value.trim())  $('#surveyDesc').value  = data.header?.description || '';
  }catch(err){
    console.error(err);
    showModal('템플릿 로드 실패: ' + err);
  }
}
function normalizeType(t){
  if (!t) return 'scale_5';
  t = String(t).trim().toLowerCase();
  if (t === 'scale5' || t === 'scale-5') return 'scale_5';
  return (['single','multi','text','scale_5'].includes(t) ? t : 'scale_5');
}

/* ===== 에디터 ===== */
function previewMarkup(type, group){
  if (type === 'single' || type === 'scale_5') return `<input type="radio" disabled name="pv-${group}">`;
  if (type === 'multi') return `<input type="checkbox" disabled>`;
  return '';
}
function makeDefaultOptions(type){
  if (type === 'scale_5') {
    return [
      {label:'매우 불만족', optValue:1},
      {label:'불만족',     optValue:2},
      {label:'보통',       optValue:3},
      {label:'만족',       optValue:4},
      {label:'매우 만족',  optValue:5}
    ];
  }
  return [{label:'예', optValue:1}, {label:'아니오', optValue:2}];
}
function qBlock(type="scale_5", question="", options=[], no=1){
  const wrap = document.createElement('div');
  wrap.className = 'q-row';
  wrap.dataset.qType = type;
  wrap.innerHTML = `
    <div class="head">
      <input type="checkbox" class="form-check-input q-check mr-2">
      <div class="font-weight-bold mr-2"><span class="q-no">${no}</span>.</div>

      <select class="form-control form-control-sm q-type mr-2" style="max-width:200px">
        <option value="single">단일선택</option>
        <option value="multi">복수선택</option>
        <option value="scale_5">5점 척도</option>
        <option value="text">주관식</option>
      </select>

      <input class="form-control form-control-sm q-title" placeholder="질문 내용을 입력">

      <div class="actions ml-2">
        <button class="icon-btn btn-sm btn-outline-secondary" type="button" data-act="up">↑</button>
        <button class="icon-btn btn-sm btn-outline-secondary" type="button" data-act="down">↓</button>
        <button class="icon-btn btn-sm btn-outline-danger"     type="button" data-act="del">삭제</button>
      </div>
    </div>

    <div class="d-flex align-items-center mb-1" style="gap:.5rem;">
      <input type="checkbox" class="form-check-input opt-check-all" id="optall-${no}">
      <label for="optall-${no}" class="small text-muted mb-0">보기 전체 선택</label>
      <button class="btn btn-sm btn-outline-danger" type="button" data-act="opt-del-selected">선택 보기 삭제</button>
    </div>

    <div class="opts"></div>

    <div class="mt-1">
      <button class="btn btn-outline-secondary btn-sm" type="button" data-act="add-opt">보기 추가</button>
    </div>
  `;
  $('.q-type', wrap).value = type;
  $('.q-title', wrap).value = question || '';

  const optsWrap = $('.opts', wrap);
  const group = String(no);
  if ((type==='single' || type==='multi' || type==='scale_5') && (!options || options.length===0)) {
    options = makeDefaultOptions(type);
  }
  options.forEach(op => optsWrap.appendChild(optRow(op.label, op.optValue, type, group)));

  const update = () => { updateOptUI(wrap, $('.q-type', wrap).value); syncOptionPreviews(wrap, $('.q-type', wrap).value); };
  $('.q-type', wrap).addEventListener('change', () => { update(); renumber(); });
  update();

  wrap.addEventListener('click', (e) => {
    const act = e.target.dataset.act;
    if (!act) return;
    if (wrap.dataset.lock === 'textTail') return;

    if (act === 'add-opt') {
      const curType = $('.q-type', wrap).value;
      optsWrap.appendChild(optRow("", "", curType, group));
    }
    if (act === 'del')     { wrap.remove(); renumber(); }
    if (act === 'up')      { wrap.previousElementSibling?.before(wrap); renumber(); }
    if (act === 'down')    { wrap.nextElementSibling?.after(wrap);     renumber(); }
    if (act === 'opt-del-selected') {
      $$('.opt-row', wrap).filter(r => r.querySelector('.opt-mark')?.checked).forEach(r => r.remove());
    }
  });

  $('.opt-check-all', wrap).addEventListener('change', (e) => {
    $$('.opt-row .opt-mark', wrap).forEach(c => c.checked = e.target.checked);
  });

  return wrap;
}
function optRow(label="", optValue="", type="single", group="g1"){
  const row = document.createElement('div');
  row.className = 'opt-row';
  row.innerHTML = `
    <span class="opt-preview mr-2"></span>
    <input class="form-control form-control-sm opt-label" placeholder="보기 라벨">
    <input class="form-control form-control-sm opt-value" placeholder="값(optValue)">
    <input type="checkbox" class="form-check-input ml-1 opt-mark" title="선택 삭제용">
    <button class="icon-btn btn-sm btn-outline-danger ml-1" type="button">삭제</button>
  `;
  $('.opt-label', row).value = label || '';
  $('.opt-value', row).value = (optValue ?? '') === '' ? '' : String(optValue);
  row.querySelector('button').addEventListener('click', ()=>row.remove());
  return row;
}
function updateOptUI(wrap, type){
  const optsWrap = $('.opts', wrap);
  const toolbar  = wrap.querySelector('.d-flex.align-items-center.mb-1');
  if (type === 'text') {
    toolbar.style.display = 'none';
    optsWrap.innerHTML = '';
    optsWrap.style.display = 'none';
  } else {
    toolbar.style.display = '';
    optsWrap.style.display = '';
    if (!optsWrap.children.length) {
      makeDefaultOptions(type).forEach(op => {
        const group = $('.q-no', wrap).textContent;
        optsWrap.appendChild(optRow(op.label, op.optValue, type, group));
      });
    }
  }
  wrap.dataset.qType = type;
}
function syncOptionPreviews(wrap, type){
  const group = $('.q-no', wrap).textContent;
  $$('.opt-row .opt-preview', wrap).forEach(sp => sp.innerHTML = previewMarkup(type, group));
}
function ensureTailTextQuestion(focus=false){
  const host = $("#qaEditor");
  const rows = $$('.q-row', host);
  const last = rows[rows.length-1];
  if (last && last.dataset.lock === 'textTail') return last;

  const tail = qBlock('text', '기타 의견을 자유롭게 남겨주세요.', [], rows.length+1);
  tail.dataset.lock = 'textTail';
  $('.q-type', tail).disabled = true;
  $('[data-act="up"]', tail).style.display = 'none';
  $('[data-act="down"]', tail).style.display = 'none';
  $('[data-act="del"]', tail).style.display = 'none';
  const toolbar  = tail.querySelector('.d-flex.align-items-center.mb-1'); if (toolbar) toolbar.style.display='none';
  const opts = $('.opts', tail); opts.innerHTML = ''; opts.style.display='none';

  host.appendChild(tail);
  if (focus) $('.q-title', tail).focus();
  renumber();
  return tail;
}
function renderEditor(questions){
  const host = $('#qaEditor');
  host.innerHTML = '';
  questions.forEach((q, idx) => host.appendChild(qBlock(q.type, q.question, q.options||[], idx+1)));
  if (!questions.length) host.innerHTML = '<div class="text-muted">문항이 없습니다. "문항 추가"로 작성하세요.</div>';
  ensureTailTextQuestion();
  renumber();
}
function renumber(){
  $$('.q-row').forEach((row, i) => { const noEl = $('.q-no', row); if (noEl) noEl.textContent = String(i+1); });
  const all = $$('.q-row .q-check');
  const any = all.some(c => c.checked);
  const allchk = all.length>0 && all.every(c=>c.checked);
  const master = $('#chkAll');
  if (master) { master.checked = allchk; master.indeterminate = !allchk && any; }
}
$('#chkAll')?.addEventListener('change', (e)=>{ $$('.q-row .q-check').forEach(c => c.checked = e.target.checked); });

/* 문항 추가 */
$('#btnAddQ').addEventListener('click', ()=>{
  const host = $('#qaEditor');
  if (host.querySelector('.text-muted')) host.innerHTML = '';
  const row  = qBlock();
  const tail = ensureTailTextQuestion();
  if (tail) host.insertBefore(row, tail); else host.appendChild(row);
  renumber();
});

/* 일괄 유형 변경 */
$('#btnBulkType')?.addEventListener('click', ()=>{
  const v = $('#bulkType').value;
  if (!v) return;
  const selected = Array.from(document.querySelectorAll('.q-row .q-check:checked')).map(chk => chk.closest('.q-row'));
  const rows = (selected.length ? selected : $$('.q-row')).filter(r => r.dataset.lock !== 'textTail');
  if (v === 'text') { ensureTailTextQuestion(true); return; }
  rows.forEach(row => { const sel = row.querySelector('.q-type'); if (sel) sel.value = v; updateOptUI(row, v); syncOptionPreviews(row, v); });
  renumber();
});

/* ===== 페이로드 수집/검증 (원본 그대로) ===== */
function toIntOrNull(v){ const n = Number(String(v ?? '').trim()); return Number.isFinite(n) ? Math.trunc(n) : null; }
function collectPayload(templateId, eventId){
  ensureTailTextQuestion();
  const mode = $('#scheduleMode').value;
  const oq = $$('.q-row').map(q => {
    const typeRaw   = $('.q-type', q).value; 
    const typeUpper = typeRaw.toUpperCase();
    const question  = $('.q-title', q).value.trim();

    const uiOpts = $$('.opt-row', q).map(or => ({
      label   : $('.opt-label', or)?.value.trim() ?? '',
      optValue: $('.opt-value', or)?.value.trim()
    })).filter(o => o.label.length>0 || String(o.optValue||'').length>0);

    let options = [];
    if (typeRaw !== 'text') {
      const mapped = uiOpts.map((o,i)=>({ label:o.label, optValue: toIntOrNull(o.optValue) }));
      if (typeRaw === 'scale_5') {
        options = mapped.map((o,i)=>({ label:o.label, optValue:(i+1) })).slice(0,5);
      } else {
        options = mapped.map((o,i)=>({ label:o.label, optValue: Number.isInteger(o.optValue)?o.optValue:(i+1) }));
      }
    }
    return { type:typeUpper, question, options };
  });

  return {
    templateId, eventId,
    title: $('#surveyTitle').value.trim(),
    description: $('#surveyDesc').value.trim(),
    status: $('#statusSel').value,
    scheduleMode: mode,
    openDelayHours: Number($('#openDelayHours').value || 0),
    closeAfterDays: Number($('#closeAfterDays').value || 7),
    questions: oq
  };
}
function validatePayload(p){
  if (!p.title)       return {ok:false, msg:'제목을 입력하세요.'};
  if (!p.description) return {ok:false, msg:'설명을 입력하세요.'};
  const allowed = new Set(['SINGLE','MULTI','SCALE_5','TEXT']);
  const qs = p.questions||[];
  if (!qs.length) return {ok:false, msg:'문항이 없습니다.'};
  for (let i=0;i<qs.length;i++){
    const q = qs[i], no = i+1;
    if (!allowed.has(String(q.type))) return {ok:false, msg:`${no}번 문항 유형이 잘못되었습니다.`};
    if (!q.question || !q.question.trim()) return {ok:false, msg:`${no}번 문항 질문을 입력하세요.`};
    const t = q.type, opts = q.options||[];
    if (t==='TEXT'){ if (opts.length) return {ok:false, msg:`${no}번 문항(TEXT)은 보기를 넣지 마세요.`}; }
    else if (t==='SINGLE' || t==='MULTI'){ if (!opts.length) return {ok:false, msg:`${no}번 문항은 최소 1개 보기 필요.`}; }
    else if (t==='SCALE_5'){
      if (opts.length!==5) return {ok:false, msg:`${no}번 문항은 5점 보기 필요.`};
      for (let j=0;j<5;j++){ if (opts[j].optValue !== (j+1)) return {ok:false, msg:`${no}번 문항 optValue는 1~5.`}; }
    }
  }
  return {ok:true};
}

/* ===== 템플릿 복제 (인라인) ===== */
document.getElementById('btnClone')?.addEventListener('click', async (ev)=>{
  const btn = ev.currentTarget;
  let title = document.getElementById('surveyTitle').value.trim();
  const desc  = document.getElementById('surveyDesc').value.trim();
  if (!title) {
    const r = document.querySelector('input[name="templateId"]:checked');
    if (r?.dataset.title) {
      title = r.dataset.title.trim();
      document.getElementById('surveyTitle').value = title;
    }
  }
  if (!title){ alert('제목을 입력하세요.'); return; }
  if (!desc){  alert('설명을 입력하세요.'); return; }

  const templateId = (document.querySelector('input[name="templateId"]:checked')||{}).value;
  if (!templateId){ alert('템플릿을 선택하세요.'); return; }
  const eventId = document.getElementById('eventSel').value;
  if (!eventId){ alert('이벤트를 선택하세요.'); return; }

  const payload = collectPayload(Number(templateId), Number(eventId));
  const v = validatePayload(payload); if (!v.ok) return alert(v.msg);

  if (!confirm("'" + title + "' 제목으로 복제하시겠습니까?")) { alert('취소되었습니다.'); return; }

  try{
    setLoading(btn, true);
    const headers = {'Content-Type':'application/json','Accept':'application/json',...CSRF_HEADERS};
    const res = await fetch(BASE + '/admin/api/surveys/clone-inline', {method:'POST', headers, credentials:'same-origin', body:JSON.stringify(payload)});
    if (!res.ok) { const txt = await res.text(); throw new Error(txt || ('HTTP '+res.status)); }
    const data = await res.json();
    if (data.ok && data.surveyId) { alert('복제되었습니다.'); location.href = CTX + '/admin/surveys/' + data.surveyId; }
    else showModal('복제 실패');
  }catch(e){ showModal('복제 실패: ' + e); }
  finally{ setLoading(btn, false); }
});
</script>
</body>
</html>
