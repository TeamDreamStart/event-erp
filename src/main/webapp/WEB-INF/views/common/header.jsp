<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>header</title>
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap"
	rel="stylesheet">
<style>
@font-face {
	font-family: 'Peristiwa';
	src: url('<c:url value="/resources/font/Peristiwa.otf"/>' )
		format('opentype');
	font-display: swap;
}

.header {
	background: transparent;
}

.header .container {
	display: flex;
	flex-direction: column;
	padding: 20px 0 0;
}

.header-top {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
	gap: 24px;
}

.logo-link {
	text-decoration: none;
	color: inherit;
	display: block;
	line-height: 1;
}

.logo {
	font-family: 'Peristiwa', cursive;
	font-size: 40px;
	line-height: 70px;
}

.user-actions {
	margin: 12px 0px 16px;
	display: flex;
	align-items: center;
	gap: 16px;
	white-space: nowrap;
	font-size: 20px; line-height: 42px;
}

.mypage-link, .btn-login {
	text-decoration: none;
	border: 0;
	cursor: pointer;
	padding: 8px 16px;
	width: 128px;
	height: 42px;
	display: inline-flex;
	justify-content: center;
	align-items: center;
	font-family: 'Montserrat', system-ui, -apple-system, Segoe UI, Roboto,
		sans-serif;
}

.mypage-link {
	background: #fff;
	color: #595959;
}

.mypage-link:hover {
	background: #e0e0e0;
}

.btn-login {
	background: #222;
	color: #E5E2DB;
	font-size: 20px;
	line-height: 42px;
}

.btn-login:hover {
	background: #555;
}

.header-hr {
	width: 100%;
	height: 1px;
	margin-bottom: 62px;
	background-color: #222;
}
</style>
</head>
<body>
	<header class="header" role="banner">
		<div class="container">
			<div class="header-top">
				<a href="<c:url value='/'/>" class="logo-link"
					aria-label="DreamStart 홈"> <span class="logo">D</span>
				</a>

				<div class="user-actions">
					<sec:authorize access="isAuthenticated()">
						<span><strong><sec:authentication
									property="principal.name" /></strong> 님 환영합니다 👋</span>
						<a href="<c:url value='/myinfo'/>" class="mypage-link">mypage</a>
						<form method="post" action="<c:url value='/logout'/>"
							style="display: inline; margin: 0;">
							<sec:csrfInput />
							<button type="submit" class="btn-login">logout</button>
						</form>
					</sec:authorize>
					<sec:authorize access="isAnonymous()">
						<a href="<c:url value='/myinfo'/>" class="mypage-link"
							style="display: none;">mypage</a>
						<a
							href="<c:url value='/login'><c:param name='mode' value='member'/></c:url>"
							class="btn-login">login</a>
					</sec:authorize>
				</div>
			</div>

			<jsp:include page="/WEB-INF/views/common/nav.jsp" />
			<hr class="header-hr" aria-hidden="true">
		</div>
	</header>
</body>
</html>
