<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://www.dafont.com/peristiwa.font" rel="stylesheet">
<title>noticelist</title>
</head>
<body>
	<!--헤더-->
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
                  </li>
               </button>
               <a href="#">mypage</a>
            </span>
         </span>
      </div>
         <nav class="header-nav">
            <a href="#">Visit</a>
            <a href="#">Event</a>
            <a href="#">Store</a>
         </nav>
   </header>
   <!--메인 컨테이너-->
   <div class="container">
	<div class="notice-title">Notice</div>
	<!--검색창-->
	<div class="search-box">
	 <input type="text" placeholder="제목/등록일자 검색">
	 <button>검색🔍</button>
	</div>
   </div>
   <!--공지사항 테이블-->
   <table>
	<thead>
		<tr>
			<th>제목</th>
			<th>등록일자</th>
			<th>조회수</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><a href="/notices/{id}">9/26(금) 새벽 2시~4시 30분 시스템 점검 안내</a></td>
			<td>2025-09-21</td>
			<td>2,948</td>
		</tr>
		<tr>
			<td><a href="/notices/{id}"> 2025년도 서비스 [9월 기준]</a></td>
			<td>2025-09-17</td>
			<td>238</td>
		</tr>
		<tr>
			<td><a href="/notices/{id}"> [공지] Android OS 최소 지원 버전 변경 안내</a></td>
			<td>2025-08-13</td>
			<td>413</td>
		</tr>
		<tr>
			<td><a href="/notices/{id}"> 현재 진행 이벤트 종료 시점 안내</a></td>
			<td>2025-07-04</td>
			<td>376</td>
		</tr>
		<tr>
			<td><a href="/notices/{id}"> 강의 불법 복제, 무단 판대 등 콘텐츠 부정 사용을 엄중히 경고</a></td>
			<td>2025-06-21</td>
			<td>2,115</td>
		</tr>
		<tr>
			<td><a href="/notices/{id}"> 강의 반품 접수 서비스 오픈 안내</a></td>
			<td>2025-06-02</td>
			<td>2,805</td>
		</tr>
		<tr>
			<td><a href="/notices/{id}"> 곧 오픈하는 이벤트 일정 안내</a></td>
			<td>2025-05-26</td>
			<td>156</td>
		</tr>
		<tr>
			<td><a href="/notices/{id}"> 제휴문의</a></td>
			<td>2025-03-11</td>
			<td>123</td>
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