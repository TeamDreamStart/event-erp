<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Join Membership</title>
<style>
    
    .mypage-link{
        cursor : pointer;
    }
    .mypage-link:hover{
        background-color: #e0e0e0;
    }
    .btn-login {
        cursor: pointer;
    }
    .btn-login:hover {
    background-color: #555;
}
.input-with-button {
    display: flex;
    gap: 8px;
    align-items: center;
}
.input-with-button input {
    flex-grow: 1;
}
.error-message {
    color: red;
    font-size: 0.9em;
    margin-top: 5px;
    display: none; /* 초기에는 숨김 */
}
    select.box {
        display: flex;
        margin-left: 5px;
        padding: 5px 0 5px 10px;
        border: 1px solid #d9d6d6;
        color: #383838;
        background-color: #ffffff;
        font-family: 'Montserrat', sans-serif;
        text-align: center;
}
    option {
        font-size: 16px;
    }
/* 1. select 박스 기본 스타일 통일 */
.birth-select {
    width: 100%;
    height: 50px; /* 기존 box 높이 50px 유지 */
    box-sizing: border-box;
    padding: 5px 0 5px 10px;
    border-radius: 4px;
    border: 1px solid #d9d6d6;
    color: #383838;
    background-color: #ffffff;
    font-family: 'Montserrat', 'Pretendard', sans-serif;
    /* 나머지 스타일 (화살표, 폰트 사이즈 등) */
}
    /* 2. 생년월일 섹션의 정렬 (가장 중요한 부분!) */
.form-group.birth-date-group {
    /* 레이블이 위에 있고, select 박스들이 아래에 한 줄로 오게 하려면 별도 flex 설정을 안 해도 됩니다. */
}
/* 3. 년/월/일 select 박스들을 한 줄에 정렬하고 간격 유지 */
.birth-select-wrapper {
    display: flex; /* 자식 요소(select)를 가로로 배열 */
    gap: 8px;      /* select 박스들 사이에 8px 간격 (이미지 기반 추정치) */
    width: 100%;   /* 부모 요소의 너비를 꽉 채우도록 */
}
    .info .box#domain-list option {
        font-size: 14px;
        background-color: #ffffff ;
    }
</style>
</head>
<body>
	<header class="header">
		<div class="header-top">
			<span class="header-left">
				<a href="/" class="logo-link"><span class="logo">D</span></a>
			</span>
			<span class="header-right">
				<span class="user-actions">
					<a href="#" class="mypage-link">my page</a>
					<button class="btn-login">login</button>
				</span>
			</span>
		</div>
			<nav class="header-nav">
				<a href="#">Visit</a>
				<a href="#">Event</a>
				<a href="#">Notice</a>
			</nav>
	</header>
	<div class="container">
		<h2>join membership</h2>
		<div class="membership-section">
			<form id="joinForm" action="#" method="post" onsubmit="return validateForm()">
				<div class="membership-form">

					<div class="form-group">
						<label for="username">아이디</label>
							<div class="input-with-button">
						<input type="text" name="username" id="username" placeholder="아이디를 입력하세요." required>
						<button type="button" onclick="checkUsernameDuplicate()">중복확인</button>
							</div>
						<p class="help-text">*아이디중복 여부 확인을 위해 입력하신 후 확인해주세요.</p>
						<p id="username-error" class="error-message"></p>
					</div>

					<div class="form-group">
						<label for="password">비밀번호</label>
						<input type="password" name="password" id="password" placeholder="비밀번호를 입력하세요." required>
						<p class="help-text">*9~12자의 영문자,숫자,특수문자를 혼용하여 입력해주세요.</p>
						<p id="password-error" class="error-message"></p>
					</div>
					
					<div class="form-group">
						<label for="password-check">비밀번호 확인</label>
						<input type="password" name="password-check" id="password-check" placeholder="비밀번호를 확인하세요." required>
						<p id="password-check-error" class="error-message"></p>
					</div>

					<div class="form-group">
						<label for="name">이름</label>
						<input type="text" name="name" id="name" required>
					</div>

                    <div class="form-group">
                        <div class="form-label">
                        <label for="gender">성별</label> </div>

                        <div class="form-radio">
                        <input type="radio" name="gender" id="male" value="male">
                        <label for="male">남</label>
                        <input type="radio" name="gender" id="female" value="female">
                        <label for="female">여</label>
                        </div>
                    </div>

                    <div class="form-group birth-date-group">
                        <label for="birth_year">생년월일</label>
                        <div class="birth-select-wrapper">
                            <select class="birth-select" id="birth_year" name="birth_year">
                            <option value="" disabled selected>출생 연도</option>
                            
                        </select>
                        <select class="birth-select" id="birth_month" name="birth_month">
                            <option value="" disabled selected>월</option>
                        </select>
                        <select class="birth-select" id="birth_day" name="birth_day">
                            <option value="" disabled selected>일</option>
                        </select>
                        </div>
                    </div>
                    
					<div class="form-group">
                        <label for="email">이메일</label>
						<div class="input-with-button">
                            <input type="text" name="email" id="email" required>
                            <span class="golbang">@</span>

                            <input class="box" id="domain-txt" type="text"/>
                                <select class="box" id="domain-list">
                                    <option value="type">직접 입력</option>
                                    <option value="naver.com">naver.com</option>
                                    <option value="google.com">google.com</option>
                                <option value="hanmail.net">hanmail.net</option>
                                <option value="nate.com">nate.com</option>
                                <option value="kakao.com">kakao.com</option>
                            </select>  

						<button type="button" onclick="checkEmailDuplicate()">중복확인</button>
						</div>
						<p class="help-text">*회원중복 가입여부 확인을 위하여 이메일을 입력하신 후 확인해주세요.</p>
						<p id="email-error" class="error-message"></p>
                    </div>
					</div>
                    
                    <div class="form-group">
                        <label for="tel">전화번호</label>
                        <input type="tel" name="tel" id="tel" required>
                    </div>

					<div class="join-bottom-button">
            <button type="button" class="btn-cancel">취소</button>
            <button type="submit" class="btn-next">다음</button>
            <!-- 다음 누르면 회원가입 완료됐다는 창이 나옴 -->
        </div>
    </div>
</form>
</div>
	<footer class="footer">
        <p>수원시 팔달구 덕영대로 895번길 11</p>
		<p>대표전화. 031-420-4204</p>
		<hr class="footer-hr">
		<p>@jfdfhfksehfkjsnckaul</p>
	</footer>

	<script>
        // 전역 변수로 중복 확인 상태를 관리
        let isUsernameChecked = false;
        let isEmailChecked = false;
        
        // 메시지를 표시하는 헬퍼 함수
    function showMessage(elementId, message, isError) {
        const element = document.getElementById(elementId);
        element.textContent = message;
        element.style.color = isError ? 'red' : 'green';
        element.style.display = 'block';
    }
    
    // 모든 메시지를 숨기는 함수
    function hideAllMessages() {
        document.querySelectorAll('.error-message').forEach(el => el.style.display = 'none');
    }

    // 아이디 중복 확인
    function checkUsernameDuplicate() {
        const username = document.getElementById('username').value.trim();
        hideAllMessages(); // 기존 메시지 숨김
        
        if (username === '') {
            showMessage('username-error', '아이디를 입력해주세요.', true);
            isUsernameChecked = false;
            return;
        }
        
        // 서버 요청
        fetch(`/check-username?username=${username}`) // UserController에 GET /check-username 매핑을 추가해야 합니다.
        .then(response => response.json())
        .then(data => {
            if (data.isDuplicate) {
                    showMessage('username-error', '이미 사용 중인 아이디입니다.', true);
                    isUsernameChecked = false;
                } else {
                    showMessage('username-error', '사용 가능한 아이디입니다.', false);
                    isUsernameChecked = true;
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showMessage('username-error', '중복 확인 중 오류가 발생했습니다.', true);
                isUsernameChecked = false;
            });
        }
    // ... (기존 checkUsernameDuplicate, showMessage, hideAllMessages, validateForm 함수 유지)

    // 생년월일 select 박스를 가져오는 변수
    const birthYearEl = document.querySelector('#birth_year');
    const birthMonthEl = document.querySelector('#birth_month');
    const birthDayEl = document.querySelector('#birth_day');

    /**
     * @brief 년/월/일 select 박스의 옵션을 동적으로 생성합니다.
     */
    function generateDateOptions() {
        // 1. 년 (Year) 옵션 생성
        const currentYear = new Date().getFullYear();
        for (let i = currentYear; i >= 1940; i--) { // 현재 년도부터 1940년까지 역순
            const option = document.createElement('option');
            option.value = i;
            option.innerText = i + '년';
            birthYearEl.appendChild(option);
        }

        // 2. 월 (Month) 옵션 생성
        for (let i = 1; i <= 12; i++) {
            const option = document.createElement('option');
            // 값이 1~9인 경우 01~09로 포맷팅 (선택사항)
            const monthValue = String(i).padStart(2, '0'); 
            option.value = monthValue;
            option.innerText = monthValue + '월';
            birthMonthEl.appendChild(option);
        }

        // 3. 일 (Day) 옵션은 월이 선택된 후 동적으로 생성되도록 초기 호출
        setDayOptions();
    }

    /**
     * @brief 선택된 년도와 월에 따라 일(Day) 옵션을 재설정합니다. (윤년 및 월별 일수 고려)
     */
    function setDayOptions() {
        // 기존 일(Day) 옵션 초기화 (플레이스홀더 제외)
        birthDayEl.innerHTML = '<option value="" disabled selected>일</option>';

        const year = birthYearEl.value;
        const month = birthMonthEl.value;
        
        // 년이나 월이 선택되지 않았다면 일 옵션 생성을 중단
        if (!year || !month) return; 

        // 월별 최대 일수 계산
        // new Date(year, month, 0)는 해당 '월'의 마지막 날짜를 반환합니다. 
        // month는 0부터 시작하므로, month에 현재 월을 넣으면 다음 달이 됩니다.
        // 따라서 month를 사용하면 정확히 해당 월의 마지막 날짜(일수)를 가져옵니다.
        const maxDay = new Date(year, month, 0).getDate(); 
        
        for (let i = 1; i <= maxDay; i++) {
            const option = document.createElement('option');
            const dayValue = String(i).padStart(2, '0');
            option.value = dayValue;
            option.innerText = dayValue + '일';
            birthDayEl.appendChild(option);
        }
    }

    // 4. 이벤트 리스너 등록 (핵심 로직)
    document.addEventListener('DOMContentLoaded', () => {
        // 페이지 로드 시 년/월 옵션 초기 생성
        generateDateOptions();

        // 년도나 월이 변경될 때마다 일 옵션을 다시 설정하도록 이벤트 리스너 추가
        birthYearEl.addEventListener('change', setDayOptions);
        birthMonthEl.addEventListener('change', setDayOptions);
        
        // ... (기존 이메일 관련 이벤트 리스너는 여기에 유지)
    });

    // ... (기존 이메일 관련 로직 및 validateForm 함수 유지)

        // 이메일 입력
        const domainListEl = document.querySelector('#domain-list')
        const domainInputEl = document.querySelector('#domain-txt')
        //select 옵션 변경 시
        domainListEl.addEventListener('change', (event) => {
            //option에 있는 도메인 선택시
            if(event.target.value !== "type") {
            // 선택한 도메인을 input에 입력하고 disabled
                domainInputEl.value = event.target.value
                domainInputEl.disabled = true
            } else { // 직접 입력 시
            // input 내용 초기화 & 입력 가능하도록 변경
                domainInputEl.value = ""
                domainInputEl.disabled = false
            }
    })
        
        // 이메일 중복 확인
        function checkEmailDuplicate() {
            const email = document.getElementById('email').value.trim();
        hideAllMessages(); // 기존 메시지 숨김

        if (email === '') {
            showMessage('email-error', '이메일을 입력해주세요.', true);
            isEmailChecked = false;
            return;
        }
        
        // 서버 요청
        fetch(`/check-email?email=${email}`) // UserController에 GET /check-email 매핑을 추가해야 합니다.
            .then(response => response.json())
            .then(data => {
                if (data.isDuplicate) {
                    showMessage('email-error', '이미 사용 중인 이메일입니다.', true);
                    isEmailChecked = false;
                } else {
                    showMessage('email-error', '사용 가능한 이메일입니다.', false);
                    isEmailChecked = true;
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showMessage('email-error', '중복 확인 중 오류가 발생했습니다.', true);
                isEmailChecked = false;
            });
    }

    // 전체 폼 유효성 검사 (submit 이벤트 핸들러)
    function validateForm() {
        hideAllMessages(); // 폼 제출 시 기존 메시지 숨김

        // 비밀번호 형식 유효성 검사 (9~12자, 영문, 숫자, 특수문자 혼용)
        const password = document.getElementById('password').value;
        const passwordPattern = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*])[a-zA-Z\d!@#$%^&*]{8,16}$/;
        if (!passwordPattern.test(password)) {
            showMessage('password-error', '8~16자의 영문자, 숫자, 특수문자를 혼용하여 입력해주세요.', true);
            document.getElementById('password').focus();
            return false;
        }

        // 비밀번호 일치 확인
        const passwordConfirm = document.getElementById('password-check').value;
        if (password !== passwordConfirm) {
            showMessage('password-check-error', '비밀번호와 비밀번호 확인 값이 일치하지 않습니다.', true);
            document.getElementById('password-check').focus();
            return false;
        }

        // 아이디와 이메일 중복 확인 완료 여부
        if (!isUsernameChecked || !isEmailChecked) {
            alert("아이디와 이메일 중복확인을 먼저 완료해주세요.");
            return false;
        }

        // 모든 유효성 검사 통과
        return true;
    }
</script>
</body>
</html>