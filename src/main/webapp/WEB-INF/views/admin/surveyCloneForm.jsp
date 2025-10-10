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

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">

<style>
/* ===== 레이아웃 / 스타일 ===== */
.container {
	max-width: 100%;
	margin: 0;
	padding-left: 6rem;
	padding-right: 6rem;
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
	width: 100%;
	background: #fff;
	border: 1px solid #eee;
	border-radius: 12px;
	padding-left: 1.5rem;
	padding-right: 1.5rem;
	margin-top: 1rem;
	box-sizing: border-box;
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

/* 문항 헤더 1줄 유지 (버튼은 고정폭, 타이틀이 남는 공간 차지) */
.q-row .head {
	display: flex;
	align-items: center;
	gap: 8px;
	flex-wrap: nowrap;
}

.q-row .q-title {
	min-width: 0;
	flex: 1 1 auto;
}

.q-row .actions {
	flex: 0 0 auto;
	white-space: nowrap;
}

/* 유형 셀렉터 폭 (요청대로 200px) */
.q-row .q-type {
	max-width: 200px;
}

/* 옵션 라인 */
.opt-row {
	display: flex;
	gap: 8px;
	margin: 6px 0;
	align-items: center;
}

.opt-row input {
	flex: 1;
}

.opt-row .opt-preview {
	flex: 0 0 auto;
	display: inline-flex;
	align-items: center;
}

.opt-row input[type="checkbox"] {
	width: auto;
	margin-right: 0;
	flex: 0 0 auto;
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

		<h2 class="mb-3">설문 템플릿 클론</h2>

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
							${e.eventId eq eventId ? 'selected' : ''}>${e.title}
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

		<!-- 복제될 설문 제목 -->
		<div class="mt-3">
			<div class="section-title">📝 복제될 설문 제목</div>
			<input id="surveyTitle" class="form-control"
				placeholder="설문 제목을 입력하세요">
			<div class="form-text">템플릿 제목을 기본값으로 채웁니다. 필요 시 수정하세요.</div>
		</div>

		<div class="mt-4 section-title d-flex align-items-center gap-2">
			🛠️ 문항/보기 에디터 <span class="badge badge-hint rounded-pill">템플릿
				선택 시 자동 로드</span>
		</div>

		<!-- 에디터 상단 툴바 + 전체 선택 체크박스 -->
		<div class="d-flex align-items-center gap-3 mb-2">
			<div class="form-check">
				<input id="chkAll" type="checkbox" class="form-check-input" /> <label
					for="chkAll" class="form-check-label fw-bold">전체 선택</label>
			</div>

			<div class="vr mx-2"></div>

			<select id="bulkType" class="form-select form-select-sm"
				style="max-width: 200px">
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

		<div class="editor-card" id="qaEditor">
			<div class="text-muted">템플릿을 먼저 선택하세요.</div>
		</div>

		<div class="mt-3 d-flex gap-2">
			<button id="btnAddQ" class="btn btn-outline-secondary">문항 추가</button>
			<button id="btnCloneAsIs" class="btn btn-secondary">원본 그대로
				복제</button>
			<button id="btnClone" class="btn btn-dark">템플릿 복제</button>
			<a href="${pageContext.request.contextPath}/admin/surveys"
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
	/* ===== 공통 유틸 ===== */
	const CSRF_TOKEN  = document.querySelector('meta[name="_csrf"]')?.content;
	const CSRF_HEADER = document.querySelector('meta[name="_csrf_header"]')?.content || 'X-CSRF-TOKEN';
	const CSRF_HEADERS = CSRF_TOKEN ? { [CSRF_HEADER]: CSRF_TOKEN } : {};
	
	const $  = (sel, ctx=document) => ctx.querySelector(sel);
	const $$ = (sel, ctx=document) => Array.from(ctx.querySelectorAll(sel));
	
	const CTX  = '${pageContext.request.contextPath}';
	const BASE = location.origin + CTX;
	
	// JSON 안전 파서: 서버가 에러로 HTML을 보내도 "Unexpected token '<'" 안 터지게
	async function parseJsonSafe(res){
	  const ct = res.headers.get('content-type') || '';
	  const text = await res.text();
	  if (ct.includes('application/json')) {
	    return JSON.parse(text);
	  }
	  throw new Error(`HTTP ${res.status} (non-JSON): ${text.slice(0, 200)}`);
	}
	
	// === 프론트 검증 함수 (전역) ===
	function validatePayload(payload) {
	  const allowed = new Set(['SINGLE','MULTI','SCALE_5','TEXT']);
	  const qs = payload?.questions || [];
	  if (!qs.length) return { ok:false, msg:'문항이 없습니다.', index:1 };

	  for (let i = 0; i < qs.length; i++) {
	    const q = qs[i];
	    const no = i + 1;

	    const t = String(q.type || '').trim().toUpperCase();
	    if (!allowed.has(t)) {
	      return { ok:false, msg:`알 수 없는 유형: ${q.type}`, index:no };
	    }

	    if (!q.question || !q.question.trim()) {
	      return { ok:false, msg:'질문 내용이 비어있어요.', index:no };
	    }

	    const opts = q.options || [];
	    if (t === 'TEXT') {
	      if (opts.length) return { ok:false, msg:'TEXT 문항에는 보기(options)를 넣지 마세요.', index:no };
	    } else if (t === 'SINGLE' || t === 'MULTI') {
	      if (!opts.length) return { ok:false, msg:`${t} 문항은 최소 1개 이상의 보기가 필요합니다.`, index:no };
	      if (!opts.every(o => Number.isInteger(o.optValue))) {
	        return { ok:false, msg:`${t} 문항의 optValue는 정수여야 합니다.`, index:no };
	      }
	    } else if (t === 'SCALE_5') {
	      if (opts.length !== 5) return { ok:false, msg:'SCALE_5 문항은 보기 5개가 필요합니다.', index:no };
	      const okSeq = opts.every((o,i) => o.optValue === (i+1));
	      if (!okSeq) return { ok:false, msg:'SCALE_5 optValue는 1~5로 보내주세요.', index:no };
	    }

	  }
	  return { ok:true };
	}	
	
	/* ===== 스케줄 ===== */
	function toggleScheduleInputs(){
	  const mode = $("#scheduleMode").value;
	  $("#openDelayHours").disabled = (mode !== 'offset');
	  $("#closeAfterDays").disabled = (mode !== 'offset');
	}
	$("#scheduleMode").addEventListener('change', toggleScheduleInputs);
	toggleScheduleInputs();
	
	/* ===== 초기 ===== */
	document.addEventListener('DOMContentLoaded', ()=>{ renumber(); });
	
	/* ===== 템플릿 선택 → 로드 (본문 20 + 꼬리 주관식 1) ===== */
	$("#tmplList").addEventListener('change', async (e) => {
	  if (e.target.name !== 'templateId') return;
	  const templateId = e.target.value;
	
	  try {
	    const res  = await fetch(BASE + '/admin/api/surveys/template-qa?templateId=' + templateId, {
	      credentials: 'same-origin',
	      headers: { 'Accept': 'application/json' }
	    });
	    const data = await res.json();
	
	    const byQ = data.optionsByQ || {};
	    const qs = (data.questions || []).map(q => ({
	      type: normalizeType(q.type),
	      question: q.question || '',
	      options: (byQ[q.questionId] || []).map(o => ({
	        label: o.label || '',
	        optValue: o.optValue || ''
	      }))
	    }));
	
	    renderEditor(qs.slice(0,20)); // 본문 최대 20

	    document.getElementById('surveyTitle').value = (data.header?.title || data.title || '');

	  } catch (err) {
	    console.error(err);
	    showModal('템플릿 로드 실패: ' + err);
	  }
	});
	
	// 👇 함수 선언
	function renderEditor(questions){
	  const host = document.getElementById('qaEditor');
	  host.innerHTML = '';
	  questions.forEach((q, idx) =>
	    host.appendChild(qBlock(q.type, q.question, q.options||[], idx+1))
	  );
	  if (!questions.length){
	    host.innerHTML = '<div class="text-muted">문항이 없습니다. "문항 추가"로 작성하세요.</div>';
	  }
	  ensureTailTextQuestion();
	  renumber();
	}
	
	// ✅ 전역에 노출
	window.renderEditor = renderEditor;
	
	function normalizeType(t){
	  if (!t) return 'scale_5';
	  t = String(t).trim().toLowerCase();
	  if (t === 'scale5' || t === 'scale-5') return 'scale_5';
	  return (['single','multi','text','scale_5'].includes(t) ? t : 'scale_5');
	}
	
	/* ===== 꼬리 주관식(마지막 고정) ===== */
	function ensureTailTextQuestion(focus=false){
	  const host = $("#qaEditor");
	  const rows = $$('.q-row', host);
	  const last = rows[rows.length-1];
	
	  if (last && last.dataset.lock === 'textTail') return last;
	
	  const tail = qBlock('text', '기타 의견을 자유롭게 남겨주세요.', [], rows.length+1);
	  tail.dataset.lock = 'textTail';
	
	  // 이동/삭제/유형변경/보기 막기
	  $('.q-type', tail).disabled = true;
	  $('[data-act="up"]', tail).style.display = 'none';
	  $('[data-act="down"]', tail).style.display = 'none';
	  $('[data-act="del"]', tail).style.display = 'none';
	  $('.opt-toolbar', tail).style.display = 'none';
	  const opts = $('.opts', tail);
	  opts.innerHTML = '';
	  opts.style.display = 'none';
	
	  host.appendChild(tail);
	  if (focus) $('.q-title', tail).focus();
	  renumber();
	  return tail;
	}
	
	/* ===== 라디오/체크 미리보기 HTML ===== */
	function previewMarkup(type, group){
	  if (type === 'single' || type === 'scale_5') {
	    return `<input type="radio" class="form-check-input" name="pv-${group}" disabled>`;
	  }
	  if (type === 'multi') {
	    return `<input type="checkbox" class="form-check-input" disabled>`;
	  }
	  return '';
	}
	
	/* ===== 문항 블록 ===== */
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
	
	  // 값 주입
	  $('.q-type', wrap).value = type;
	  $('.q-title', wrap).value = question || '';
	
	  const optsWrap = $('.opts', wrap);
	  const group = String(no);
	
	  // 기본 옵션 생성
	  if ((type==='single' || type==='multi' || type==='scale_5') && (!options || options.length===0)) {
	    options = makeDefaultOptions(type);
	  }
	  options.forEach(op => optsWrap.appendChild(optRow(op.label, op.optValue, type, group)));
	
	  // 타입 변경 → 옵션 UI/미리보기 동기화
	  const update = () => { updateOptUI(wrap, $('.q-type', wrap).value); syncOptionPreviews(wrap, $('.q-type', wrap).value); };
	  $('.q-type', wrap).addEventListener('change', () => { update(); renumber(); });
	  update();
	
	  // 내부 버튼들
	  wrap.addEventListener('click', (e) => {
	    const act = e.target.dataset.act;
	    if (!act) return;
	
	    // 잠금 주관식은 무시
	    if (wrap.dataset.lock === 'textTail') return;
	
	    if (act === 'add-opt') {
	      const curType = $('.q-type', wrap).value;
	      optsWrap.appendChild(optRow("", "", curType, group));
	    }
	    if (act === 'del')     { wrap.remove(); renumber(); }
	    if (act === 'up')      { wrap.previousElementSibling?.before(wrap); renumber(); }
	    if (act === 'down')    { wrap.nextElementSibling?.after(wrap);     renumber(); }
	    if (act === 'opt-del-selected') {
	      $$('.opt-row', wrap)
	        .filter(r => r.querySelector('.opt-mark')?.checked)
	        .forEach(r => r.remove());
	    }
	  });
	
	  // 보기 전체선택(선택삭제용 체크 .opt-mark 대상)
	  $('.opt-check-all', wrap).addEventListener('change', (e) => {
	    $$('.opt-row .opt-mark', wrap).forEach(c => c.checked = e.target.checked);
	  });
	
	  return wrap;
	}
	
	/* ===== 옵션 한 줄 (미리보기 + 라벨/값 + 선택삭제 체크 + 삭제) ===== */
	function optRow(label="", optValue="", type="single", group="g1"){
	  const row = document.createElement('div');
	  row.className = 'opt-row';
	  row.innerHTML = `
		<span class="opt-preview me-2"></span>
	    <input class="form-control form-control-sm" placeholder="보기 라벨">
	    <input class="form-control form-control-sm" placeholder="값(optValue)">
	    <input type="checkbox" class="form-check-input ms-1 opt-mark" title="선택 삭제용">
	    <button class="icon-btn btn-sm btn-outline-danger ms-1" type="button">삭제</button>
	  `;
	  const [ , labelInput, valueInput ] = row.querySelectorAll('input');
	  labelInput.value = label || '';
	  valueInput.value = optValue || '';
	  row.querySelector('button').addEventListener('click', ()=>row.remove());
	  return row;
	}
	
	/* ===== 옵션 UI/미리보기 동기화 ===== */
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
	
	/* ===== 기본 옵션 프리셋 ===== */
	function makeDefaultOptions(type){
	  if (type === 'scale_5') {
	    return [
	      {label:'매우 그렇지 않다', optValue: 1},
	      {label:'그렇지 않다',     optValue: 2},
	      {label:'보통이다',       optValue: 3},
	      {label:'그렇다',         optValue: 4},
	      {label:'매우 그렇다',    optValue: 5}
	    ];
	  }
	  return [
	    {label:'예',   optValue: 1},
	    {label:'아니오', optValue: 2}
	  ];
	}
	
	/* ===== 번호/전체선택 동기화 ===== */
	function renumber(){
	  $$('.q-row').forEach((row, i) => {
	    const noEl = $('.q-no', row);
	    if (noEl) noEl.textContent = String(i+1);
	    // 번호 바뀌면 미리보기 그룹 네임도 자연스레 새로 렌더 시 반영됨
	  });
	
	  const all = $$('.q-row .q-check');
	  const anyChecked = all.some(c => c.checked);
	  const allChecked = all.length > 0 && all.every(c => c.checked);
	  const master = $('#chkAll');
	  if (master) {
	    master.checked = allChecked;
	    master.indeterminate = !allChecked && anyChecked;
	  }
	}
	
	/* ===== 모달 ===== */
	function showModal(msg, onClose){
	  $("#modalMsg").textContent = msg;
	  const m = new bootstrap.Modal($("#resultModal"));
	  $("#modalOk").onclick = ()=>{ m.hide(); onClose && onClose(); };
	  m.show();
	}
	
	/* ===== 문항 추가(항상 꼬리 주관식 앞에) ===== */
	$("#btnAddQ").addEventListener('click', ()=>{
	  const host = $("#qaEditor");
	  if (host.querySelector('.text-muted')) host.innerHTML = "";
	  const row  = qBlock(); // 기본 5점척도
	  const tail = ensureTailTextQuestion();
	  if (tail) host.insertBefore(row, tail); else host.appendChild(row);
	  renumber();
	});
	
	/* ===== 복제(인라인) ===== */
	(() => {
	  const btn = $("#btnClone");
	  let inFlight = false;

	  const MSG = {
	    SUCCESS: '복제되었습니다.',
	    DUP: '이미 복제되었습니다.',
	    UNKNOWN: '복제 중 알 수 없는 오류가 발생했습니다.',
	    REQ_ERR: '요청 데이터가 올바르지 않습니다.',
	  };

	  btn.addEventListener('click', async () => {
	    if (inFlight) return;
	    inFlight = true; btn.disabled = true;

	    try {
	      const templateId = ($('input[name="templateId"]:checked')||{}).value;
	      if (!templateId) { alert('템플릿을 선택하세요.'); return; }

	      const eventId = $("#eventSel").value;
	      if (!eventId)    { alert('이벤트를 선택하세요.'); return; }

	      const payload = collectPayload(Number(templateId), Number(eventId));
	      const v = validatePayload(payload);
	      if (!v.ok) {
	        showModal(`문항 ${v.index}번 오류: ${v.msg}`);
	        const t = document.querySelector(`.q-row:nth-of-type(${v.index}) .q-title`);
	        if (t) { t.scrollIntoView({behavior:'smooth', block:'center'}); t.focus(); }
	        return;
	      }

	      const headers = { 'Content-Type': 'application/json', 'Accept': 'application/json', ...CSRF_HEADERS };
	      const res = await fetch(BASE + '/admin/api/surveys/clone-inline', {
	        method: 'POST',
	        headers,
	        credentials: 'same-origin',
	        body: JSON.stringify(payload)
	      });

	      // 1) HTTP 단계 에러 우선
	      if (!res.ok) {
	        if (res.status === 409) return showModal(MSG.DUP);
	        if (res.status === 400 || res.status === 422) return showModal(MSG.REQ_ERR);
	        const txt = await res.text().catch(()=> '');
	        return showModal(txt || `${MSG.UNKNOWN} (HTTP ${res.status})`);
	      }

	      // 2) JSON 파싱 (컨트롤러 200+JSON 전제)
	      const data = await res.json().catch(() => ({}));
	      if (data && data.ok && data.surveyId) {
	        return showModal(MSG.SUCCESS, () => {
	          // 성공 후 이동: 상세 페이지
	          location.href = `${CTX}/admin/surveys/${data.surveyId}`;
	          // 또는 목록으로 보내려면 ↓ 주석 해제
	          // location.href = `${CTX}/admin/surveys?eventId=${eventId}`;
	        });
	      }

	      return showModal((data && data.message) || MSG.UNKNOWN);

	    } catch (e) {
	      showModal(`${MSG.UNKNOWN}\n` + (e?.message || e));
	    } finally {
	      inFlight = false; btn.disabled = false;
	    }
	  });
	})();
	
	// 문자열 → 정수 (실패 시 null)
	function toIntOrNull(v) {
	  const n = Number(String(v ?? '').trim());
	  return Number.isFinite(n) ? Math.trunc(n) : null;
	}

	/* ===== 원본 그대로 복제 ===== */
	async function cloneAsIs() {
	  const templateId = (document.querySelector('input[name="templateId"]:checked') || {}).value;
	  if (!templateId) { return alert('템플릿을 선택하세요.'); }
	  const eventId = document.getElementById('eventSel').value;
	  if (!eventId) { return alert('이벤트를 선택하세요.'); }
	
	  try {
		// Accept 추가
		const headers = { 'Content-Type': 'application/x-www-form-urlencoded', 'Accept': 'application/json', ...CSRF_HEADERS };
	    const params = new URLSearchParams({ templateId, eventId });
	    const res = await fetch(BASE + '/admin/api/surveys/clone', {
	      method: 'POST', headers, credentials: 'same-origin', body: params
	    });
	 // JSON 안전 파서 사용
	    const data = await parseJsonSafe(res);
	    if (data.ok) {
	      showModal('템플릿 원본 복제에 성공했습니다!', () => { location.href = CTX + '/admin/surveys?eventId=' + eventId; });
	    } else {
	      showModal('템플릿 복제 실패했습니다. 다시 시도해주세요.');
	    }
	  } catch (e) {
	    showModal('템플릿 복제 실패했습니다. 오류: ' + e);
	  }
	}
	document.getElementById('btnCloneAsIs')?.addEventListener('click', cloneAsIs);
	

	/* ===== 페이로드 수집 ===== */
	function collectPayload(templateId, eventId){
	  ensureTailTextQuestion(); // 전송 직전에도 보장
	
	  const mode = $("#scheduleMode").value;
	  const oq = $$('.q-row').map(q => {
	    const typeRaw   = $('.q-type', q).value;           // 'single' | 'multi' | 'scale_5' | 'text'
	    const typeUpper = typeRaw.toUpperCase();           // ENUM 규격
	    const question  = $('.q-title', q).value.trim();
	
	    // 옵션 수집 (라벨/값)
	    const uiOpts = $$('.opt-row', q).map(or => ({
	      label: $('input:nth-of-type(1)', or).value.trim(),
	      optValue: $('input:nth-of-type(2)', or).value.trim()
	    })).filter(o => o.label.length > 0 || o.optValue.length > 0);
	
	    // 전송용 옵션 변환
	    let options = [];
	    if (typeRaw !== 'text') {
	      // 숫자 변환 (실패 시 null)
	      const mapped = uiOpts.map((o, i) => ({
	        label: o.label,
	        optValue: toIntOrNull(o.optValue)
	      }));
	
	      if (typeRaw === 'scale_5') {
	        // 척도는 1~5 강제
	        options = mapped.map((o, i) => ({
	          label: o.label,
	          optValue: i + 1
	        })).slice(0, 5);
	      } else {
	        // single/multi: 비거나 숫자 아님 → 1부터 순번
	        options = mapped.map((o, i) => ({
	          label: o.label,
	          optValue: Number.isInteger(o.optValue) ? o.optValue : (i + 1)
	        }));
	      }
	    }
	
	    return { type: typeUpper, question, options };
	  });
	
	  return {
	    templateId,
	    eventId,
	    title: document.getElementById('surveyTitle').value.trim(),
	    scheduleMode: mode,
	    openDelayHours: Number($("#openDelayHours").value || 0),
	    closeAfterDays: Number($("#closeAfterDays").value || 7),
	    questions: oq
	  };
	}

	
	/* ===== 전체선택 토글 ===== */
	$('#chkAll')?.addEventListener('change', (e) => {
	  $$('.q-row .q-check').forEach(c => c.checked = e.target.checked);
	});
	
	/* ===== 일괄 유형 변경 ===== */
	document.getElementById('btnBulkType')?.addEventListener('click', () => {
	  const v = document.getElementById('bulkType').value;
	  if (!v) return;
	
	  // 선택된 문항, 없으면 전체. 단, 잠금 주관식은 제외
	  const selected = Array.from(document.querySelectorAll('.q-row .q-check:checked'))
	                    .map(chk => chk.closest('.q-row'));
	  const rows = (selected.length ? selected : $$('.q-row'))
	                .filter(r => r.dataset.lock !== 'textTail');
	
	  if (v === 'text') {
	    // 꼬리 주관식만 보장하고 나머지는 변경하지 않음
	    ensureTailTextQuestion(true);
	    return;
	  }
	
	  rows.forEach(row => {
	    const sel = row.querySelector('.q-type');
	    if (sel) sel.value = v;
	    updateOptUI(row, v);
	    syncOptionPreviews(row, v);
	  });
	  renumber();
	});
	
	/* ===== 일괄 삭제 ===== */
	$('#btnBulkDel').addEventListener('click', ()=>{
	  const targets = $$('.q-row').filter(r => $('.q-check', r).checked && r.dataset.lock !== 'textTail');
	  if (!targets.length) return;
	  if (!confirm(`선택한 문항 ${targets.length}개를 삭제할까요?`)) return;
	  targets.forEach(r => r.remove());
	  renumber();
	});
	
	
</script>
</body>
</html>
