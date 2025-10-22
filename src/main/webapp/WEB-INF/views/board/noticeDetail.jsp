<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.cdnfonts.com/css/peristiwa" rel="stylesheet">
<link href="https://fonts.google.com/specimen/Montserrat"
	rel="stylesheet">
<link rel="stylesheet" href="/webapp/resources/css/noticeList.css">

<style>
/*==================================
  1. 기본 레이아웃 및 폰트 설정 (Main Container: 888px 고정)
==================================*/
body {
    /* 배경색 */
    background-color: #E5E2DB; 
    /* 폰트 및 기본 텍스트 색상 */
    font-family: 'Montserrat', sans-serif;
    color: #222; 
    margin: 0;
    /* 전체 페이지 중앙 정렬 및 최소 높이 설정 */
    display: flex;
    flex-direction: column;
    align-items: center;
    min-height: 100vh;
}

main {
    /* 메인 콘텐츠 래퍼: 888px로 고정 및 중앙 정렬 */
    width: 888px; /* 핵심 컨테이너 너비 */
    margin: 140px auto 80px auto; /* 상단/하단 여백 설정 */
    padding: 0; /* 내부 여백 제거 */
    background-color: transparent;
    flex-grow: 1; /* 남은 공간을 차지하여 푸터를 하단에 고정 */
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
    border: 1px solid #ccc; /* 안내 텍스트 박스 테두리 */
    padding: 10px;
    border-radius: 5px;
    margin-bottom: 30px;
}

.form-group {
    display: flex;
    margin-bottom: 15px;
    border: 1px solid #ccc; /* 입력 그룹 전체 테두리 */
}

.form-label {
    width: 80px;
    background-color: #f7f7f7;
    padding: 15px 10px;
    text-align: center;
    border-right: 1px solid #ccc; /* 라벨과 입력 필드 구분선 */
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
    height: 150px; /* 내용 입력 필드 높이 */
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
</style>

<title>noticedetail</title>
</head>

<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />


	<main>
		<section class="notice-section">
			<h2>Notice</h2>
			<div class="notice-header">
				<h3>${postDTO.title }</h3>
				<div class="notice-meta">
					<span>등록일자: ${postDTO.createdAt }</span> | <span>조회:
						${postDTO.viewCount }</span>
				</div>
			</div>
			<div class="notice-content">
				<c:if test="${not empty fileList }">
					<c:forEach var="fileDTO" items="${fileList}">
						<img style="width: 100%"
							src="${pageContext.request.contextPath}/resources/uploadTemp/${fileDTO.storedPath}/${fileDTO.uuid}_${fileDTO.originalName}"
							alt="${fileDTO.originalName}">
					</c:forEach>
					<br>
				</c:if>
				<c:if test="${empty fileList }">
					<span>* 첨부된 사진이 없습니다.</span>
					<br>
				</c:if>
				${postDTO.content }
			</div>
			<div class="back-button-container">
				<button class="back-button" onclick="location.href='/notices'">목록</button>
			</div>
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</footer>
</body>
</html> 