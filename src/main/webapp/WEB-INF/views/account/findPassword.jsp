<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap"
	rel="stylesheet" />
<title>findPassword</title>
<link rel="stylesheet" type="text/css"
	href="/resources/css/findPassword.css">
<style type="text/css">
/* 기본 스타일 */
.tab-radio-group {
	display: flex;
}

.tab-btn {
	padding: 10px 20px;
	cursor: pointer;
	border: 1px solid #ccc;
	background-color: #CBD4C2;
	margin-right: 2px;
	border-radius: 10px 10px 0 0;
	transition: background-color 0.3s;
	user-select: none;
	background-color: #CBD4C2;
}

.tab-btn:hover {
	background-color: #e0e0e0;
}

/* 라디오 숨기기 */
input[type="radio"] {
	display: none;
}

/* 체크된 라벨 강조 */
input[type="radio"]:checked+label {
	background-color: #FAF9F6;
	font-weight: bold;
	border-bottom: none;
}

/* 클릭 막기 */
.tab-radio-group.readonly label {
	pointer-events: none;
}

.box {
	background-color: #FAF9F6;
	border-radius: 0 0 20px 20px;
	width: 620px;
	height: 300px;
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	gap: 15px;
	border: 1px solid #ccc;
	border-top: none;
}

.container {
	display: flex;
	justify-content: center;
	margin-top: 50px;
}
</style>
</head>
<body>
	<script>
		const result = '${empty result ? "" : result}';
		const msg = '${empty msg ? "" : msg}';
		if (result === 'success') {
			alert(`${msg}`);
		} else if (result === 'fail') {
			alert(`${msg}`);
			window.location.href = "/find-password";
		}
		const findUserName = '${empty findUserName ? "" : findUserName}'
		if (findUserName !== "") {
			alert("고객님의 아이디는 " + findUserName + "입니다.");
			window.location.href = "/login";
		}
		function checkCode(e) {
			const codeCheck = document.querySelector('input[name="codeCheck"]').value
					.trim();
			const code = document.querySelector('input[name="code"]').value
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
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<main>
		<div class="container">

			<!-- 이메일 입력 단계 -->
			<c:if test="${empty email }">
				<form action="/find-password" method="get">
					<div class="tab-radio-group">
						<input type="radio" id="tab-findId" name="findType" value="findId"
							checked hidden> <label for="tab-findId" class="tab-btn">아이디
							찾기</label> <input type="radio" id="tab-findPass" name="findType"
							value="findPass" hidden> <label for="tab-findPass"
							class="tab-btn">비밀번호 찾기</label>
					</div>

					<div class="box">
						<label for="email">이메일</label> <input type="text" name="email"
							placeholder="이메일을 입력해 주세요." required>
						<div>
							<button style="height: 45px;" type="submit">인증번호 전송</button>
							<button type="button" onclick="history.back()">취소</button>
						</div>
					</div>
				</form>
			</c:if>

			<!-- 인증번호 입력 단계 -->
			<c:if test="${not empty email}">
				<form action="/find-password" method="post"
					onsubmit="return checkCode(event)">
					<div class="tab-radio-group readonly">
						<c:if test="${findType eq 'findId' }">
							<input type="radio" id="tab-findId" name="findType"
								value="findId" checked hidden>
							<label for="tab-findId" class="tab-btn">아이디 찾기</label>
							<input type="radio" id="tab-findPass" name="findType"
								value="findPass" hidden>
							<label for="tab-findPass" class="tab-btn">비밀번호 찾기</label>
						</c:if>
						<c:if test="${findType eq 'findPass' }">
							<input type="radio" id="tab-findId" name="findType"
								value="findId" hidden>
							<label for="tab-findId" class="tab-btn">아이디 찾기</label>
							<input type="radio" id="tab-findPass" name="findType"
								value="findPass" checked hidden>
							<label for="tab-findPass" class="tab-btn">비밀번호 찾기</label>
						</c:if>
					</div>

					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" /> <input type="hidden" name="email"
						value="${email }">

					<div class="box">
						<label for="code">인증번호</label> <input type="hidden"
							name="codeCheck" value="${code }"> <input type="text"
							name="code" placeholder="인증번호를 입력해 주세요." required>
						<div>
							<button type="submit">확인</button>
							<button type="button" onclick="history.back()">취소</button>
						</div>
					</div>
				</form>
			</c:if>

		</div>
	</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
</body>
</html>
