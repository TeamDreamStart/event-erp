<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.security.SecureRandom"%>
<%@ page import="java.math.BigInteger"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Login</title>
<style>
.page-wrap {
	max-width: 960px;
	margin: 0 auto;
	padding: 40px 20px;
}

.title {
	font-size: 28px;
	font-weight: 800;
	margin: 20px 0 24px;
}

.login-card {
	width: 520px;
	max-width: 100%;
	margin: 0 auto;
	border: 1px solid #cfcfcf;
	border-radius: 2px;
	background: #f9f9f7;
	padding: 28px 24px;
}

.form-row {
	margin-bottom: 16px;
}

.label {
	display: block;
	font-size: 14px;
	margin-bottom: 6px;
	color: #222;
}

.input {
	width: 100%;
	height: 36px;
	padding: 0 10px;
	border: 1px solid #c9c9c9;
	background: #fff;
}

.actions {
	display: flex;
	gap: 12px;
	margin-top: 10px;
}

.btn {
	appearance: none;
	border: 1px solid #222;
	background: #fff;
	cursor: pointer;
	padding: 8px 18px;
	height: 36px;
	line-height: 18px;
	text-decoration: none;
	display: inline-flex;
	align-items: center;
}

.btn-primary {
	background: #e9efe6;
	border-color: #a5b49c;
}

.sub-links {
	text-align: right;
	margin-top: 8px;
	font-size: 12px;
	color: #444;
}

.alert {
	margin: 0 auto 16px;
	width: 520px;
	max-width: 100%;
	padding: 10px 12px;
	border: 1px solid;
}

.alert-error {
	border-color: #cc6666;
	background: #fff2f2;
	color: #8a2f2f;
}

.alert-info {
	border-color: #6a8fbf;
	background: #f2f7ff;
	color: #2d4e7b;
}
</style>
</head>
<body>
	<div class="page-wrap">
		<h1 class="title">로그인</h1>

		<!-- 실패/로그아웃 안내 (쿼리파라미터 기반) -->
		<c:if test="${param.error == 'disabled'}">
			<div class="alert alert-error">비활성(또는 휴면) 계정입니다. 관리자에게 문의하세요.</div>
		</c:if>
		<c:if test="${param.error != null && param.error != 'disabled'}">
			<div class="alert alert-error">아이디 또는 비밀번호를 확인해 주세요.</div>
		</c:if>
		<c:if test="${param.logout != null}">
			<div class="alert alert-info">로그아웃 되었습니다.</div>
		</c:if>

		<!-- ★ action=/login, POST, CSRF 필수 -->
		<form class="login-card" method="post"
			action="<c:url value='/login'/>">
			<sec:csrfInput />

			<div class="form-row">
				<label class="label" for="username">아이디</label>
				<!-- 로그인시 아이디, 이메일 둘다 가능하게 하기 위해 login으로 통일 -->
				<input class="input" type="text" id="login" name="login"
					placeholder="아이디(또는 이메일)" required autofocus>
			</div>

			<div class="form-row">
				<label class="label" for="password">비밀번호</label> <input
					class="input" type="password" id="password" name="password"
					placeholder="비밀번호" required>
			</div>

			<div class="actions">
				<button type="submit" class="btn btn-primary">로그인</button>
				<a class="btn" href="<c:url value='/join'/>">회원가입</a>
			</div>

			<div class="sub-links">
				<a href="<c:url value='/find-password'/>">아이디 · 비밀번호 찾기</a>
			</div>
		</form>
	</div>

	<div>
		<a href="${location }
	"><img style="height: 20px" alt="카카오로그인버튼"
			src="../resources/img/kakao.png"></a>
	</div>

	<%
	String clientId = "9CN0AyXIHmflebLIalgz";//애플리케이션 클라이언트 아이디값";
	String redirectURI = URLEncoder.encode("http://localhost:8080/login/naver/callback", "UTF-8");
	SecureRandom random = new SecureRandom();
	String state = new BigInteger(130, random).toString();
	String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
	apiURL += "&client_id=" + clientId;
	apiURL += "&redirect_uri=" + redirectURI;
	apiURL += "&state=" + state;
	session.setAttribute("state", state);
	%>
	<a href="<%=apiURL%>"><img height="50"
		src="http://static.nid.naver.com/oauth/small_g_in.PNG" /></a>
</body>
</html>
