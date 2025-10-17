<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700;900&display=swap" rel="stylesheet"/>
<title>reservation agreement</title>
<style>
body{
background-color: #E5E2DB;
color: #222222;
font-family: 'Montserrat', sans-serif;
font-size: 16px;
font-weight: normal;
margin: 0;
padding: 0 120px 60px;
line-height: 1;
}
main {
margin-top: 0;
padding: 0;
}
.container {
width: 100%;
margin: 0 auto;
padding: 0;
}
.section-header {
display: flex;
justify-content: space-between;
align-items: center;
margin-bottom: 16px;
}

.section-header h2 {
font-size: 30px;
font-weight: 700;
line-height: 40px;
}
.container{
max-width: 888px;
margin: 0 auto;
background-color: #E5E2DB;
}
.main-cancle {
    display: flex;
    flex-direction: column;
    gap: 38px; 
}

.cancle-scroll{
max-width: 888px;
margin: 0 auto;
width: 100%;
}
.cancle-reason{
background-color: #FAF9F6;
color: #222222;
padding: 30px;
box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
flex-grow: 1;
overflow-y: auto;
height: 367px; 
font-size: 14px;
}

/* 체크박스 영역 (예/아니오) 스타일 수정 */
.cancle-checkbox-wrap {
    max-width: 888px;
    margin: -22px auto 0 auto; /* 상단 마진을 -22px로 설정하여 위로 끌어 올림 */
    width: 100%;
    display: flex;
    justify-content: flex-end;
    gap: 21px; 
}
.cancle-checkbox-wrap label {
    font-size: 14px;
}
.cancle-checkbox-wrap input[type="checkbox"] {
    margin-right: 4px;
}

.end-btn{
margin: 58px auto 0 auto;
display: grid;
grid-template-columns: 1fr 1fr;
width: fit-content;
margin-bottom: 140px;
}
#btn-back{
	border: 1px solid #AFAFAF;
	background-color: #F2F0EF;
	margin-right: 16px;
	padding: 8px 2px;
	width: 80px;
	border-radius: 12px;
	font-weight: bold;
	cursor: pointer;
	font-size: 14px;
}
#reservation-cancle{
	display: block;
border: 1px solid #8FAFED;
background-color: #BFD4F9;
padding: 8px 2px;
border-radius: 12px;
font-size: 14px;
width: 80px; /* 취소 버튼과 동일한 크기로 설정 */
text-decoration: none;
font-weight: bold;
cursor: pointer;
color: #222222;
}
.reservation-info h4,
.cancle-reason h4 {
margin-top: 4px;
font-size: 14px;
font-weight: bold;
margin-bottom: 0;
}

/* agree-all (전체 동의) 오른쪽 정렬 */
.agree-all{
font-size: 14px;
text-align: right;
margin-top: 0; 
}
.agree-all label input {
    margin: 3px 9px 3px 4px;
}

.reservation-info p {
margin-bottom: 25px;
font-size: 14px;
}
.cancle-reason label {
font-size: 14px;
};
.cancle-reason p {
margin-top: 0;
font-weight: normal; 
font-size: 14px;
line-height: normal; 
}
</style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<main>
<div class="container">
<div class="section-header">
<h2>개인정보 활용 동의서</h2>
</div>
<div class="main-cancle">

    <div style="overflow: scroll;" class="cancle-scroll">
    <article class="cancle-reason" aria-required="true">
        <h4>D의 회원가입,이벤트참여,예약 등을 위해 아래와 같이 개인정보를 수집,이용합니다.</h4>
    </article>
    </div>
    <div class="cancle-checkbox-wrap">
        <label><input type="checkbox" required>예</label>
        <label><input type="checkbox" required>아니오</label>
    </div>

    <div style="overflow: scroll;" class="cancle-scroll">
    <article class="cancle-reason" aria-required="true">
        <h4>D의 회원가입,이벤트참여,예약 등을 위해 아래와 같이 개인정보를 수집,이용합니다.</h4>
    </article>
    </div>
    <div class="cancle-checkbox-wrap">
        <label><input type="checkbox" required>예</label>
        <label><input type="checkbox" required>아니오</label>
    </div>

    <div style="overflow: scroll;" class="cancle-scroll">
    <article class="cancle-reason" aria-required="true">
        <h4>D의 회원가입,이벤트참여,예약 등을 위해 아래와 같이 개인정보를 수집,이용합니다.</h4>
    </article>
    </div>
    <div class="cancle-checkbox-wrap">
        <label><input type="checkbox" required>예</label>
        <label><input type="checkbox" required>아니오</label>
    </div>

    <div style="overflow: scroll;" class="cancle-scroll">
    <article class="cancle-reason" aria-required="true">
        <h4>D의 회원가입,이벤트참여,예약 등을 위해 아래와 같이 개인정보를 수집,이용합니다.</h4>
    </article>
    </div>
    <div class="cancle-checkbox-wrap">
        <label><input type="checkbox" required>예</label>
        <label><input type="checkbox" required>아니오</label>
    </div>

    <div style="overflow: scroll;" class="cancle-scroll">
    <article class="cancle-reason" aria-required="true">
        <h4>D의 회원가입,이벤트참여,예약 등을 위해 아래와 같이 개인정보를 수집,이용합니다.</h4>
    </article>
    </div>
    <div class="cancle-checkbox-wrap">
        <label><input type="checkbox" required>예</label>
        <label><input type="checkbox" required>아니오</label>
    </div>
    
    <div class="agree-all">
        <label><input type="checkbox" required>전체 동의</label>
    </div>
    
    <div class="end-btn">
    <button onclick="history.back()" id="btn-back">취소</button>
		<div style="display: block; text-align: center;">
			<a href="#" id="reservation-cancle">다음</a>
		</div>              
    </div>
</div>
</div>
</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>