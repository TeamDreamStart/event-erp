<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet"/>
<title>findPassword</title>
<link rel="stylesheet" type="text/css" href="/resources/css/findPassword.css">
</head>
<body>
      <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <main>
    <div class="container">
        <h2>Find</h2>
        <div class="find-main">
            <div class="tab-header">
                <button type="button" class="tab-btn active" data-tab="uid-section-content">아이디 찾기</button>
                <button type="button" class="tab-btn" data-tab="password-section-content">비밀번호 찾기</button>
            </div>
            
            <div id="uid-section-content" class="tab-content active">
                <form action="/login" method="post">
                    <div class="find-uid-form">
                    <label for="email_uid">이메일로 찾기</label><br>
                    <div class="input-group">
                        <input type="text" name="userEmail" id="email_uid" placeholder="이메일을 입력하세요." required>
                        <button type="button" class="btn-send-code">인증번호 전송</button>
                    </div>
                    <span id="email-uid-message" class="error-message"></span>
                    </div>
                    
                    <div class="find-uid-form">
                    <label for="verificationCode_uid">인증번호</label><br>
                    <div class="input-group">
                        <input type="text" id="verificationCode_uid" name="verificationCode" placeholder="인증번호를 입력하세요." required>
                        <button type="button" class="btn-verify">확인</button>
                    </div>
                    </div>
                                        <div class="end-btn">
                        <button onclick="history.back()" class="btn-cancle">취소</button>
                        <button type="submit" class="btn-find-uid">로그인</button>
                    </div>
                </form>
            </div>
            
            <div id="password-section-content" class="tab-content">
                <form action="/reset-password" method="post">
                    <div class="find-password-form">
                    <label for="email_pw">이메일로 찾기</label><br>
                    <div class="input-group">
                        <input type="text" name="userEmail" id="email_pw" placeholder="이메일을 입력하세요." required>
                        <button type="button" class="btn-send-code">인증번호 전송</button>
                    </div>
                    <span id="email-pw-message" class="error-message"></span>
                    </div>
                    
                    <div class="find-password-form">
                    <label for="verificationCode_pw">인증번호</label><br>
                    <div class="input-group">
                        <input type="text" id="verificationCode_pw" name="verificationCode" placeholder="인증번호를 입력하세요." required>
                        <button type="button" class="btn-verify">확인</button>
                    </div>
                    </div>
                                        <div class="end-btn">
                        <button onclick="history.back()" class="btn-cancle">취소</button>
                        <button type="submit" class="btn-find-pass">비밀번호 찾기</button>
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

            // 유효성 검사 통과 시
            showMessage(messageId, '인증번호를 전송합니다.', false); // 성공 메시지는 초록색으로 표시 가능
            // 서버 전송 로직...
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

            // 유효성 검사 통과 시
            showMessage(messageId, '인증번호를 전송합니다.', false); // 성공 메시지는 초록색으로 표시 가능
            // 서버 전송 로직...
        });
    }
});
</script>
</body>
</html>