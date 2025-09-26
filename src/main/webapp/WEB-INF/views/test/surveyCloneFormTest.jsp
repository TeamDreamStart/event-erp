<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
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

// 템플릿 선택 → QA 로드
$("#tmplList").addEventListener('change', async (e) => {
  if (e.target.name !== 'templateId') return;
  const templateId = e.target.value;
  const res = await fetch(BASE + '/survey-test/template-qa?templateId=' + templateId);
  const data = await res.json();
  renderEditor(data.questions || []);
});

// 에디터 렌더링
function renderEditor(questions){
  const host = $("#qaEditor");
  host.innerHTML = "";
  questions.forEach(q => host.appendChild(qBlock(q.type, q.question, q.options||[])));
  if (!questions.length){
    host.innerHTML = '<div class="text-muted">문항이 없습니다. "문항 추가"로 작성하세요.</div>';
  }
}

// 문항 블록
function qBlock(type="single", question="", options=[]){
  const wrap = document.createElement('div');
  wrap.className = 'q-row';

  /* ★★★ 여기가 핵심: JS 템플릿 리터럴 내부의 ${...} 전부 \${...} 로 */
  wrap.innerHTML = `
    <div class="d-flex gap-2 align-items-center mb-2">
      <select class="form-select form-select-sm" style="max-width:140px">
        <option value="single" \${type==='single'?'selected':''}>단일선택</option>
        <option value="multi"  \${type==='multi'?'selected':''}>복수선택</option>
        <option value="scale_5" \${type==='scale_5'?'selected':''}>5점 척도</option>
      </select>
      <input class="form-control form-control-sm" placeholder="질문 내용을 입력" value="\${escapeHtml(question)}">
      <button class="icon-btn btn-sm btn-outline-secondary" type="button" data-act="up">↑</button>
      <button class="icon-btn btn-sm btn-outline-secondary" type="button" data-act="down">↓</button>
      <button class="icon-btn btn-sm btn-outline-danger" type="button" data-act="del">삭제</button>
    </div>
    <div class="opts"></div>
    <div class="mt-1">
      <button class="btn btn-outline-secondary btn-sm" type="button" data-act="add-opt">보기 추가</button>
    </div>
  `;

  const optsWrap = $('.opts', wrap);
  options.forEach(op => optsWrap.appendChild(optRow(op.label, op.optValue)));

  const typeSel = $('select', wrap);
  const updateOptVisibility = () => {
    const isText = (typeSel.value === 'text');
    optsWrap.parentElement.style.display = isText ? 'none' : '';
  };
  typeSel.addEventListener('change', updateOptVisibility);
  updateOptVisibility();

  wrap.addEventListener('click', (e)=>{
    const act = e.target.dataset.act;
    if (!act) return;
    if (act === 'add-opt') optsWrap.appendChild(optRow("", ""));
    if (act === 'del') wrap.remove();
    if (act === 'up')  wrap.previousElementSibling?.before(wrap);
    if (act === 'down') wrap.nextElementSibling?.after(wrap);
  });

  return wrap;
}

// 보기 행
function optRow(label="", optValue=""){
  const row = document.createElement('div');
  row.className = 'opt-row';
  row.innerHTML = `
    <input class="form-control form-control-sm" placeholder="보기 라벨" value="\${escapeHtml(label)}">
    <input class="form-control form-control-sm" placeholder="값(optValue)" value="\${escapeHtml(optValue||'')}">
    <button class="icon-btn btn-sm btn-outline-danger" type="button">삭제</button>
  `;
  row.lastElementChild.addEventListener('click', ()=>row.remove());
  return row;
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
    const res = await fetch(BASE + '/survey-test/clone-inline', {
      method:'POST',
      headers:{'Content-Type':'application/json'},
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

function collectPayload(templateId, eventId){
  const mode = $("#scheduleMode").value;
  const oq = $$('.q-row').map(q => {
    const type = $('select', q).value;
    const question = $('input', q).value.trim();
    const opts = $$('.opt-row', q).map(or => ({
      label: $('input:nth-of-type(1)', or).value.trim(),
      optValue: $('input:nth-of-type(2)', or).value.trim()
    })).filter(o => o.label.length>0);
    return { type, question, options: (type==='text' ? [] : opts) };
  });

  return {
    templateId,
    eventId,
    userId: ${userId == null ? 0 : userId},  // 이건 EL 그대로 사용 (백틱 밖이라 안전)
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
	</script>
</body>
</html>
