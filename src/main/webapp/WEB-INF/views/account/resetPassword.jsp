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

	<header> </header>

	<nav></nav>

    
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
</>
</body>
</html>