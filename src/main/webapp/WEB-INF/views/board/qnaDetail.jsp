<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <link href="https://fonts.cdnfonts.com/css/peristiwa" rel="stylesheet">
    <link rel="stylesheet" href="qnaDetail.css">

<style>
/*==================================
  1. 기본 레이아웃 및 폰트 설정
==================================*/
body {
    /* 기본 폰트와 배경색 설정 */
    font-family: 'Montserrat'; 
    color: #222; 
    margin: 0;
    padding: 0;
    background-color:#E5E2DB;
}

main {
    /* 메인 콘텐츠 중앙 정렬 및 최대 너비 설정 */
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
}

/*==================================
  2. Q&A 폼 (Form) 스타일
==================================*/
.page-title {
    text-align: center;
    font-size: 30px;
    font-weight: bold;
    margin-bottom: 50px;
    letter-spacing: 2px;
}

.qna-from {
    max-width: 600px;
    margin: 0 auto;
    padding: 20px 0;
}

.guide-text {
    text-align: center;
    font-size: 14px;
    color: #222;
    border: 1px solid #ccc; /* --light-border-color 대체 */
    padding: 10px;
    border-radius: 5px;
    margin-bottom: 30px;
}

.form-group {
    display: flex;
    margin-bottom: 15px;
    border: 1px solid #ccc; /* --light-border-color 대체 */
}

.form-label {
    width: 80px;
    background-color: #f7f7f7;
    padding: 15px 10px;
    text-align: center;
    border-right: 1px solid #ccc; /* --light-border-color 대체 */
    box-sizing: border-box;
    font-size: 15px;
}

.form-group input,
.form-group textarea {
    flex-grow: 1;
    border: none;
    padding: 15px 20px;
    font-size: 16px;
    box-sizing: border-box;
    resize: none;
    outline: none;
}

.content-area {
    margin-bottom: 30px;
}

.content-area textarea {
    height: 150px;
}

/* 버튼 그룹 스타일 */
.button-group {
    text-align: center;
    margin-top: 20px;
}

.button-group button {
    padding: 10px 25px;
    margin: 0 5px;
    border: 1px solid #ccc; /* 버튼 테두리 */
    cursor: pointer;
    font-size: 14px;
}

.btn-cancel {
    background-color: #F2F0EF;
    border: 1px solid #AFAFAF;
    color: #222;
}

.btn-submit {
     background-color: #BFD4F9;
    border: 1px solid #8FAFED;
    color: #222;
}

.btn-list {
    background-color: #F8F8F8;
    border-color: #AFAFAF;
    color: #222;
}

</style>

<title>qnadetail</title>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	</header>

	<div class="qna-form-container">
		<h1>질문 상세보기</h1>

		<div class="detail-group">
			<label>작성자</label>
			<div class="detail-content">
				${postDTO.userId }
			</div>
		</div>

		<div class="detail-group">
			<label>제목</label>
			<div class="detail-content">
				${postDTO.title}
			</div>
		</div>

		<div class="detail-group">
			<label>질문 내용</label>
			<div class="detail-content textarea">
				${postDTO.content}
			</div>
		</div>

		<div class="detail-group">
			<label>작성일</label>
			<div class="detail-content">
				${postDTO.createdAt}
			</div>
		</div>
		<div class="detail-group">
			<label>답변</label>
			<c:forEach var="commentDTO" items="${commentList }">
				<div class="detail-content">
				${commentDTO.content }
				</div>
			</c:forEach>
		</div>

	</div>
	<button onclick="location.href='/qna'" type="button">목록</button>

	<footer>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    </footer>
	
</body>
</html>
