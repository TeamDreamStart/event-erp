<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://bootswatch.com/3/paper/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>

	<header> </header>

	<nav></nav>

	<article>

		<h1>공지사항 상세보기</h1>
		<div class="container">
			<!-- 게시글 제목 -->
			<h3 class="page-header">${boardDTO.title }</h3>

			<table class="table table-bordered">
				<tr>
					<th style="width: 100px;">작성자</th>
					<td>${boardDTO.userId}</td>
					<th style="width: 100px;">작성일</th>
					<td>${boardDTO.createdAt}</td>
				</tr>
				<tr>
					<th>조회수</th>
					<td colspan="3">${boardDTO.viewCount}</td>
				</tr>
			</table>

			<!-- 게시글 내용 -->
			<div class="well">
				<p style="white-space: pre-wrap;">${boardDTO.content}</p>
			</div>

			<!-- 이전글/다음글 -->
			<table class="table table-bordered">
				<tr>
					<th style="width: 80px;">이전글</th>
					<td><c:if test="${not empty prevDTO}">
							<a
								href="${pageContext.request.contextPath}/board-test/${prevDTO.postId}">
								${prevDTO.title} </a>
						</c:if></td>
				</tr>
				<tr>
					<th>다음글</th>
					<td><c:if test="${not empty nextDTO}">
							<a
								href="${pageContext.request.contextPath}/board-test/${nextDTO.postId}">
								${nextDTO.title} </a>
						</c:if></td>
				</tr>
			</table>

			<!-- 버튼 그룹 -->
			<div class="text-right">
				<a href="${pageContext.request.contextPath}/board-test"
					class="btn btn-default">목록</a> <a
					href="${pageContext.request.contextPath}/board-test/${boardDTO.postId}/update"
					class="btn btn-primary">수정</a> <a
					href="${pageContext.request.contextPath}/board-test/${boardDTO.postId}/delete"
					class="btn btn-danger" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
			</div>
			<!-- 미구현 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
			<!-- QNA 답변 ! -->
			<h4 class="page-header">댓글</h4>

			<!-- 댓글 입력 -->
			<form id="commentForm">
				<textarea id="commentContent" placeholder="댓글을 입력하세요."
					style="width: 100%"></textarea>
				<button type="submit" class="btn btn-default">작성</button>
			</form>

			<!-- 댓글 목록 -->
			<div id="commentListArea">
				<c:forEach var="commentDTO" items="${commentList}">
					<div class="well">
						<b>${commentDTO.userId}</b><br> ${commentDTO.content}<br>
						<small>${commentDTO.createdAt}</small>
					</div>
				</c:forEach>
			</div>
		</div>
	</article>

	<footer> </footer>
</body>
</html>