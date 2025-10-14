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
<script type="text/javascript">
	function checkCode(e) {
		const codeCheck = document.querySelector('input[name="codeCheck"]').value.trim();
		const code = document.querySelector('input[name="code"]').value.trim();

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

		// 일치할 경우 정상 제출
		return true;
	}
</script>

	<header> </header>

	<nav></nav>

	<article>
		<h1>Hello world!</h1>
	<!-- 아이디찾기 -->
	<!--아이디 찾기 - 이메일 전송 후 이메일 값, 아이디값 가지고 다시 돌아옴-->
	<h1>아이디찾기</h1>
	<form action="/email-test" method="get">
	<label>이메일</label>
	<input type="hidden" name="findType" value="findId">
<!-- 	<input type="hidden" name="findType" value="findPassword"> -->
		<input type="text" name="email" value="${email }" placeholder="이메일을 입력해 주세요." required>
		<button type="submit"> 인증번호 전송</button>
	</form>
	<form action="/email-test" method="post" onsubmit="return checkCode(event)">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" name="email" value="${email }">
		<label>인증번호</label>
		<!-- 코드 확인용 -->
		<input type="hidden" name="codeCheck" value="${code }" disabled="disabled">
		<input type="text" name="code" placeholder="인증번호를 입력해 주세요." required>
		<button type="submit"> 확인</button>
	</form>
	
	</article>

	<footer> </footer>
</body>
</html>