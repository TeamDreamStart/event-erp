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
				<h1>회원 목록</h1>
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
						<th>회원번호</th>
						<th>아이디</th>
						<th>성함</th>
						<th>이메일</th>
						<th>전화번호</th>
						<th>마지막 로그인</th>
						<th>계정생성일</th>
						<th>수정일</th>
						<th>활동여부</th>
					</tr>
				</thead>
				<tbody>
					<!-- 존재하지 않는 사원번호 검색시 또는 사원이 한명도 없을 때-->
					<c:choose>
						<c:when test="${empty userList}">
							<tr>
								<td class="text-center" colspan="9">사원정보를 찾을 수 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="userDTO" items="${userList}">
								<tr>
									<td>${userDTO.userId}</td>
									<td>${userDTO.userName}</td>
									<td>${userDTO.name}</td>
									<td>${userDTO.email}</td>
									<td>${userDTO.phone}</td>
									<td>${userDTO.lastLoginAt}</td>
									<td>${userDTO.createdAt}</td>
									<td>${userDTO.updatedAt}</td>
									<c:choose>
										<c:when test="${userDTO.isActive==1}">
											<td>활동중</td>
										</c:when>
										<c:otherwise>
											<td>휴면</td>
										</c:otherwise>
									</c:choose>
									<td><a class="btn btn-default" href="#"> 상세보기 </a></td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			
			
			<!-- paging -->
			<div class="text-center">
				<ul class="pagination">
					<c:if test="${pageVO.prev }">
						<li><a href="list-test?page=1">&laquo;&laquo;</a></li>
						<li><a href="list-test?page=${pageVO.startPage-1}">&laquo;</a></li>
					</c:if>
					<c:if test="${!empty userList || userList.size()!=1}">
						<c:forEach begin="${pageVO.startPage }" end="${pageVO.endPage }"
							var="idx">
							<li class=<c:out value="${pageVO.cri.page==idx? 'active':''}"/>>
								<a href="list-test?page=${idx }">${idx }</a>
							</li>
						</c:forEach>
					</c:if>
					<c:if test="${pageVO.next && pageVO.endPage > 0 }">
						<li><a href="list-test?page=${pageVO.endPage+1 }">&raquo;</a></li>
						<li><a href="list-test?page=${lastPage}">&raquo;&raquo;</a></li>
					</c:if>

				</ul>
			</div>
		</div>
		
		
		
		
		



	</article>

	<footer> </footer>
</body>
</html>