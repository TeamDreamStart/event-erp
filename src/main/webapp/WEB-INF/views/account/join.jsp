<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap"
	rel="stylesheet" />
<title>join</title>
<link rel="stylesheet" type="text/css" href="/resources/css/join.css">
<style>
  .field-msg { display:block; margin-top:4px; font-size:12px; }
  .ok { color:#0a7a0a; }       /* 초록 */
  .warn { color:#d9534f; }     /* 빨강 */
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<main>
		<div class="container">
			<h2>join membership</h2>
			<div class="membership-section">
				<form id="joinForm" action="/join" method="post"
					onsubmit="return validateForm()">
					<div class="membership-form">

						<!-- 아이디 -->
						<div class="form-group">
							<label for="username">아이디</label>
							<div class="input-with-button">
								<input type="text" name="username" id="username"
									placeholder="아이디를 입력하세요." required>
								<button type="button" id="btn-check-username">중복확인</button>
							</div>
							<small id="username-msg" class="field-msg"></small>
						</div>

						<!-- 비밀번호 -->
						<div class="form-group">
							<label for="password">비밀번호</label> <input type="password"
								name="password" id="password" placeholder="비밀번호를 입력하세요."
								required> <small id="password-msg" class="field-msg"></small>
						</div>

						<!-- 비밀번호 확인 -->
						<div class="form-group">
							<label for="password-check">비밀번호 확인</label> <input
								type="password" name="password-check" id="password-check"
								placeholder="비밀번호를 확인하세요." required> <small
								id="password2-msg" class="field-msg"></small>
						</div>

						<div class="form-group">
							<label for="name">이름</label> <input type="text" name="name"
								id="name" required>
						</div>

						<div class="form-group">
							<div class="form-label">
								<label for="gender">성별</label>
							</div>

							<div class="form-radio">
								<input type="radio" name="gender" id="male" value="male">
								<label for="male">남</label> <input type="radio" name="gender"
									id="female" value="female"> <label for="female">여</label>
							</div>
						</div>

						<div class="form-group birth-date-group">
							<label for="birth_year">생년월일</label>
							<div class="birth-select-wrapper">
								<select class="birth-select" id="birth_year" name="birth_year">
									<option value="" disabled selected>출생 연도</option>

								</select> <select class="birth-select" id="birth_month"
									name="birth_month">
									<option value="" disabled selected>월</option>
								</select> <select class="birth-select" id="birth_day" name="birth_day">
									<option value="" disabled selected>일</option>
								</select>
							</div>
						</div>

						<!-- 이메일 -->
						<div class="form-group">
							<label for="email">이메일</label>
							<div class="input-with-button">
								<input type="text" id="email-local" placeholder="아이디" required>
								<span class="golbang">@</span> <input class="box"
									id="domain-txt" type="text" placeholder="도메인 입력" /> <select
									class="box" id="domain-list">
									<option value="type">직접 입력</option>
									<option value="naver.com">naver.com</option>
									<option value="gmail.com">gmail.com</option>
									<option value="hanmail.net">hanmail.net</option>
									<option value="nate.com">nate.com</option>
									<option value="kakao.com">kakao.com</option>
								</select>
								<button type="button" id="btn-check-email">중복확인</button>
							</div>
							<small id="email-msg" class="field-msg"></small>
						</div>
					</div>

					<div class="form-group">
						<label for="tel">전화번호</label> <input type="tel" name="tel"
							id="tel" required>
					</div>

					<div class="join-bottom-button">
						<button type="button" class="btn-cancel">취소</button>
						<button type="submit" class="btn-next">다음</button>
						<!-- 다음 누르면 회원가입 완료됐다는 창이 나옴 -->
					</div>
				</form>
			</div>
		</div>
	</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
<script>
  // 상태 플래그
  let isUsernameChecked = false;
  let isEmailChecked = false;

  // 유틸
  const $ = sel => document.querySelector(sel);
  const setMsg = (id, text, ok) => {
    const el = $(id);
    el.textContent = text || '';
    el.classList.remove('ok', 'warn');
    if (text) el.classList.add(ok ? 'ok' : 'warn');
  };

  // 생년월일 옵션 채우기
  const birthYearEl = $('#birth_year');
  const birthMonthEl = $('#birth_month');
  const birthDayEl = $('#birth_day');

  function generateDateOptions() {
    if (!birthYearEl || !birthMonthEl || !birthDayEl) return;

    const currentYear = new Date().getFullYear();
    for (let y = currentYear; y >= 1940; y--) {
      const o = document.createElement('option');
      o.value = y;
      o.textContent = y + '년';
      birthYearEl.appendChild(o);
    }
    for (let m = 1; m <= 12; m++) {
      const o = document.createElement('option');
      o.value = String(m).padStart(2, '0');
      o.textContent = o.value + '월';
      birthMonthEl.appendChild(o);
    }
    setDayOptions();
  }

  function setDayOptions() {
    birthDayEl.innerHTML = '<option value="" disabled selected>일</option>';
    const y = birthYearEl.value;
    const m = birthMonthEl.value;
    if (!y || !m) return;
    const maxDay = new Date(y, m, 0).getDate();
    for (let d = 1; d <= maxDay; d++) {
      const o = document.createElement('option');
      o.value = String(d).padStart(2, '0');
      o.textContent = o.value + '일';
      birthDayEl.appendChild(o);
    }
  }

  // 비밀번호 실시간 검증
  const pwd = $('#password');
  const pwd2 = $('#password-check');
  const PWD_RE = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,16}$/;

  function validatePwd() {
    if (!pwd.value) { setMsg('#password-msg', '비밀번호를 입력하세요.', false); return false; }
    if (!PWD_RE.test(pwd.value)) {
      setMsg('#password-msg', '8~16자, 영문/숫자/특수문자 조합이어야 합니다.', false);
      return false;
    }
    setMsg('#password-msg', '사용 가능한 비밀번호입니다. ✅', true);
    return true;
  }

  function validatePwd2() {
    if (!pwd2.value) { setMsg('#password2-msg', '', true); return false; }
    if (pwd.value !== pwd2.value) {
      setMsg('#password2-msg', '비밀번호가 일치하지 않습니다.', false);
      return false;
    }
    setMsg('#password2-msg', '비밀번호가 일치합니다. ✅', true);
    return true;
  }

  // 아이디 중복확인
  function checkUsernameDuplicate() {
    const username = $('#username').value.trim();
    if (!username) {
      setMsg('#username-msg', '아이디를 입력하세요.', false);
      isUsernameChecked = false; return;
    }
    fetch('/api/users/check-username?username=' + encodeURIComponent(username))
      .then(r => r.json())
      .then(data => {
        if (data.exists) {
          setMsg('#username-msg', '이미 사용 중인 아이디입니다.', false);
          isUsernameChecked = false;
        } else {
          setMsg('#username-msg', '사용 가능한 아이디입니다. ✅', true);
          isUsernameChecked = true;
        }
      })
      .catch(() => {
        setMsg('#username-msg', '중복 확인 중 오류가 발생했습니다.', false);
        isUsernameChecked = false;
      });
  }

  // 이메일 파트 조합/검증
  const domainListEl = $('#domain-list');
  const domainInputEl = $('#domain-txt');

  domainListEl.addEventListener('change', (e) => {
    if (e.target.value !== 'type') {
      domainInputEl.value = e.target.value;
      domainInputEl.disabled = true;
    } else {
      domainInputEl.value = '';
      domainInputEl.disabled = false;
      domainInputEl.focus();
    }
  });

  function buildEmail() {
    const local = $('#email-local').value.trim();
    const domain = domainInputEl.value.trim();
    return (local && domain) ? (local + '@' + domain).toLowerCase() : '';
  }

  function checkEmailDuplicate() {
    const email = buildEmail();
    if (!email) {
      setMsg('#email-msg', '이메일 아이디/도메인을 모두 입력하세요.', false);
      isEmailChecked = false; return;
    }
    fetch('/api/users/check-email?email=' + encodeURIComponent(email))
      .then(r => r.json())
      .then(data => {
        if (data.exists) {
          setMsg('#email-msg', '이미 사용 중인 이메일입니다.', false);
          isEmailChecked = false;
        } else {
          setMsg('#email-msg', '사용 가능한 이메일입니다. ✅', true);
          isEmailChecked = true;
        }
      })
      .catch(() => {
        setMsg('#email-msg', '중복 확인 중 오류가 발생했습니다.', false);
        isEmailChecked = false;
      });
  }

  // 폼 제출 전 최종 검증 + hidden email 합치기
  const form = document.getElementById('joinForm');
  form.addEventListener('submit', (e) => {
    const ok1 = validatePwd();
    const ok2 = validatePwd2();
    if (!ok1 || !ok2) { e.preventDefault(); return; }

    if (!isUsernameChecked || !isEmailChecked) {
      alert('아이디/이메일 중복확인을 완료해 주세요.');
      e.preventDefault(); return;
    }

    // 최종 email hidden 필드 생성/주입 (서버는 name="email"을 받음)
    const finalEmail = buildEmail();
    if (!finalEmail) { setMsg('#email-msg','유효한 이메일을 입력하세요.', false); e.preventDefault(); return; }
    let hidden = form.querySelector('input[name="email"]');
    if (!hidden) {
      hidden = document.createElement('input');
      hidden.type = 'hidden';
      hidden.name = 'email';
      form.appendChild(hidden);
    }
    hidden.value = finalEmail.toLowerCase(); // DB 제약과 동일하게 소문자

    // 성별/생년월일 등 name 매핑은 기존 서버 DTO와 맞춰주세요.
  });

  // 이벤트 바인딩
  document.addEventListener('DOMContentLoaded', () => {
    generateDateOptions();
    birthYearEl.addEventListener('change', setDayOptions);
    birthMonthEl.addEventListener('change', setDayOptions);

    pwd.addEventListener('input', validatePwd);
    pwd2.addEventListener('input', validatePwd2);

    document.getElementById('btn-check-username').addEventListener('click', checkUsernameDuplicate);
    document.getElementById('btn-check-email').addEventListener('click', checkEmailDuplicate);
  });
</script>

</body>
</html>