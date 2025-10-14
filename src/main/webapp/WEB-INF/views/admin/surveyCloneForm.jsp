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

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
/* ===== 레이아웃 / 스타일 ===== */
.container{max-width:100%;margin:0;padding:2rem 6rem;}
.radio-item{border:1px solid #eee;border-radius:12px;padding:16px;margin-bottom:12px;background:#fff;}
.section-title{font-weight:800;margin-top:10px;margin-bottom:6px;}
.badge-hint{background:#eef2ff;color:#1e3a8a;}
.editor-card{width:100%;background:#fff;border:1px solid #eee;border-radius:12px;padding:1.2rem;margin-top:1rem;box-sizing:border-box;}
.q-row{border-top:1px dashed #e5e7eb;padding-top:10px;margin-top:10px;}
.q-row:first-child{border-top:none;padding-top:0;margin-top:0;}
.q-row .head{display:flex;align-items:center;gap:8px;flex-wrap:nowrap;}
.q-row .q-title{min-width:0;flex:1 1 auto;}
.q-row .actions{flex:0 0 auto;white-space:nowrap;}
.q-row .q-type{max-width:200px;}
.opt-row{display:flex;gap:8px;margin:6px 0;align-items:center;}
.opt-row .opt-preview{flex:0 0 auto;display:inline-flex;align-items:center;}
.opt-row input[type="checkbox"]{width:auto;margin-right:0;flex:0 0 auto;}
.icon-btn{border:1px solid #e5e7eb;background:#fff;border-radius:8px;padding:4px 8px;}
/* 라벨/값 인풋에 명확한 클래스 (★ on 문제 원천 차단) */
.opt-label{flex:1;}
.opt-value{width:160px;}
</style>
</head>

<body>
<div class="container">

  <div class="d-flex align-items-center gap-2 mb-3">
    <a class="btn btn-outline-secondary" href="<c:url value='/admin/surveys'/>">&larr; 뒤로가기</a>
    <h2 class="mb-0">설문 템플릿 클론</h2>
  </div>

  <!-- 템플릿 선택 -->
  <div class="mb-3 section-title">📑 템플릿 선택</div>
  <div id="tmplList">
    <c:forEach var="t" items="${templates}">
      <label class="radio-item w-100 d-block">
        <input type="radio" name="templateId" value="${t.surveyId}"
       class="form-check-input me-2"
       data-title="${t.title}"
       data-desc="${t.description}"
       <c:if test="${t.surveyId eq selectedTemplateId}">checked</c:if>>

        [${t.templateKey}] ${t.title}
        <div class="text-muted mt-1 small">${t.description}</div>
      </label>
    </c:forEach>
  </div>

  <div class="row g-4 mt-2">
    <div class="col-md-6">
      <div class="section-title">📅 이벤트 선택</div>
      <select id="eventSel" class="form-select">
        <option value="">- 이벤트 선택 -</option>
        <c:forEach var="e" items="${eventList}">
          <option value="${e.eventId}" <c:if test="${e.eventId eq selectedEventId}">selected</c:if>>
            ${e.title} (${e.startDate} ~ ${e.endDate})
          </option>
        </c:forEach>
      </select>
    </div>

    <div class="col-md-6">
      <div class="section-title">⏱️ 스케줄 모드</div>
      <select id="scheduleMode" class="form-select">
        <option value="default">기본 (종료 즉시 오픈, 7일 후 종료)</option>
        <option value="offset">오프셋 지정 (종료 +N시간 후 오픈, M일 후 마감)</option>
      </select>
      <div class="mt-2">
        <input id="openDelayHours" type="number" class="form-control" value="0" disabled placeholder="오픈 지연 (N시간)">
      </div>
      <div class="mt-2">
        <input id="closeAfterDays" type="number" class="form-control" value="7" disabled placeholder="마감 시점 (오픈 후 M일)">
      </div>
      <div class="text-muted small mt-2">※ open_at / close_at 은 서버에서 자동 계산됩니다.</div>
    </div>
  </div>
  
  <div class="col-md-6">
  <div class="section-title">📦 생성 상태</div>
  <select id="statusSel" class="form-select">
    <option value="DRAFT">작성중 (DRAFT)</option>
    <option value="OPEN">배포 (OPEN)</option>
    <option value="CLOSED">종료 (CLOSED)</option>
    <option value="ARCHIVED">보관 (ARCHIVED)</option>
  </select>
  <div class="text-muted small mt-2">※ 기본값은 DRAFT. 필요 시 바로 OPEN으로 생성할 수 있어요.</div>
</div>
  

  <!-- 제목/설명 (★ 둘 다 직접 입력 + 필수) -->
  <div class="mt-3">
    <div class="section-title">📝 복제될 설문 제목</div>
    <input id="surveyTitle" class="form-control" placeholder="설문 제목을 입력하세요"
       value="${prefillTitle}">
    <div class="form-text">템플릿 제목을 기본값으로 채우되, 여기서 변경 가능합니다.</div>
    <div class="section-title">🗒️ 복제될 설문 설명</div>
	<textarea id="surveyDesc" rows="3" class="form-control" placeholder="설문 설명을 입력하세요">${prefillDesc}</textarea>
  </div>

  <div class="mt-4 section-title d-flex align-items-center gap-2">
    🛠️ 문항/보기 에디터 <span class="badge badge-hint rounded-pill">템플릿 선택 + 이벤트 선택 시 자동 로드</span>
  </div>

  <!-- 상단 툴바 -->
  <div class="d-flex align-items-center gap-3 mb-2">
    <div class="form-check">
      <input id="chkAll" type="checkbox" class="form-check-input">
      <label for="chkAll" class="form-check-label fw-bold">전체 선택</label>
    </div>

    <div class="vr mx-2"></div>

    <select id="bulkType" class="form-select form-select-sm" style="max-width:200px">
      <option value="">보기 유형 일괄변경…</option>
      <option value="single">단일선택</option>
      <option value="multi">복수선택</option>
      <option value="scale_5">5점 척도</option>
      <option value="text">주관식(텍스트)</option>
    </select>
    <button id="btnBulkType" class="btn btn-sm btn-outline-secondary">적용</button>

    <button id="btnBulkDel" class="btn btn-sm btn-outline-danger ms-1">선택 삭제</button>
  </div>

  <div class="editor-card" id="qaEditor">
    <div class="text-muted">템플릿과 이벤트를 선택하면 문항을 자동으로 가져옵니다.</div>
  </div>

  <div class="mt-3 d-flex gap-2">
    <button id="btnAddQ" class="btn btn-outline-secondary">문항 추가</button>
    <button id="btnCloneAsIs" class="btn btn-secondary">원본 그대로 복제</button>

    <!-- ★ 최종 클론 버튼: 제목/설명 확인 → Y/N -->
    <button id="btnClone" class="btn btn-dark">템플릿 복제</button>

    <!-- 취소 UX: 모달(Y/N), 목록으로, 뒤로가기 -->
    <button type="button" class="btn btn-outline-secondary" onclick="openCancelModal()">취소</button>
    <a href="<c:url value='/admin/surveys'/>" class="btn btn-outline-secondary">목록으로</a>
  </div>

	<!-- ⬆️ 맨 위로 버튼 -->
	<button id="btnScrollTop" type="button" aria-label="맨 위로"
	  style="
	    position: fixed; right: 24px; bottom: 24px;
	    width: 44px; height: 44px; border-radius: 999px;
	    border: 1px solid #e5e7eb; background:#fff;
	    box-shadow: 0 6px 18px rgba(0,0,0,.08);
	    display:none; align-items:center; justify-content:center;
	    z-index: 9999;
	  ">
	  ↑
	</button>
	
</div>

<!-- 취소 모달 (y/n) -->
<div id="cancelModal" style="display:none; position:fixed; inset:0; background:rgba(0,0,0,.35); align-items:center; justify-content:center;">
  <div style="background:#fff; border-radius:12px; padding:18px; width:360px;">
    <div style="font-weight:800; margin-bottom:8px;">취소하시겠습니까?</div>
    <div style="color:#6b7280; font-size:14px; margin-bottom:16px;">취소 시 모든 내용이 지워집니다.</div>
    <div style="display:flex; gap:8px; justify-content:flex-end;">
      <button class="btn btn-outline-secondary" onclick="closeCancelModal()">N</button>
      <button class="btn btn-primary" onclick="confirmCancel()">Y</button>
    </div>
  </div>
</div>

<!-- 결과 모달 -->
<div class="modal fade" id="resultModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog"><div class="modal-content">
    <div class="modal-header"><h5 class="modal-title">알림</h5></div>
    <div class="modal-body" id="modalMsg">처리 결과</div>
    <div class="modal-footer"><button type="button" class="btn btn-primary" id="modalOk">확인</button></div>
  </div></div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
/* ===== 공통 ===== */
const CSRF_TOKEN  = document.querySelector('meta[name="_csrf"]')?.content;
const CSRF_HEADER = document.querySelector('meta[name="_csrf_header"]')?.content || 'X-CSRF-TOKEN';
const CSRF_HEADERS = CSRF_TOKEN ? { [CSRF_HEADER]: CSRF_TOKEN } : {};
const $  = (sel, ctx=document) => ctx.querySelector(sel);
const $$ = (sel, ctx=document) => Array.from(ctx.querySelectorAll(sel));
const CTX  = '${pageContext.request.contextPath}';
const BASE = location.origin + CTX;

function showModal(msg, onClose){
  $("#modalMsg").textContent = msg;
  const m = new bootstrap.Modal($("#resultModal"));
  $("#modalOk").onclick = ()=>{ m.hide(); onClose && onClose(); };
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
	  if (String(el.value||'').trim()) return; // 이미 사용자가 입력 → 건드리지 않음
	  if (val != null && String(val).trim()) el.value = String(val).trim();
}

function prefillFromSelectedTemplate(){
	  const r = document.querySelector('input[name="templateId"]:checked');
	  if (!r) return;
	  // 제목/설명은 '비어있을 때만' 채움
	  setIfEmpty(document.getElementById('surveyTitle'), r.dataset.title || '');
	  setIfEmpty(document.getElementById('surveyDesc'),  r.dataset.desc  || '');
}

document.getElementById('tmplList')?.addEventListener('change', (e)=>{
	  if (e.target.name === 'templateId') prefillFromSelectedTemplate();
});
$("#eventSel").addEventListener('change', tryAutoLoad);

//페이지 진입 시 (상세→수정) 자동 프리필 수행하되, 사용자가 이미 적은 값은 보존
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

    renderEditor(qs.slice(0,20));      // 본문 최대 20
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
      <input type="checkbox" class="form-check-input q-check me-2">
      <div class="fw-bold me-2"><span class="q-no">${no}</span>.</div>

      <select class="form-select form-select-sm q-type me-2" style="max-width:200px">
        <option value="single">단일선택</option>
        <option value="multi">복수선택</option>
        <option value="scale_5">5점 척도</option>
        <option value="text">주관식</option>
      </select>

      <input class="form-control form-control-sm q-title" placeholder="질문 내용을 입력">

      <div class="actions ms-2">
        <button class="icon-btn btn-sm btn-outline-secondary" type="button" data-act="up">↑</button>
        <button class="icon-btn btn-sm btn-outline-secondary" type="button" data-act="down">↓</button>
        <button class="icon-btn btn-sm btn-outline-danger"     type="button" data-act="del">삭제</button>
      </div>
    </div>

    <div class="d-flex align-items-center gap-2 mb-1 opt-toolbar">
      <input type="checkbox" class="form-check-input opt-check-all" id="optall-${no}">
      <label for="optall-${no}" class="small text-muted mb-0">보기 전체 선택</label>
      <button class="btn btn-sm btn-outline-danger ms-1" type="button" data-act="opt-del-selected">선택 보기 삭제</button>
    </div>

    <div class="opts"></div>

    <div class="mt-1">
      <button class="btn btn-outline-secondary btn-sm" type="button" data-act="add-opt">보기 추가</button>
    </div>
  `;

  $('.q-type', wrap).value = type;
  $('.q-title', wrap).value = question || '';

  // 옵션 세팅 (★ ‘on’ 문제 방지: 라벨/값 인풋에 명확한 클래스 사용)
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
    <span class="opt-preview me-2"></span>
    <input class="form-control form-control-sm opt-label" placeholder="보기 라벨">
    <input class="form-control form-control-sm opt-value" placeholder="값(optValue)">
    <input type="checkbox" class="form-check-input ms-1 opt-mark" title="선택 삭제용">
    <button class="icon-btn btn-sm btn-outline-danger ms-1" type="button">삭제</button>
  `;
  $('.opt-label', row).value = label || '';
  $('.opt-value', row).value = (optValue ?? '') === '' ? '' : String(optValue);
  row.querySelector('button').addEventListener('click', ()=>row.remove());
  // 미리보기는 유형 변경 시 재그림
  return row;
}
function updateOptUI(wrap, type){
  const optsWrap = $('.opts', wrap);
  const toolbar  = $('.opt-toolbar', wrap);
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
  $('.opt-toolbar', tail).style.display = 'none';
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

/* ===== 페이로드 수집 ===== */
function toIntOrNull(v){ const n = Number(String(v ?? '').trim()); return Number.isFinite(n) ? Math.trunc(n) : null; }
function collectPayload(templateId, eventId){
  ensureTailTextQuestion(); // 고정 주관식 유효화
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
	    templateId,
	    eventId,
	    title: $('#surveyTitle').value.trim(),
	    description: $('#surveyDesc').value.trim(),
	    status: $('#statusSel').value,   // ★ 추가
	    scheduleMode: mode,
	    openDelayHours: Number($('#openDelayHours').value || 0),
	    closeAfterDays: Number($('#closeAfterDays').value || 7),
	    questions: oq
  };
}

/* ===== 검증 ===== */
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
    const t = q.type;
    const opts = q.options||[];
    if (t==='TEXT'){ if (opts.length) return {ok:false, msg:`${no}번 문항(TEXT)은 보기를 넣지 마세요.`}; }
    else if (t==='SINGLE' || t==='MULTI'){ if (!opts.length) return {ok:false, msg:`${no}번 문항은 최소 1개 보기 필요.`}; }
    else if (t==='SCALE_5'){
      if (opts.length!==5) return {ok:false, msg:`${no}번 문항은 5점 보기 필요.`};
      for (let j=0;j<5;j++){ if (opts[j].optValue !== (j+1)) return {ok:false, msg:`${no}번 문항 optValue는 1~5.`}; }
    }
  }
  return {ok:true};
}

/* ===== 원본 그대로 복제 ===== */
document.getElementById('btnCloneAsIs')?.addEventListener('click', async ()=>{
  const templateId = ($('input[name="templateId"]:checked')||{}).value;
  if (!templateId) return showModal('템플릿을 선택하세요.');
  const eventId = $('#eventSel').value; if (!eventId) return showModal('이벤트를 선택하세요.');
  const status = $('#statusSel').value || 'DRAFT';
  
  try{
    const headers = {'Content-Type':'application/x-www-form-urlencoded; charset=UTF-8','Accept':'application/json',...CSRF_HEADERS};
    const params = new URLSearchParams({ templateId, eventId, status });
    const res = await fetch(BASE + '/admin/api/surveys/clone', {method:'POST', headers, credentials:'same-origin', body:params});
    const data = await (res.headers.get('content-type')?.includes('json') ? res.json() : res.text().then(t=>{throw new Error(t)}));
    if (data.ok) showModal('복제되었습니다.', ()=> location.href = CTX + '/admin/surveys/' + data.surveyId);
    else showModal('복제 실패');
  }catch(e){ showModal('복제 실패: ' + e); }
});

/* ===== 인라인 복제 (제목/설명 확인 → Y/N) ===== */
// ===== 복제 버튼 =====
document.getElementById('btnClone')?.addEventListener('click', async ()=>{
  let title = document.getElementById('surveyTitle').value.trim();
  const desc  = document.getElementById('surveyDesc').value.trim();
  if (!title) {
    const r = document.querySelector('input[name="templateId"]:checked');
    if (r?.dataset.title) {
      title = r.dataset.title.trim();
      document.getElementById('surveyTitle').value = title; // 인풋도 채워줌
    }
  }
  if (!title){ alert('제목을 입력하세요.'); return; }
  if (!desc){  alert('설명을 입력하세요.'); return; }

  const templateId = (document.querySelector('input[name="templateId"]:checked')||{}).value;
  if (!templateId){ alert('템플릿을 선택하세요.'); return; }
  const eventId = document.getElementById('eventSel').value;
  if (!eventId){ alert('이벤트를 선택하세요.'); return; }

  // … (payload 수집은 기존 그대로)
  const payload = collectPayload(Number(templateId), Number(eventId));
  // 확인창은 "현재 입력칸의 값"으로
  if (!confirm("'" + title + "' 제목으로 복제하시겠습니까?")) { alert('취소되었습니다.'); return; }

  try{
    const headers = {'Content-Type':'application/json','Accept':'application/json',...CSRF_HEADERS};
    const res = await fetch(BASE + '/admin/api/surveys/clone-inline', {method:'POST', headers, credentials:'same-origin', body:JSON.stringify(payload)});
    if (!res.ok) { const txt = await res.text(); throw new Error(txt || ('HTTP '+res.status)); }
    const data = await res.json();
    if (data.ok && data.surveyId) { alert('복제되었습니다.'); location.href = CTX + '/admin/surveys/' + data.surveyId; }
    else showModal('복제 실패');
  }catch(e){ showModal('복제 실패: ' + e); }
});

/* ===== 맨 위로 버튼 ===== */
const btnTop = document.getElementById('btnScrollTop');
function toggleTopBtn(){
  const y = window.scrollY || document.documentElement.scrollTop;
  btnTop.style.display = (y > 300) ? 'flex' : 'none';
}
window.addEventListener('scroll', toggleTopBtn, {passive:true});
window.addEventListener('load', toggleTopBtn);
btnTop.addEventListener('click', () => {
  window.scrollTo({ top: 0, behavior: 'smooth' });
});


/* 취소 모달 */
function openCancelModal(){ document.getElementById('cancelModal').style.display='flex'; }
function closeCancelModal(){ document.getElementById('cancelModal').style.display='none'; }
function confirmCancel(){ location.href = '<c:url value="/admin/surveys"/>'; }
</script>
</body>
</html>
