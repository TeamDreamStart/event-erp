<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://www.dafont.com/peristiwa.font" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700;900&display=swap" rel="stylesheet"/>
	<link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/common.css'/>">

<style>
/*==================================
  1. 기본 레이아웃 및 폰트 설정 (Main Container: 888px 고정)
==================================*/
body {
 background: #E5E2DB;
}
.notice-section{
  margin: 0 auto;
}
.notice-header h3{
    font-size: 14px;
    font-weight: 700;
    margin-bottom: 28px;
}
.page-title {
 text-align: center;
 font-size: 30px;
 font-weight: bold;
 margin: 0px 0 89px 0;
 position: relative;
 padding-bottom: 10px;
}
.notice-content{
    margin: 0 auto;
  max-width: 888px;
    background-color: #FAF9F6;
  padding: 29px 24px;
  min-height: 555px;
  border-top: 1px solid #222222;
  font-size: 14px;
}
    .notice-meta {
  font-size: 14px;
  color: #888;
  text-align: right;
  padding: 28px 0;
  color: #AFAFAF;
  border-top: 1px solid #AFAFAF;
  border-bottom: 1px solid #AFAFAF;
}
.notice-meta span:first-child {
  margin-right: 15px;
}
.notice-main-detail{
    margin-top: 29px;
}
.back-button-container{
    text-align: right;
    margin: 0 auto;
    max-width: 888px;
}
.back-button {
    margin-top: 32px;
    margin-bottom: 140px;
  padding: 8px 39px;
  background-color: #FAF9F6; /* 흰색에 가까운 배경색 */
  border: 1px solid #222222; /* 얇은 회색 테두리 */
  border-radius: 12px;
  font-size: 14px;
  color: #222;
  cursor: pointer;
}
.back-button:hover {
  background-color: #d9d9d9;
}

</style>

<title>noticedetail</title>
</head>

<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />


	<main>
		<section class="notice-section">
			<h1 class="page-title">Notice</h1>
            <div class="notice-content">
			<div class="notice-header">
				<h3>${postDTO.title }</h3>
				<div class="notice-meta">
					<span>등록일자: ${postDTO.createdAt }</span> | <span>조회:
						${postDTO.viewCount }</span>
                    </div>
                </div>
                <div class="notice-main-detail">
				<c:if test="${not empty fileList }">
					<c:forEach var="fileDTO" items="${fileList}">
						<img style="width: 100%"
							src="${pageContext.request.contextPath}/resources/uploadTemp/${fileDTO.storedPath}/${fileDTO.uuid}_${fileDTO.originalName}"
							alt="${fileDTO.originalName}">
					</c:forEach>
					<br>
				</c:if>

                <!--노티스 주요 내용-->
				<c:if test="${empty fileList }">
					<span>* 첨부된 사진이 없습니다.</span>
					<br>
				</c:if>
				${fn:trim(postDTO.content)}
			</div>
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