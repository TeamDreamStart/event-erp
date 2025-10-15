<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700;900&display=swap" rel="stylesheet"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@12/swiper-bundle.min.css"/>

<title>login</title>
<link rel="stylesheet" type="text/css" href="/resources/css/login.css">
<style>
    body {
        background-color: #E5E2DB;
		color: #222222;
		font-family: 'Montserrat', sans-serif;
		font-size: medium;
font-weight: normal;
		margin: 0;
		padding: 0 120px 60px; 
		line-height: 1;
	}
	main {
		margin-top: 0; 
		padding: 0; 
	}
	h2{
		font-size: 20px;
        font-weight: bold;
        user-select: none;
        cursor: default;
        margin-bottom: 40px;
        padding-top: 40px;
	}
    .container {
        width: 100%;
}
	.find-main {
    /* find-main을 화면 가운데 정렬 */
    margin: 0 auto;
    margin-bottom: 60px;
    
}
.tab-content {
    display: none;
}
.uid-section-content, .password-section-content{
        width: 40%;
        max-width: 400px;
        background-color: #FAF9F6;
    border: 1px solid #222222;
    border-radius: 12px;
    margin: 0 auto;
    margin-bottom: 60px;
    padding: 48px 104px;
		font-family: 'Montserrat', sans-serif;
        font-size: 14px;
        display: block;
        text-align: center;
    }
	/* active 클래스가 붙으면 보이도록 설정 */
	.tab-content.active {
		display: block;
    }
.tab-header {
	display: flex;
}
	.tab-btn {
		/* 버튼 기본 스타일 */
        padding: 12px 0;
    cursor: pointer;
    background-color: #CBD4C2;
    border: none;
    color: #888888;
    border-radius: 12px;
    width: 50%;
    font-family: 'Montserrat', sans-serif;
    font-size: 14px;
    text-align: center;
}
	.tab-btn.active {
        /* 활성화된 버튼 스타일 */
        background-color: #FAF9F6;
		border: 1px solid #222222;
		color: #222222;
        font-weight: bold;
		border-bottom: none;
		margin-bottom: -1px;
		font-family: 'Montserrat', sans-serif;
		font-size: 14px;
        
    }
.find-uid-form, .find-password-form{
    margin: 0 auto 16px auto; 
    display: block; 
    max-width: 400px; 
}

/* 라벨 스타일: 왼쪽 정렬 */
.find-uid-form label, .find-password-form label {
    display: block;
    width: 100%;
    font-weight: bold;
    text-align: left;
    margin-bottom: 0; /* 라벨 자체의 하단 마진 제거 */
    padding-bottom: 0;
    line-height: 1; /* 라벨의 높이 최소화 */
    font-size: 14px;
}

/* input-group: input과 버튼을 나란히 배치 (줄바꿈 방지) */
.input-group{
    display: flex;
    flex-wrap: nowrap;
    align-items: center;
    margin-top: -5px;
    justify-content: flex-start; 
}
br{
	margin: 0;
	padding: 0;
	line-height: 0;
}

input::placeholder{
    color: #D9D9D9;
    font-family: 'Montserrat', sans-serif;
    font-size: 14px;
}
input#verificationCode_uid, #verificationCode_pw, #email_uid, #email_pw{
    width: 100%;
flex-grow: 1; 
box-sizing: border-box;
background-color: #F2F0EF;
border: 1px solid #222222;
border-radius: 3px;
padding: 10px 12px 10px 12px;
height: 37px;
}
#email_uid ::placeholder{
    padding-left:12px;
}
br {
    margin-top: -4px;
    padding: 0;
    line-height: 0;
}
.btn-register, .btn-send-code, .btn-verify, .btn-find-uid, .btn-find-pass, .btn-cancle {
    padding: 8px 2px;
    width: 80px;
    text-decoration: none;
    border-radius: 12px;
    font-family: 'Montserrat', sans-serif;
    font-size: 14px;
    cursor: pointer;
    flex-shrink: 0;
    font-weight: bold;
    color: #222222;
} 
.btn .btn-send-code, .btn-verify, .btn-find-uid, .btn-find-pass {
    border: 1px solid #8FAFED;
    background-color: #BFD4F9;
}
.btn-cancle{
    border: 1px solid #AFAFAF;
    background-color: #F2F0EF;
    margin-right: 16px;
}
.btn-register{
    border: 1px solid #8FAFED;
    background-color: #BFD4F9;
    margin-right: 16px;
    padding: 8px 2px;
    width: 80px;
}
.find-link{
    text-align: right;
    margin: 4px auto 0 auto;
}
.find-link a {
    color: #222222;
    text-decoration: none;
    font-size: 12px;
}

/* 하단 버튼 영역 가운데 정렬 */
.end-btn{
    margin: 58px auto 0 auto;
    display: block;
    width: fit-content;
    text-align: center;
}
.error-message {
    display: block; /* 줄바꿈 */
    color: red; /* 빨간색 글씨 */
    font-size: 11px;
    margin-top: 4px;
    height: 15px; /* 메시지가 없을 때 공간 확보 방지 */
    text-align: left; /* 왼쪽 정렬 */
    user-select: none;
    cursor: default;
}
/* 반응형 디자인 */
@media (max-width: 768px) {
    body {
        padding: 0 10px 30px;
    }
}
@media (max-width: 480px) {
    .tab-content {
        padding: 30px 20px;
    }
    .input-group {
        display: block;
    }
    input[type=text], input[type=password] {
        width: 100%;
        min-width: unset;
        margin-bottom: 8px;
    }
    .btn-register, .btn-cancle, .btn-find-uid, .btn-find-pass {
        width: 80px;
    }
    .end-btn {
        gap: 8px;
        margin-top: 30px;
    }
}
</style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <main>
    <div class="container">
        <h2>Login</h2>
        <div class="find-main">
            <div class="tab-header">
                <button type="button" class="tab-btn active" data-tab="uid-section-content">회원으로 로그인하기</button>
                <button type="button" class="tab-btn" data-tab="password-section-content">비회원으로 예약조회</button>
            </div>
            
            <div id="uid-section-content" class="tab-content active">
                <form action="/${postDTO.username}" method="post">
                    <div class="find-uid-form">
                    <label for="email_uid">이메일</label><br>
                    <div class="input-group">
                        <input type="text" name="userEmail" id="email_uid" placeholder="이메일을 입력하세요." required>
                    </div>
                    <span id="email-uid-message" class="error-message"></span>
                    </div>
                    
                    <div class="find-uid-form">
                    <label for="verificationCode_uid">비밀번호</label><br>
                    <div class="input-group">
                        <input type="password" id="verificationCode_uid" name="verificationCode" placeholder="비밀번호를 입력하세요." required>
                    </div>
                    <div class="find-link">
					<a href="/find-password">아이디 · 비밀번호 찾기</a>
				</div>
                    </div>
				
                <div class="end-btn">
                    <button button onclick="history.back()" class="btn btn-cancle">취소</button>
					<a href="/join" class="btn btn-register">회원가입</a>
					<button type="submit" class="btn btn-find-uid">로그인</button>
				</div>
                </form>
            </div>
            
            <div id="password-section-content" class="tab-content">
                <form action="/${postDTO.name}" method="post">
                    <div class="find-password-form">
                    <label for="email_pw">이메일</label><br>
                    <div class="input-group">
                        <input type="text" name="userEmail" id="email_pw" placeholder="이메일을 입력하세요." required>
                    </div>
                    <span id="email-pw-message" class="error-message"></span>
                    </div>
                    
                    <div class="find-password-form">
                    <label for="verificationCode_pw">비밀번호</label><br>
                    <div class="input-group">
                        <input type="text" id="verificationCode_pw" name="verificationCode" placeholder="비밀번호를 입력하세요." required>
                    </div>
                    </div>

                    <div class="end-btn">
                        <button button onclick="history.back()" class="btn btn-cancle">취소</button>
                        <button type="submit" class="btn btn-find-pass">로그인</button>
                    </div>
                </form>
            </div>
        </div>
    </div> <hr>
    </main>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
<script>
document.addEventListener('DOMContentLoaded', function() {
    const tabButtons = document.querySelectorAll('.tab-btn');
    const tabContents = document.querySelectorAll('.tab-content');

    tabButtons.forEach(button => {
        button.addEventListener('click', function() {
            const targetId = this.dataset.tab;

            tabButtons.forEach(btn => btn.classList.remove('active'));
            this.classList.add('active');
            tabContents.forEach(content => content.classList.remove('active'));

            const targetContent = document.getElementById(targetId);
            if (targetContent) {
                targetContent.classList.add('active');
            }
        });
    });

    // 메시지를 표시하거나 숨기는 함수 (참고하신 로직 기반)
    function showMessage(elementId, message, isError) {
        const messageElement = document.getElementById(elementId);
        if (messageElement) {
            messageElement.textContent = message;
            messageElement.style.color = isError ? 'red' : 'green';
        }
    }

    // 모든 이메일 메시지 숨기는 함수
    function hideAllEmailMessages() {
        showMessage('email-uid-message', '', false);
        showMessage('email-pw-message', '', false);
    }
    
    function isValidEmail(email) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    }

    const sendCodeUidBtn = document.querySelector('#uid-section-content .btn-send-code');
    const sendCodePwBtn = document.querySelector('#password-section-content .btn-send-code');

    if (sendCodeUidBtn) {
        sendCodeUidBtn.addEventListener('click', function() {
            const messageId = 'email-uid-message';
            const emailInput = document.getElementById('email_uid');
            const email = emailInput.value.trim();
            
            // 기존 메시지 숨김
            showMessage(messageId, '', false); 

            if (email === "") {
                showMessage(messageId, '이메일을 입력해 주세요.', true);
                emailInput.focus();
                return;
            }

            if (!isValidEmail(email)) {
                showMessage(messageId, '올바른 이메일 형식이 아닙니다. 다시 확인해 주세요.', true);
                emailInput.focus();
                return;
            }
        });
    }

    if (sendCodePwBtn) {
        sendCodePwBtn.addEventListener('click', function() {
            const messageId = 'email-pw-message';
            const emailInput = document.getElementById('email_pw');
            const email = emailInput.value.trim();
            
            // 기존 메시지 숨김
            showMessage(messageId, '', false);

            if (email === "") {
                showMessage(messageId, '이메일을 입력해 주세요.', true);
                emailInput.focus();
                return;
            }
            
            if (!isValidEmail(email)) {
                showMessage(messageId, '올바른 이메일 형식이 아닙니다. 다시 확인해 주세요.', true);
                emailInput.focus();
                return;
            }
        });
    }
});
</script>
</body>
</html>