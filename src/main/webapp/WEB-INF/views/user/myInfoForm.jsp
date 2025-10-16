<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>내 정보 수정</title>
<style>
	body {
		font-family: Arial, sans-serif;
		margin: 30px;
	}
	h1 {
		margin-bottom: 20px;
	}
	.section {
		margin-top: 20px;
	}
	.label {
		display: inline-block;
		width: 120px;
		font-weight: bold;
	}
	.row {
		margin: 10px 0;
	}
	input, select {
		padding: 6px;
		width: 250px;
	}
	button {
		padding: 8px 15px;
		margin-top: 20px;
		cursor: pointer;
	}
	.btn-primary {
		background-color: #007bff;
		color: white;
		border: none;
	}
	.btn-secondary {
		background-color: #aaa;
		color: white;
		border: none;
		margin-left: 10px;
	}
	img {
		width: 40px;
		vertical-align: middle;
	}
</style>
</head>

<body>

	<header>
		<jsp:include page="/WEB-INF/views/common/header.jsp" flush="true" />
	</header>

	<h1>내 정보 수정</h1>

	<form action="/my-info/${userDTO.userId}/update" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

		<div class="section">
			<div class="row">
				<span class="label">회원번호</span>
				<input type="text" name="userId" value="${userDTO.userId}" disabled>
			</div>

			<c:if test="${not empty userDTO.snsId}">
				<div class="row">
					<span class="label">SNS 회원</span>
					<img alt="네이버 로그인 이미지" src="/resources/img/naver/btnG_아이콘사각.png">
				</div>
			</c:if>
			<c:if test="${empty userDTO.snsId}">
			<div class="row">
				<span class="label">아이디</span>
				<input type="text" name="username" value="${userDTO.username}" disabled>
			</div>
			</c:if>
			<div class="row">
				<span class="label">이메일</span>
				<input type="email" name="email" value="${userDTO.email}" disabled>
			</div>

			<div class="row">
				<span class="label">이름</span>
				<input type="text" name="name" value="${userDTO.name}">
			</div>

			<div class="row">
				<span class="label">전화번호</span>
				<input type="text" name="phone" value="${userDTO.phone}">
			</div>

			<div class="row">
				<span class="label">성별</span>
				<select name="gender">
					<option value="0" ${userDTO.gender == 0 ? 'selected' : ''}>여성</option>
					<option value="1" ${userDTO.gender == 1 ? 'selected' : ''}>남성</option>
				</select>
			</div>

			<div class="row">
				<span class="label">생년월일</span>
				<input type="date" name="birthDate" value="${userDTO.birthDate}">
			</div>

			<div class="row">
				<span class="label">가입일</span>
				<input type="text" value="${userDTO.createdAt}" disabled>
			</div>

			<div class="row">
				<button type="submit" class="btn-primary"
					onclick="return confirm('수정한 결과를 저장하시겠습니까?');">저장</button>
				<button type="button" class="btn-secondary"
					onclick="location.href='/my-info/${userDTO.userId}'">취소</button>
			</div>
		</div>
	</form>

	<footer>
		<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="true" />
	</footer>

</body>
</html>
