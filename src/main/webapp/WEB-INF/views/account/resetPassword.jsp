<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<%@ taglib prefix="sec"
    uri="http://www.springframework.org/security/tags"%>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700;900&display=swap" rel="stylesheet"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@12/swiper-bundle.min.css"/>

<script src="https://cdn.jsdelivr.net/npm/swiper@12/swiper-bundle.min.js"></script>
<title>resetPassword</title>
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
    .container {
        width: 100%;
}
    .section-header h2{
        font-size: 20px;
        font-weight: bold;
        user-select: none;
        cursor: default;
        margin-bottom: 40px;
        padding-top: 40px;
    }
.resetPassword-section{
    background-color: #FAF9F6;
    border: 1px solid #222222;
    border-radius: 12px;
    margin: 0 auto;
    margin-bottom: 60px;
    width: 40%;
    max-width: 400px;
    padding: 48px 104px;
		font-family: 'Montserrat', sans-serif;
        font-size: 14px;
        display: block;
        text-align: center;
}
.resetPassword-form label{
    display: block;
    width: 100%;
    font-weight: bold;
    text-align: left;
    margin-bottom: 8px;
    padding-bottom: 0;
    line-height: 1; /* 라벨의 높이 최소화 */
}

input::placeholder{
    color: #D9D9D9;
    font-family: 'Montserrat', sans-serif;
    font-size: 14px;
}
.resetPassword-section input[type="password"]{
    width: 100%;
    box-sizing: border-box;
    background-color: #F2F0EF;
    border: 1px solid #222222;
    border-radius: 3px;
    padding: 10px 12px;
    font-size: 14px;
    outline: none;
    transition: border-color 0.2s;
    caret-color: transparent;
}
.resetPassword-section input[type="password"]:focus {
    border-color: #222222;
}
input::placeholder{
    color: #D9D9D9;
    font-family: 'Montserrat', sans-serif;
    font-size: 12px;
}

.help-text {
    font-size: 12px;
    color: #D9D9D9;
    margin: 4px 0 0 0;
    text-align: left;
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
.btn-change-password{
    display: block;
    width: 100px;
    padding: 8px 2px;
    font-family: 'Montserrat', sans-serif;
    border: 1px solid #8FAFED;
    background-color: #BFD4F9;
    border-radius: 12px;
    font-size: 14px;
    font-weight: bold;
    cursor: pointer;
    text-align: center;
    margin: 58px auto 0 auto;
    transition: background-color 0.2s;
}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<main>
		<div class="container">
            <div class="section-header">
                <h2>Reset Password</h2>
            </div>
			<div class="resetPassword-section">
			
			
			
			
				<form action="/reset-password" method="post">
					<div class="resetPassword-form">
						<label for="newPassword">새 비밀번호</label> 
						<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
						<!-- 이메일값 안 받아오면 이 페이지에서 나가게 자바스크립트 처리@@@@@@@@@@@@@@@@@@@@@@@@ -->
						<input type="hidden" name="email" value="${email }">
						<input type="password"
							id="newPassword" name="newPass" placeholder="새 비밀번호를 입력하세요."
							required>
						<p class="help-text">(영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10~16자)</p>
						<p id="newPassword-error" class="error-message"></p>
					</div>
					<div class="resetPassword-form">
						<label for="confirm-newPassword">새 비밀번호 확인</label> <input
							type="password" id="confirm-newPassword"
							name="confirm-newPassword" placeholder="새 비밀번호를 입력하세요." required>
						<p id="confirm-newPassword" class="error-message"></p>
					</div>
					<button type="submit" class="btn-change-password">변경하기</button>
				</form>
                </div>
                </div>
                <hr>
				<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
				<script>
    // 메시지를 표시하는 헬퍼 함수
    function showMessage(elementId, message, isError) {
        const element = document.getElementById(elementId);
        if (element) { // 요소가 존재하는지 확인
            element.textContent = message;
            element.style.color = isError ? 'red' : 'green';
            element.style.display = 'block';
        }
    }
    
    // 모든 메시지를 숨기는 함수
    function hideAllMessages() {
        document.querySelectorAll('.error-message').forEach(el => el.style.display = 'none');
    }

    /**
     * @brief 새 비밀번호 설정 폼의 유효성을 검사합니다.
     * @returns {boolean} 폼 제출 여부 (true: 제출, false: 제출 안 함)
     */
    function validateForm() {
        hideAllMessages(); // 폼 제출 시 기존 메시지 모두 숨김

        // 1. 새 비밀번호 필드 가져오기
        const newPasswordInput = document.getElementById('newPassword');
        const newPassword = newPasswordInput.value;
        const newPasswordErrorEl = document.getElementById('newPassword-error');

        // 2. 새 비밀번호 확인 필드 가져오기
        const confirmNewPasswordInput = document.getElementById('confirm-newPassword');
        const confirmNewPassword = confirmNewPasswordInput.value;
        const confirmNewPasswordErrorEl = document.getElementById('confirm-newPassword-error');
        const passwordPattern = new RegExp(
            /^(?:(?=.*[a-zA-Z])(?=.*\d)|(?=.*[a-zA-Z])(?=.*[!@#$%^&*])|(?=.*\d)(?=.*[!@#$%^&*])|(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*]))[a-zA-Z\d!@#$%^&*]{8,16}$/
        );

        if (!passwordPattern.test(newPassword)) {
            showMessage('newPassword-error', '영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10~16자로 입력해주세요.', true);
            newPasswordInput.focus();
            return false;
        }

        // 4. 새 비밀번호 일치 확인
        if (newPassword !== confirmNewPassword) {
            showMessage('confirm-newPassword-error', '새 비밀번호와 비밀번호 확인 값이 일치하지 않습니다.', true);
            confirmNewPasswordInput.focus();
            return false;
        }

        // 모든 유효성 검사 통과
        return true;
    }

    // 폼 제출 이벤트 리스너 등록
    document.addEventListener('DOMContentLoaded', () => {
        const resetPasswordForm = document.querySelector('.resetPassword-section form');
        if (resetPasswordForm) {
            resetPasswordForm.addEventListener('submit', function(event) {
                if (!validateForm()) {
                    event.preventDefault(); // 유효성 검사 실패 시 폼 제출 방지
                }
            });
        }
    });
</script>
</body>
</html>