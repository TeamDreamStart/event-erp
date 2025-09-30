<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />

<title>설문 템플릿 클론 (TEST)</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">

<style>
.container {
	max-width: 1100px;
	margin: 40px auto;
}

.radio-item {
	border: 1px solid #eee;
	border-radius: 12px;
	padding: 16px;
	margin-bottom: 12px;
	background: #fff;
}

.section-title {
	font-weight: 800;
	margin-top: 10px;
	margin-bottom: 6px;
}

.badge-hint {
	background: #eef2ff;
	color: #1e3a8a;
}

.editor-card {
	background: #fff;
	border: 1px solid #eee;
	border-radius: 12px;
	padding: 16px;
}

.q-row {
	border-top: 1px dashed #e5e7eb;
	padding-top: 10px;
	margin-top: 10px;
}

.q-row:first-child {
	border-top: none;
	padding-top: 0;
	margin-top: 0;
}

.opt-row {
	display: flex;
	gap: 8px;
	margin: 6px 0;
}

.opt-row input {
	flex: 1;
}

.icon-btn {
	border: 1px solid #e5e7eb;
	background: #fff;
	border-radius: 8px;
	padding: 4px 8px;
}
</style>
</head>
<body>
	<div class="container">

		<h2 class="mb-3">설문 템플릿 클론 (TEST)</h2>

		<div class="mb-3 section-title">📑 템플릿 선택</div>
		<div id="tmplList">
			<c:forEach var="t" items="${templates}">
				<label class="radio-item w-100 d-block"> <input type="radio"
					name="templateId" value="${t.surveyId}"
					class="form-check-input me-2"> [${t.templateKey}]
					${t.title}
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
						<option value="${e.eventId}"
							${e.eventId == eventId ? 'selected' : ''}>${e.title}
							(${e.startDate} ~ ${e.endDate})</option>
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
					<input id="openDelayHours" type="number" class="form-control"
						value="0" disabled placeholder="오픈 지연 (N시간)">
				</div>
				<div class="mt-2">
					<input id="closeAfterDays" type="number" class="form-control"
						value="7" disabled placeholder="마감 시점 (오픈 후 M일)">
				</div>
				<div class="text-muted small mt-2">※ open_at / close_at은 서버에서
					자동 계산됩니다.</div>
			</div>
		</div>

		<div class="mt-4 section-title d-flex align-items-center gap-2">
			🛠️ 문항/보기 에디터 <span class="badge badge-hint rounded-pill">템플릿
				선택 시 자동 로드</span>
		</div>

		<!-- 에디터 상단 툴바 + 전체 선택 체크박스 -->
		<div class="d-flex align-items-center gap-3 mb-2">
			<div class="form-check">
				<input id="chkAllQuestions" type="checkbox" class="form-check-input" />
				<label for="chkAllQuestions" class="form-check-label fw-bold">문항
					전체선택</label>
			</div>


			<div class="vr mx-2"></div>

			<select id="bulkType" class="form-select form-select-sm"
				style="max-width: 160px">
				<option value="">보기 유형 일괄변경…</option>
				<option value="single">단일선택</option>
				<option value="multi">복수선택</option>
				<option value="scale_5">5점 척도</option>
				<option value="text">주관식(텍스트)</option>
			</select>
			<button id="btnBulkType" class="btn btn-sm btn-outline-secondary">적용</button>

			<button id="btnBulkDel" class="btn btn-sm btn-outline-danger ms-1">선택
				삭제</button>
		</div>

		<!-- 보기 전체 선택(5점) -->
		<div class="ms-3 d-flex align-items-center gap-2">
			<span class="badge bg-light text-dark">보기 전체 선택</span>
			<div id="bulkChoices" class="btn-group" role="group"
				aria-label="likert5 bulk">
				<!-- value 는 DB의 option_value 와 동일하게 -->
				<input type="radio" class="btn-check" name="bulkLikert" id="bulk1"
					autocomplete="off" value="1"> <label
					class="btn btn-outline-secondary btn-sm" for="bulk1">1</label> <input
					type="radio" class="btn-check" name="bulkLikert" id="bulk2"
					autocomplete="off" value="2"> <label
					class="btn btn-outline-secondary btn-sm" for="bulk2">2</label> <input
					type="radio" class="btn-check" name="bulkLikert" id="bulk3"
					autocomplete="off" value="3"> <label
					class="btn btn-outline-secondary btn-sm" for="bulk3">3</label> <input
					type="radio" class="btn-check" name="bulkLikert" id="bulk4"
					autocomplete="off" value="4"> <label
					class="btn btn-outline-secondary btn-sm" for="bulk4">4</label> <input
					type="radio" class="btn-check" name="bulkLikert" id="bulk5"
					autocomplete="off" value="5"> <label
					class="btn btn-outline-secondary btn-sm" for="bulk5">5</label>
			</div>
			<button type="button" id="btnApplyBulk"
				class="btn btn-primary btn-sm">적용</button>
		</div>
	</div>


	<div class="editor-card" id="qaEditor">
		<!-- 라디오 선택 시 에디터로 문항/보기 로드 & 편집 가능 -->
		<div class="text-muted">템플릿을 먼저 선택하세요.</div>
	</div>

	<div class="mt-3 d-flex gap-2">
		<button id="btnAddQ" class="btn btn-outline-secondary">문항 추가</button>
		<button id="btnClone" class="btn btn-dark">템플릿 복제</button>
		<a href="${pageContext.request.contextPath}/survey-test"
			class="btn btn-outline-secondary">취소</a>
	</div>

	</div>

	<!-- 결과 모달 -->
	<div class="modal fade" id="resultModal" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">알림</h5>
				</div>
				<div class="modal-body" id="modalMsg">처리 결과</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="modalOk">확인</button>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<script>
const CSRF_TOKEN  = document.querySelector('meta[name="_csrf"]')?.content;
const CSRF_HEADER = document.querySelector('meta[name="_csrf_header"]')?.content || 'X-CSRF-TOKEN';
const CSRF_HEADERS = { [CSRF_HEADER]: CSRF_TOKEN }; // 편하게 쓰려고 미리 객체로

const $ = (sel, ctx=document) => ctx.querySelector(sel);
const $$ = (sel, ctx=document) => Array.from(ctx.querySelectorAll(sel));

/* JSP 값을 안전하게 JS로 */
const CTX = '${pageContext.request.contextPath}';
const BASE = location.origin + CTX;

function toggleScheduleInputs(){
  const mode = $("#scheduleMode").value;
  $("#openDelayHours").disabled = (mode !== 'offset');
  $("#closeAfterDays").disabled = (mode !== 'offset');
}
$("#scheduleMode").addEventListener('change', toggleScheduleInputs);
toggleScheduleInputs();

//보강: 초기에 한 번 동기화
document.addEventListener('DOMContentLoaded', ()=>{
  renumber(); // 현재 문항 상태 기준으로 상단 체크박스 반영
});


// 템플릿 선택 → QA 로드
$("#tmplList").addEventListener('change', async (e) => {
  if (e.target.name !== 'templateId') return;
  const templateId = e.target.value;
  try {
    const res = await fetch(BASE + '/survey-test/template-qa?templateId=' + templateId, { credentials:'same-origin' });
    const ct = res.headers.get('content-type') || '';
    if (!ct.includes('application/json')) {
      const text = await res.text();
      console.error('[template-qa] JSON이 아님. 상태=', res.status, '본문=', text.slice(0, 500));
      showModal('템플릿 로드 실패: 서버가 JSON 대신 다른 응답을 보냈습니다. (상세는 콘솔)');
      return;
    }
    const data = await res.json();
    // 서버 키가 다를 수도 있으니 널가드
    const qs = (data.questions || data.Questions || data.items || []).map(normalizeQuestion);
    renderEditor(qs);
  } catch (err) {
    console.error(err);
    showModal('템플릿 로드 실패: ' + err);
  }
});

function normalizeQuestion(q){
	  return {
	   type     : q.type || q.qType || 'scale_5',
	    question : q.question || q.title || q.text || '',
	    options  : (q.options || q.choices || []).map(o => ({
	      label    : o.label ?? o.text ?? '',
	      optValue : o.optValue ?? o.value ?? ''
	    }))
	  };
	}



// 에디터 렌더링
function renderEditor(questions){
  const host = $("#qaEditor");
  host.innerHTML = "";
  questions.forEach((q, idx) => host.appendChild(qBlock(q.type, q.question, q.options||[], idx+1)));
  if (!questions.length){
    host.innerHTML = '<div class="text-muted">문항이 없습니다. "문항 추가"로 작성하세요.</div>';
  }
  renumber(); // 항상 번호 재부여
}


/** 문항 블록(번호 + 선택체크 + 유형 + 질문 + 보기) */
function qBlock(type="scale_5", question="", options=[], no=1){
  const wrap = document.createElement('div');
  wrap.className = 'q-row';
  wrap.dataset.qType = type;

  wrap.innerHTML = `
    <div class="d-flex gap-2 align-items-center mb-2">
      <input type="checkbox" class="form-check-input q-check">
      <div class="fw-bold me-1"><span class="q-no">${no}</span>.</div>

      <select class="form-select form-select-sm q-type" style="max-width:140px">
        <option value="single" \${type==='single'?'selected':''}>단일선택</option>
        <option value="multi"  \${type==='multi'?'selected':''}>복수선택</option>
        <option value="scale_5" \${type==='scale_5'?'selected':''}>5점 척도</option>
        <option value="text" \${type==='text'?'selected':''}>주관식</option>
      </select>

      <input class="form-control form-control-sm q-title" placeholder="질문 내용을 입력" value="\${escapeHtml(question)}">

      <button class="icon-btn btn-sm btn-outline-secondary" type="button" data-act="up">↑</button>
      <button class="icon-btn btn-sm btn-outline-secondary" type="button" data-act="down">↓</button>
      <button class="icon-btn btn-sm btn-outline-danger" type="button" data-act="del">삭제</button>
    </div>
    
    <!-- 보기(옵션) 툴바 -->
    <div class="d-flex align-items-center gap-2 mb-1 opt-toolbar">
	    <input type="checkbox" class="form-check-input opt-check-all">
	    <span class="small text-muted">보기 전체 선택</span>
	    <button class="btn btn-sm btn-outline-danger ms-1" type="button" data-act="opt-del-selected">선택 보기 삭제</button>
    </div>

    <div class="opts"></div>

    <div class="mt-1">
      <button class="btn btn-outline-secondary btn-sm" type="button" data-act="add-opt">보기 추가</button>
    </div>
  `;

  const optsWrap = $('.opts', wrap);
  // 옵션 생성 규칙: 전달된 options가 없고, 유형이 옵션형이면 기본옵션 자동 생성
  if ((type==='single' || type==='multi' || type==='scale_5') && (!options || options.length===0)) {
    options = makeDefaultOptions(type);
  }
  options.forEach(op => optsWrap.appendChild(optRow(op.label, op.optValue)));

  const typeSel = $('.q-type', wrap);
  const update = () => updateOptUI(wrap, typeSel.value);
  typeSel.addEventListener('change', () => { update(); renumber(); });
  update();

  wrap.addEventListener('click', (e)=>{
    const act = e.target.dataset.act;
    if (!act) return;
    if (act === 'add-opt') optsWrap.appendChild(optRow("", ""));
    if (act === 'del') { wrap.remove(); renumber(); }
    if (act === 'up')  { wrap.previousElementSibling?.before(wrap); renumber(); }
    if (act === 'down'){ wrap.nextElementSibling?.after(wrap); renumber(); }
    if (act === 'opt-del-selected') {
    	const targets = $$('.opt-row', wrap).filter(r => $('.opt-check', r)?.checked);
    	if (!targets.length) return;
    	targets.forEach(r => r.remove());
    	}
  });
  // 보기 전체선택 토글
  $('.opt-check-all', wrap).addEventListener('change', (e)=>{
  $$('.opt-row .opt-check', wrap).forEach(c => c.checked = e.target.checked);
  });
  
  return wrap;
}

/** 보기 한 줄 */
function optRow(label="", optValue=""){
  const row = document.createElement('div');
  row.className = 'opt-row';
  row.innerHTML = `
	<input type="checkbox" class="form-check-input me-1 opt-check">
	<input class="form-control form-control-sm" placeholder="보기 라벨" value="\${escapeHtml(label)}">
    <input class="form-control form-control-sm" placeholder="값(optValue)" value="\${escapeHtml(optValue||'')}">
    <button class="icon-btn btn-sm btn-outline-danger" type="button">삭제</button>
  `;
  row.lastElementChild.addEventListener('click', ()=>row.remove());
  return row;
}

/** 유형에 따라 옵션 영역 표시/숨김 + 기본옵션 유지 */
function updateOptUI(wrap, type){
  const optsWrap = $('.opts', wrap);
  if (type === 'text') {
    optsWrap.parentElement.style.display = 'none';
    optsWrap.innerHTML = ''; // 텍스트 유형은 보기 제거
  } else {
    optsWrap.parentElement.style.display = '';
    if (!optsWrap.children.length) {
      // 비어있으면 기본옵션 생성
      makeDefaultOptions(type).forEach(op => optsWrap.appendChild(optRow(op.label, op.optValue)));
    }
    if (type === 'scale_5') {
      // 5점척도는 항상 1~5 기본셋 유지 (이미 있으면 갱신은 강제하지 않음)
      if (optsWrap.children.length === 0) {
        makeDefaultOptions('scale_5').forEach(op => optsWrap.appendChild(optRow(op.label, op.optValue)));
      }
    }
  }
  wrap.dataset.qType = type;
}

/** 기본 옵션 프리셋 */
function makeDefaultOptions(type){
  if (type === 'scale_5') {
    return [
      {label:'매우 그렇지 않다', optValue:'1'},
      {label:'그렇지 않다',   optValue:'2'},
      {label:'보통이다',     optValue:'3'},
      {label:'그렇다',       optValue:'4'},
      {label:'매우 그렇다',  optValue:'5'}
    ];
  }
  // 단일/복수 기본 2개
  return [
    {label:'예', optValue:'Y'},
    {label:'아니오', optValue:'N'}
  ];
}

/** 문항 번호 재부여 */
function renumber(){
  $$('.q-row').forEach((row, i) => {
    const noEl = $('.q-no', row);
    if (noEl) noEl.textContent = String(i+1);
  });
  // 전체선택 체크박스 상태 동기화
  const all = $$('.q-row .q-check');
  const allChecked = all.length>0 && all.every(c=>c.checked);
  const master = $('#chkAllQuestions');
  if (master) master.checked = allChecked;

}

function escapeHtml(str){
  return (str||"").replace(/[&<>"']/g, s => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[s]));
}

// 문항 추가 버튼
$("#btnAddQ").addEventListener('click', ()=>{
  const host = $("#qaEditor");
  if (host.querySelector('.text-muted')) host.innerHTML = "";
  host.appendChild(qBlock());
});

// 복제 버튼 → JSON POST
$("#btnClone").addEventListener('click', async ()=>{
  const templateId = ($('input[name="templateId"]:checked')||{}).value;
  if (!templateId){ return alert('템플릿을 선택하세요.'); }

  const eventId = $("#eventSel").value;
  if (!eventId){ return alert('이벤트를 선택하세요.'); }

  const payload = collectPayload(Number(templateId), Number(eventId));
  try{
	  const headers = { 'Content-Type': 'application/json' };
	  if (CSRF_TOKEN) {
	    headers[CSRF_HEADER] = CSRF_TOKEN;  // CSRF 헤더 키에 토큰 주입
	  }

	  const res = await fetch(BASE + '/survey-test/clone-inline', {
	    method: 'POST',
	    headers,
	    credentials: 'same-origin',
	    body: JSON.stringify(payload)
	  });
    const data = await res.json();
    if (data.ok){
      showModal('템플릿 등록에 성공했습니다!', ()=> {
        location.href = CTX + '/survey-test?eventId=' + eventId;
      });
    }else{
      showModal('템플릿 등록 실패했습니다. 다시 시도해주세요.');
    }
  }catch(e){
    showModal('템플릿 등록 실패했습니다. 오류: ' + e);
  }
});

<%-- 페이로드 수집부(번호/선택 무시, 옵션 수집 유지) --%>
function collectPayload(templateId, eventId){
	  const mode = $("#scheduleMode").value;
	  const oq = $$('.q-row').map(q => {
	    const type = $('.q-type', q).value;
	    const question = $('.q-title', q).value.trim();
	    const opts = $$('.opt-row', q).map(or => ({
	      label: $('input:nth-of-type(1)', or).value.trim(),
	      optValue: $('input:nth-of-type(2)', or).value.trim()
	    })).filter(o => o.label.length>0 || o.optValue.length>0);
	    return { type, question, options: (type==='text' ? [] : opts) };
	  });

	  return {
	    templateId,
	    eventId,
	    userId: ${userId == null ? 0 : userId},
	    scheduleMode: mode,
	    openDelayHours: Number($("#openDelayHours").value||0),
	    closeAfterDays: Number($("#closeAfterDays").value||7),
	    questions: oq
	  };
	}


// 모달
function showModal(msg, onClose){
  $("#modalMsg").textContent = msg;
  const m = new bootstrap.Modal($("#resultModal"));
  $("#modalOk").onclick = ()=>{ m.hide(); onClose && onClose(); };
  m.show();
}

//문항 전체선택 토글
$('#chkAllQuestions')?.addEventListener('change', (e)=>{
  $$('.q-row .q-check').forEach(c => c.checked = e.target.checked);
});


// 일괄 유형 변경
$('#btnBulkType').addEventListener('click', ()=>{
  const v = $('#bulkType').value;
  if (!v) return;
  const targets = $$('.q-row').filter(r => $('.q-check', r).checked);
  targets.forEach(r => { $('.q-type', r).value = v; updateOptUI(r, v); });
});

//보기(1~5) 일괄 적용: 선택 문항(없으면 전체)의 5점 척도 옵션 중 해당 값만 체크
$('#btnApplyBulk')?.addEventListener('click', ()=>{
  const bulkVal = document.querySelector('input[name="bulkLikert"]:checked')?.value;
  if (!bulkVal) { alert('적용할 보기(1~5)를 선택하세요.'); return; }

  // 대상 문항: 체크된 문항 있으면 그 문항들, 아니면 전체 문항
  const selected = $$('.q-row .q-check:checked').map(chk => chk.closest('.q-row'));
  const targets = selected.length ? selected : $$('.q-row');

  let touched = 0;

  targets.forEach(qEl => {
    const qType = qEl.dataset.qType || $('.q-type', qEl)?.value;
    if (qType !== 'scale_5') return; // 5점 척도만 대상

    // 모든 옵션 체크 해제 후, optValue가 일치하는 옵션만 체크
    const rows = $$('.opt-row', qEl);
    rows.forEach(r => { $('.opt-check', r).checked = false; });

    rows.forEach(r => {
      const valInput = $('input:nth-of-type(2)', r); // "값(optValue)" 인풋
      const isMatch = (valInput?.value?.trim() === bulkVal);
      if (isMatch) {
        const c = $('.opt-check', r);
        if (c) { c.checked = true; touched++; }
      }
    });
  });

  if (!touched) {
    alert('적용할 대상(5점 척도 문항/옵션)을 찾지 못했어요.\n문항 유형과 옵션 값을 확인하세요.');
  }
});


// 일괄 삭제
$('#btnBulkDel').addEventListener('click', ()=>{
  const targets = $$('.q-row').filter(r => $('.q-check', r).checked);
  if (!targets.length) return;
  if (!confirm(`선택한 문항 ${targets.length}개를 삭제할까요?`)) return;
  targets.forEach(r => r.remove());
  renumber();
});

	</script>
</body>
</html>
