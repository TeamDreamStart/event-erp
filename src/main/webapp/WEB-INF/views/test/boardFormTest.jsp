<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글</title>
<link href="https://bootswatch.com/3/paper/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">

		<c:choose>
			<c:when test="${empty postDTO && formType ne 'insert'}">
				<div class="alert alert-danger" role="alert">존재하지 않는 게시글입니다.</div>
				<div class="text-right">
					<a href="${pageContext.request.contextPath}/board-test"
						class="btn btn-default">목록으로</a>
				</div>
			</c:when>

			<c:when test="${formType eq 'insert' or formType eq 'update'}">
				<h1>
					<c:if test="${formType eq 'insert'}">
						<c:if test="${category eq 'NOTICE'}">공지사항</c:if>
						<c:if test="${category eq 'QNA'}">Q&A</c:if> 작성</c:if>
					<c:if test="${formType eq 'update'}">
						<c:if test="${postDTO.category eq 'NOTICE'}">공지사항</c:if>
						<c:if test="${postDTO.category eq 'QNA'}">Q&A</c:if> 수정</c:if>
				</h1>

				<form method="post"
					action="<c:choose>
							<c:when test='${formType eq "insert"}'>${pageContext.request.contextPath}/board-test/form</c:when>
							<c:when test='${formType eq "update"}'>${pageContext.request.contextPath}/board-test/${postDTO.postId}/update</c:when>
						</c:choose>">
					<div class="form-group">
						<label>제목</label> <input type="text" name="title"
							class="form-control" value="${postDTO.title}">
					</div>
					<div class="form-group">
						<label>내용</label>
						<textarea name="content" class="form-control" rows="8">${postDTO.content}</textarea>
					</div>
					<%-- <div class="form-group">
					<label>카테고리</label>
					<select name="category" class="form-control">
						<option value="NOTICE" <c:if test="${postDTO.category eq 'NOTICE'}">selected</c:if>>공지사항</option>
						<option value="QNA" <c:if test="${postDTO.category eq 'QNA'}">selected</c:if>>Q&A</option>
					</select>
				</div> --%>
					<input type="hidden" name="category"
						value="<c:if test="${postDTO.category eq 'NOTICE'}">NOTICE</c:if>
							   <c:if test="${postDTO.category eq 'QNA'}">QNA</c:if>">
					<div class="text-right">
						<a href="${pageContext.request.contextPath}/board-test"
							class="btn btn-default">취소</a>
						<button type="submit" class="btn btn-primary">
							<c:if test="${formType eq 'insert'}">등록</c:if>
							<c:if test="${formType eq 'update'}">수정</c:if>
						</button>
					</div>
				</form>
			</c:when>
		</c:choose>



	</div>
</body>
</html>
