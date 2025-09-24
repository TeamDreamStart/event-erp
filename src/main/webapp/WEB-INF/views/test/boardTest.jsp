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
		<div class=container>
			<div class="page-header">
				<h1>공지사항</h1>
			</div>

			<!-- 		<div class="row">
			<div class="col-md-6 text-right">
				<form class="form-inline" action="empDetail" method="get">
					<div class="form-group">
						<input type="text" name="empno" class="form-control"
							placeholder="회원번호 입력">
					</div>
					<button type="submit" class="btn btn-primary">
						<span class="glyphicon glyphicon-search"></span> 검색
					</button>
				</form>
			</div>
		</div> -->

			<hr>
			<table class="table table-striped table-hover">
				<thead>
					<tr>
						<th>글 번호</th>
						<th>카테고리</th>
						<th>제목</th>
						<th>조회수</th>
						<th>생성일</th>
						<th>수정일</th>
						<th>댓글수</th>
					</tr>
				</thead>
				<tbody>
					<!-- 존재하지 않는 사원번호 검색시-->
					<c:choose>
						<c:when test="${empty boardList}">
							<tr>
								<td class="text-center" colspan="5">게시글이 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="boardDTO" items="${boardList}">
								<c:if test="${boardDTO.visibility eq 'PUBLIC'}">
									<tr>
										<td>${boardDTO.postId}</td>
										<td>${boardDTO.category}</td>
										<td>${boardDTO.title}</td>
										<td>${boardDTO.viewCount}</td>
										<td>${boardDTO.createdAt}</td>
										<td>${boardDTO.updatedAt}</td>
										<td>${boardDTO.commentCount}</td>
										<td><a class="btn btn-default"
											href="/board-test/${boardDTO.postId}"> 상세보기 </a></td>
									</tr>
								</c:if>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>


			<!-- paging -->
			<div class="text-center">
				<ul class="pagination">
					<c:if test="${pageVO.prev}">
						<li><a href="board-test?page=1">&laquo;&laquo;</a></li>
						<li><a href="board-test?page=${pageVO.startPage - 1}">&laquo;</a></li>
					</c:if>

					<c:forEach begin="${pageVO.startPage}" end="${pageVO.endPage}"
						var="idx">
						<li class="${pageVO.cri.page == idx ? 'active' : ''}"><a
							href="board-test?page=${idx}">${idx}</a></li>
					</c:forEach>

					<c:if test="${pageVO.next}">
						<li><a href="board-test?page=${pageVO.endPage + 1}">&raquo;</a></li>
						<li><a href="board-test?page=${pageVO.totalPage}">&raquo;&raquo;</a></li>
					</c:if>
				</ul>
			</div>


		</div>
	</article>

	<footer> </footer>
</body>
</html>