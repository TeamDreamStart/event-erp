<%-- 이전에 제공해 드린 공지사항 목록 전체 JSP 코드 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link href="https://www.dafont.com/peristiwa.font" rel="stylesheet"> 
		<link href="https://fonts.google.com/specimen/Montserrat" rel="stylesheet"> 
		<link rel="stylesheet" href="/webapp/resources/css/noticeList.css">

		<style>
.body{
    font-family: 'Montserrat';
    margin: 0;
    padding: 0;
    background-color: #E5E2DB;
    color: #222;
    line-height: 1.6;
}

.main-container{
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
    background-color: white;
}

a{
    text-decoration: none;
    color: inherit;
}

ul{
    list-style: none;
    padding: 0;
    margin: 0;
}

button{
    cursor: pointer;
    background: none;
    border: none;
    padding: 0;
    font-family: inherit;
    color: inherit;
}

.header{
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
    position: relative;
    border-bottom: 1px solid #222;
    background-color: white;
}

.header-top{
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    position: relative;/*자식 요소의 absoulute 기준점*/
    margin-bottom: 20px;
}

.logo-link{
    font-family: 'peristiwa';
    font-size: 64px;
    font-style: italic;
    color: #222;
    display: inline-block;
    margin-left: 20px;
}

.header-right{
    display: flex;
    gap: 0px;
    /*align-items: center;
    position: absolute;
    top: 15px;
    right: 20px;
    z-index: 10;*/
}

.user-actions{
    display: flex;
    align-items: center;
    gap: 0px; /*mypage와 login 사이 간격*/
    margin-top: 10px; /*help 영역과의 수직 위치 맞추기*/
}

/*mypage (얇은 텍스트)*/
.btn-mypage{
    font-size: 20px; /*글씨 크기 조정*/
    font-weight: 400; /*얇기*/
    padding: 8px 15px; /*login 박스와 높이 맞추기 위해 패딩 추가*/
    color: #222;
    background-color: #FFFFFF;
    border: 1px solid #FFFFFF;
    margin: 0;
    border-right: none;
}
.btn-login{
    font-size: 20px;
    font-weight: 400;
    color: #FFFFFF;
    background-color: #222;
    padding: 8px 15px;
    text-align: center;
    line-height: 1;
    margin: 0;
}

.user-actions a:last-child{
    /*font-weight: bold;*/
    border-left: 1px solid #222;
    padding-left: 15px;
}

.login-button{
    font-weight: bold;
}

.header-nav{
    display: flex;
    /*justify-content: flex-start;*/
    gap: 40px; 
    font-size: 30px;
    font-weight: 300;
    padding-left: 20px;
}

.header-nav a:hover{
    color: #FFFFFF;
}

.help-area{
    position: absolute;
    top: 140px;
    right: 20px;
    z-index: 5;
    text-align: right;
    width: auto;
    /*padding: 8px 15px; /*mypage와 login과 같은 높이 확보*/
}

.help-button{
    font-weight: 300;
    font-size: 30px;
    padding: 5px 0;
    width: auto;
    text-align: left;
}
.help-text {
    display: flex;
    flex-direction: row;
    position: absolute;
    top: 100%; /*help 버튼 바로 아래*/
    right: 0;
    z-index: 10;
    background-color: #FFFFFF;
    border: 1px solid #222;
    padding: 5px;
    box-shadow: 0 2px 5px rgda(0,0,0,0.1);
    margin-bottom: 5px;
    font-size: 14px;
    font-weight: bold;
    gap: 8px;

}
.help-search.hidden {
    display: none
}
.help-input {
    width: 100px;
    height: 20px;
    border: 1px solid #ccc;
    margin-bottom: 2px;
    padding: 2px 5px;
    font-size: 12px;
    box-sizing: border-box;
}

.help-input.small {
    width: 60px; /* Q&A 폭 좁게 */
}

/*메인 네비게이션(visit, event, reservation*/
.header-nav{
    display: flex;
    gap: 40px;
    font-size: 30px;
    font-weight: 300;
    padding-left: 20px;
}

.header-nav a{
    padding-bottom: 10px;
    transition: color 0.2s;
}

.header-nav a:hover{
    color: #0088ff;
}
/* 3. Main Content (Notice) 스타일 */
.main-content{
    padding-top: 80px;
}

.page-title {
    text-align: center;
    font-size: 30px;
    font-weight: bold;
    margin: 80px 0 40px 0;
    position: relative;
    padding-bottom: 10px;
}

/* 검색창 */
.search-bar {
    display: flex;
    justify-content: center;
    margin-bottom: 50px;
    border:none;  /*테두리 제거*/
    max-width: 450px;
    margin: 50px auto;
    gap: 10px;
}
.search-input {
    width: 300px;
    padding: 15px 20px;
    background-color:#CBD4C2;
    border: 1px solid #222;
    border-radius: 15px;
    flex-grow: 1;
    box-shadow: none;
    outline: none;
    font-size: 18px;
    color:#222 ;
    opacity: 1;
}
.search-btn {
    padding: 10px 20px;
    background-color: #CBD4C2;
    border: 1px solid #222;
    border-radius: 15px;
    font-size: 18px;
    outline: none;
}

/* 게시판 테이블 */
.notice-table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 40px;
    text-align: center;
}
.notice-table thead th {
    font-weight: bold;
    padding: 15px 0;
    /*border-top: 1px solid #222; /* 상단 굵은 선 */
    border-bottom: 1px solid #222; /* 하단 얇은 선 */
}
.notice-table tbody td {
    padding: 12px 0;
    border-bottom: 1px solid #AFAFAF;
    color: #222;
    font-size: 15px;
}
.notice-table tbody td:first-child{
    text-align: center;
    width: 5%;
    padding-left: 0px;
}

.notice-table tbody tr:hover {
    background-color: #FFFFFF;
    cursor: pointer;
}

/* 제목 셀은 왼쪽 정렬 */
.notice-table td:first-child {
    text-align: left;
    padding-left: 10px;
    /* 제목 링크가 td 전체를 덮도록 처리 (A 태그의 href에 내용을 넣지 않고 텍스트를 따로 추가해야 함) */
}
.notice-table td a {
    display: block; /* 링크가 셀 전체를 덮도록 */
}

/* 조회수와 등록일자는 폭을 좁게 */
.notice-table th:nth-child(2), .notice-table td:nth-child(2) {
    width: 15%; /* 등록일자 */
}
.notice-table th:nth-child(3), .notice-table td:nth-child(3) {
    width: 10%; /* 조회수 */
}

/* 페이지네이션 */
.pagination-container{
    text-align: center;
    margin-top: 40px;
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

.pagination li{
    display: inline-block;
}

.pagination li a{
    padding: 5px 10px;
    font-size: 18px;
    color: #999;
    display: block;
    transition: color 0.2s;
}

.pagination li.active a{
    font-weight: bold;
    color: #222;
}
.nav-arrow {
    font-size: 20px;
    color: #999;
}
.page-number {
    padding: 5px 10px;
    font-size: 16px;
    border: 1px solid transparent;
    transition: all 0.2s;
}
.page-number.active {
    font-weight: bold;
    border-bottom: 2px solid #333; /* 현재 페이지 강조 */
}

.pagination a:hover{
	color: #222; /* 텍스트를 검은색으로 변경 */
    background-color: transparent; /* 배경색 변경 없음 */
    cursor: pointer;
}

/* 4. Footer 영역 스타일 */
.footer {
    background-color: #CBD4C2; /* 연한 녹색 계열 배경 */
    color: #222;
    padding: 30px 0;
    margin-top: 80px;
    text-align: center;
}
.footer-content p {
    margin: 5px 0;
    font-size: 14px;
}
.footer-hr {
    display: none; /* 디자인에 hr이 없으므로 숨김 처리 */
}
.footer p:last-child {
    margin-top: 15px;
    font-weight: bold;
} 
		</style>

    <title>noticelist</title>
</head>
<body>
	<header class="header">
    <div class="header-top">
        <span class="header-left">
            <a href="/" class="logo-link"><span class="logo">D</span></a>
        </span>
        
                <span class="header-right">
            <div class="user-actions"> 
                <a href="#" class="btn-mypage">mypage</a> 
                <a href="#" class="btn-login">login</a> 
            </div>
        </span>
    </div> 
    
        <nav class="header-nav"> 
        <a href="#">Visit</a>
        <a href="#">Event</a>
        <a href="#">Reservation</a>
    </nav>
    
        <div class="help-area">
        <button class="help-button">Help</button>
        
                <div class="help-dropdown">
            <a href="#" class="help-item">Notice</a>
            <a href="#" class="help-item">Q&A</a>
        </div>
    </div>
</header>

	
    <main class="main-content">
        <h1 class="page-title">Notice</h1>
        
        <div class="search-bar">
            <input type="text" placeholder="제목/등록일자 검색" class="search-input">
            <button class="search-btn">검색</button>
        </div>

        <table class="notice-table">
            <thead>
                <tr>
                    <th>제목</th>
                    <th>등록일자</th>
                    <th>조회수</th>

                </tr>
            </thead>
            <tbody>
                 <c:choose>
                    <c:when test="${empty boardList}">
                        <tr>
                            <td class="text-center" colspan="6">게시글이 없습니다.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="boardDTO" items="${boardList}">
                            <c:if
                                test="${boardDTO.visibility eq 'PUBLIC' and boardDTO.category eq 'NOTICE'}">
                                <tr>
                                    <td>${boardDTO.postId}</td>
                                    <td>${boardDTO.category}</td>
                                    <td><a href="/notices/${boardDTO.postId}">${boardDTO.title}</a></td>
                                    <td>${boardDTO.viewCount}</td>
                                    <td>${boardDTO.createdAt}</td>
                                    <td><a class="btn btn-default"
                                         href="/notices/${boardDTO.postId}"> 상세보기 </a></td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

        <%-- Paging --%>
        <div class="text-center">
            <ul class="pagination">
                <c:if test="${pageVO.prev }">
                    <li><a href="/notices?page=1">&laquo;&laquo;</a></li>
                    <li><a href="/notices?page=${pageVO.startPage-1}">&laquo;</a></li>
                </c:if>
                <c:forEach begin="${pageVO.startPage }" end="${pageVO.endPage }" var="idx">
                    <li class=<c:out value="${pageVO.cri.page==idx? 'active':''}"></c:out>>
                        <a href="/notices?page=${idx }">${idx }</a>
                    </li>
                </c:forEach>
                <c:if test="${pageVO.next && pageVO.endPage > 0 }">
                    <li><a href="/notices?page=${pageVO.endPage+1 }">&raquo;</a></li>
                    <li><a href="/notices?page=${lastPage}">&raquo;&raquo;</a></li>
                </c:if>
            </ul>
        </div>
    </div>
    </main>

    <footer class="footer">
        <div class="footer-content">
            <p>수원시 팔달구 덕영대로 895번길 11</p>
            <p>대표전화. 031-420-4204</p>
            <p class="social-link">@jfdfhfksehfkjsnckaul</p>
        </div>
    </footer>
</body>
</html>