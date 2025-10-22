<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.cdnfonts.com/css/peristiwa" rel="stylesheet">
<link href="https://fonts.google.com/specimen/Montserrat"
	rel="stylesheet">
<link rel="stylesheet" href="/webapp/resources/css/noticeList.css">

<style>
/* ==== 기본 스타일 ==== */
body {
	font-family: 'Montserrat', sans-serif;
	margin: 0;
	padding: 0;
	background-color: #E5E2DB;
	color: #222;
	line-height: 1.6;
}

.container {
	max-width: 1200px;
	margin: 0 auto;
	padding: 20px;
}

a {
	text-decoration: none;
	color: inherit;
}

/* ==== 페이지 타이틀 ==== */
.page-title {
	text-align: center;
	font-size: 30px;
	font-weight: bold;
	margin: 80px 0 40px 0;
	position: relative;
	padding-bottom: 10px;
}

/* ==== 검색창 ==== */
.search-bar {
	display: flex;
	justify-content: center;
	max-width: 888px;
	margin: 50px auto;
	gap: 20px;
}

.search-bar input[type="text"] {
	width: 708px;
	height: 60px;
	background-color: #CBD4C2;
	border: 1px solid #222;
	border-radius: 15px;
	font-size: 18px;
	outline: none;
	margin-right: 43px;
	padding-left: 14px;
}

.search-bar button {
	width: 112px;
	height: 60px;
	background-color: #CBD4C2;
	border: 1px solid #222;
	border-radius: 15px;
	font-size: 18px;
	font-weight: bold;
	cursor: pointer;
}

/* ==== Q&A 헤더 ==== */
.qna-header-wrapper {
	max-width: 888px;
	margin: 0 auto;
	font-weight: bold;
	font-size: 14px;
}

.qna-header {
	display: flex;
	justify-content: space-between;
	border-bottom: 1px solid #AFAFAF;
	padding-bottom: 10px;
}

.qna-header div:nth-child(1) {
	width: 50%;
	padding-left: 20px;
}

.qna-header div:nth-child(2) {
	width: 15%;
	text-align: center;
}

qna-header div:nth-child(3) {
	width: 15%;
	text-align: center;
}

.qna-header div:nth-child(4) {
	width: 10%;
	text-align: center;
}

/* ==== Q&A 리스트 ==== */
.qna-list-container {
	max-width: 888px;
	margin: 0 auto;
	background-color: #FAF9F6;
}

.qna-item {
	border-bottom: 1px solid #E5E5E5;
}

.qna-summary {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 12px 0;
	cursor: pointer;
}

.qna-summary:hover {
	background-color: #F8F8F8;
}

.qna-col {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.qna-col.title {
	width: 50%;
	padding-left: 20px;
	display: flex;
}

.title-icon {
	width: 20px;
	height: 20px;
	border-radius: 50%;
	padding: 4px;
	text-align: center;
	color: white;
	background-color: #b2c3b3;
	margin-right: 10px;
}

.qna-col.writer {
	width: 15%;
	text-align: center;
}

.qna-col.date {
	width: 15%;
	text-align: center;
}

.qna-col.status {
	width: 10%;
	text-align: center;
	font-weight: bold;
}

.status-waiting {
	color: #888888;
}

.status-complete {
	color: #0088ff;
}

/* detail content */
.qna-content {
	padding: 20px 40px;
	background-color: #FDFDFD;
	border-top: 1px dashed #DDD;
}

.pagination {
	display: flex;
	justify-content: center;
	gap: 15px;
	align-items: center;
	color: #888888;
	font-size: 18px;
	transition: 0.2s;
}

.pagination li {
	display: inline-block;
}

.pagination li a {
	padding: 5px 10px;
	font-size: 18px;
	color: #999;
	display: block;
	transition: color 0.2s;
}

.pagination li.active a {
	font-weight: bold;
	color: #222;
}
f
</style>
</head>

<body>
	<header>
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
	</header>

	<div class="container">
		<div class="page-title">
			<a href="/qna">Q&A</a>
		</div>

		<!-- 검색 영역 -->
		<div class="search-bar">
			<form action="/qna" method="get">
				<input type="hidden" name="searchType" value="title"> <input
					type="text" name="keyword" placeholder="제목 검색">
				<button type="submit">검색🔍️</button>
			</form>
		</div>
	</div>

	<!-- 헤더 -->
	<div class="qna-header-wrapper">
		<div class="qna-header">
			<div>제목</div>
			<div>작성자</div>
			<div>등록일자</div>
			<div>상태</div>
		</div>
	</div>

	<!-- Q&A 리스트 -->
	<div class="qna-list-container">
		<c:if test="${not empty postList  }">


			<c:forEach var="postDTO" items="${postList}">
				<c:if
					test="${postDTO.visibility eq 'PUBLIC' and postDTO.category eq 'QNA'}">
					<details class="qna-item">
						<summary class="qna-summary">
							<div class="qna-col title">
								<div class="title-icon">Q</div>
								<strong>${postDTO.title}</strong>
							</div>
							<div class="qna-col writer">${postDTO.userId}</div>
							<div class="qna-col date">
								<fmt:formatDate value="${postDTO.createdAt}"
									pattern="yyyy-MM-dd" />
							</div>
							<div class="qna-col status">
								<c:choose>
									<c:when test="${postDTO.commentCount > 0}">
										<span class="status-complete">답변완료</span>
									</c:when>
									<c:otherwise>
										<span class="status-waiting">답변대기</span>
									</c:otherwise>
								</c:choose>
							</div>
						</summary>
						<div class="qna-content">
							<strong>문의 내용:</strong>
							<p>${postDTO.title}</p>

							<c:if test="${postDTO.commentCount > 0}">
								<br>
								<strong>[답변]</strong>
								<br>
								<p>${postDTO.commentContent}</p>
							</c:if>
						</div>
					</details>
				</c:if>
			</c:forEach>
		</c:if>
		<c:if test="${ empty postList && not empty keyword }">
			<div class="qna-summary">검색결과가 없습니다.</div>
		</c:if>
	</div>
	<%-- Paging --%>
	<div class="text-center">
		<ul class="pagination">
			<c:if test="${pageVO.prev }">
				<li><a
					href="/qna?page=1&searchType=${searchType }&keyword=${keyword }">&laquo;&laquo;</a></li>
				<li><a
					href="/qna?page=${pageVO.startPage-1}&searchType=${searchType }&keyword=${keyword }">&laquo;</a></li>
			</c:if>
			<c:forEach begin="${pageVO.startPage }" end="${pageVO.endPage }"
				var="idx">
				<li
					class=<c:out value="${pageVO.cri.page==idx? 'active':''}"></c:out>>
					<a
					href="/qna?page=${idx }&searchType=${searchType }&keyword=${keyword }">${idx }</a>
				</li>
			</c:forEach>
			<c:if test="${pageVO.next && pageVO.endPage > 0 }">
				<li><a
					href="/qna?page=${pageVO.endPage+1 }&searchType=${searchType }&keyword=${keyword }">&raquo;</a></li>
				<li><a
					href="/qna?page=${lastPage}&searchType=${searchType }&keyword=${keyword }">&raquo;&raquo;</a></li>
			</c:if>
		</ul>
	</div>

	<footer>
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</footer>
</body>
</html>
