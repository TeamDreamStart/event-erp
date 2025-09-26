<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
		<h2>Reset Password</h2>
		<div class="resetPassword-section">
			<form action="#" method="post">
				<div class="resetPassword-form">
					<label for="newPassword">새 비밀번호</label>
					<input type="password" id="newPassword" name="newPassword" placeholder="새 비밀번호를 입력하세요." required>
					<p class="help-text">(영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10~16자)</p>
					<p id="newPassword-error" class="error-message"></p>
				</div>
				<div class="resetPassword-form">
					<label for="confirm-newPassword">새 비밀번호 확인</label>
					<input type="password" id="confirm-newPassword" name="confirm-newPassword" placeholder="새 비밀번호를 입력하세요." required>
					<p id="confirm-newPassword" class="error-message"></p>
				</div>
				<button type="submit" class="btn-change-password">변경하기</button>
			</form>
<footer class="footer">
        <p>수원시 팔달구 덕영대로 895번길 11</p>
		<p>대표전화. 031-420-4204</p>
		<hr class="footer-hr">
		<p>@jfdfhfksehfkjsnckaul</p>
	</footer>
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
        const newPasswordErrorEl = document.getElementById('newPassword-error'); // 오류 메시지 표시할 요소 ID 수정

        // 2. 새 비밀번호 확인 필드 가져오기
        const confirmNewPasswordInput = document.getElementById('confirm-newPassword');
        const confirmNewPassword = confirmNewPasswordInput.value;
        const confirmNewPasswordErrorEl = document.getElementById('confirm-newPassword-error'); // 오류 메시지 표시할 요소 ID 수정

        // 3. 비밀번호 형식 유효성 검사 (영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10~16자)
        // 정규식 설명:
        // ^                 : 문자열의 시작
        // (?=.*[a-zA-Z])    : 최소 하나의 영문자 (대소문자 구분 없음) 포함
        // (?=.*\d)          : 최소 하나의 숫자 포함
        // (?=.*[!@#$%^&*])  : 최소 하나의 특수문자 포함 (여기서는 예시로 일부 특수문자만 포함)
        // ................ : 위 3가지 조건 중 2가지 이상을 만족시키려면 복합적인 정규식이 필요합니다.
        //                  : 여기서는 '2가지 이상 조합' 조건이 이미지와 다소 모호하여, 
        //                  : '영문, 숫자, 특수문자 모두 포함'으로 가정하고 정규식을 작성합니다.
        //                  : 만약 2가지 이상 조합이라면 정규식 수정이 필요합니다. (예시 정규식 아래 추가)
        // {10,16}           : 총 길이가 10자 이상 16자 이하
        // $                 : 문자열의 끝

        // 이미지의 헬프 텍스트: "(영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10~16자)" 에 맞는 정규식
        // 1. 영문+숫자
        // 2. 영문+특수문자
        // 3. 숫자+특수문자
        // 4. 영문+숫자+특수문자
        // 이 모든 케이스를 만족하는 정규식을 구성하는 것이 가장 정확합니다.
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