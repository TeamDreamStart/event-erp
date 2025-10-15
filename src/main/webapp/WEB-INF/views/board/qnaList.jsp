<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link href="https://www.dafont.com/peristiwa.font" rel="stylesheet"> 
		<link href="https://fonts.google.com/specimen/Montserrat" rel="stylesheet"> 
		<link rel="stylesheet" href="/webapp/resources/css/noticeList.css">

		<style>
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
  2. 헤더 (Header) 스타일
==================================*/
.header {
    max-width: 1200px;
    border-bottom: 1px solid #222; 
    padding: 20px 0;
    margin-bottom: 50px;
}

.header-top {
    max-width: 1000px;
    margin: 0 auto;
    padding: 0 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

/* 로고 스타일 */
.logo {
    font-family:'peristiwa'; 
    font-size: 64px;
    font-weight: bold;
    color: #222; 
}

.logo-link {
    text-decoration: none;
    color: inherit;
}

/* 유저 액션 (mypage, login) 스타일 */
.user-actions a {
  font-weight: bold;
    border-left: 1px solid #222;
    padding-left: 15px;
}

.membership {
    background-color: #222; 
    color: #fff;
    border: none;
    padding: 8px 15px;
    cursor: pointer;
    font-size: 20px;
    text-transform: uppercase;
    position: relative; 
    z-index: 10;
}

.user-actions {
    display: flex;
    align-items: center;
}

/* GNB (Visit, Event, Reservation) 스타일 */
.header-nav {
    display: flex;
    justify-content: flex-start;
    gap: 40px; 
    font-size: 30px;
    font-weight:  87px;
    padding: 30px 0 10px 200px;
}

.header-nav a {
    text-decoration: none;
    color: #222;
    padding-bottom: 5px;
}

.header-nav::after {
    content: "Help";
    position: absolute;
    right: 20px;
    font-size: 30px;
    color: #222;
}


/*==================================
  3. Q&A 폼 (Form) 스타일
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
    border: 1px solid #ccc; /* --light-border-color 대체 */
    cursor: pointer;
    font-size: 14px;
}

.btn-cancel {
    background-color: #F2F0EF;
    color: #222;
}

.btn-submit {
    background-color: #BFD4F9; 
    color: #fff;
    /*border-color: #6a9cff;*/
}


/*==================================
  4. 푸터 (Footer) 스타일
==================================*/
.footer {
    background-color: #CBD4C2; /* 연한 녹색 계열 배경 */
    color: #222;
    padding: 30px 0;
    margin-top: 80px;
    text-align: center;
}
.footer p {
    margin: 5px 0;
    font-size: 20px;
}
.footer-hr {
    display: none; /* 디자인에 hr이 없으므로 숨김 처리 */
}
.footer p:last-child {
    margin-top: 15px;
    font-weight: bold;
} 
</style>
</head>
<body>
    <header class="header">
        <div class="header-top">
            <span class="header-left">
                <a href="/" class="logo-link"><span class="logo">D</span></a>
            </span>
            <span class="header-right">
                <span class="user-actions">
                    <!-- HTML 오류를 수정하고 버튼 텍스트를 단순화했습니다. -->
                    <button class="membership">login</button> 
                    <a href="#">mypage</a>
                </span>
            </span>
        </div>
        <nav class="header-nav">
            <a href="#">Visit</a>
            <a href="#">Event</a>
            <a href="#">Reservation</a>
        </nav>
    </header>
    
    <!--메인 컨테이너-->
    <div class="container main-content">
        <div class="page-title">Q&A</div>
        
        <!--검색창-->
        <div class="search-bar">
            <input type="text" class="search-input" placeholder="제목/작성자/등록일자 검색">
            <button class="search-btn">검색</button>
        </div>
        
        <!-- ⭐️ 요청하신: 분리된 리스트 헤더 (제목, 작성자, 등록일자, 상태) -->
        <div class="qna-header">
            <div>제목</div>
            <div>작성자</div>
            <div>등록일자</div>
            <div>상태</div>
        </div>
        
        <!-- ⭐️ 리스트 박스 컨테이너 (888x584 고정 크기 및 스크롤) -->
        <div class="qna-list-container">
            <!-- 공지사항 테이블: thead 제거 후 tbody만 사용 -->
            <table class="notice-table">
                <!-- <thead>는 분리된 qna-header가 대체하므로 제거합니다. -->
                <tbody>
                    <tr>
                        <td>
                            <a href="/qna/{id}">강의시간 및 휴일은 어떻게 됩니까?</a>
                            <!-- 과도한 p 태그와 내용 줄바꿈은 목록 뷰를 망치므로 제거했습니다. -->
                        </td>
                        <td>김*현</td>
                        <td>2025-09-17</td>
                        <td><span class="status-waiting">답변대기</span></td>
                    </tr>
                    <tr>
                        <td>
                            <a href="/qna/{id}">단체강연을 가고싶습니다. 어떻게 신청하나요?</a>
                        </td>
                        <td>이*청</td>
                        <td>2025-09-17</td>
                        <td><span class="status-waiting">답변대기</span></td>
                    </tr>
                    <tr>
                        <td>
                            <a href="/qna/{id}">강연실의 작품 촬영이 가능한가요?</a>
                        </td>
                        <td>조*서</td>
                        <td>2025-09-18</td>
                        <td><span class="status-complete">답변완료</span></td>
                    </tr>
                    <tr>
                        <td>
                            <a href="/qna/{id}">강연 당일 예매 및 취소가 가능한가요?</a>
                        </td>
                        <td>윤*은</td>
                        <td>2025-09-18</td>
                        <td><span class="status-complete">답변완료</span></td>
                    </tr>
                    <tr>
                        <td>
                            <a href="/qna/{id}">홈페이지 이용하기 좋은 최적화된 웹브라우저는 무엇인가요?</a>
                        </td>
                        <td>서*리</td>
                        <td>2025-09-19</td>
                        <td><span class="status-complete">답변완료</span></td>
                    </tr>
                    <tr>
                        <td>
                            <a href="/qna/{id}">있는 강의관련 이미지를 사용해도 되나요?</a>
                        </td>
                        <td>정*비</td>
                        <td>2025-09-19</td>
                        <td><span class="status-complete">답변완료</span></td>
                    </tr>
                    <tr>
                        <td>
                            <a href="/qna/{id}">강의실에서 개최하는 각종 행사 일정을 알고싶습니다.</a>
                        </td>
                        <td>김*호</td>
                        <td>2025-09-20</td>
                        <td><span class="status-complete">답변완료</span></td>
                    </tr>
                    <tr>
                        <td>
                            <a href="/qna/{id}">회사에서 근무하고 싶으면 어떻게 하면 될까요?</a>
                        </td>
                        <td>김*모</td>
                        <td>2025-09-20</td>
                        <td><span class="status-complete">답변완료</span></td>
                    </tr>
                </tbody>
            </table>
        </div>
        
        <!--페이지네이션-->
        <div class="pagination">
            <a href="#">&lt;</a>
            <a href="#" class="active">1</a>
            <a href="#">2</a>
            <a href="#">3</a>
            <a href="#">&gt;</a>
        </div>
    </div>
    
    <!--푸터-->
    <footer class="footer">
        <p>수원시 팔달구 덕영대로 895번길 11</p>
        <p>대표전화. 031-420-4204</p>
        <hr class="footer-hr">
        <p>@jfdfhfksehfkjsnckaul</p>
    </footer>
</body>
</html>