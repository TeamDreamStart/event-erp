<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이메일 인증번호 테스트</title>
</head>
<body>

	<script type="text/javascript">
	 const result = '${empty result ? "" : result}';
	const msg = '${empty msg ? "" : msg}';
    if (result === 'success') {
        alert(`${msg}`);
    } else if (result === 'fail') {
        alert(`${msg}`);
        window.location.href = "/email-test";
    }
		function checkCode(e) {
			const codeCheck = document.querySelector('input[name="codeCheck"]').value
					.trim();
			const code = document.querySelector('input[name="verificationCode"]').value
					.trim();

			if (code === "") {
				alert("인증번호를 입력해주세요.");
				e.preventDefault();
				return false;
			}

			if (code !== codeCheck) {
				alert("인증번호가 일치하지 않습니다.");
				e.preventDefault();
				return false;
			}

			return true;
		}
	</script>

		<h1>이메일 인증</h1>
		<!-- 이메일 입력 단계 -->
		<c:if test="${empty email }">
			<form action="/email-test" method="get">
				<input type="text" name="email" placeholder="이메일을 입력해 주세요." required>
				<button type="submit">인증번호 전송</button>
			</form>
		</c:if>
		<!-- 인증번호 입력 단계 -->
		<c:if test="${not empty email}">
			<form action="/email-test" method="post"
				onsubmit="return checkCode(event)">
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" /> <input type="hidden" name="email"
					value="${email }"> <label>인증번호</label> <input type="hidden"
					name="codeCheck" value="${code }"> <input type="text"
					name="code" placeholder="인증번호를 입력해 주세요." required>
				<button type="submit">확인</button>
			</form>
		</c:if>

</body>
</html>
