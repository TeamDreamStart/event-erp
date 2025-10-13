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
/* 3. Main Content (qna) 스타일 */
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
    margin-bottom: 40px auto;
    text-align: center;
}
.notice-table thead th {
    font-weight: bold;
    padding: 15px 0;
    border-top: 2px solid #222; /* 상단 굵은 선 */
    border-bottom: 1px solid #222; /* 하단 얇은 선 */
	font-size: 14px;
}
.notice-table tbody td {
    padding: 12px 0;
    border-bottom: 1px solid #AFAFAF;
    color: #222;
    font-size: 15px;
	vertical-align: top;
}

.notice-table th:nth-child(1) { width: auto; } /* 제목 (나머지 공간 전부) */
.notice-table th:nth-child(2), .notice-table td:nth-child(2) { width: 15%; } /* 작성자 */
.notice-table th:nth-child(3), .notice-table td:nth-child(3) { width: 12%; } /* 등록일자 */
.notice-table th:nth-child(4), .notice-table td:nth-child(4) { width: 10%; font-weight: bold; } /* 상태 */


.notice-table tbody td:nth-child(1){
	text-align: left; /*제목은 왼쪽 정렬*/
	padding-left: 20px;
}

.notice-table td a{
	display: flex;
	align-items: center;
	font-weight: bold;
	color: #222;
	padding: 5px 0;
}

.notice-table td a::before{
	content: Q;
	margin-right: 10px;
	font-size: 22px;
	color: #FAF9F6;
}
.notice-table td p{
	margin: 5px 0 0 35px;
	padding: 0;
	color: #595959;
	font-size: 14px;
	white-space: normal;
	overflow: hidden;
	text-overflow: ellipsis;
	display: -webkit-box;
	-webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    line-height: 1.5;
    max-height: 3em; /* 1.5 * 2 = 3em */
}


.notice-table tbody td:first-child{
    text-align: center;
	width: auto;
}

.notice-table tbody tr:hover {
    background-color: #FFFFFF;
    cursor: pointer;
}

/* 답변대기 상태 강조 */
.notice-table td:nth-child(4):contains('답변대기'){ 
    color: #888888; 
}

/* 답변완료 상태 강조 */
.notice-table td:nth-child(4):contains('답변완료') {
    color: #0088ff; /* 파란색 계열 */
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

<title>qnalist</title>
</head>
<body>
	<header class="header">
      <div class="header-top">
      <span class="header-left">
         <a href="/" class="logo-link"><span class="logo">D</span></a>
         </span>
         <span class="header-right">
            <span class="user-actions">
               <button class="membership">login
                  <li>
                     <a href="#">로그인</a>
                     <a href="#">로그아웃</a>
                     <a href="#">회원가입</a>
                  </li>h
               </button>
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
   <div class="container">
	<div class="page-title">Q&A</div>
   <!--검색창-->
   <div class="search-bar">
	<input type="text" placeholder="제목/작성자/등록일자 검색">
	<button>검색</button>
   </div>
   </div>
   <!--공지사항 테이블-->
   <table class="notice-table">
	<thead>
		<tr>
			<th>제목</th>
			<th>작성자</th>
			<th>등록일자</th>
			<th>상태</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>
			 <a href="/qna/{id}">강의시간 및 휴일은 어떻게 됩니까?</a>
			<p>내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용<br>
				내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용<br>
				내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용<br>
				내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용<br>
				</p>
			</td>
			<td>김*현</td>
			<td>2025-09-17</td>
			<td>답변대기</td>
		</tr>
		<tr>
			<td>
			<a href="/qna/{id}">단체강연을 가고싶습니다. 어떻게 신청하나요?</a>
			<p>내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용<br>
				내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용<br>
				내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용<br>
				내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용<br>
				</p>
			</td>
			<td>이*청</td>
			<td>2025-09-17</td>
			<td>답변대기</td>
		</tr>
		<tr>
			<td>
			<a href="/qna/{id}">강연실의 작품 촬영이 가능한가요?</a>
			<p>내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용<br>
				내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용<br>
				내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용<br>
				내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용<br>
				</p>
			</td>
			<td>조*서</td>
			<td>2025-09-18</td>
			<td>답변완료</td>
		</tr>
		<tr>
			<td>
			<a href="/qna/{id}">강연 당일 예매 및 취소가 가능한가요?</a>
			<p>내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용<br>
				내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용<br>
				내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용<br>
				내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용<br>
				</p>
			</td>
			<td>윤*은</td>
			<td>2025-09-18</td>
			<td>답변완료</td>
		</tr>
		<tr>
			<td>
			<a href="/qna/{id}">홈페이지 이용하기 좋은 최적화된 웹브라우저는 무엇인가요?</a>
			<p>내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용<br>
				내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용<br>
				내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용<br>
				내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용<br>
				</p>
			</td>
			<td>서*리</td>
			<td>2025-09-19</td>
			<td>답변완료</td>
		</tr>
		<tr>
			<td>
			<a href="/qna/{id}">있는 강의관련 이미지를 사용해도 되나요?</a>
			<p>내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용<br>
				내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용<br>
				내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용<br>
				내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용<br>
				</p>
			</td>
			<td>정*비</td>
			<td>2025-09-19</td>
			<td>답변완료</td>
		</tr>
		<tr>
			<td>
			<a href="/qna/{id}">강의실에서 개최하는 각종 행사 일정을 알고싶습니다.</a>
			<p>내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용<br>
				내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용<br>
				내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용<br>
				내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용<br>
				</p>
				</td>
			<td>김*호</td>
			<td>2025-09-20</td>
			<td>답변완료</td>
		</tr>
		<tr>
			<td>
			<a href="/qna/{id}">회사에서 근무하고 싶으면 어떻게 하면 될까요?</a>
			<p>내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용<br>
				내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용<br>
				내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용<br>
				내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용내용 내용 내용 내용 내용<br>
				</p>
				</td>
			<td>김*모</td>
			<td>2025-09-20</td>
			<td>답변완료</td>
		</tr>
	</tbody>
   </table>
    <!--페이지네이션-->
   <div class="pagination">
	 <a href="#">&lt;</a>
	 <a href="#">1</a>
	 <a href="#">2</a>
	 <a href="#">3</a>
	 <a href="#">&gt;</a>
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