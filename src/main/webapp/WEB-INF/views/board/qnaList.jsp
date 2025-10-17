<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

        <!DOCTYPE html>
        <html>
        <head>
            <meta charset="UTF-8">
            <link href="https://fonts.cdnfonts.com/css/peristiwa" rel="stylesheet">
            <link href="https://fonts.google.com/specimen/Montserrat" rel="stylesheet">
            <link rel="stylesheet" href="/webapp/resources/css/qnaList.css">
            <style>
                /* 1. 공통 및 기본 스타일 */
                body {
                    font-family: 'Montserrat';
                    margin: 0;
                    padding: 0;
                    background-color: #E5E2DB;
                    color: #222;
                    line-height: 1.6;
                }

                .main-container {
                    max-width: 1200px;
                    margin: 0 auto;
                    padding: 20px;
                    background-color: white;
                }

                a {
                    text-decoration: none;
                    color: inherit;
                }

                ul {
                    list-style: none;
                    padding: 0;
                    margin: 0;
                }

                button {
                    cursor: pointer;
                    background: none;
                    border: none;
                    padding: 0;
                    font-family: inherit;
                    color: inherit;
                }

                /* 3. Main Content (qna) 스타일 */
                .main-content {
                    padding-top: 80px;
                }

                .page-title {
                    text-align: center;
                    font-size: 30px;
                    font-weight: bold;
                    margin: 65px 0 40px 0;
                    position: relative;
                    padding-bottom: 10px;
                }

                /* 검색창 */
                .search-bar {
                    display: flex;
                    justify-content: center;
                    margin-bottom: 0px;
                    border: none;
                    /*테두리 제거*/
                    max-width: 888px;
                    margin: 50px auto;
                    gap: 43px;
                }

                /*검색 입력창*/
                .search-input {
                    width: 733px;
                    height: 60px;
                    box-sizing: border-box;
                    padding: 0px 20px;
                    background-color: #CBD4C2;
                    border: 1px solid #222;
                    border-radius: 15px;
                    flex-grow: 0;
                    box-shadow: none;
                    outline: none;
                    font-size: 18px;
                    color: #222;
                    opacity: 1;
                }

                .search-input::placeholder {
                    color: #888888;
                    opacity: 1;
                }

                /*검색 버튼*/
                .search-btn {
                    width: 112px;
                    height: 60px;
                    box-sizing: border-box;
                    padding: 0px;
                    background-color: #CBD4C2;
                    border: 1px solid #222;
                    border-radius: 15px;
                    font-size: 18px;
                    outline: none;
                    font-weight: bold;

                    /* 텍스트 정렬 */
                    display: flex;
                    justify-content: center;
                    align-items: center;

                    /*버튼 텍스트 색상*/
                    color: #222;
                }

                .qna-header {
                    display: flex;
                    justify-content: space-between;
                    font-weight: bold;
                    font-size: 14px;
                    padding: 0 0px 10px 0;
                    /* 아래쪽 패딩으로 테이블과 간격 조정 */
                    margin: 40 auto 0 auto;
                    max-width: 888px;
                    border-top: 1px solid #222;
                    border-bottom: none;
                    background-color: transparent;
                }

                .qna-header>div:nth-child(1) {
                    width: 50%;
                    text-align: left;
                    padding-left: 20px;
                }

                .qna-header>div:nth-child(2) {
                    width: 15%;
                    text-align: center;
                }

                .qna-header>div:nth-child(3) {
                    width: 15%;
                    text-align: center;
                }

                .qna-header>div:nth-child(4) {
                    width: 10%;
                    text-align: center;
                }

                /* ⭐️ Q&A 리스트 박스 컨테이너 (888x584 크기 및 스크롤) */
                .qna-box {
                    max-width: 888px;
                    height: 584px;
                    margin: 0 auto;
                    /* 헤더 텍스트와 분리를 위한 상단 마진 */
                    background-color: #FAF9F6;
                    /* 리스트 배경색을 흰색으로 설정 */
                    overflow-y: auto;
                    /* 내용이 넘칠 경우 스크롤 허용 */
                    border-bottom: 1px solid #222;
                }

                .qna-detail {
                    padding: 10px 20px;
                    border-bottom: 1px solid #AFAFAF;
                }

                .qna-summary {
                    font-weight: 500;
                    font-size: 16px;
                    cursor: pointer;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                }

                .qna-title {
                    color: #222;
                    font-size: 14px;
                }

                .qna-meta {
                    font-size: 14px;
                    color: #222;
                }

                .qna-answer {
                    margin-top: 10px;
                    padding: 10px 0 0 0;
                    border-top: 1px dashed #ccc;
                    font-size: 14px;
                    color: #595959;
                }

                details[open] .qna-summary {
                    margin-bottom: 10px;
                }

                /* ⭐️ Q&A 리스트 테이블 */
                .qna-table {
                    width: 100%;
                    border-collapse: collapse;
                    margin: 0;
                    text-align: center;
                }

                .qna-table thead th {
                    border-bottom: none;
                }

                .qna-table tbody td {
                    padding: 12px 0;
                    border-bottom: 1px solid #AFAFAF;
                    color: #222;
                    font-size: 15px;
                    vertical-align: middle;
                }

                .qna-table tbody tr:last-child td {
                    border-bottom: none;
                    /* 마지막 줄 아래 선 제거 */
                }

                /* 테이블 컬럼 너비 지정 */
                .qna-table td:nth-child(1) {
                    width: 50%;
                    text-align: left;
                    padding-left: 20px;
                }

                /* 제목 */

                .qna-table td:nth-child(2) {
                    width: 15%;
                }

                /* 작성자 */

                .qna-table td:nth-child(3) {
                    width: 15%;
                }

                /* 등록일자 */

                .qna-table td:nth-child(4) {
                    width: 10%;
                    font-weight: bold;
                }

                /* 상태 */

                /* 질문 제목 링크 스타일 */
                .qna-table td a {
                    display: block;
                    /* 전체 셀 클릭 가능하게 */
                    font-weight: 500;
                    color: #222;
                    padding: 0;
                    text-align: left;
                }

                .qna-table td a::before {
                    content: 'Q';
                    margin-right: 10px;
                    font-size: 22px;
                    /* 크기 조정 */
                    color: #888888;
                }

                /* 답변대기 상태 강조 */
                .status-waiting {
                    color: #888888;
                    font-size: 14px;
                }

                /* 답변완료 상태 강조 */
                .status-complete {
                    color: #0088ff;
                    font-size: 14px;
                }

                /* 페이지네이션 */
                .pagination {
                    display: flex;
                    justify-content: center;
                    gap: 16px;
                    align-items: center;
                    margin-top: 40px;
                }

                .pagination a {
                    padding: 5px 10px;
                    font-size: 18px;
                    color: #888888;
                    transition: color 0.2s;
                }

                .pagination a.active {
                    font-weight: bold;
                }

                .pagination a:hover {
                    color: #222;
                    cursor: pointer;
                }
            </style>
        </head>

      <body>
            <header>
                <jsp:include page="/WEB-INF/views/common/header.jsp"/>
            </header>
            <div class="container">
                <div class="page-title">Q&A</div>
                <div class="search-bar">
                    <input type="text" class="search-input" placeholder="제목/작성자/등록일자 검색">
                    <button class="search-btn">검색</button>
                </div>
            </div>
                   <div class="qna-header"> 
                    <div>제목</div>
                    <div>작성자</div>
                    <div>등록일자</div>
                    <div>상태</div>
            </div>
                        <div class="qna-box">
                                <table class="qna-table">
                                        <tbody>
                        <c:choose>
                            <c:when test="${empty postList}">
                                <tr>
                                    <td class="text-center" colspan="4">게시글이 없습니다.</td>
                                </tr>
                                </c:when>
                            <c:otherwise>
                                       <c:forEach var="postDTO" items="${postList}">
                              <c:if test="${postDTO.visibility eq 'PUBLIC' and postDTO.category eq 'QNA'}">
                                        <tr>
                                            <td colspan="4" style="padding: 0;">
                                                <details class="qna-detail">
                                                    <summary class="qna-summary">
                                                        <span class="qna-title">Q. ${postDTO.title}</span>
                                                        <span class="qna-meta">${postDTO.userId} | ${postDTO.createdAt}
                                                            <c:choose>
                                                                <c:when test="${postDTO.commentCount > 0}">
                                                                    <span style="color:#0088FF">답변완료</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="status-waiting">답변대기</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </summary>
                                                    <div class="qna-answer">
                                                        <c:choose>
                                                            <c:when test="${postDTO.commentCount > 0}">
                                                                <p>관리자 답변 내용이 여기에 들어갑니다.</p>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <p>아직 답변이 등록되지 않았습니다.</p>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </details>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
            </table>
            </div>
            <div class="pagination">
                <a href="#">&lt;</a> <a href="#">1</a> <a href="#">2</a> <a href="#">3</a>
                <a href="#">&gt;</a>
            </div>
            <footer>
                <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
            </footer>
        </body>
        </html>