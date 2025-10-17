<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <link href="https://fonts.cdnfonts.com/css/peristiwa" rel="stylesheet">
        <link href="https://fonts.google.com/specimen/Montserrat" rel="stylesheet"> 
        <link rel="stylesheet" href="/webapp/resources/css/noticeList.css">

<style>

/* 1. 공통 및 기본 스타일 */
body {
    font-family: 'Montserrat', sans-serif; /* 폰트 fallback 추가 */
    margin: 0;
    padding: 0;
    background-color: #E5E2DB;
    color: #222;
    line-height: 1.6;
}

.container { /* .main-container 대신 HTML의 .container 사용 */
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
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
/* .main-content는 HTML에 없으므로 스타일 제거 */

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
    border: none; /*테두리 제거*/
    max-width: 888px;
    margin: 50px auto;
    gap: 43px;
}

/*검색 입력창*/
.search-bar input[type="text"] { /* 클래스가 없어 태그 선택자로 변경 */
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

.search-bar input[type="text"]::placeholder {
    color: #888888;
    opacity: 1;
}

/*검색 버튼*/
.search-bar button { /* 클래스가 없어 태그 선택자로 변경 */
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

/* ======================================================= */
/* ⭐️ 테이블 구조를 대체하는 Q&A 목록 스타일 */
/* ======================================================= */

/* Q&A 헤더 (테이블 <thead> 대체) */
.qna-header-wrapper {
    max-width: 888px;
    margin: 0 auto;
    font-weight: bold;
    font-size: 14px;
    padding-bottom: 10px;
}

.qna-header {
    display: flex;
    justify-content: space-between;
    padding: 0 0px 10px 0;
    border-bottom: 1px solid #AFAFAF; /* 헤더 구분선 */
}

/* 헤더 컬럼 너비 지정 */
.qna-header > div:nth-child(1) { width: 50%; text-align: left; padding-left: 20px; } /* 제목 */
.qna-header > div:nth-child(2) { width: 15%; text-align: center; } /* 작성자 */
.qna-header > div:nth-child(3) { width: 15%; text-align: center; } /* 등록일자 */
.qna-header > div:nth-child(4) { width: 10%; text-align: center; } /* 상태 */

/* ⭐️ Q&A 리스트 박스 컨테이너 (888x584 크기 및 스크롤) */
.qna-list-container {
    max-width: 888px;
    height: 584px;
    margin: 0 auto; 
    border: 1px solid #AFAFAF;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
    background-color: white; /* 리스트 배경색을 흰색으로 설정 */
    overflow-y: auto; /* 내용이 넘칠 경우 스크롤 허용 */
}

/* ⭐️ 각 Q&A 항목 (details 태그) */
.qna-item {
    border-bottom: 1px solid #E5E5E5;
    padding: 0;
    margin: 0;
}

.qna-item:last-child {
    border-bottom: none;
}

/* Summary (게시글 제목, 정보) 스타일 */
.qna-summary {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 12px 0;
    font-size: 15px;
    cursor: pointer; /* 클릭 가능함을 명시 */
    list-style: none; /* 기본 화살표 숨기기 */
}

/* summary 태그의 기본 화살표를 제거하고 커스텀 스타일 적용 (선택 사항) */
.qna-summary::-webkit-details-marker {
    display: none;
}
.qna-summary::before {
    content: ''; /* 기본 화살표 대체 */
    display: none; 
}


/* summary 호버 시 배경색 변경 (사용자가 클릭할 것임을 인지하도록) */
.qna-summary:hover {
    background-color: #F8F8F8;
}

/* Summary 컬럼 너비 지정 */
.qna-col {
    padding: 0 5px;
    text-align: center;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.qna-col.title-col {
    width: 50%;
    text-align: left;
    font-weight: 500;
    padding-left: 20px;
}
.qna-summary > .qna-col:nth-child(2) { width: 15%; } /* 작성자 */
.qna-summary > .qna-col:nth-child(3) { width: 15%; } /* 등록일자 */
.qna-summary > .qna-col:nth-child(4) { width: 10%; font-weight: bold; } /* 상태 */


/* 'Q' 아이콘 스타일 */
.q-icon {
    content: 'Q';
    margin-right: 10px;
    font-size: 18px; /* 크기 조정 */
    color: #888888;
    font-weight: bold;
}


/* Details (펼쳐졌을 때의 본문 내용) 스타일 */
.qna-content {
    padding: 20px;
    padding-left: 40px; /* 제목과의 정렬을 위해 왼쪽 패딩 조정 */
    margin-top: -1px; /* summary와 겹치는 선 보정 */
    border-top: 1px dashed #DDD;
    background-color: #FDFDFD;
    font-size: 14px;
    color: #555;
    line-height: 1.8;
}

.qna-content strong {
    color: #222;
}

.view-detail-link {
    display: inline-block;
    margin-top: 10px;
    color: #0088ff;
    font-weight: bold;
}


/* 답변대기 상태 강조 */
.status-waiting {
    color: #888888;
}

/* 답변완료 상태 강조 */
.status-complete {
    color: #0088ff;
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
    <!--메인 컨테이너-->
    <div class="container">
        <div class="page-title">Q&A</div>
        <!--검색창-->
        <div class="search-bar">
            <input type="text" placeholder="제목/작성자/등록일자 검색">
            <button class="search-btn">검색</button>
        </div>
    </div>
    
    <!-- Q&A 헤더 (테이블 헤더 대체) -->
    <!-- .notice-table을 대체하기 위한 목록 헤더 -->
    <div class="qna-header-wrapper">
        <div class="qna-header">
            <div>제목</div>
            <div>작성자</div>
            <div>등록일자</div>
            <div>상태</div>
        </div>
    </div>


    <!-- ⭐️ Q&A 리스트 박스 컨테이너 (스크롤 및 리스트 목록) -->
    <div class="qna-list-container">
        <c:choose>
            <c:when test="${empty postList}">
                <div class="empty-list-message">게시글이 없습니다.</div>
            </c:when>
            <c:otherwise>
                <c:forEach var="postDTO" items="${postList}">
                    <c:if test="${postDTO.visibility eq 'PUBLIC' and postDTO.category eq 'QNA'}">
                        <!-- ⭐️ 각 게시글: details로 감싸 접기/펴기 기능 구현 -->
                        <details class="qna-item">
                            
                            <!-- Summary: 항상 보이는 제목/정보 줄 -->
                            <summary class="qna-summary">
                                <div class="qna-col title-col">
                                    <span class="q-icon">Q</span>
                                    ${postDTO.title}
                                </div>
                                <div class="qna-col">${postDTO.userId}</div>
                                <div class="qna-col">${postDTO.createdAt}</div>
                                <div class="qna-col status-col">
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
                            
                            <!-- Details: 펼쳐졌을 때 보이는 내용 (실제 Post 내용) -->
                            <div class="qna-content">
                                <p>
                                    <!-- 실제 DB에서 가져온 content 내용 출력 (가정) -->
                                    <strong>문의 내용 요약:</strong> ${postDTO.title}에 대한 상세 문의 내용입니다. <br>
                                    <c:if test="${postDTO.commentCount > 0}">
                                        <br>
                                        <strong>[답변]</strong> 답변 내용이 여기에 표시됩니다.
                                    </c:if>
                                    <br>
                                    <a href="/qna/${postDTO.postId}" class="view-detail-link">전체 페이지에서 상세 내용 보기</a>
                                </p>
                            </div>
                            
                        </details>
                    </c:if>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
    
    <!-- 이전에 있던 table 태그는 제거되었습니다. -->

    <!--페이지네이션-->
    <div class="pagination">
        <a href="#">&lt;</a> <a href="#">1</a> <a href="#">2</a> <a href="#">3</a>
        <a href="#">&gt;</a>
    </div>
    <footer>
            <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    </footer>
</body>
</html>
