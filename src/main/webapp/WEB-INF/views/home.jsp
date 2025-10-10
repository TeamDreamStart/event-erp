<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Home</title>
<style>
.header-top {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 10px 16px;
	border-bottom: 1px solid #eee
}

.user-actions {
	display: flex;
	gap: 10px;
	align-items: center
}

.btn {
	appearance: none;
	border: 1px solid #222;
	background: #fff;
	cursor: pointer;
	padding: 6px 12px;
	text-decoration: none;
	display: inline-flex;
	align-items: center
}

.btn-primary {
	background: #e9efe6;
	border-color: #a5b49c
}
</style>
</head>
<body>
	<header class="header">
		<div class="header-top">
			<a href="<c:url value='/'/>">D</a>

			<div class="user-actions">
				<!-- 로그인 상태 -->
				<sec:authorize access="isAuthenticated()">
					<span> <strong><sec:authentication
								property="principal.username" /></strong> 님 환영합니다 👋
					</span>
					<a class="btn" href="<c:url value='/myinfo'/>">my info</a>
					<!-- 로그아웃은 POST + CSRF -->
					<form method="post" action="<c:url value='/logout'/>"
						style="margin: 0">
						<sec:csrfInput />
						<button type="submit" class="btn btn-primary">logout</button>
					</form>
				</sec:authorize>

				<!-- 비로그인 상태 -->
				<!-- security사용해야해서 input -> sec -->
				<sec:authorize access="isAnonymous()">
					<a class="btn btn-primary" href="<c:url value='/login'/>">login</a>
					<a class="btn" href="<c:url value='/join'/>">join</a>
				</sec:authorize>
			</div>
		</div>
	</header>

	<article>
		<h1>Hello world!</h1>
		<p>The time on the server is ${serverTime}.</p>
		<!-- 나머지 컨텐츠 그대로 유지 -->
		<a href="/list-test">회원목록 테스트</a> <a href="/board-test">게시판 테스트</a>
		<a href="/admin">어드민페이지</a>
		<a href="/admin/surveys">어드민용 설문조사 리스트</a>
	</article>
</body>
</html>
