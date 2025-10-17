<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700;900&display=swap"
	rel="stylesheet" />
<title>MyPage - 회원 정보 수정</title>
<style>
body {
	background-color: #E5E2DB;
	color: #222222;
	font-family: 'Montserrat', sans-serif;
	font-size: 16px;
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
	max-width: 896px;
	margin: 0 auto;
	padding: 0;
}

.section-header {
	display: flex;
	align-items: center;
	margin-bottom: 20px;
}

.page-title {
	display: flex;
	align-items: center;
}

.page-title h2 {
	font-size: 30px;
	font-weight: 700;
	line-height: 40px;
}

.page-title a {
	text-decoration: none;
	color: #222222;
	margin-right: 10px;
	font-size: 24px;
}

.info-box {
	background-color: #FFFFFF;
	border: 1px solid #D9D9D9;
	padding: 32px 23px;
	border-radius: 12px;
	margin-bottom: 26px;
}

.form-section-title {
	font-size: 16px;
	font-weight: bold;
	margin-bottom: 30px;
}

.form-group {
	margin-bottom: 20px;
}

.form-group:last-of-type {
	margin-bottom: 0;
}

.form-label {
	display: block;
	font-size: 14px;
	font-weight: 700;
	margin-bottom: 8px;
}

.form-input-box {
	/* 100% 대신 max-width를 사용하여 전체 너비를 제한하고 min-width를 적용 */
	max-width: 100%;
	min-width: 434px; /* 요청하신 최소 너비 적용 */
	padding: 8px;
	border-radius: 3px;
	font-size: 14px;
	box-sizing: border-box;
	border: 1px solid #AFAFAF;
	background-color: #F2F0EF;
}

.form-input-box::placeholder {
	color: #AFAFAF;
}

.email-input {
	background-color: #D9D9D9;
	border: 1px solid #AFAFAF;
}

.help-text, .error-message {
	display: block;
	font-size: 12px;
	margin-top: 5px;
}

.help-text {
	color: #888;
}

.error-message {
	color: #E53935;
	font-weight: 700;
	display: none;
}

.form-input-box:invalid:not(:placeholder-shown), .form-input-box.error {
	border-color: #AFAFAF;
}

.form-group.has-error .error-message {
	display: block;
}

.button-area {
	display: flex;
	justify-content: flex-end;
	gap: 14px;
	margin-top: 40px;
}

.action-btn {
	padding: 10px 10px;
	border-radius: 12px;
	font-weight: 700;
	font-size: 14px;
	cursor: pointer;
	border: none;
	height: 34px;
	display: flex;
	justify-content: center;
	align-items: center;
}

.cancel-btn {
	background-color: #F2F0EF;
	color: #222222;
	border: 1px solid #AFAFAF;
}

.save-btn {
	background-color: #BFD4F9;
	color: #222222;
	border: 1px solid #8FAFED;
}
</style>
</head>

<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<main>
		<div class="container">
			<div class="section-header">
				<div class="page-title">
					<h2>MyPage</h2>
				</div>
			</div>

			<div class="info-box">
				<form onsubmit="return validateForm(event)"
					action="/my-info/${userDTO.userId}/update" method="post">
					<div class="form-section-title">기본 정보</div>
					<input type="hidden" id="userId" name="userId"
						value="${userDTO.userId}">

					<div class="form-group">
						<label class="form-label" for="email">이메일 (변경 불가)</label> <input
							type="text" id="email" name="email"
							class="form-input-box email-input" value="${userDTO.email}"
							onblur="checkEmailFormat(this)">
					</div>

					<div class="form-group">
						<label class="form-label" for="name">이름*</label> <input
							type="text" id="name" name="name" class="form-input-box"
							value="${userDTO.name}" required>
					</div>

					<div class="form-group" id="phone-group">
						<label class="form-label" for="phone">전화번호*</label> <input
							type="text" id="phone" name="phone" value="${userDTO.phone}"
							class="form-input-box" placeholder="예) 010-1234-5678" required
							pattern="\d{3}-\d{4}-\d{4}" oninput="autoFormatPhone(this)"
							onblur="checkPhoneValidity(this)"> <span
							class="help-text">'-'를 포함하여 000-0000-0000 형식으로 입력해 주세요.</span> <span
							class="error-message" id="phone-error">전화번호 형식이 올바르지 않습니다.
							(예: 000-0000-0000)</span>
					</div>
				</form>
			</div>

			<div class="info-box" style="margin-bottom: 140px;">
				<form action=" " method="post">
					<div class="form-section-title">비밀번호 변경</div>

					<div class="form-group">
						<label class="form-label" for="currentPassword">현재 비밀번호</label> <input
							type="password" id="currentPassword" name="currentPassword"
							class="form-input-box" placeholder="현재 비밀번호를 입력하세요"> <input
							type="hidden" name="existingPassword" value="${userDTO.password}">
					</div>

					<div class="form-group">
						<label class="form-label" for="newPassword">새 비밀번호</label> <input
							type="password" id="newPassword" name="newPassword"
							class="form-input-box" placeholder="새 비밀번호를 입력하세요">
					</div>

					<div class="form-group">
						<label class="form-label" for="confirmPassword">새 비밀번호 확인</label>
						<input type="password" id="confirmPassword" name="confirmPassword"
							class="form-input-box" placeholder="새 비밀번호를 다시 입력하세요">
					</div>

					<div class="button-area">
						<button type="button" class="action-btn cancel-btn"
							onclick="history.back()">취소</button>
						<button type="submit" class="action-btn save-btn">저장</button>
					</div>
				</form>
			</div>
		</div>
	</main>

	<script>
		function checkEmailFormat(input) {
			const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;

			if (input.value.trim() !== "" && !emailPattern.test(input.value)) {
				alert("이메일 형식이 올바르지 않습니다.");
			}
		}

		function autoFormatPhone(input) {
			let value = input.value.replace(/[^0-9]/g, '');
			let formattedValue = '';

			if (value.length > 3 && value.length <= 7) {
				formattedValue = value.substring(0, 3) + '-'
						+ value.substring(3);
			} else if (value.length > 7) {
				formattedValue = value.substring(0, 3) + '-'
						+ value.substring(3, 7) + '-' + value.substring(7, 11);
			} else {
				formattedValue = value;
			}

			input.value = formattedValue;

			checkPhoneValidity(input);
		}

		function checkPhoneValidity(input) {
			const parentGroup = document.getElementById('phone-group');
			const pattern = new RegExp(input.pattern);

			if (input.value.trim() === "" || pattern.test(input.value)) {
				parentGroup.classList.remove('has-error');
				input.classList.remove('error');
			} else {
				parentGroup.classList.add('has-error');
				input.classList.add('error');
			}
		}

		function validateForm(event) {
			const phoneInput = document.getElementById('phone');

			checkPhoneValidity(phoneInput);

			if (!phoneInput.checkValidity()) {
				event.preventDefault();
				alert("필수 정보를 올바르게 입력해 주세요.");
				return false;
			}

			return true;
		}

		document.addEventListener('DOMContentLoaded', function() {
			const phoneInput = document.getElementById('phone');
		});
	</script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
